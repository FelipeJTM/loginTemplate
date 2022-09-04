import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

// Mock Bloc
class MockCounterBloc extends MockBloc<CounterEvent, int>
    implements CounterBloc {}

void main() {
  mainBloc();
}


void mainBloc() {
/*  group('whenListen', () {
    test("Let's mock the CounterBloc's stream!", () {
      // Create Mock CounterBloc Instance
      final bloc = MockCounterBloc();

      // Stub the listen with a fake Stream
      whenListen(bloc, Stream.fromIterable([0, 1, 2, 3]));

      // Expect that the CounterBloc instance emitted the stubbed Stream of
      // states
      expectLater(bloc.stream, emitsInOrder(<int>[0, 1, 2, 3]));
    });
  });*/

  group('CounterBloc', () {
    blocTest<CounterBloc, int>(
      'emits [] when nothing is added',
      build: () => CounterBloc(),
      expect: () => const <int>[],
    );

    blocTest<CounterBloc, int>(
      'emits [1] when CounterIncrementPressed is added',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(CounterIncrementPressed()),
      expect: () => const <int>[1],
    );
  });
}

abstract class CounterEvent {}

class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
  }
}