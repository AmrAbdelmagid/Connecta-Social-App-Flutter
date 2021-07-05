import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connecta_social_app/cubits/register_cubit/register_states.dart';
import 'package:connecta_social_app/models/user_model.dart';
import 'package:connecta_social_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = false;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    emit(RegisterPasswordVisibilityState());
  }

  static String globalUid = '';

  void register(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    isLogout = false;
    emit(RegisterLoadingState());
    try {
      UserCredential response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      globalUid = response.user!.uid;
      createUser(
          name: name, email: email, phone: phone, uid: response.user!.uid);
      // emit(RegisterSuccessState());
    } catch (error) {
      log(error.toString());
      emit(RegisterErrorState(error.toString()));
    }
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uid,
  }) async {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uid: uid,
      image:
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png',
      bio: 'Write your bio...',
      isEmailVerified: false,
    );
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(model.toMap());
      emit(CreateUserSuccessState(uid));
    } catch (error,s) {
      log(s.toString());
      emit(CreateUserErrorState(error.toString()));
    }
  }
}
