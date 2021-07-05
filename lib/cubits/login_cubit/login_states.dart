
abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  String uid;
  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginLoadingState extends LoginStates {}

class LoginPasswordVisibilityState extends LoginStates {}
