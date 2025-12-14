import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh')
  ];

  /// Título de la aplicación
  ///
  /// In es, this message translates to:
  /// **'Transport Dashboard'**
  String get appTitle;

  /// Mensaje de bienvenida
  ///
  /// In es, this message translates to:
  /// **'BIENVENIDO AL DASHBOARD'**
  String get welcome;

  /// Subtítulo del servicio
  ///
  /// In es, this message translates to:
  /// **'SERVICIO DE TRANSPORTE ONLINE'**
  String get serviceTitle;

  /// Título de login
  ///
  /// In es, this message translates to:
  /// **'INICIAR SESION'**
  String get loginTitle;

  /// Título de registro
  ///
  /// In es, this message translates to:
  /// **'REGISTRARME'**
  String get registerTitle;

  /// Texto del botón de login
  ///
  /// In es, this message translates to:
  /// **'INGRESAR'**
  String get login;

  /// Texto del botón de registro
  ///
  /// In es, this message translates to:
  /// **'NUEVA CUENTA'**
  String get register;

  /// Placeholder del campo de email
  ///
  /// In es, this message translates to:
  /// **'Tu Correo'**
  String get email;

  /// Placeholder del campo de contraseña
  ///
  /// In es, this message translates to:
  /// **'Tu Contraseña'**
  String get password;

  /// Placeholder del campo de nombre
  ///
  /// In es, this message translates to:
  /// **'Tu Nombre'**
  String get name;

  /// Link para recuperar contraseña
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get forgotPassword;

  /// Título del selector de idioma
  ///
  /// In es, this message translates to:
  /// **'Seleccionar Idioma'**
  String get selectLanguage;

  /// Label para idioma
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// Texto del menú Home
  ///
  /// In es, this message translates to:
  /// **'H O M E'**
  String get home;

  /// Texto del menú Factura
  ///
  /// In es, this message translates to:
  /// **'F A C T U R A'**
  String get invoice;

  /// Texto del menú Bases
  ///
  /// In es, this message translates to:
  /// **'B A S E S'**
  String get bases;

  /// Texto del menú Habilitar
  ///
  /// In es, this message translates to:
  /// **'H A B I L I T A R'**
  String get enableDrivers;

  /// Texto del botón Salir
  ///
  /// In es, this message translates to:
  /// **'S A L I R'**
  String get logout;

  /// Texto corto para viajes (móvil)
  ///
  /// In es, this message translates to:
  /// **'VIAJES'**
  String get trips;

  /// Texto largo para viajes realizados (desktop)
  ///
  /// In es, this message translates to:
  /// **'VIAJES REALIZADOS'**
  String get completedTrips;

  /// Texto corto para conductor (móvil)
  ///
  /// In es, this message translates to:
  /// **'CONDUCTOR'**
  String get driver;

  /// Texto largo para conductores activos (desktop)
  ///
  /// In es, this message translates to:
  /// **'CONDUCTORES ACTIVOS'**
  String get activeDrivers;

  /// Texto corto para vehículos (móvil)
  ///
  /// In es, this message translates to:
  /// **'VEHICULOS'**
  String get vehicles;

  /// Texto largo para vehículos activos (desktop)
  ///
  /// In es, this message translates to:
  /// **'VEHICULOS ACTIVOS'**
  String get activeVehicles;

  /// Texto para apellido
  ///
  /// In es, this message translates to:
  /// **'APELLIDO'**
  String get lastName;

  /// Texto para nombre
  ///
  /// In es, this message translates to:
  /// **'NOMBRE'**
  String get firstName;

  /// Texto para vehículo
  ///
  /// In es, this message translates to:
  /// **'VEHICULO'**
  String get vehicle;

  /// Texto para columna de viajes
  ///
  /// In es, this message translates to:
  /// **'VIAJES'**
  String get tripsColumn;

  /// Texto para acciones
  ///
  /// In es, this message translates to:
  /// **'ACCIONES'**
  String get actions;

  /// Texto para licencia
  ///
  /// In es, this message translates to:
  /// **'LICENCIA'**
  String get license;

  /// Texto para patente
  ///
  /// In es, this message translates to:
  /// **'PATENTE'**
  String get plate;

  /// Texto para modelo
  ///
  /// In es, this message translates to:
  /// **'MODELO'**
  String get model;

  /// Texto para status
  ///
  /// In es, this message translates to:
  /// **'STATUS'**
  String get status;

  /// Título para top mensual de conductores
  ///
  /// In es, this message translates to:
  /// **'Top Mensual Conductores'**
  String get topMonthlyDrivers;

  /// Título para conductores conectados
  ///
  /// In es, this message translates to:
  /// **'Conductores Conectados'**
  String get connectedDrivers;

  /// Título para crear base en zona
  ///
  /// In es, this message translates to:
  /// **'Crea tu Base en la Zona que quieras'**
  String get createBaseInZone;

  /// Texto del botón siguiente
  ///
  /// In es, this message translates to:
  /// **'SIGUIENTE'**
  String get next;

  /// Mensaje para presionar siguiente
  ///
  /// In es, this message translates to:
  /// **'Presiona SIGUIENTE'**
  String get pressNext;

  /// Mensaje para seleccionar zona
  ///
  /// In es, this message translates to:
  /// **'Seleccionar zona'**
  String get selectZone;

  /// Título para habilitar conductores
  ///
  /// In es, this message translates to:
  /// **'Habilitar conductores'**
  String get enableDriversTitle;

  /// Mensaje cuando no hay conductores
  ///
  /// In es, this message translates to:
  /// **'No hay conductores para mostrar.'**
  String get noDriversToShow;

  /// Texto cuando no hay vehículo
  ///
  /// In es, this message translates to:
  /// **'Sin vehículo'**
  String get noVehicle;

  /// Mensaje mientras se procesa la habilitación
  ///
  /// In es, this message translates to:
  /// **'Procesando habilitación...'**
  String get processingEnable;

  /// Texto del botón habilitar
  ///
  /// In es, this message translates to:
  /// **'Habilitar'**
  String get enable;

  /// Etiqueta para zona
  ///
  /// In es, this message translates to:
  /// **'Zona:'**
  String get zoneLabel;

  /// Etiqueta para base
  ///
  /// In es, this message translates to:
  /// **'Base:'**
  String get baseLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'en',
        'es',
        'it',
        'ja',
        'ko',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
