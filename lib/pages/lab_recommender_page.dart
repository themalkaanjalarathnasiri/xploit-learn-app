import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/services/lab_service.dart';
import 'package:vulnerability_learn_app/models/lab.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';
import 'package:lottie/lottie.dart';

class LabRecommenderPage extends StatefulWidget {
  final String skillLevel;
  final List<String> selectedTopics;
  const LabRecommenderPage(
      {super.key, required this.skillLevel, required this.selectedTopics});

  @override
  _LabRecommenderPageState createState() => _LabRecommenderPageState();
}

class _LabRecommenderPageState extends State<LabRecommenderPage> {
  late Future<List<Lab>> _labsFuture;

  @override
  void initState() {
    super.initState();
    _labsFuture = LabService.getLabRecommendations(
        widget.skillLevel, widget.selectedTopics);
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
            child: const Text(
              'Lab Recommender',
              style: TextStyle(
                color: kWhite,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Lottie.asset(
              'assets/animation/Animation - 1747459555404.json',
              fit: BoxFit.cover, // Adjust the height as needed
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/training.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'These Labs will help you to improve your skills as a ${widget.skillLevel} in ${widget.selectedTopics.join(', ')}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<Lab>>(
                  future: _labsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<Lab> labs = snapshot.data!;
                      return ListView.builder(
                        itemCount: labs.length,
                        itemBuilder: (context, index) {
                          Lab lab = labs[index];
                          String imagePath;
                          switch (lab.source) {
                            case "TryHackMe":
                              imagePath = "assets/images/tryhackme.png";
                              break;
                            case "Hack The Box":
                              imagePath = "assets/images/hackthebox.png";
                              break;
                            case "PortSwigger":
                            case "PortSwigger Web Security Academy":
                              imagePath = "assets/images/portswigger.png";
                              break;
                            default:
                              imagePath =
                                  "assets/images/vulnerability.png"; // Default image
                          }
                          return Card(
                            color: kBlack.withOpacity(0.6),
                            margin: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imagePath,
                                    height: 50,
                                    width: 50,
                                  ),
                                  Text(
                                    lab.name,
                                    style: const TextStyle(
                                      color: kWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    lab.description,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: kWhite,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Source: ${lab.source}",
                                    style: const TextStyle(
                                      color: kWhite,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No labs found.'));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
