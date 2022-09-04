import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:login_template/bloc/auth/auth.dart';



void main() {
  authBlocTest();
}

void authBlocTest() {
  group('LoginBloc empty', () {
    blocTest<AuthBloc, AuthState>(
      'just testing',
      build: () => AuthBloc(),
      expect: () => <AuthState>[],
    );

  });
  group('LoginBloc good', () {
    blocTest<AuthBloc, AuthState>(
      'trying to enter with good credentials',
      build: () => AuthBloc(),
      //act: (bloc) => bloc.add(SignIn(userName:'felipe',password:'1234')),
      act: (bloc) => bloc.add(GoToHomeEvent()),
      expect: () => <AuthState>[AuthenticatedState()],
    );
  });
}
