import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vulnerability_learn_app/pages/user_preferences_screen.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';
import 'package:vulnerability_learn_app/widgets/custom_button.dart';
import 'package:vulnerability_learn_app/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  final String userEmail;
  final String skillLevel;
  final List<String> selectedTopics;

  const ProfilePage({
    Key? key,
    required this.userEmail,
    required this.skillLevel,
    required this.selectedTopics,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _skillLevel = "";
  List<String> _selectedTopics = [];

  @override
  void initState() {
    super.initState();
    _skillLevel = widget.skillLevel;
    _selectedTopics = List<String>.from(widget.selectedTopics);
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: kBlack,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header Section
              Column(
                children: [
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/man.png'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Logged in as:",
                    style: TextStyle(
                      color: kGreen,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    widget.userEmail,
                    style: const TextStyle(color: kWhite, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Card(
                  color: kBlack,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: kGreen, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.settings, color: kWhite),
                    title: const Text('Edit Preferences',
                        style: TextStyle(color: kWhite, fontSize: 18)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserPreferencesScreen(
                            emailController:
                                TextEditingController(text: widget.userEmail),
                            isEditing: true,
                            selectedSkillLevel: widget.skillLevel,
                            selectedTopics: widget.selectedTopics,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Card(
                  color: kBlack,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: kGreen, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.timeline, color: kWhite),
                    title: const Text('Roadmap & Progress',
                        style: TextStyle(color: kWhite, fontSize: 18)),
                    onTap: () {
                      print("Open Progress");
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () => _logout(context),
                  child: CustomButton(
                    buttonName: 'Logout',
                    buttonColor: kGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
