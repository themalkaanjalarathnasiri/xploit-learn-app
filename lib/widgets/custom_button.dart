import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
            color: kWhite,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
