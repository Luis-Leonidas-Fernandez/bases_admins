import 'package:dashborad/service/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class ApiConfig {


  static final  Dio _dio = Dio();

  static void configureDio(){

    final String baseUrl = kIsWeb
        ? const String.fromEnvironment('API_BASE_URL')
        : dotenv.env['API_BASE_URL'] ?? '';

    _dio.options.baseUrl =  baseUrl;
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
    _dio.options.validateStatus = (_) => true; 
    _dio.options.headers = {     
       if (StorageService.prefs.getString('token')?.isNotEmpty ?? false)
        'x-token': StorageService.prefs.getString('token')!,   
           
    };   

  }

  //IMPUT POST
  
   static Future post(String path, Map<String, dynamic> data) async {   

    try {

      final Response resp = await _dio.post(path, data: data);     

      
       return resp.data;
        
      

    } catch (e) {     
             
      throw ('Error en el POST');
    }
  }


  static Future get(String path) async {   

    try {

      final resp = await _dio.get(path);     
      
      //final viajes = resp.data;
      //final json = jsonEncode(viajes);
      // ignore: avoid_print
      //print("RESPUESTA OK ${resp.data.toString()}");
       
       return resp.data;
        
      

    } catch (e) {   

      // ignore: avoid_print
      print("ERROR");  
             
      throw ('Error en el GET');
    }
  }
   
  
  static Future put(String path) async {   

    try {

      final resp = await _dio.put(path);     
             
       return resp.data;       
      
    } catch (e) {   
              
      throw ('Error en el GET');
    }
  }
  

}