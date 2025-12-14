import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:transport_dashboard/constants/constants.dart';
import 'package:transport_dashboard/view/register.dart';
import 'package:transport_dashboard/widgets/language_selector.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';
import 'package:transport_dashboard/blocs/language/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterView extends StatelessWidget {

  final Widget child;
  const RegisterView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
      
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          height: size.height,
          width: size.width,
          child: Row( 

            children: [

           _Welcome(),
           //
           //
           Container(
           width: 400,
           height: double.infinity,
           color: Colors.black,
           child: const Column(
            children: [

            SizedBox(height: 180),
            
            
            Expanded(child: RegisterScreen()), 
            
              
            
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
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(                      
          children: [

            const SizedBox(height: 80),

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
                      textStyle: h3, 
                      cursor: '_',
                      speed: const Duration(milliseconds: 55)
                    ),
                  ],
                );
              },
            ),
        
        const SizedBox(height: 150),

        _ImageProfile(),

        const SizedBox(height: 80),
          
       
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
                    child: Image(
                      image: AssetImage('assets/company_logo.png'),
                    ),
                  ),
            ),
      ),
    );
  }  
  

}


