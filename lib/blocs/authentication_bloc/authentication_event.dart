part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class CreateAccountEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String fullName;
  final BuildContext context;

  CreateAccountEvent(this.email, this.password, this.fullName, this.context);
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final BuildContext context;

  LoginEvent(this.email, this.password, this.context);

}
