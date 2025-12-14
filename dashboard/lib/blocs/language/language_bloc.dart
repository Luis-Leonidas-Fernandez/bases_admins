import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:transport_dashboard/models/app_language.dart';
import 'package:transport_dashboard/service/language_service.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends HydratedBloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(
    language: AppLanguage.spanish,
    locale: Locale('es'),
  )) {
    on<LoadLanguageEvent>(_onLoadLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
    
    // Cargar idioma guardado al inicializar
    add(const LoadLanguageEvent());
  }

  Future<void> _onLoadLanguage(
    LoadLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    final savedLanguage = await LanguageService.getSavedLanguage();
    emit(LanguageState(
      language: savedLanguage,
      locale: Locale(savedLanguage.code),
    ));
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    await LanguageService.saveLanguage(event.language);
    emit(LanguageState(
      language: event.language,
      locale: Locale(event.language.code),
    ));
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    try {
      final languageCode = json['language_code'] as String;
      final language = AppLanguage.fromCode(languageCode);
      return LanguageState(
        language: language,
        locale: Locale(language.code),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return {
      'language_code': state.language.code,
    };
  }
}

