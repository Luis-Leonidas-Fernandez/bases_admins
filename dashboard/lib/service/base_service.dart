import 'package:transport_dashboard/api/config.dart';
import 'package:transport_dashboard/models/bases.dart';
import 'package:dio/dio.dart';


class BaseService {

  late BaseModel baseSelected;


  Future createBase(BaseModel? baseSelected, String uid) async {
    try {
      final id = uid;
      final ubicacion = baseSelected?.ubicacion ?? "";

    
      // Solo enviamos ubicacion, el backend calcula zona y base automáticamente
      final Map<String, dynamic> data = {'ubicacion': ubicacion};

      final String registerBasePath = '/base/new/$id';
      final respuesta = await ApiConfig.post(registerBasePath, data); 

      // Verificar si la respuesta indica error
      if (respuesta is Map<String, dynamic> && respuesta['ok'] == false) {
        final errorMsg = respuesta['msg'] ?? 'Error al crear la base';
        throw Exception(errorMsg);
      }

      // La respuesta puede venir en formato {"ok": true, "result": {...}} o {"ok": true, "data": {...}}
      Map<String, dynamic> baseData;
      if (respuesta is Map<String, dynamic>) {
        if (respuesta.containsKey('result')) {
          baseData = respuesta['result'] as Map<String, dynamic>;
        } else if (respuesta.containsKey('data')) {
          baseData = respuesta['data'] as Map<String, dynamic>;
        } else {
          baseData = respuesta;
        }
      } else {
        throw Exception('Respuesta del servidor en formato inesperado: $respuesta');
      }

      final baseResponse = BaseModel.fromJson(baseData); 
      
      baseSelected = baseResponse;     

      ApiConfig.configureDio();

      return baseSelected;
    } on DioException catch (e) {
      // Manejar errores de Dio específicamente
      String errorMsg = 'Error al crear la base';
      
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        if (responseData.containsKey('msg')) {
          errorMsg = responseData['msg'] as String;
        }
      } else if (e.message != null) {
        // Intentar extraer del mensaje si está en formato de string
        final message = e.message ?? '';
        // Buscar patrones como: msg: "texto" o msg: texto
        final match1 = RegExp(r'msg:\s*"([^"]+)"').firstMatch(message);
        final match2 = RegExp(r'msg:\s*([^,}]+)').firstMatch(message);
        
        if (match1 != null) {
          errorMsg = match1.group(1)?.trim() ?? errorMsg;
        } else if (match2 != null) {
          errorMsg = match2.group(1)?.trim() ?? errorMsg;
        }
      }
      
      throw Exception(errorMsg);
    } catch (e) {

      final errorMsg = e.toString().replaceAll('Exception: ', '');
      throw Exception(errorMsg);
    }
  }
}