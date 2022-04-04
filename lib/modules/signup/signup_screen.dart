// ignore_for_file: avoid_print, deprecated_member_use

import 'package:buildcondition/buildcondition.dart';
import 'package:cic_app/layout/rafeq.dart';
import 'package:cic_app/modules/signup/register_cubit/register_cubit.dart';
import 'package:cic_app/modules/signup/register_cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../../models/components.dart';
import '../../network/local/cache_helper.dart';
import '../login/login_screen.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {

  SignUpScreen({Key? key}) : super(key: key);

  final _nameController1 = TextEditingController();
  final _emailController1 = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _phoneController1 = TextEditingController();
  var formSignUpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Color.fromRGBO(69, 125, 88, 1),),
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (BuildContext context) => ShopSignUpCubit(),
        child: BlocConsumer<ShopSignUpCubit, SignUpStates>(
          listener: (context, state) {
            if (state is SignUpSuccessState) {
              if (state.loginModel.status == true) {
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
            var cubit = ShopSignUpCubit.get(context);
            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //lottie
                    const SizedBox(
                      width: 217,
                      height: 92,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Image(
                          image: AssetImage('assets/images/c4.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: Text('sign-up'.toUpperCase(),style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w600),),
                    ),
                    Form(
                      key: formSignUpKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              customTextFormField(
                                c: _emailController1,
                                validator: ValidationBuilder().email().build(),
                                action: TextInputAction.next,
                                type: TextInputType.emailAddress,
                                text: 'Email',
                              ),
                              const SizedBox(height: 10),
                              customTextFormField(
                                c: _passwordController1,
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
                              customTextFormField(
                                c: _nameController1,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  } else {
                                    return null;
                                  }
                                },
                                action: TextInputAction.next,
                                type: TextInputType.name,
                                text: 'Name',
                              ),
                              const SizedBox(height: 10),
                              customTextFormField(
                                c: _phoneController1,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your phone';
                                  } else {
                                    return null;
                                  }
                                },
                                action: TextInputAction.done,
                                type: TextInputType.phone,
                                text: 'Phone',
                              ),
                              const SizedBox(height: 30),
                              BuildCondition(
                                condition: state is! SignUpLoadingState,
                                builder: (context) => FlatButton(
                                  color: const Color.fromRGBO(203, 221, 209, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //minWidth: 500,
                                  onPressed: () {
                                    if (formSignUpKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      ShopSignUpCubit.get(context).userSignUp(
                                        name: _nameController1.text,
                                        email: _emailController1.text,
                                        phone: _phoneController1.text,
                                        password: _passwordController1.text,
                                      );
                                    } else {
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                                    child: Text('CREATE NEW\n    ACCOUT',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400
                                        )),
                                  ),
                                ),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator()),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


