import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vulnerability_learn_app/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final preferencesBox = await Hive.openBox('preferences');
  String skillLevel =
      (preferencesBox.get('skillLevel') ?? "Beginner") as String;
  List<String> selectedTopics = List<String>.from(
      (preferencesBox.get('selectedTopics') ?? const []) as List);

  print('User Preferences:');
  print('Skill Level: $skillLevel');
  print('Selected Topics: $selectedTopics');

  runApp(const XploitLearn());
}

class XploitLearn extends StatelessWidget {
  const XploitLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Xploit Learn",
      home: SplashScreen(),
    );
  }
}
