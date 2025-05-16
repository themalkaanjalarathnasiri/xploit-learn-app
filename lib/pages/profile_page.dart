import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vulnerability_learn_app/pages/user_preferences_screen.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';
import 'package:vulnerability_learn_app/widgets/custom_button.dart';
import 'package:vulnerability_learn_app/pages/login_page.dart';
import 'package:vulnerability_learn_app/pages/roadmap_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfilePage extends StatefulWidget {
  final String userEmail;
  final String skillLevel;
  final List<String> selectedTopics;
  final Function(int?, int?, String?, String?)? onStepCompleted;

  const ProfilePage({
    Key? key,
    required this.userEmail,
    required this.skillLevel,
    required this.selectedTopics,
    this.onStepCompleted,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _skillLevel = "";
  List<String> _selectedTopics = [];
  int? _lastCompletedStep;
  int? _nextStep;
  String? _lastCompletedStepTitle;
  String? _nextStepTitle;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastCompletedStep = prefs.getInt('lastCompletedStep') ?? null;
      _nextStep = prefs.getInt('nextStep') ?? null;
    });
  }

  Future<void> _loadPreferences() async {
    final preferencesBox = await Hive.openBox('preferences');
    setState(() {
      _skillLevel =
          (preferencesBox.get('skillLevel') ?? widget.skillLevel) as String;
      _selectedTopics = List<String>.from(
          (preferencesBox.get('selectedTopics') ?? widget.selectedTopics)
              as List);
    });
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/assets_task_01jv97x4f4f2j9f79cttbaffcs_1747288276_img_0 (1).png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            '',
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                    color: kBlack.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: kGreen, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.settings, color: kWhite),
                      title: const Text('Edit Preferences',
                          style: TextStyle(color: kWhite, fontSize: 18)),
                      onTap: () async {
                        final result = await Navigator.push(
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
                        ) as Map<String, dynamic>?;

                        if (result != null) {
                          setState(() {
                            _skillLevel = result['skillLevel'] as String;
                            _selectedTopics = result['topics'] as List<String>;
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Card(
                    color: kBlack.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: kGreen, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.timeline, color: kWhite),
                      title: const Text('Roadmap & Progress',
                          style: TextStyle(color: kWhite, fontSize: 18)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoadmapPage(
                              skillLevel: _skillLevel,
                              selectedTopics: _selectedTopics,
                              onStepCompleted: (lastCompletedStep, nextStep,
                                  lastCompletedStepTitle, nextStepTitle) async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                // Update the state of the ProfilePage
                                setState(() {
                                  _lastCompletedStep = lastCompletedStep;
                                  _nextStep = nextStep;
                                  _lastCompletedStepTitle =
                                      lastCompletedStepTitle;
                                  _nextStepTitle = nextStepTitle;
                                  print(
                                      'Last completed step: $_lastCompletedStep, Next step: $_nextStep, Last completed step title: $_lastCompletedStepTitle, Next step title: $_nextStepTitle');
                                });
                                await prefs.setInt('lastCompletedStep',
                                    lastCompletedStep ?? -1);
                                await prefs.setInt('nextStep', nextStep ?? -1);
                                await _loadProgress();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Card(
                    color: kBlack.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: kGreen, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Completed Step:',
                            style: const TextStyle(
                                color: kWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${_lastCompletedStepTitle ?? 'None'}',
                            style: const TextStyle(color: kWhite, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Next Step:',
                            style: const TextStyle(
                                color: kWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${_nextStepTitle ?? 'None'}',
                            style: const TextStyle(color: kWhite, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
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
      ),
    );
  }
}
