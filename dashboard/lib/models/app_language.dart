enum AppLanguage {
  spanish('es', 'Español', 'ES'),
  english('en', 'English', 'GB'),
  chinese('zh', '中文', 'CN'),
  korean('ko', '한국어', 'KR'),
  japanese('ja', '日本語', 'JP'),
  italian('it', 'Italiano', 'IT');

  const AppLanguage(this.code, this.name, this.flagCode);
  
  final String code;
  final String name;
  final String flagCode;

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.spanish,
    );
  }
}

