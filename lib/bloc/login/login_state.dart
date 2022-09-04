part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
//Todo add the states to:
//loading state
//good credentials state
//bad credentials state
//error state