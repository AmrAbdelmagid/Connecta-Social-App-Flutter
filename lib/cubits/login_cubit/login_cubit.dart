import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connecta_social_app/cubits/login_cubit/login_states.dart';
import 'package:connecta_social_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = false;



  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    emit(LoginPasswordVisibilityState());
  }

  void login({required String email, required String password}) async {
    isLogout = false;
    emit(LoginLoadingState());
    try {
       UserCredential response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccessState(response.user!.uid));
    }
    catch(error){
      log(error.toString());
      isLogin = false;
      emit(LoginErrorState(error.toString()));
    }
  }
}
