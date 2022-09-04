part of 'register_bloc.dart';

@immutable
abstract class RegisterState extends Equatable{
  RegisterState();

  @override
  List<Object> get props => [];
}

class ReadyToRegisterState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterCompletedState extends RegisterState {
  final bool status;
  RegisterCompletedState({required this.status});
}

class RegisterFailedState extends RegisterState {
  final String error;

  RegisterFailedState(this.error);

  @override
  String toString() {
    return "error: $error";
  }
}
