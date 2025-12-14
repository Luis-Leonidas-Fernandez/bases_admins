import 'package:transport_dashboard/api/config.dart';
import 'package:transport_dashboard/blocs/base/base_bloc.dart';


import 'package:transport_dashboard/road/config.dart';
import 'package:transport_dashboard/service/auth_service.dart';
import 'package:transport_dashboard/service/base_service.dart';
import 'package:transport_dashboard/service/drivers_base_service.dart';
import 'package:transport_dashboard/service/storage_service.dart';
import 'package:transport_dashboard/utils/custom_scroll.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:transport_dashboard/layout/responsive_layout.dart';
import 'package:transport_dashboard/screens/screens.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'blocs/blocs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Import condicional que evita errores en Android al compilar lógica Web
import 'utils/url_strategy_stub.dart'
    if (dart.library.html) 'utils/url_strategy_web.dart';



void main() async {

 
  // Aplica estrategia de URL solo si se está en Web (condicional)
  configureAppUrlStrategy();   
  
   WidgetsFlutterBinding.ensureInitialized();
   
   // Cargar archivo .env solo para mobile (no web)
   if (!kIsWeb) {
     try {
       await dotenv.load(fileName: ".env");
     } catch (e) {
       // Si no existe el archivo .env, continuar sin error
       // El token se obtendrá como string vacío
     }
   }
   
   GoRouter.optionURLReflectsImperativeAPIs = true;
   await StorageService.configurePrefs();
   ApiConfig.configureDio();    
   


   // Inicializar HydratedBloc con manejo de errores
   try {
     HydratedBloc.storage = await HydratedStorage.build(
       storageDirectory: kIsWeb
           ? HydratedStorage.webStorageDirectory
           : await getTemporaryDirectory(),
     );
   } catch (e) {
     // En caso de error, continuar sin hydrated storage (los blocs funcionarán pero sin persistencia)
     debugPrint('Warning: Could not initialize HydratedBloc storage: $e');
   }

   
   runApp(
    MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => LanguageBloc()),
      BlocProvider(create: (context) => AuthBloc(authService: AuthService())),
      BlocProvider(create: (context) => BaseBloc(baseService: BaseService())),
      BlocProvider(create: (context) => DriversBloc(driverBaseService: DriversAndBaseService(),
      authBloc: BlocProvider.of<AuthBloc>(context)),),
      BlocProvider(create: (context) => MenuBloc()),
      BlocProvider(create: (context) => LocationBloc())
    ],
    child: const MyApp())
   );
    
   }

   

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoRouter? _router;

  @override
  Widget build(BuildContext context) {
    // Crear el router una sola vez usando los blocs del provider padre
    _router ??= ConfigRoad(
      context.read<AuthBloc>(), 
      context.read<BaseBloc>()
    ).router;

    return Builder(
      builder: (context) {
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) {
            return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if(state is OnAddUserSessionEvent ) {
                  _router!.go('/dashboard');
                } else if (state is OnClearUserSessionEvent){
                  _router!.go('/login');
                }
              },
              child: MaterialApp.router( 
                key: ValueKey('app_${languageState.locale}'), // Clave que incluye el locale para forzar reconstrucción
                scrollBehavior: MyCustomScrollBehavior(),          
                debugShowCheckedModeBanner: false,                  
                routerConfig: _router!, // Usar el router estable
                title: 'Transport Dashboard',
                locale: languageState.locale,
                supportedLocales: const [
                  Locale('es'), // Español
                  Locale('en'), // Inglés
                  Locale('zh'), // Chino
                  Locale('ko'), // Coreano
                  Locale('ja'), // Japonés
                  Locale('it'), // Italiano
                ],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  AppLocalizations.delegate,
                ],
                builder:( context , child) => ResponsiveLayout(
                  mobileScaffold:  MobileScaffold(child: child!,),
                  tabletScaffold:  TabletScaffold(child: child,),
                  desktopScaffold: DesktopScaffold(child: child,),
                  child: child, 
                ),
              ),
            );
          }
        );
      },
    );
  }
}