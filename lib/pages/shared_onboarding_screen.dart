import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';

class SharedOnboardingScreen extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  const SharedOnboardingScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: kWhite, // Default text color
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Text(
            description,
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
            imageUrl,
            width: 350,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
