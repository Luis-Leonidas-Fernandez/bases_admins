part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

 class OnAddUserSessionEvent extends AuthEvent{ 
  
  final Admin? admin;
 
 const OnAddUserSessionEvent(this.admin);
} 

class OnAuthenticatingEvent extends AuthEvent{ 
   
 const OnAuthenticatingEvent();
} 

class OnClearUserSessionEvent extends AuthEvent{ 
   
 const  OnClearUserSessionEvent();
}

class OnAuthErrorEvent extends AuthEvent {
  final String message;
  const OnAuthErrorEvent(this.message);
  @override
  List<Object> get props => [message];
}

class OnClearAuthErrorEvent extends AuthEvent {
  const OnClearAuthErrorEvent();
  @override
  List<Object> get props => [];
}

class RequestPasswordResetEvent extends AuthEvent {
  final String email;
  const RequestPasswordResetEvent(this.email);
  @override
  List<Object> get props => [email];
}

class ValidateResetTokenEvent extends AuthEvent {
  final String token;
  const ValidateResetTokenEvent(this.token);
  @override
  List<Object> get props => [token];
}

class ResetPasswordEvent extends AuthEvent {
  final String token;
  final String newPassword;
  const ResetPasswordEvent(this.token, this.newPassword);
  @override
  List<Object> get props => [token, newPassword];
}

