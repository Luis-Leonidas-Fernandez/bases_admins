import 'package:transport_dashboard/blocs/blocs.dart';
import 'package:transport_dashboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyNavBar extends StatelessWidget {

  final AnimationController? controller;
  const MyNavBar({super.key, this.controller});
  

  @override
  Widget build(BuildContext context) {
    
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 50,
          decoration: buildBoxDecoration(),
          child: Row(
            children: [
              if (size.width <= 1110)
                IconButton(
                    icon: const Icon(
                      Icons.menu_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      menuBloc.add(const OnIsOpenSideBarEvent());
                      controller?.forward();

                      
                      }
                
                    ),
              const SizedBox(width: 5),
            ],
          ),
        );
      },
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      color: firstColor,
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
