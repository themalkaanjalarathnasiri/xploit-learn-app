import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';

class TopicButton extends StatelessWidget {
  final String topic;
  final bool isSelected;
  final VoidCallback onPressed;

  const TopicButton({
    Key? key,
    required this.topic,
    required this.isSelected,
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
          color: isSelected ? kGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kGreen,
            width: 2,
          ),
        ),
        child: Text(
          topic,
          style: TextStyle(
            color: kWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
