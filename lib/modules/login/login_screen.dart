// ignore_for_file: avoid_print, deprecated_member_use

import 'package:buildcondition/buildcondition.dart';
import 'package:cic_app/layout/rafeq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../models/components.dart';
import '../../network/local/cache_helper.dart';
import '../signup/signup_screen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.status);
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(
                  const RafeqScreen(),
                  context,
                );
              });
            } else {
              print(state.loginModel.message);
              String? m = state.loginModel.message;
              MotionToast.error(
                description: Text(
                  m!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15),
                ),
                animationType: ANIMATION.fromLeft,
                //layoutOrientation: ORIENTATION.rtl,
                position: MOTION_TOAST_POSITION.bottom,
                width: 300,
                height: 100,
              ).show(context);
            }
          }
        },
        builder: (context, state) {
          //final cubit = ShopLoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //lottie
                    const SizedBox(
                      width: 147,
                      height: 89,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Image(
                          image: AssetImage('assets/images/c3.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Hello'.toUpperCase(),style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 20),
                    Text('sign-in'.toUpperCase(),style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w600),),
                    Form(
                      key: formLoginKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              customTextFormField(
                                c: _emailController,
                                validator: ValidationBuilder().email().build(),
                                action: TextInputAction.next,
                                type: TextInputType.emailAddress,
                                text: 'Email',
                              ),
                              const SizedBox(height: 10),
                              customTextFormField(
                                c: _passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  } else {
                                    return null;
                                  }
                                },
                                action: TextInputAction.next,
                                type: TextInputType.visiblePassword,
                                text: 'Password',
                              ),
                              const SizedBox(height: 10),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'welcom!',
                                  style: TextStyle(
                                    color: Color.fromRGBO(69, 125, 88, 1),
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              BuildCondition(
                                condition: state is! ShopLoginLoadingState,
                                builder: (context) => FlatButton(
                                  color: const Color.fromRGBO(203, 221, 209, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //minWidth: 500,
                                  onPressed: () {
                                    if (formLoginKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      ShopLoginCubit.get(context).login(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                    } else {
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
                                    child: Text('sign-in'.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700
                                        )),
                                  ),
                                ),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
                              ),
                              const SizedBox(height: 30),
                              const Text('Don’t have an account? ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                              const SizedBox(height: 30),
                              Align(
                                alignment: Alignment.center,
                                child:FlatButton(
                                  color: const Color.fromRGBO(203, 221, 209, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //minWidth: 500,
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                                    child: Text('Register Now',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
