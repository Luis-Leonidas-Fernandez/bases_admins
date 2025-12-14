part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LoadLanguageEvent extends LanguageEvent {
  const LoadLanguageEvent();
}

class ChangeLanguageEvent extends LanguageEvent {
  final AppLanguage language;

  const ChangeLanguageEvent(this.language);

  @override
  List<Object> get props => [language];
}

