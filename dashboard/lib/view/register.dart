import 'package:dashborad/blocs/user/auth_bloc.dart';
import 'package:dashborad/buttons/nueva_cuenta.dart';
import 'package:dashborad/widgets/tittle_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(      
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: const Form(
            child: ColumnTextField()
            ),
        ),

      ),

    );
  }
}

class ColumnTextField extends StatefulWidget {

  const ColumnTextField({super.key});

  @override
  State<ColumnTextField> createState() => _ColumnTextFieldState();
}

class _ColumnTextFieldState extends State<ColumnTextField> {

  final nameCtrl  = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {  

    final authBloc = BlocProvider.of<AuthBloc>(context);
    final size = MediaQuery.of(context).size;   

    return  Container(

        color: Colors.transparent,
                    
      
        child: Column(       
         
          children: [
             
            TittleRegister(size: size),
        
            const SizedBox(height: 10),

             TextContainer(
                child: TextField(
                 decoration: const InputDecoration(
                  icon: Icon(Icons.home),
                  hintText: "Tu Nombre",
                  
                ),
                controller: nameCtrl,
                )
                
               ),

            const  SizedBox(height: 5),   
            
            TextContainer(
                child: TextField(
                 decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: "Tu Correo",
                  
                ),
                controller: emailCtrl,
                )
                
                
               ),
              const  SizedBox(height: 5),
        
              TextContainer(
                child: TextField(
                 decoration: const InputDecoration(
                  icon: Icon(Icons.key),
                  hintText: "Tu Contraseña",
                ),
                controller: passCtrl,
                )
                
               ),        
            
        
              const SizedBox(height: 15),        
               

               MaterialButton(
                minWidth: 125,
                height: 37,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                onPressed: authBloc.state.authenticando == true ? (){}
                : () async {


                  final registerOk = await authBloc.initRegister(nameCtrl.text.toString(), emailCtrl.text.toString(),
                  passCtrl.text.toString());
                  
                 
                  
                  // ignore: use_build_context_synchronously
                  if(registerOk == true && context.mounted == true)  return context.goNamed('dashboard'); 
                     
                     
                    
                 

                },
                child: Text("REGISTRAR",
                 style: GoogleFonts.montserratAlternates(
                 color: Colors.white,
                 fontSize: 18)
                ) 
                ),

        
               const SizedBox(height: 10),               
               
               ButtonNuevaCuenta(
                text: "TENGO CUENTA",
                onPressed: (){
        
                 GoRouter.of(context).push('/login');
                  
                }
                ),
             
            
              
              
               
          ],
        ),
      );
    
  }
}


class TextContainer extends StatelessWidget {

  final Widget child;
  const TextContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
   
    return Container(
       
      padding: const EdgeInsets.symmetric(horizontal: 15),           
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
      

    );
  }
}