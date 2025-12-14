import 'package:transport_dashboard/blocs/user/auth_bloc.dart';
import 'package:transport_dashboard/buttons/nueva_cuenta.dart';
import 'package:transport_dashboard/widgets/tittle_register.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';
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

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
              action: SnackBarAction(
                label: 'Cerrar',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
          authBloc.add(const OnClearAuthErrorEvent());
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(       
          children: [
            const SizedBox(height: 40),
            TittleRegister(size: size),
            const SizedBox(height: 30),

            TextContainer(
              child: TextField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.home),
                  hintText: AppLocalizations.of(context)?.name ?? "Tu Nombre",
                ),
                controller: nameCtrl,
              ),
            ),
            const SizedBox(height: 5),   
            
            TextContainer(
              child: TextField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: AppLocalizations.of(context)?.email ?? "Tu Correo",
                ),
                controller: emailCtrl,
              ),
            ),
            const SizedBox(height: 5),
        
            TextContainer(
              child: TextField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.key),
                  hintText: AppLocalizations.of(context)?.password ?? "Tu Contraseña",
                ),
                controller: passCtrl,
              ),
            ),        
            
            const SizedBox(height: 15),        

            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return MaterialButton(
                  minWidth: 125,
                  height: 37,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  onPressed: (state.isLoading || state.authenticando == true) 
                    ? (){}
                    : () async {
                      final registerOk = await authBloc.initRegister(
                        nameCtrl.text.toString(),
                        emailCtrl.text.toString(),
                        passCtrl.text.toString()
                      );
                      
                      if (registerOk == true && context.mounted == true) {
                        return context.goNamed('dashboard'); 
                      }
                    },
                  child: state.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)?.register ?? "REGISTRAR",
                        style: GoogleFonts.montserratAlternates(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                );
              },
            ),
        
            const SizedBox(height: 10),               
            
            ButtonNuevaCuenta(
              text: "TENGO CUENTA",
              onPressed: () {
                GoRouter.of(context).push('/login');
              }
            ),
          ],
        ),
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