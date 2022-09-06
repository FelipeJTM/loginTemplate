part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessfulState extends LoginState {}

class LoginBadCredentialsState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  const LoginErrorState(this.error);

  @override
  String toString() {
    // TODO: implement toString
    return "Error: $error";
  }
}
