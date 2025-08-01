import 'package:dashborad/buttons/link_text.dart';
import 'package:flutter/material.dart';



class AppBarDesing extends StatelessWidget {
  const AppBarDesing({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(     
    
     children: [
    
          LinkText(text: 'WELCOME'),
          LinkText(text: 'ABOUT'),
          LinkText(text: 'PROJECT'),
          LinkText(text: 'PORTFOLIO'),
          LinkText(text: 'CONTACT'),
          
     ],
    );
  }
}