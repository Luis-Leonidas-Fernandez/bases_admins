import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dashborad/constants/constants.dart';
import 'package:flutter/material.dart';


class LoginView extends StatelessWidget {

  final Widget child;
  const LoginView({super.key, required this.child, });
  
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
      
    return Container(
      color: Colors.transparent,
      height: size.height,
      width: size.width,
      child: size.width < 1100 ?
      
      ListView(

        children: [

          Container(
            color: Colors.black,
            width: size.width,
            height: 500,
            child: Column(
              children: [

                 _Welcome(size: size),               

                 const SizedBox(height: 20),
              ],
            ),
            ),
             

             Container(
            color: Colors.black,
            width: size.width,
            height: size.height,
            child: Column(
              children: [

                 Expanded(child: child),

              ],
              
            ),
            ),



        ],
      ):
      Row( 

        children: [

           _Welcome(size: size,),
           //
           //
           Container(
           width: 600,
           height: double.infinity,
           color: Colors.black,
           child: Column(
            children: [

            const SizedBox(height: 180),            

            Expanded(child: child), 
                 
                      
           
            ],
           ),
           ),
         
        ],
      ) 
      
      );

     
    
  }
}

class _Welcome extends StatelessWidget {

  final Size? size;
  const _Welcome({this.size});

  

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ Color(0xFF2F1B6D), Color(0xFF673AB7)]
                )
              ),
        padding: const EdgeInsets.symmetric(horizontal: 20),          
        child: Column(                      
          children: [

            const SizedBox(height: 80),

            FittedBox(
              fit: BoxFit.contain,
              child: Text('BIENVENIDO A INRI REMISES', style: h4)
              ),

            const SizedBox(height: 5), 
            
            AnimatedTextKit(            
              animatedTexts: [       
                           
                TypewriterAnimatedText('SERVICIO DE TRANSPORTE ONLINE',
                 textStyle: size!.width < 400 ? h14 :h3, cursor: '_',                 
                 speed: const Duration(milliseconds: 55),
                 
               ),
              ],
              ),
        
        const SizedBox(height: 150),

        _ImageProfile(),

        //const SizedBox(height: 80),
          
       
          ],
        ),
      ), 
    );
  }

}

class _ImageProfile extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {   
   
    return Expanded(     
      child: Align(
         alignment: const Alignment( 0.1,-1.5),
        child: Container( 
                
               height: 500,
               width: 500,
               color: Colors.transparent,                      
                 
                  child: const Center(          
                    child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Image(
                    image: AssetImage('assets/inri.png'),
                    ),
                    ),
                  ),
            ),
      ),
    );
  }  
  

}


