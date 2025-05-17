import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vulnerability_learn_app/services/gemini_service.dart';

class RoadmapPage extends StatefulWidget {
  final String skillLevel;
  final List<String> selectedTopics;
  final Function(int?, int?, String?, String?)? onStepCompleted;

  const RoadmapPage(
      {Key? key,
      required this.skillLevel,
      required this.selectedTopics,
      this.onStepCompleted})
      : super(key: key);

  @override
  _RoadmapPageState createState() => _RoadmapPageState();
}

class _RoadmapPageState extends State<RoadmapPage> {
  List<bool> _completed = [];
  List<Map<String, dynamic>> _roadmapSteps = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadRoadmapAndCompletedStates();
  }

  Future<void> _loadRoadmapAndCompletedStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedRoadmap = prefs.getStringList('roadmap');
    List<bool> loadedCompleted = [];

    if (encodedRoadmap != null) {
      _roadmapSteps = encodedRoadmap
          .map((step) => jsonDecode(step) as Map<String, dynamic>)
          .toList();

      for (int i = 0; i < _roadmapSteps.length; i++) {
        loadedCompleted.add(prefs.getBool('step_$i') ?? false);
      }
    } else {
      _roadmapSteps = [];
    }

    setState(() {
      _completed = loadedCompleted;
    });
  }

  Future<void> _generateRoadmap() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final geminiService = GeminiService();
      final roadmap = await geminiService.getRoadmap(
          widget.skillLevel, widget.selectedTopics);

      setState(() {
        _roadmapSteps = roadmap;
        _completed = List.generate(_roadmapSteps.length, (index) => false);
        _isLoading = false;
      });
      await _saveRoadmapAndCompletedStates();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _roadmapSteps = []; // Clear the roadmap steps
        _completed = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate roadmap. Please try again.'),
        ),
      );
    }
  }

  Future<void> _saveRoadmapAndCompletedStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedRoadmap =
        _roadmapSteps.map((step) => jsonEncode(step)).toList();
    await prefs.setStringList('roadmap', encodedRoadmap);

    for (int i = 0; i < _completed.length; i++) {
      await prefs.setBool('step_$i', _completed[i]);
    }

    int lastCompletedIndex =
        _completed.lastIndexWhere((element) => element == true);
    int nextIncompleteIndex =
        _completed.indexWhere((element) => element == false);

    String? lastCompletedTitle = lastCompletedIndex != -1
        ? _roadmapSteps[lastCompletedIndex]['title']
        : null;

    String? nextIncompleteTitle = nextIncompleteIndex != -1
        ? _roadmapSteps[nextIncompleteIndex]['title']
        : null;

    await prefs.setInt('lastCompletedIndex', lastCompletedIndex);
    await prefs.setInt('nextIncompleteIndex', nextIncompleteIndex);
    if (lastCompletedTitle != null) {
      await prefs.setString('lastCompletedTitle', lastCompletedTitle);
    }
    if (nextIncompleteTitle != null) {
      await prefs.setString('nextIncompleteTitle', nextIncompleteTitle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/assets_task_01jva7s46rejn9q8vptfg5v7x8_1747321732_img_0.png', // Replace with actual road image path
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: SizedBox(
              width: 260,
              child: Center(
                child: Text(
                  "Your Learning Roadmap",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent, // Or dark gray
            elevation: 0, // Or a subtle shadow
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: _completed.isNotEmpty
                                ? _completed
                                        .where((element) => element)
                                        .length /
                                    _completed.length
                                : 0,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.greenAccent),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Progress: ${_completed.where((element) => element).length} of ${_completed.length} completed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_roadmapSteps.isEmpty && !_isLoading)
                    Text(
                      "There was an issue generating the roadmap using the Gemini API. Displaying a default roadmap instead.",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  Expanded(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: _roadmapSteps.length,
                            itemBuilder: (context, index) {
                              final isCompleted = index < _completed.length
                                  ? _completed[index]
                                  : false;
                              return Align(
                                alignment: index.isEven
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: SizedBox(
                                  width: 200, // Adjust width as needed
                                  child: Card(
                                    color: isCompleted
                                        ? Colors.grey[700]
                                        : Colors.grey[800]!.withOpacity(
                                            0.7), // Dark gray background
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors
                                                    .white, // Border color
                                                width: 1.5, // Border width
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                  4), // Optional: Add rounded corners
                                            ),
                                            child: Transform.scale(
                                              scale: 1.2, // Increase the size
                                              child: Checkbox(
                                                value: isCompleted,
                                                onChanged: (value) async {
                                                  setState(() {
                                                    _completed[index] = value!;
                                                  });
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  prefs.setBool(
                                                      'step_$index', value!);
                                                  widget.onStepCompleted?.call(
                                                      _completed.lastIndexWhere(
                                                          (element) => element),
                                                      _completed.indexWhere(
                                                          (element) =>
                                                              !element),
                                                      _roadmapSteps.isNotEmpty &&
                                                              _completed.lastIndexWhere((element) => element) !=
                                                                  -1
                                                          ? _roadmapSteps[_completed.lastIndexWhere((element) => element)]
                                                              ['title']
                                                          : null,
                                                      _roadmapSteps.isNotEmpty &&
                                                              _completed.indexWhere(
                                                                      (element) =>
                                                                          !element) !=
                                                                  -1
                                                          ? _roadmapSteps[_completed.indexWhere((element) => !element)]
                                                              ['title']
                                                          : null);
                                                  await _saveRoadmapAndCompletedStates();
                                                },
                                                activeColor: Colors.green,
                                                checkColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _roadmapSteps[index]
                                                          ['title'] ??
                                                      "", // Use roadmap title
                                                  style: TextStyle(
                                                    color: isCompleted
                                                        ? Colors.grey[400]
                                                        : Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  _roadmapSteps[index]
                                                          ['description'] ??
                                                      "", // Use roadmap description
                                                  style: TextStyle(
                                                    color: isCompleted
                                                        ? Colors.grey[500]
                                                        : Colors.grey[
                                                            400], // Light gray font
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _generateRoadmap();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Generate New Roadmap",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
