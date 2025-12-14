import 'package:transport_dashboard/blocs/user/auth_bloc.dart';
import 'package:transport_dashboard/buttons/nueva_cuenta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailCtrl = TextEditingController();
  bool emailSent = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          // ignore: avoid_print
          print('❌ ForgotPassword error: ${state.errorMessage}');
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
        constraints: const BoxConstraints(maxHeight: 480),
        child: Column(
          children: [
            const SizedBox(height: 48),
            
            Text(
              'Recuperar Contraseña',
              style: GoogleFonts.montserratAlternates(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Ingresa tu email y te enviaremos un enlace para restablecer tu contraseña',
                style: GoogleFonts.montserratAlternates(
                  fontSize: 14,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextContainer(
                child: TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: "Tu Correo",
                  ),
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),

            const SizedBox(height: 15),

            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return MaterialButton(
                  minWidth: 125,
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  onPressed: (state.isLoading || emailSent)
                    ? () {}
                    : () async {
                        if (emailCtrl.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Por favor, ingresa tu email'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        
                        setState(() {
                          emailSent = true;
                        });
                        
                        authBloc.add(RequestPasswordResetEvent(emailCtrl.text));
                        
                        // Mostrar mensaje de éxito después de un breve delay
                        Future.delayed(const Duration(milliseconds: 500), () {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Si el email existe, recibirás un enlace para restablecer tu contraseña',
                                ),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 5),
                              ),
                            );
                          }
                        });
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
                        emailSent ? "Email Enviado" : "Enviar Enlace",
                        style: GoogleFonts.montserratAlternates(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                );
              },
            ),

            const SizedBox(height: 8),

            ButtonNuevaCuenta(
              text: "Volver al Login",
              onPressed: () {
                GoRouter.of(context).go('/login');
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

