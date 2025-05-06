import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/pages/splash_screen.dart';

void main() {
  runApp(const VulnerabilityLearnApp());
}

class VulnerabilityLearnApp extends StatelessWidget {
  const VulnerabilityLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Xploit Learn",
      home: SplashScreen(),
    );
  }
}
