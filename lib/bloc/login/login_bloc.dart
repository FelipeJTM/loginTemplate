
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../helper/login_helper.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginWithUserAndPassword>((event, emit) async {
     try{
       emit(LoginLoadingState());
       LoginHelper loginHelper = LoginHelper(event.userName, event.password);
       bool correctCredentials = await loginHelper.verifyUserAndPassword();
       if(correctCredentials) return emit(LoginSuccessfulState());
       return emit(LoginBadCredentialsState());
     }catch(exception){
       return emit(LoginErrorState(exception.toString()));
     }
    });
  }
}