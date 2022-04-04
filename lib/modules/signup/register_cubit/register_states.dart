
import '../../../models/login_model.dart';

abstract class SignUpStates{}

class SignUpInitialState extends SignUpStates{}

class SignUpSuccessState extends SignUpStates{
  final ShopLoginModel loginModel;
  SignUpSuccessState(this.loginModel);
}

class SignUpLoadingState extends SignUpStates{}

class SignUpErrorState extends SignUpStates{
  final String error;
  SignUpErrorState(this.error);
}

class ChangeBottomNavState1 extends SignUpStates{}
