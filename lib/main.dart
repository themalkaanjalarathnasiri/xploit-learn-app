import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vulnerability_learn_app/pages/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:vulnerability_learn_app/pages/video_recommendation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const XploitLearn());
}

class XploitLearn extends StatelessWidget {
  const XploitLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Xploit Learn",
      home: const SplashScreen(),
    );
  }
}
