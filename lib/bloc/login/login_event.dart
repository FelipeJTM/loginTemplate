part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginWithUserAndPassword extends LoginEvent{
  final String userName;
  final String password;
  LoginWithUserAndPassword(this.userName, this.password);
}