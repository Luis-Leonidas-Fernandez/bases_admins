import 'package:transport_dashboard/service/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';


class ApiConfig {


  static final  Dio _dio = Dio();

  static void configureDio(){

    final String baseUrl = kIsWeb
        ? const String.fromEnvironment('API_BASE_URL')
        : dotenv.env['API_BASE_URL'] ?? '';

    // Debug: Verificar que la URL base esté configurada
    if (baseUrl.isEmpty) {
      debugPrint('⚠️ WARNING: API_BASE_URL no está configurada');
    } else {
      debugPrint('✅ API Base URL: $baseUrl');
    }

    _dio.options.baseUrl =  baseUrl;
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
    _dio.options.validateStatus = (_) => true; 
    _dio.options.headers = {     
       if (StorageService.prefs.getString('token')?.isNotEmpty ?? false)
        'x-token': StorageService.prefs.getString('token')!,   
           
    };   

  }

  // Helper method to parse response data
  static dynamic _parseResponse(dynamic data) {
    if (data is String) {
      try {
        return jsonDecode(data);
      } catch (e) {
        // Si falla el parse, devolver el string original
        return data;
      }
    }
    return data;
  }

  //IMPUT POST
  
   static Future post(String path, Map<String, dynamic> data) async {   

    try {
      final String fullUrl = '${_dio.options.baseUrl}$path';
      debugPrint('📤 POST Request: $fullUrl');
      debugPrint('📤 POST Data: $data');

      final Response resp = await _dio.post(path, data: data);
      
      debugPrint('📥 POST Response Status: ${resp.statusCode}');
      debugPrint('📥 POST Response Data: ${resp.data}');

      // Si el status code indica error, lanzar excepción con información útil
      if (resp.statusCode != null && resp.statusCode! >= 400) {
        final errorMsg = 'Error del servidor: ${resp.statusCode} - ${resp.data}';
        debugPrint('❌ $errorMsg');
        throw DioException(
          requestOptions: resp.requestOptions,
          response: resp,
          type: DioExceptionType.badResponse,
          message: errorMsg,
        );
      }

      return _parseResponse(resp.data);
    } catch (e) {
      // Mostrar el error real
      if (e is DioException) {
        debugPrint('❌ DioException: ${e.message}');
        debugPrint('❌ Tipo: ${e.type}');
        debugPrint('❌ URL: ${e.requestOptions.uri}');
        if (e.response != null) {
          debugPrint('❌ Status: ${e.response!.statusCode}');
          debugPrint('❌ Response: ${e.response!.data}');
        }
        throw Exception('Error en el POST: ${e.message}');
      } else {
        debugPrint('❌ Error desconocido: $e');
        throw Exception('Error en el POST: $e');
      }
    }
  }


  static Future get(String path) async {   

    try {
      final String fullUrl = '${_dio.options.baseUrl}$path';
      debugPrint('📤 GET Request: $fullUrl');

      final resp = await _dio.get(path);
      
      debugPrint('📥 GET Response Status: ${resp.statusCode}');
      debugPrint('📥 GET Response Data: ${resp.data}');

      // Si el status code indica error, lanzar excepción
      if (resp.statusCode != null && resp.statusCode! >= 400) {
        final errorMsg = 'Error del servidor: ${resp.statusCode} - ${resp.data}';
        debugPrint('❌ $errorMsg');
        throw DioException(
          requestOptions: resp.requestOptions,
          response: resp,
          type: DioExceptionType.badResponse,
          message: errorMsg,
        );
      }

      return _parseResponse(resp.data);
    } catch (e) {
      if (e is DioException) {
        debugPrint('❌ DioException: ${e.message}');
        debugPrint('❌ Tipo: ${e.type}');
        debugPrint('❌ URL: ${e.requestOptions.uri}');
        if (e.response != null) {
          debugPrint('❌ Status: ${e.response!.statusCode}');
          debugPrint('❌ Response: ${e.response!.data}');
        }
        throw Exception('Error en el GET: ${e.message}');
      } else {
        debugPrint('❌ Error desconocido: $e');
        throw Exception('Error en el GET: $e');
      }
    }
  }
   
  
  static Future put(String path) async {   

    try {
      final String fullUrl = '${_dio.options.baseUrl}$path';
      debugPrint('📤 PUT Request: $fullUrl');

      final resp = await _dio.put(path);
      
      debugPrint('📥 PUT Response Status: ${resp.statusCode}');
      debugPrint('📥 PUT Response Data: ${resp.data}');

      if (resp.statusCode != null && resp.statusCode! >= 400) {
        final errorMsg = 'Error del servidor: ${resp.statusCode} - ${resp.data}';
        debugPrint('❌ $errorMsg');
        throw DioException(
          requestOptions: resp.requestOptions,
          response: resp,
          type: DioExceptionType.badResponse,
          message: errorMsg,
        );
      }

      return _parseResponse(resp.data);
    } catch (e) {
      if (e is DioException) {
        debugPrint('❌ DioException: ${e.message}');
        debugPrint('❌ Tipo: ${e.type}');
        debugPrint('❌ URL: ${e.requestOptions.uri}');
        if (e.response != null) {
          debugPrint('❌ Status: ${e.response!.statusCode}');
          debugPrint('❌ Response: ${e.response!.data}');
        }
        throw Exception('Error en el PUT: ${e.message}');
      } else {
        debugPrint('❌ Error desconocido: $e');
        throw Exception('Error en el PUT: $e');
      }
    }
  }
  

}