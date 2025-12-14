import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:transport_dashboard/constants/constants.dart';
import 'package:transport_dashboard/widgets/language_selector.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';
import 'package:transport_dashboard/blocs/language/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginView extends StatelessWidget {

  final Widget child;
  const LoginView({super.key, required this.child, });
  
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
      
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          height: size.height,
          width: size.width,
          child: size.width < 1100 ?
      
      ListView(

        children: [

          Container(
            color: Colors.black,
            width: size.width,
            height: 580,
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
      
      ),
        // Selector de idioma en la esquina superior derecha
        const Positioned(
          top: 20,
          right: 20,
          child: LanguageSelector(
            showLabel: false,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
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
        padding: const EdgeInsets.symmetric(horizontal: 10),          
        child: Column(                      
          children: [

            const SizedBox(height: 50),

            FittedBox(
              fit: BoxFit.contain,
              child: Text(AppLocalizations.of(context)?.welcome ?? 'BIENVENIDO AL DASHBOARD', style: h4)
              ),

            const SizedBox(height: 5), 
            
            BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, languageState) {
                return AnimatedTextKit(
                  key: ValueKey(languageState.locale), // Clave única para forzar reconstrucción
                  animatedTexts: [       
                              
                    TypewriterAnimatedText(
                      AppLocalizations.of(context)?.serviceTitle ?? 'SERVICIO DE TRANSPORTE ONLINE',
                      textStyle: size!.width < 400 ? h14 : h3, 
                      cursor: '_',                 
                      speed: const Duration(milliseconds: 55),
                    ),
                  ],
                );
              },
            ),
        
        const SizedBox(height: 100),

        _ImageProfile(),

     
          
       
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
               height: 400,
               width: 500,
               color: Colors.transparent,                      
                 
                  child: const Center(          
                    child: Image(
                      image: AssetImage('assets/company_logo.png'),
                    ),
                  ),
            ),
      ),
    );
  }  
  

}


