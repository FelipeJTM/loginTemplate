part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}
class InitialState extends AuthState {}

class UnAuthenticatedState extends AuthState {}

class AuthenticatedState extends AuthState {}

class RegisteringState extends AuthState {}

