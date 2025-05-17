import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';
import 'package:vulnerability_learn_app/widgets/lesson_card.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vulnerability_learn_app/services/gemini_service.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LessonsPage extends StatefulWidget {
  final String skillLevel;
  final List<String> selectedTopics;

  LessonsPage({
    Key? key,
    required this.skillLevel,
    required this.selectedTopics,
  }) : super(key: key);

  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  String? _lastCompletedTitle;
  String? _nextIncompleteTitle;
  String? _lastCompletedContent;
  String? _nextIncompleteContent;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLessonContent();
  }

  Future<void> _loadLessonContent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final geminiService = GeminiService();

    _lastCompletedTitle = prefs.getString('lastCompletedTitle');
    _nextIncompleteTitle = prefs.getString('nextIncompleteTitle');

    if (_lastCompletedTitle != null) {
      _lastCompletedContent =
          await geminiService.getLessonContent(_lastCompletedTitle!);
    }

    if (_nextIncompleteTitle != null) {
      _nextIncompleteContent =
          await geminiService.getLessonContent(_nextIncompleteTitle!);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreen,
      appBar: AppBar(
        backgroundColor: kGreen,
        title: SizedBox(
          width: 260,
          child: Center(
            child: Text(
              "Learning Modules",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(
              'assets/animation/Animation - 1747392926307.json',
              fit: BoxFit.cover,
            ),
          ),
          _isLoading
              ? Center(
                  child: Text(
                    "Fetching lessons........",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Skill Level Banner
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/online-lesson.png",
                                width: 80,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "These lessons are tailored for your ${widget.skillLevel} skill level in ${widget.selectedTopics.join(', ')}.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Lesson Cards
                      if (_lastCompletedTitle != null)
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _lastCompletedTitle!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 16.0),
                                          MarkdownBody(
                                            data: _lastCompletedContent ??
                                                "No content available",
                                            styleSheet: MarkdownStyleSheet(
                                              p: TextStyle(color: Colors.white),
                                              h1: TextStyle(
                                                  color: Colors.white),
                                              h2: TextStyle(
                                                  color: Colors.white),
                                              h3: TextStyle(
                                                  color: Colors.white),
                                              h4: TextStyle(
                                                  color: Colors.white),
                                              h5: TextStyle(
                                                  color: Colors.white),
                                              h6: TextStyle(
                                                  color: Colors.white),
                                              em: TextStyle(
                                                  color: Colors.white),
                                              strong: TextStyle(
                                                  color: Colors.white),
                                              a: TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: LessonCard(
                            lessonTitle: _lastCompletedTitle!,
                            cardTitle: 'Last Completed Lesson',
                          ),
                        ),
                      if (_nextIncompleteTitle != null)
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _nextIncompleteTitle!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 16.0),
                                          MarkdownBody(
                                            data: _nextIncompleteContent ??
                                                "No content available",
                                            styleSheet: MarkdownStyleSheet(
                                              p: TextStyle(color: Colors.white),
                                              h1: TextStyle(
                                                  color: Colors.white),
                                              h2: TextStyle(
                                                  color: Colors.white),
                                              h3: TextStyle(
                                                  color: Colors.white),
                                              h4: TextStyle(
                                                  color: Colors.white),
                                              h5: TextStyle(
                                                  color: Colors.white),
                                              h6: TextStyle(
                                                  color: Colors.white),
                                              em: TextStyle(
                                                  color: Colors.white),
                                              strong: TextStyle(
                                                  color: Colors.white),
                                              a: TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: LessonCard(
                            lessonTitle: _nextIncompleteTitle!,
                            cardTitle: 'Next Lesson',
                          ),
                        ),
                      if (_lastCompletedTitle == null &&
                          _nextIncompleteTitle == null)
                        Center(
                          child: Text(
                            "No lessons available. Please complete steps in the roadmap.",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
