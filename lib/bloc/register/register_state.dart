part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable{
  const RegisterState();

  @override
  List<Object> get props => [];
}

class ReadyToRegisterState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterCompletedState extends RegisterState {
  final bool status;
  const RegisterCompletedState({required this.status});
}

class RegisterFailedState extends RegisterState {
  final String error;

  const RegisterFailedState(this.error);

  @override
  String toString() {
    return "error: $error";
  }
}
