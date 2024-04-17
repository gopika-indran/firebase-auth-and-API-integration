import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mock/login.dart';

class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3))
        .whenComplete(() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Loginpage(),
            )));
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset("assets/images/welcome.json"),
      ),
    );
  }
}
