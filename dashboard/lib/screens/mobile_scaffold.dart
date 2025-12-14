import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:transport_dashboard/constants/constants.dart';
import 'package:flutter/material.dart';



class MobileScaffold extends StatelessWidget {

  final Widget child;
  const MobileScaffold({super.key, required this.child});
   
  @override
  Widget build(BuildContext context) {

  

    return Scaffold(           
       
      
      body: Scrollbar(
        
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [           

           
           Container(child: child,)
               
            
           
            
          
            ], 
            ),
      )
    );
  }
}


class WelcomeBack extends StatelessWidget {

  const WelcomeBack({super.key});

  

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [ Color(0xFF2F1B6D), Color(0xFF673AB7)]
              )
            ),
      padding: const EdgeInsets.symmetric(horizontal: 20),  
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(                      
        children: [
    
          const SizedBox(height: 80),
    
          FittedBox(
            fit: BoxFit.contain,
            child: Text('BIENVENIDO AL DASHBOARD', style: h4)
            ),
    
          const SizedBox(height: 5), 
          
          AnimatedTextKit(            
            animatedTexts: [       
                         
              TypewriterAnimatedText('SERVICIO DE TRANSPORTE ONLINE', textStyle: h3, cursor: '_',
               speed: const Duration(milliseconds: 55)
             ),
            ],
            ),
      
      const SizedBox(height: 120),
    
      _ImageCarPhone(),    
     
        
     
        ],
      ),
    );
  }

}

class _ImageCarPhone extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {   
   

    return Expanded(    
      child: Align(
         alignment: const Alignment( 0.1,-1.5),
        child: Container(                 
              
               color: Colors.transparent,                      
               
                  child: const Center(          
                    child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                  
                    // child: Image(
                    //   image: AssetImage('assets/logo.png'),
                    // ),
                    ),
                  ),
            ),
      ),
    );
  }  
  

}


