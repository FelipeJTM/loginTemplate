import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_template/bloc/register/register_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  registerBlocTest();
}

void registerBlocTest() {
  group("Basic cases", () {
    blocTest<RegisterBloc, RegisterState>(
      "basic credentials - {This should work}",
      build: () => RegisterBloc(),
      act: (bloc) => bloc.add(
        AttemptToRegisterUserEvent(
          userName: 'felipe_test',
          password: '1234',
          email: 'felipe_test@gmail.com',
        ),
      ),
      expect: () => <RegisterState>[RegisterLoadingState(),const RegisterCompletedState(status: true)],
    );
  });
}
