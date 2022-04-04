// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/components.dart';
import '../../network/local/cache_helper.dart';
import '../login/login_screen.dart';

class BoardingModel {
  final String image;
  final String text;
  final String text2;

  BoardingModel({
    required this.image,
    required this.text,
    required this.text2,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/c2.png',
      text: 'HI,WELCOME TO OUR COMMUNITY',
      text2: 'we build scalable intelligent mobile applications that simplify people’s life.',
    ),
    BoardingModel(
      image: 'assets/images/c1.png',
      text: 'BRING YOUR CREATIVE IDEAS',
      text2: 'Share your ideas , build a community , expand your network',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value!) {
        navigateAndFinish(
          LoginScreen(),
          context,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardingController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    print('last');
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    print('not last');
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, item) =>
                    buildBoardingItem(boarding[item]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                  color: Color.fromRGBO(69, 125, 88, 0.25),
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardingController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 10),
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Column buildBoardingItem(BoardingModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Expanded(
          child: SizedBox(
            width: 269,
            height: 226,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Image(
                image: AssetImage('${model.image}'),
              ),
            ),
          ),
        ),
        SizedBox(height: 80),
        Expanded(
          child: Text(
            '${model.text}',
            style: TextStyle(
              fontSize: 26.9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${model.text}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(69, 125, 88, 1)
            ),
          ),
        ),
      ],
    );
  }
}


