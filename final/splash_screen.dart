import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'login_Function.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginFunction(),
        ));
    // bool isLogedIn = true;
    // if (isLogedIn) {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const Homescreen(),
    //       ));
    // } else {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const LoginPage(),
    //       ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Lottie.asset("lib/images/Animation .json")),
            const Center(
              child: Text(
                "Staff Registration",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
