// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, avoid_print
import 'package:flutter/material.dart';

Color defaultColor = Colors.deepOrange;

void navigateTo(Widget, context) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

void navigateAndFinish(Widget, context) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) => false,
    );

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';

LinearGradient gradient = const LinearGradient(
  // begin: Alignment.topLeft,
  // end: Alignment.bottomRight,
  colors: <Color>[
    Colors.yellow,
    Colors.amber,
    Colors.orangeAccent,
    Colors.orange,
    Colors.deepOrangeAccent,
    Colors.deepOrange,
  ],
);
TextFormField customTextFormField({
  required validator,
  required action,
  required TextInputType? type,
  required String text,
  required dynamic c,
  IconData? prefix,
  IconData? suffix,
  bool secure = false,
  suffixPressed,
  Function? onSubmit,
}) =>
    TextFormField(
      controller: c,
      validator: validator,
      textInputAction: action,
      keyboardType: type,
      obscureText: secure,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(40),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color.fromRGBO(69, 125, 88, 0.25),),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(69, 125, 88, 0.25),
        labelText: text,
        labelStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(69, 125, 88, 0.54)),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: () {
            suffixPressed();
          },
        ),
      ),
    );

