part of 'auth_bloc.dart';


class AuthState extends Equatable {
  
  final bool? authenticando;
  final Admin? admin;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.authenticando = false,   
    this.admin,
    this.isLoading = false,
    this.errorMessage,
  });

  AuthState copyWith({   
    Admin? admin,
    bool? autenticando,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) => AuthState(    
    authenticando: autenticando ?? authenticando,
    admin: admin ?? this.admin,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
  );

  @override
  List<Object?> get props => [authenticando, admin, isLoading, errorMessage];
}

class UserSessionInitialState extends AuthState {
  const UserSessionInitialState(): super(
    admin: null, 
    authenticando: false,
    isLoading: false,
    errorMessage: null,
  );
}


