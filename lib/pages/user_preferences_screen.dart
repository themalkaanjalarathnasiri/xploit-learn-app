import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';
import 'package:vulnerability_learn_app/widgets/custom_button.dart';
import 'package:hive/hive.dart';
import 'package:vulnerability_learn_app/pages/home_page.dart';
import 'package:vulnerability_learn_app/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:vulnerability_learn_app/widgets/topic_button.dart';
import 'package:vulnerability_learn_app/widgets/skill_level_button.dart';

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({
    Key? key,
    required this.emailController,
    this.isEditing = false,
    this.selectedSkillLevel,
    this.selectedTopics,
  }) : super(key: key);

  final TextEditingController emailController;
  final bool isEditing;
  final String? selectedSkillLevel;
  final List<String>? selectedTopics;

  @override
  _UserPreferencesScreenState createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  String _skillLevel = "";
  List<String> _selectedTopics = [];

  @override
  void initState() {
    super.initState();
    _skillLevel = widget.selectedSkillLevel ?? "";
    _selectedTopics = widget.selectedTopics ?? [];
  }

  final List<String> _topics = [
    "XSS",
    "SQLi",
    "Command Injection",
    "LFI/RFI",
    "Directory Traversal",
    "SSRF",
    "CSRF",
    "IDOR"
        "Broken Authentication",
    "Insecure Deserialization",
    "HTTP Response Splitting",
    "Web Cache Poisoning",
    "Broken Access Control",
  ];
  final List<String> _skillLevels = ["Beginner", "Intermediate", "Expert"];
  //final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: kBlack,
        title: Column(
          children: const [
            Text(
              "Customize Your",
              style: TextStyle(
                color: kWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Learning Path",
              style: TextStyle(
                color: kWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              const Text(
                "What topics are you most interested in?",
                style: TextStyle(
                  color: kWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 2.0,
                children: _topics.map((topic) {
                  return TopicButton(
                    topic: topic,
                    isSelected: _selectedTopics.contains(topic),
                    onPressed: () {
                      setState(() {
                        if (_selectedTopics.contains(topic)) {
                          _selectedTopics.remove(topic);
                        } else {
                          _selectedTopics.add(topic);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                "What is your current skill level?",
                style: TextStyle(
                  color: kWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8.0,
                children: _skillLevels.map((skillLevel) {
                  return SkillLevelButton(
                    skillLevel: skillLevel,
                    selectedSkillLevel: _skillLevel,
                    onPressed: () {
                      setState(() {
                        _skillLevel = skillLevel;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              GestureDetector(
                onTap: () {
                  _savePreferences();
                },
                child: CustomButton(
                  buttonName: widget.isEditing ? 'Save' : 'Continue',
                  buttonColor: kGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _savePreferences() async {
    print("Selected Topics: $_selectedTopics");
    print("Skill Level: $_skillLevel");

    if (widget.isEditing) {
      Navigator.pop(context, {
        'skillLevel': _skillLevel,
        'topics': _selectedTopics,
      });
    } else {
      // Open the preferences box
      final preferencesBox = await Hive.openBox('preferences');

      // Set the hasSetPreferences flag to true
      await preferencesBox.put(widget.emailController.text, true);

      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  userEmail: widget.emailController.text,
                )),
      );
    }
  }
}
