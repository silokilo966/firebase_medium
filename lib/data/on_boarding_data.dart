import 'dart:async';

import 'package:firebase_todoapp/views/OnBoardingPages/firstpage.dart';
import 'package:firebase_todoapp/views/OnBoardingPages/secondpage.dart';
import 'package:flutter/material.dart';

class OnBoardingWidget extends StatefulWidget {
  const OnBoardingWidget({
    Key? key,
  }) : super(key: key);

  @override
  _OnBoardingWidgetState createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  Timer? _timer;
  int currentPage = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
        return setState(() {
          if (currentPage < 1) {
            currentPage++;
          } else {
            currentPage = 0;
          }
          pageController.animateToPage(
            currentPage,
            duration:const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        });
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    // ignore: avoid_print
    print("OnBoarding Dispose timer called");
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          allowImplicitScrolling: true,
          controller: pageController,
          children:const [
            FirstPage(),
            SecondPage(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(18),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                        const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0)
                      ]),
                  child: ElevatedButton(
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('RegisterScreen');
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          decoration: TextDecoration.none),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'LoginScreen');
                        },
                        child: const Text("Sign in")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
