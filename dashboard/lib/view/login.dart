import 'package:transport_dashboard/blocs/user/auth_bloc.dart';
import 'package:transport_dashboard/buttons/nueva_cuenta.dart';
import 'package:transport_dashboard/widgets/tittle.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          // Limpiar el error después de mostrarlo
          authBloc.add(const OnClearAuthErrorEvent());
        }
      },
      child: Container(
        color: Colors.transparent,
        constraints: const BoxConstraints(maxHeight: 480),                  
        child: Column(       
          children: [
            Tittle(size: size),
            const SizedBox(height: 48),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextContainer(
                child: TextField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: AppLocalizations.of(context)?.email ?? "Tu Correo",
                  ),
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            const SizedBox(height: 5),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextContainer(
                child: TextField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.key),
                    hintText: AppLocalizations.of(context)?.password ?? "Tu Contraseña",
                  ),
                  controller: passCtrl,
                  obscureText: true,
                ),
              ),
            ),

            const SizedBox(height: 15),

            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return MaterialButton(
                  minWidth: 125,
                  height: 45,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  onPressed: (state.isLoading || state.authenticando == true) 
                    ? (){}
                    : () async {
                      final registerOk = await authBloc.initLogin(
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
                        AppLocalizations.of(context)?.login ?? "INGRESAR",
                        style: GoogleFonts.montserratAlternates(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                );
              },
            ),

            const SizedBox(height: 8),

            TextButton(
              onPressed: () => context.push('/forgot-password'),
              child: Text(
                AppLocalizations.of(context)?.forgotPassword ?? '¿Olvidaste tu contraseña?',
                style: GoogleFonts.montserratAlternates(
                  fontSize: 14,
                  color: Colors.lightBlue[400] ?? Colors.lightBlue,
                ),
              ),
            ),
            
            ButtonNuevaCuenta(
              text: AppLocalizations.of(context)?.register ?? "NUEVA CUENTA",
              onPressed: () {
                GoRouter.of(context).push('/register');
              },
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