import 'package:transport_dashboard/blocs/base/base_bloc.dart';
import 'package:transport_dashboard/blocs/blocs.dart';
import 'package:transport_dashboard/view/base_view.dart';
import 'package:transport_dashboard/view/base_view_mobile.dart';
import 'package:transport_dashboard/view/dashboard.dart';
import 'package:transport_dashboard/view/driver_history.dart';
import 'package:transport_dashboard/view/enable_driver_page.dart';
import 'package:transport_dashboard/view/factura.dart';
import 'package:transport_dashboard/view/home.dart';
import 'package:transport_dashboard/view/login.dart';
import 'package:transport_dashboard/view/login_view.dart';
import 'package:transport_dashboard/view/register.dart';
import 'package:transport_dashboard/view/forgot_password.dart';
import 'package:transport_dashboard/view/reset_password.dart';
import 'package:transport_dashboard/widgets/dialog.dart';
import 'package:transport_dashboard/widgets/error_dialog.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class ConfigRoad {

final AuthBloc? authBloc;
final BaseBloc? baseBloc;

ConfigRoad(this.authBloc, this.baseBloc, );


late final auth = authBloc;
late final GoRouter router = GoRouter(
 
 
  initialLocation: '/login',
  debugLogDiagnostics: true,

  routes: <GoRoute>[
         
        GoRoute(
          name: 'login',
          path: '/login',         
          builder: (context, state) => const LoginView(child:  LoginScreen()),
        ),
         GoRoute(
          name: 'register',
          path: '/register',          
          builder: (context, state) => const LoginView(child:  RegisterScreen()),
        ),
        GoRoute(
          name: 'forgot-password',
          path: '/forgot-password',
          builder: (context, state) => const LoginView(child: ForgotPasswordScreen()),
        ),
        GoRoute(
          name: 'reset-password',
          path: '/reset-password',
          builder: (context, state) {
            // El token viene como query parameter desde el email del backend
            final token = state.uri.queryParameters['token'] ?? '';
            final isValid = state.uri.queryParameters['valid'] == 'true';
            final error = state.uri.queryParameters['error'];
            
            return LoginView(
              child: ResetPasswordScreen(
                token: token,
                isValid: isValid,
                error: error,
              ),
            );
          },
        ),

        GoRoute(
          name: 'dashboard',
          path: '/dashboard',          
          pageBuilder: (context, state) {
            return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),  
            child: const MyDashborad(child: Home()),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInCirc).animate(animation),
                child: child,
                );

            }
            );
          } 
          //
        ),       
       GoRoute(
          name: 'invoice',
          path: '/dashboard/invoice',          
          pageBuilder: (context, state) {
           return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const MyDashborad(child: FacturaView()),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInCirc).animate(animation),
                child: child,
                );

            }
            );

          } 
          
        ), 
             

        GoRoute(
          name: 'base',
          path: '/dashboard/create/base',          
          pageBuilder: (context, state) {
           return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const MyDashborad(child: BasePage()),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInCirc).animate(animation),
                child: child,
                );

            }
            );

          } 
          
        ),

        GoRoute(
          name: 'mobile',
          path: '/dashboard/create/base/mobile',          
          pageBuilder: (context, state) {
           return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const MyDashborad(child: BasePageMobile()),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInCirc).animate(animation),
                child: child,
                );

            }
            );

          } 
          
        ),  

        GoRoute(
          name: 'dialog',
          path: '/dialog',          
          pageBuilder: (context, state) {
           return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const MyDashborad(child: CustomDialog()),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInCirc).animate(animation),
                child: child,
                );

            }
            );

          } 
          
        ), 

        GoRoute(
          name: 'error',
          path: '/error',          
          pageBuilder: (context, state) {
           return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const MyDashborad(child: ErrorDialog()),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInCirc).animate(animation),
                child: child,
                );

            }
            );

          }           
        ), 
        
        GoRoute(
          name: 'driver-history',
          path: '/dashboard/driver/:id',          
          pageBuilder: (context, state) {
           final id = state.pathParameters['id']!;
           return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: MyDashborad(child: TravelHistoryPage(driverId: id)),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInCirc).animate(animation),
                child: child,
                );

            }
            );
          }           
        ),

       

       GoRoute(
          name: 'drivers-enable',
          path: '/dashboard/drivers/enable',          
          pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 350),
          child: const MyDashborad(child: EnableDriverPage()),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
          },
         ),      
        ),
       ], 
     
      );


      
  }