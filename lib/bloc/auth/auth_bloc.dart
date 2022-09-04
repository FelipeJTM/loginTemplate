import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

import '../../helper/login_helper.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(UnAuthenticatedState()) {
    on<GoToHomeEvent>((event, emit){
      return emit(AuthenticatedState());
    });
    on<GoToLoginEvent>((event, emit) {
      return emit(UnAuthenticatedState());
    });
    //Todo: handle Registering event
  }
}
