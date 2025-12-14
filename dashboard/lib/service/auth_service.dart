import 'package:transport_dashboard/api/config.dart';
import 'package:transport_dashboard/models/admin.dart';
import 'package:transport_dashboard/models/login.dart';
import 'package:transport_dashboard/service/storage_service.dart';
import 'package:dio/dio.dart';

class AuthService {
  Admin? admin; 

  register(String nombre, String email, String password) async {
    try {
      final data = {'nombre': nombre,'email': email,'password': password};     
      const String registerPath = '/loginadmin/new'; 
          
      final respuesta = await ApiConfig.post(registerPath, data); 
  
         
       
      final authResponse = LoginResponse.fromMap(respuesta);
      admin = authResponse.admin;     

      StorageService.prefs.setString('token', authResponse.token);
      StorageService.prefs.setString('uid', authResponse.admin.uid);    
      StorageService.prefs.setString('base', authResponse.admin.base.toString());

      ApiConfig.configureDio();
      
      return admin;  
    } catch (e) {
      String errorMessage = _extractErrorMessage(e);
      throw Exception(errorMessage);
    }
  }

  loginUser(email, password) async {
    try {
      final object = {'email': email,'password': password};
      const String loginPath = '/loginadmin/'; 

      final respuesta = await ApiConfig.post(loginPath, object); 

      final authResponse = LoginResponse.fromMap(respuesta);
      admin = authResponse.admin; 

      StorageService.prefs.setString('token', authResponse.token);
      StorageService.prefs.setString('uid', authResponse.admin.uid);    
      StorageService.prefs.setString('base', authResponse.admin.base.toString());
     
      ApiConfig.configureDio();    

      return admin;  
    } catch (e) {
      String errorMessage = _extractErrorMessage(e);
      throw Exception(errorMessage);
    }
  }

