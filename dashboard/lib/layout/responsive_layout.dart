import 'package:transport_dashboard/screens/screens.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  
  final Widget child;
  final Widget mobileScaffold;
  final Widget tabletScaffold;
  final Widget desktopScaffold;
  
  const ResponsiveLayout({
     super.key,     
     required this.mobileScaffold,
     required this.tabletScaffold,
     required this.desktopScaffold,
     required this.child 
  });
  

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints){
        if (constraints.maxWidth < 856){
          return MobileScaffold(child: child,);
        }else if (constraints.maxWidth < 1100){
          return TabletScaffold(child: child,);
        } else {
          return DesktopScaffold(child: child,);
        }
      }
    );
  }
}
