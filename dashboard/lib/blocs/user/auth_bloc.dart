import 'package:transport_dashboard/models/admin.dart';
import 'package:transport_dashboard/service/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {

  AuthService authService;  

  AuthBloc({required this.authService}) : super(const AuthState(
    authenticando: false, 
    admin: null,
    isLoading: false,
    errorMessage: null,
  )) {
    on<OnAuthenticatingEvent>((event, emit) => emit(
      state.copyWith(autenticando: true, isLoading: true, clearError: true)
    ));
    on<OnClearUserSessionEvent>((event, emit) => emit(const UserSessionInitialState()));
    on<OnAddUserSessionEvent>((event, emit) { 
      emit(state.copyWith(    
        admin: event.admin,
        autenticando: true,
        isLoading: false,
        clearError: true,
      ));
    });
    on<OnAuthErrorEvent>((event, emit) {
      emit(state.copyWith(
        isLoading: false,
        autenticando: false,
        errorMessage: event.message,
      ));
    });
    on<OnClearAuthErrorEvent>((event, emit) {
      emit(state.copyWith(clearError: true));
    });
    on<RequestPasswordResetEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, clearError: true));
      try {
        final success = await authService.requestPasswordReset(event.email);
        if (success) {
          emit(state.copyWith(isLoading: false));
        } else {
          emit(state.copyWith(isLoading: false));
        }
      } catch (e) {
        // ignore: avoid_print
        print('❌ AuthBloc - Error en requestPasswordReset: $e');
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
      }
    });
    on<ValidateResetTokenEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, clearError: true));
      try {
        final isValid = await authService.validateResetToken(event.token);
        if (isValid) {
          emit(state.copyWith(isLoading: false));
        } else {
          emit(state.copyWith(
            isLoading: false, 
            errorMessage: 'Token inválido o expirado'
          ));
        }
      } catch (e) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
      }
    });
    on<ResetPasswordEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, clearError: true));
      try {
        final success = await authService.resetPassword(event.token, event.newPassword);
        if (success) {
          emit(state.copyWith(isLoading: false));
        }
      } catch (e) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
      }
    });
  }  
  
 

   @override
  AuthState? fromJson(Map<String, dynamic> json) {
    
     try {
      
      final usuario  = Admin.fromJson(json);
            
      final authUserState = AuthState(
        admin: usuario,
        authenticando: false,
        isLoading: false,
        errorMessage: null,
      );         
      
      return authUserState;  

      
    } catch (e) {

      
      return null;
    }
  }
  
  @override
  Map<String, dynamic>? toJson(AuthState state) {
    

     if(state.admin != null){
      final data = state.admin!.toJson();      
      
     
      return data;
     }else{
      
      
      return null;
     }     
  }  
  

  Future<bool> initRegister(String nombre, String email, String password) async {
    try {
      add(const OnAuthenticatingEvent());
      
      final admin = await authService.register(nombre, email, password);   
         
      if (admin is Admin) {
        add(OnAddUserSessionEvent(admin));
        return true;
      } else {
        add(const OnAuthErrorEvent('Error al registrar el usuario.'));
        return false;
      }    
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      add(OnAuthErrorEvent(errorMessage));
      return false;
    }
  }


  Future<bool> initLogin(String email, String password) async {
    try {
      add(const OnAuthenticatingEvent());
      
      final usuario = await authService.loginUser(email, password); 
         
      if (usuario is Admin) {
        add(OnAddUserSessionEvent(usuario));     
        return true;
      } else {
        add(const OnAuthErrorEvent('Credenciales incorrectas.'));
        return false;
      }    
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      add(OnAuthErrorEvent(errorMessage));
      return false;
    }
  }


}