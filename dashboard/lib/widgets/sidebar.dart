import 'package:dashborad/blocs/blocs.dart';
import 'package:dashborad/connection/log_out.dart';
import 'package:dashborad/constants/constants.dart';
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
                //const SizedBox(height: 10),
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
                      child: Text(name ?? '',
                          style: GoogleFonts.merienda(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ))
            ],
          )
        ]));
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
                        child: Text("H O M E",
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
                        child: Text("S A L I R",                            
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
                        "F A C T U R A",
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

                //GoRouter.of(context).push('/dashboard/create/base'); 
                //menuBloc.add(const OnIsCloseSideBarEvent());

                } else{

                //GoRouter.of(context).push('/dashboard/create/base/mobile'); 
                //menuBloc.add(const OnIsCloseSideBarEvent()); 


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
                        "B A S E S",
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
                  "H A B I L I T A R",
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

