import 'package:transport_dashboard/models/app_language.dart';
import 'package:transport_dashboard/service/storage_service.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';

  /// Obtiene el idioma guardado en preferencias
  static Future<AppLanguage> getSavedLanguage() async {
    final languageCode = StorageService.prefs.getString(_languageKey);
    if (languageCode != null) {
      return AppLanguage.fromCode(languageCode);
    }
    return AppLanguage.spanish; // Idioma por defecto
  }

  /// Guarda el idioma seleccionado
  static Future<void> saveLanguage(AppLanguage language) async {
    await StorageService.prefs.setString(_languageKey, language.code);
  }
}

