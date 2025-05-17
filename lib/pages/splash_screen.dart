import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vulnerability_learn_app/pages/onboarding_page.dart';
import 'package:vulnerability_learn_app/pages/home_page.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';
import 'package:hive/hive.dart';
import 'package:vulnerability_learn_app/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () async {
      // Open the users box
      final usersBox = await Hive.openBox('users');

      // Check if any user is registered
      if (usersBox.isNotEmpty) {
        // Navigate to the home page
        final email = usersBox.keys.first;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(userEmail: email)),
        );
      } else {
        // Navigate to the onboarding page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
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
                "assets/animation/DH7tepTi2C.json",
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
