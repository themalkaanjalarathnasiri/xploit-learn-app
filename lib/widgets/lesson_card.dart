import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';

class LessonCard extends StatelessWidget {
  final String cardTitle;
  final String lessonTitle;

  const LessonCard({
    Key? key,
    required this.lessonTitle,
    required this.cardTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
      height: 250.0, // Increased height
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: kBlack.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            cardTitle,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            lessonTitle,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
