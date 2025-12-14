import 'package:transport_dashboard/blocs/blocs.dart';
import 'package:transport_dashboard/widgets/navbar.dart';
import 'package:transport_dashboard/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDashborad extends StatefulWidget {
  final Widget child;

  const MyDashborad({super.key, required this.child});

  @override
  State<MyDashborad> createState() => _MyDashboradState();
}

class _MyDashboradState extends State<MyDashborad>
    with SingleTickerProviderStateMixin {
  MenuBloc? menuBloc;

  late AnimationController controller;
  late Animation<double> movement;
  late Animation<double> opacity;

  @override
  void initState() {
    

    menuBloc = BlocProvider.of<MenuBloc>(context);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    movement = Tween<double>(begin: -220, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    super.initState();
    
  }

  @override
  void dispose() {
     
     controller.dispose();
     super.dispose();        
   
  }




  @override
  Widget build(BuildContext context) {


    final menuBloc = BlocProvider.of<MenuBloc>(context); 
    final size = MediaQuery.of(context).size;




    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {         

         
        return Container(
            color: Colors.transparent,
            height: size.height,
            width: size.width,
            child: Scaffold(
                body: Stack(children: [
            
              Row(
                children: [
                  if (size.width >= 1110) const SideBarMenu(),
                  Expanded(
                    child: Column(
                      children: [
                        // AQUI MOSTRAR LAS VIEW
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: widget.child),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (size.width < 1110) MyNavBar(controller: controller),
              AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) => Stack(
                         
                         children: [                          
                         

                          if (menuBloc.state.isOpen == true)                            
                            
                            Opacity(
                              opacity: opacity.value,
                              child: GestureDetector(
                                onTap: () {                                  
                                 
                                  controller.reverse();
                                  menuBloc.add(const OnIsCloseSideBarEvent());
                                  },
                               
                                child: Container(
                                  width: size.width,
                                  height: size.height,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          Transform.translate(
                            offset: Offset(movement.value, 0),
                            child: const SideBarMenu(),
                          )
                        ],
                      ))
            ])));
      },
    );
  }
}
