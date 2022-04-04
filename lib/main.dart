// ignore_for_file: unnecessary_new

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cic_app/layout/rafeq.dart';
import 'package:flutter/material.dart';

import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'network/local/bloc_observer.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  HttpOverrides.global = new MyHttpOverrides();

  Widget widget;

  late bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  late String? token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const RafeqScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    onBoarding = false;
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({Key? key, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorr = Color.fromRGBO(69, 125, 88, 0.25);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: colorr,
        //scaffoldBackgroundColor: Colors.white60,
        appBarTheme: const AppBarTheme(
          // systemOverlayStyle: SystemUiOverlayStyle(
          //   statusBarColor: Colors.deepOrange,
          //   statusBarIconBrightness: Brightness.light
          // ),
            titleTextStyle: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            titleSpacing: 20,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey,
            elevation: 20),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.deepOrange),
        ),
      ),
      home: startWidget,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(),
    );
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