  String _extractErrorMessage(dynamic error) {
    if (error is DioException) {
      // Intentar extraer el mensaje del backend
      if (error.response != null && error.response!.data != null) {
        final data = error.response!.data;
        if (data is Map<String, dynamic>) {
          // Buscar mensajes comunes del backend
          String? backendMessage;
          if (data.containsKey('msg')) {
            backendMessage = data['msg']?.toString();
          } else if (data.containsKey('message')) {
            backendMessage = data['message']?.toString();
          } else if (data.containsKey('error')) {
            backendMessage = data['error']?.toString();
          }
          
          if (backendMessage != null && backendMessage.isNotEmpty) {
            return _normalizeErrorMessage(backendMessage);
          }
        }
      }
      
      // Mensajes según el tipo de error
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return '⏱️ Tiempo de espera agotado. Por favor, verifica tu conexión a internet e intenta nuevamente.';
        case DioExceptionType.connectionError:
          return '🔌 Error de conexión. Por favor, verifica tu conexión a internet.';
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 400) {
            return '❌ Credenciales incorrectas. Por favor, verifica tu email y contraseña.';
          } else if (statusCode == 401) {
            return '🔒 No autorizado. Verifica tus credenciales e intenta nuevamente.';
          } else if (statusCode == 409) {
            return '📧 El email ya está registrado. Por favor, inicia sesión o usa otro email.';
          } else if (statusCode == 404) {
            return '👤 Usuario no encontrado. Verifica tu email e intenta nuevamente.';
          }
          return '⚠️ Error del servidor. Por favor, intenta nuevamente más tarde.';
        default:
          return '❓ Error de conexión. Por favor, verifica tu conexión e intenta nuevamente.';
      }
    } else if (error is Exception) {
      final message = error.toString();
      // Extraer el mensaje si está en el formato "Exception: mensaje"
      if (message.startsWith('Exception: ')) {
        return _normalizeErrorMessage(message.substring(11));
      }
      return _normalizeErrorMessage(message);
    }
    
    return '⚠️ Ocurrió un error inesperado. Por favor, intenta nuevamente.';
  }

  String _normalizeErrorMessage(String message) {
    // Normalizar y mejorar mensajes comunes del backend
    final lowerMessage = message.toLowerCase().trim();
    
    // Mapear mensajes del backend a mensajes más amigables
    if (lowerMessage.contains('contraseña') && lowerMessage.contains('no es valida')) {
      return '🔒 La contraseña no es válida. Por favor, verifica tu contraseña e intenta nuevamente.';
    }
    if (lowerMessage.contains('contraseña') && (lowerMessage.contains('incorrecta') || lowerMessage.contains('incorrecto'))) {
      return '🔒 Contraseña incorrecta. Por favor, verifica tu contraseña e intenta nuevamente.';
    }
    if (lowerMessage.contains('email') && (lowerMessage.contains('no existe') || lowerMessage.contains('no encontrado'))) {
      return '📧 Email no encontrado. Por favor, verifica tu email e intenta nuevamente.';
    }
    if (lowerMessage.contains('email') && (lowerMessage.contains('ya existe') || lowerMessage.contains('registrado'))) {
      return '📧 Este email ya está registrado. Por favor, inicia sesión o usa otro email.';
    }
    if (lowerMessage.contains('usuario') && (lowerMessage.contains('no existe') || lowerMessage.contains('no encontrado'))) {
      return '👤 Usuario no encontrado. Por favor, verifica tus credenciales.';
    }
    if (lowerMessage.contains('credenciales')) {
      return '❌ Credenciales incorrectas. Por favor, verifica tu email y contraseña.';
    }
    
    // Si no hay coincidencias, capitalizar la primera letra y agregar punto final si falta
    String normalized = message.trim();
    if (normalized.isNotEmpty) {
      normalized = normalized[0].toUpperCase() + (normalized.length > 1 ? normalized.substring(1) : '');
      if (!normalized.endsWith('.') && !normalized.endsWith('!') && !normalized.endsWith('?')) {
        normalized += '.';
      }
      // Agregar emoji si el mensaje no tiene uno ya
      if (!normalized.contains(RegExp(r'[\u{1F300}-\u{1F9FF}]', unicode: true))) {
        normalized = '⚠️ $normalized';
      }
    }
    
    return normalized;
  }

  // Solicitar reset de contraseña
  // POST /api/loginadmin/reset-password
  // Body: { "email": "usuario@email.com" }
  Future<bool> requestPasswordReset(String email) async {
    try {
      final data = {'email': email};
      const String resetPasswordPath = '/loginadmin/reset-password';
      
      final response = await ApiConfig.post(resetPasswordPath, data);
      // ignore: avoid_print
      print('✅ Password reset request successful: $response');
      return true;
    } catch (e) {
      // ignore: avoid_print
      print('❌ Error en requestPasswordReset: $e');
      String errorMessage = _extractErrorMessage(e);
      throw Exception(errorMessage);
    }
  }

  // Validar token de reset (opcional, para verificar antes de mostrar formulario)
  // GET /api/loginadmin/reset-password/:token
  // El backend redirige a {FRONTEND_URL}/reset-password?token=xxx&valid=true
  // O con error: /reset-password?token=xxx&error=token_invalido|token_expirado
  Future<bool> validateResetToken(String token) async {
    try {
      final String validateTokenPath = '/loginadmin/reset-password/$token';
      // Usar GET - el backend redirige, pero podemos capturar la respuesta si es 200
      await ApiConfig.get(validateTokenPath);
      return true;
    } catch (e) {
      // Si hay error, el token es inválido/expirado
      return false;
    }
  }

  // Resetear contraseña con token
  // POST /api/loginadmin/reset-password/:token
  // Body: { "newPassword": "nuevaContraseña123" }
  Future<bool> resetPassword(String token, String newPassword) async {
    try {
      final data = {'newPassword': newPassword};
      final String resetPasswordPath = '/loginadmin/reset-password/$token';
      
      await ApiConfig.post(resetPasswordPath, data);
      return true;
    } catch (e) {
      String errorMessage = _extractErrorMessage(e);
      throw Exception(errorMessage);
    }
  }
}

