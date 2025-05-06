import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';

class FirstOnboardingScreen extends StatelessWidget {
  const FirstOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: kWhite, // Default text color
              ),
              children: [
                TextSpan(text: "Welcome to "), // Normal text
                TextSpan(
                  text: "X",
                  style: TextStyle(color: kGreen), // Different color for "X"
                ),
                TextSpan(text: "ploit Learn"), // Normal text continues
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Text(
            "Master the art of ethical hacking and vulnerability exploitation with AI-driven learning",
            style: TextStyle(
              color: kWhite,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Image.asset(
            "assets/images/Hacker-bro.png",
            width: 350,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
