
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterLoadingState extends RegisterStates {}

class RegisterPasswordVisibilityState extends RegisterStates {}

class CreateUserSuccessState extends RegisterStates {
  String uid;
  CreateUserSuccessState(this.uid);
}

class CreateUserErrorState extends RegisterStates {
  final String error;

  CreateUserErrorState(this.error);
}
