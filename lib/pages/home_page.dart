import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';
import 'package:vulnerability_learn_app/pages/profile_page.dart';
import 'package:vulnerability_learn_app/pages/video_recommendation_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:vulnerability_learn_app/utils/tips.dart';
import 'package:vulnerability_learn_app/pages/assistant_screen.dart';
import 'package:vulnerability_learn_app/pages/roadmap_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  final String userEmail;

  const HomePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentTip = Tips.getRandomTip();
  String _skillLevel = "Beginner";
  List<String> _selectedTopics = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final preferencesBox = await Hive.openBox('preferences');
    setState(() {
      _skillLevel = (preferencesBox.get('skillLevel') ?? "Beginner") as String;
      _selectedTopics = List<String>.from(
          (preferencesBox.get('selectedTopics') ?? const []) as List);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: kBlack,
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              color: kWhite,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: "X",
                style: TextStyle(color: kGreen),
              ),
              TextSpan(text: "ploit Learn"),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoadmapPage(
                      skillLevel: _skillLevel, selectedTopics: _selectedTopics),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: kGreen,
                child: Icon(Icons.map_sharp, color: kBlack),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    userEmail: widget.userEmail,
                    skillLevel: _skillLevel,
                    selectedTopics: _selectedTopics,
                  ),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: kGreen,
                child: Icon(Icons.person, color: kBlack),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Lottie Animation in the Background
          Positioned.fill(
            child: Opacity(
              opacity: 0.5, // Adjust the opacity as needed
              child: Lottie.asset(
                'assets/animation/Animation - 1747234102274.json',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content in the Foreground
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome back, Analyst!",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Ready to enhance your skills?",
                  style: TextStyle(
                    color: kLightGrey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildFeatureCard(
                      context,
                      "🧪 Labs",
                      "Start Practicing",
                      "Hands-on vulnerability labs",
                      () => print("Labs tapped"),
                    ),
                    _buildFeatureCard(
                      context,
                      "📚 Tutorials",
                      "Learn Vulnerabilities",
                      "In-depth guides and writeups",
                      () => print("Tutorials tapped"),
                    ),
                    _buildFeatureCard(
                      context,
                      "📺 Videos",
                      "Watch & Learn",
                      "Curated videos by your topics",
                      () => print("Videos tapped"),
                    ),
                    _buildFeatureCard(
                      context,
                      "🤖 Assistant",
                      "Technical Help",
                      "Ask questions or get guidance",
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AssistantScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 500,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kGrey.withOpacity(0.3),
                      border: Border(
                        left: BorderSide(
                          color: kGreen,
                          width: 4,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Today's Tip",
                          style: TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _currentTip,
                          style: const TextStyle(color: kLightGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String icon, String title,
      String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kDarkGrey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: kGreen,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                icon,
                style: const TextStyle(color: kWhite, fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: kLightGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
