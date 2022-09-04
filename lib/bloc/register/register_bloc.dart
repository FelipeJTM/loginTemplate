
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../helper/register_helper.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(ReadyToRegisterState()) {
    on<AttemptToRegisterUserEvent>((event, emit) async{
      try {
        emit(RegisterLoadingState());
        RegisterHelper registerHelper = RegisterHelper(
          email: event.email,
          password: event.password,
          userName: event.userName,
        );
        bool dataSavedCorrectly = await registerHelper.saveUserData();
        emit(RegisterCompletedState(status: dataSavedCorrectly));
      } on Exception catch (e) {
        emit(RegisterFailedState(e.toString()));
      }
    });
  }
}
