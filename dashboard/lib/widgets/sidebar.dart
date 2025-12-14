import 'package:transport_dashboard/blocs/blocs.dart';
import 'package:transport_dashboard/connection/log_out.dart';
import 'package:transport_dashboard/constants/constants.dart';
import 'package:transport_dashboard/widgets/language_selector.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SideBarMenu extends StatefulWidget {
  
  const SideBarMenu({
    super.key,
  });

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {

  @override
  Widget build(BuildContext context) {
    
    final driverBloc = BlocProvider.of<DriversBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Container(
                    height: size.height,
                    width: 220.0,
                    decoration: buildBoxDecoration(),
                    child: Stack(
                    children: [
                    buildAvatar(authBloc: authBloc, size),
        Positioned(
            top: 250,
            left: 15,
            child: Column(
              children: [
                buildItemHome(context, menuBloc: menuBloc),
                buildGetTaxe(context, menuBloc: menuBloc),
                buildRegisterBase(context, menuBloc: menuBloc),
                buildEnableDrivers(context, menuBloc: menuBloc),
                const SizedBox(height: 10),
                const LanguageSelector(
                  isDropdown: true,
                  showLabel: true,
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                ),
                buildLogOut(context,
                    driverBloc: driverBloc, authBloc: authBloc, menuBloc: menuBloc)
              ],
            ))
                    ],
                  ),
                  );
      },
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        color: secondColor,
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20), topRight: Radius.circular(20)));
  }

  Widget buildAvatar(Size size, {required AuthBloc authBloc}) {
    final name = authBloc.state.admin?.nombre;

    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        final translatedName = _translateName(name, languageState.locale);

        return Container(
          color: Colors.transparent,
          child: Stack(children: [
            Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  color: Colors.transparent,
                  height: 80.0,
                  width: 80.0,
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(
                    0.0,
                    -0.5,
                  ),
                  child: Container(
                    color: Colors.transparent,
                    height: 80,
                    width: 200.1,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        translatedName,
                        style: GoogleFonts.merienda(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600
                        )
                      ),
                    ),
                  )
                )
              ],
            )
          ]),
        );
      },
    );
  }

  // Helper function para traducir el nombre manteniendo el formato original
  String _translateName(String? name, Locale locale) {
    if (name == null || name.isEmpty) return '';
    
    // Mapeo de traducciones (puedes expandir esto según tus necesidades)
    final translations = {
      'Usuario': {
        'en': 'User',
        'zh': '用户',
        'ko': '사용자',
        'ja': 'ユーザー',
        'it': 'Utente',
        'es': 'Usuario',
      },
      'Administrador': {
        'en': 'Administrator',
        'zh': '管理员',
        'ko': '관리자',
        'ja': '管理者',
        'it': 'Amministratore',
        'es': 'Administrador',
      },
      'Admin': {
        'en': 'Admin',
        'zh': '管理员',
        'ko': '관리자',
        'ja': '管理者',
        'it': 'Admin',
        'es': 'Admin',
      },
      'Luis': {
        'en': 'Luis',
        'zh': '路易斯',
        'ko': '루이스',
        'ja': 'ルイス',
        'it': 'Luis',
        'es': 'Luis',
      },
      // Agrega más traducciones aquí según necesites
    };
    
    // Normalizar el nombre del backend: trim y eliminar espacios múltiples
    final nameTrimmed = name.trim().replaceAll(RegExp(r'\s+'), ' ');
    
    // Buscar si hay una traducción para este nombre (comparar sin importar mayúsculas/minúsculas)
    final nameKey = translations.keys.where(
      (key) => nameTrimmed.toLowerCase() == key.toLowerCase(),
    ).firstOrNull;
    
    if (nameKey != null && translations.containsKey(nameKey)) {
      final localeCode = locale.languageCode;
      final translated = translations[nameKey]?[localeCode];
      
      // Mantener el formato original (mayúsculas/minúsculas)
      if (translated != null) {
        // Si el original estaba todo en mayúsculas, mantener las mayúsculas
        if (nameTrimmed == nameTrimmed.toUpperCase()) {
          return translated.toUpperCase();
        }
        // Si el original empezaba con mayúscula, mantener ese formato
        if (nameTrimmed.isNotEmpty && 
            nameTrimmed[0] == nameTrimmed[0].toUpperCase() && 
            nameTrimmed.substring(1).toLowerCase() == nameTrimmed.substring(1)) {
          return translated[0].toUpperCase() + translated.substring(1).toLowerCase();
        }
        // De lo contrario, devolver la traducción tal cual
        return translated;
      }
    }
    
    // Si no hay traducción, retornar el nombre original manteniendo mayúsculas/minúsculas
    return name;
  }

  Widget buildItemHome(context, {required MenuBloc menuBloc}) {
    return Container(
        height: 80,
        width: 190,
        color: Colors.transparent,
        child: Stack(children: [
          TextButton(
              onPressed: () {                
                
                GoRouter.of(context).push('/dashboard');
                menuBloc.add(const OnIsCloseSideBarEvent());
                
                
              },
              child: Row(
                children: [
                  Container(
                    color: Colors.transparent,
                    child: const Center(
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 28.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    color: Colors.transparent,
                    height: 80,
                    width: 130.1,
                    child: Align(
                        alignment: const Alignment(-0.6, 0.1),
                        child: Text(
                            AppLocalizations.of(context)?.home ?? "H O M E",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                            ))),
                  )
                ],
              ))
        ]));
  }

  Widget buildLogOut(BuildContext context,
      {required DriversBloc driverBloc, required AuthBloc authBloc, required MenuBloc menuBloc}) {

    return Container(
        color: Colors.transparent,
        child: Stack(
          children: [
    
            Row(
    
              children: [
    
              Container(
                color: Colors.transparent,
                height: 80.0,
                width: 35.0,
                child: const Center(
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
              ),
              
              
              Container(
                  color: Colors.transparent,
                  height: 80.0,
                  width: 130.0,
                  child: Align(
                      alignment: const Alignment(-0.9, 0.0),
                      child: TextButton(
                        onPressed: () async {
                          LogOutApp.instance.finishApp();
                          logOut(authBloc, driverBloc, menuBloc);
    
                          context.go('/login');
                        },
                        child: Text(
                            AppLocalizations.of(context)?.logout ?? "S A L I R",                            
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                            )),
                      ))),
            ]),
          ],
        ));
  }

  Widget buildGetTaxe(context, {required MenuBloc menuBloc}) {
    return Container(
        height: 80,
        width: 190,
        color: Colors.transparent,
        child: Stack(children: [
          const SizedBox(height: 15),
          TextButton(
              onPressed: () {

                
                //GoRouter.of(context).push('/dashboard/invoice');
                //menuBloc.add(const OnIsCloseSideBarEvent()); 
                                            
                
              },
              child: Row(
                children: [
                  const Center(
                    child: Icon(
                      Icons.document_scanner,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Align(
                      alignment: const Alignment(
                        -0.2,
                        0.0,
                      ),
                      child: Text(
                        AppLocalizations.of(context)?.invoice ?? "F A C T U R A",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                        ),
                      )),
                ],
              )),
        ]));
  }

  Widget buildRegisterBase(context, {required MenuBloc menuBloc}) {

    final Size size = MediaQuery.of(context).size;

    return Container(
        height: 80,
        width: 190,
        color: Colors.transparent,
        child: Stack(children: [
          const SizedBox(height: 15),
          TextButton(
              onPressed: () {
                
                if(size.width > 855) {

                GoRouter.of(context).push('/dashboard/create/base'); 
                menuBloc.add(const OnIsCloseSideBarEvent());

                } else{

                GoRouter.of(context).push('/dashboard/create/base/mobile'); 
                menuBloc.add(const OnIsCloseSideBarEvent()); 


                }
                               
               
              },
              child: Row(
                children: [
                  const Center(
                    child: Icon(
                      Icons.app_registration_rounded,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Align(
                      alignment: const Alignment(
                        -0.2,
                        0.0,
                      ),
                      child: Text(
                        AppLocalizations.of(context)?.bases ?? "B A S E S",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                        ),
                      )),
                ],
              )),
        ]));
  }
}

void logOut(AuthBloc authBloc, DriversBloc driversBloc, MenuBloc menuBloc) {
  authBloc.add(const OnClearUserSessionEvent());
  //menuBloc.stopController();
  driversBloc.stopPeriodicTasck();
}

Widget buildEnableDrivers(context, {required MenuBloc menuBloc}) {
  return Container(
    height: 80,
    width: 190,
    color: Colors.transparent,
    child: Stack(
      children: [
        const SizedBox(height: 15),
        TextButton(
          onPressed: () {
            // Navega a tu página de habilitación de conductores
            // Ajusta el path si en tu GoRouter usaste otro:
            GoRouter.of(context).push('/dashboard/drivers/enable');
            menuBloc.add(const OnIsCloseSideBarEvent());
          },
          child: Row(
            children: [
              const Center(
                child: Icon(
                  Icons.verified_user, // o el ícono que prefieras
                  color: Colors.white,
                  size: 28.0,
                ),
              ),
              const SizedBox(width: 15),
              Align(
                alignment: const Alignment(-0.2, 0.0),
                child: Text(
                  AppLocalizations.of(context)?.enableDrivers ?? "H A B I L I T A R",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

