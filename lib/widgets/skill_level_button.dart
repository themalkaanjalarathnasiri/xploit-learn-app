import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';

class SkillLevelButton extends StatelessWidget {
  final String skillLevel;
  final String selectedSkillLevel;
  final VoidCallback onPressed;

  const SkillLevelButton({
    Key? key,
    required this.skillLevel,
    required this.selectedSkillLevel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: skillLevel == selectedSkillLevel ? kGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kGreen,
            width: 2,
          ),
        ),
        child: Text(
          skillLevel,
          style: TextStyle(
            color: kWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
