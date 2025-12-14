part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final AppLanguage language;
  final Locale locale;

  const LanguageState({
    required this.language,
    required this.locale,
  });

  LanguageState copyWith({
    AppLanguage? language,
    Locale? locale,
  }) {
    return LanguageState(
      language: language ?? this.language,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object> get props => [language, locale];
}

