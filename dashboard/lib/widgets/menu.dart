import 'package:transport_dashboard/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:transport_dashboard/service/navigation_service.dart';

class Menu extends StatelessWidget {

  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);

    //SideMenuProvider.closeMenu();
  }
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children:  const [

          //Logo(),

        SizedBox(height: 50),


        TextSeparator(text: 'Inicio'),

           /* MenuItems(
            text: 'Data Base',
            icon: Icons.home,
            //onPressed: (){},
            onPressed: () =>   navigateTo(Flurorouter.dashboard),
            //isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          ),  */
         
           SizedBox(height: 40),
          //TextSeparator(text: 'Salida'),
         /*  MenuItems(
              text: 'Cerrar sesión',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }), */
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: (Colors.indigo),
      boxShadow: [BoxShadow(color: Colors.black87, blurRadius: 13)]);
}


 
