import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  //urls services

  // For web: use String.fromEnvironment('API_URL') or flutter_dotenv
  // For mobile: use flutter_dotenv package
  
  static String apiUrl = kIsWeb
      ? const String.fromEnvironment('API_URL', defaultValue: '')
      : const String.fromEnvironment('API_URL', defaultValue: '');
      
  static String apiUrlWeb = kIsWeb
      ? const String.fromEnvironment('API_URL_WEB', defaultValue: '')
      : const String.fromEnvironment('API_URL_WEB', defaultValue: '');

  // Mapbox Access Token
  // Detección dinámica: Web usa String.fromEnvironment, Mobile usa flutter_dotenv
  static String getMapboxToken() {
    if (kIsWeb) {
      // Para web: usa dart-define-from-file o String.fromEnvironment
      return const String.fromEnvironment('MAPBOX_ACCESS_TOKEN', defaultValue: '');
    } else {
      // Para mobile: usa flutter_dotenv (archivo .env debe estar cargado)
      // Verifica si dotenv está cargado antes de acceder
      try {
        return dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
      } catch (e) {
        // Si dotenv no está cargado, retorna string vacío
        return '';
      }
    }
  }
}
