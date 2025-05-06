import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vulnerability_learn_app/pages/onboarding_page.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBlack,
      body: Column(
        children: [
          Expanded(
            // Gives more space to the main animation
            child: Center(
              child: Lottie.asset(
                "assets/animation/Artboard 1.json",
                width: screenWidth, // Responsive width
                height: screenHeight, // Adjust height based on screen size
                // fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
