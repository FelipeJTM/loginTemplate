part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class GoToHomeEvent extends AuthEvent {}

class GoToLoginEvent extends AuthEvent {}

class GoToRegisterEvent extends AuthEvent{}
