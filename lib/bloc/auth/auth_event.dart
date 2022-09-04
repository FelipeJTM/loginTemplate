part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class GoToHomeEvent extends AuthEvent {}

class GoToLoginEvent extends AuthEvent {}

//Todo: add event to go to Registering event