part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class AttemptToRegisterUserEvent extends RegisterEvent {
  final String userName;
  final String password;
  final String email;

  AttemptToRegisterUserEvent({
    required this.email,
    required this.userName,
    required this.password,
  });
}
