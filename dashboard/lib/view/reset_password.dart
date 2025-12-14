import 'package:transport_dashboard/blocs/user/auth_bloc.dart';
import 'package:transport_dashboard/buttons/nueva_cuenta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;
  final bool isValid;
  final String? error;

  const ResetPasswordScreen({
    super.key,
    required this.token,
    required this.isValid,
    this.error,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final newPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  bool passwordReset = false;

  String? _getErrorMessage() {
    if (widget.error != null) {
      switch (widget.error) {
        case 'token_invalido':
          return 'El enlace de recuperación no es válido';
        case 'token_expirado':
          return 'El enlace ha expirado. Solicita uno nuevo.';
        case 'ya_verificado':
          return 'Este enlace ya fue utilizado';
        default:
          return 'Error al validar el enlace';
      }
    }
    return null;
  }

  @override
  void dispose() {
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final errorMessage = _getErrorMessage();

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
        } else if (!state.isLoading && passwordReset && state.errorMessage == null) {
          // Mostrar mensaje de éxito y redirigir a login
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Contraseña restablecida correctamente. Inicia sesión con tu nueva contraseña'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            ),
          );
          
          // Redirigir a login después de un breve delay
          Future.delayed(const Duration(seconds: 1), () {
            if (context.mounted) {
              context.go('/login');
            }
          });
        }
      },
      child: Container(
        color: Colors.transparent,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          children: [
            const SizedBox(height: 48),
            
            Text(
              'Restablecer Contraseña',
              style: GoogleFonts.montserratAlternates(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),

            // Mostrar error si el token es inválido/expirado o si no hay token
            if (errorMessage != null || widget.token.isEmpty || (!widget.isValid && widget.error == null && widget.token.isNotEmpty))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          errorMessage ?? (widget.token.isEmpty 
                            ? 'No se proporcionó un token de recuperación válido'
                            : 'Token inválido o expirado'),
                          style: GoogleFonts.montserratAlternates(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Mostrar formulario solo si hay token y es válido (no hay error)
            if (widget.token.isNotEmpty && errorMessage == null && widget.error == null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextContainer(
                  child: TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: "Nueva Contraseña",
                    ),
                    controller: newPasswordCtrl,
                    obscureText: true,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextContainer(
                  child: TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock_outline),
                      hintText: "Confirmar Contraseña",
                    ),
                    controller: confirmPasswordCtrl,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Colors.deepPurple,
                    onPressed: (state.isLoading || passwordReset)
                      ? () {}
                      : () async {
                          if (newPasswordCtrl.text.isEmpty || confirmPasswordCtrl.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Por favor, completa ambos campos'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (newPasswordCtrl.text != confirmPasswordCtrl.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Las contraseñas no coinciden'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (newPasswordCtrl.text.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('La contraseña debe tener al menos 6 caracteres'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          authBloc.add(ResetPasswordEvent(widget.token, newPasswordCtrl.text));
                          setState(() {
                            passwordReset = true;
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
                          passwordReset ? "Restablecida" : "Restablecer Contraseña",
                          style: GoogleFonts.montserratAlternates(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                  );
                },
              ),
            ],

            const SizedBox(height: 8),

            ButtonNuevaCuenta(
              text: "Volver al Login",
              onPressed: () {
                context.go('/login');
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

