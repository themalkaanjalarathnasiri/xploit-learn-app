import 'package:flutter/material.dart';
import 'package:vulnerability_learn_app/utils/colors.dart';
import '../models/video.dart';
import '../services/gemini_service.dart';
import '../services/youtube_service.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoRecommendationScreen extends StatefulWidget {
  final String skillLevel;
  final List<String> selectedTopics;
  final List<Map<String, String>> roadmap;
  final int nextStepIndex;

  VideoRecommendationScreen({
    required this.skillLevel,
    required this.selectedTopics,
    required this.roadmap,
    required this.nextStepIndex,
  });

  @override
  _VideoRecommendationScreenState createState() =>
      _VideoRecommendationScreenState();
}

class _VideoRecommendationScreenState extends State<VideoRecommendationScreen> {
  final GeminiService _geminiService = GeminiService();
  final YoutubeService _youtubeService = YoutubeService();
  List<Video> _videos = [];
  bool _useMockData = false; // Optional: Mock Data Mode

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    if (_useMockData) {
      // Mock data
      setState(() {
        _videos = [
          Video(
              title: 'Mock Video 1',
              videoId: 'mock1',
              thumbnailUrl: 'https://via.placeholder.com/150',
              channel: 'Mock Channel 1'),
          Video(
              title: 'Mock Video 2',
              videoId: 'mock2',
              thumbnailUrl: 'https://via.placeholder.com/150',
              channel: 'Mock Channel 2'),
        ];
      });
    } else {
      // API calls
      final nextStep = widget.roadmap[widget.nextStepIndex]['title'] ?? "";
      final queries = await _geminiService.generateSearchQueries(nextStep);
      print(nextStep);
      final videos = await _youtubeService.getVideos(queries);
      setState(() {
        _videos = videos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreen,
      appBar: AppBar(
        backgroundColor: kGreen,
        title: Text(
          'Video Recommendations',
          style: TextStyle(
            color: kWhite,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _videos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/montage.png",
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "These videos will help you completing next step.",
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _videos.length > 5 ? 5 : _videos.length,
                    itemBuilder: (context, index) {
                      final video = _videos[index];
                      return InkWell(
                        onTap: () async {
                          final url =
                              "https://www.youtube.com/watch?v=${video.videoId}";
                          await launchUrl(Uri.parse(url));
                        },
                        child: Card(
                          color: kBlack.withOpacity(0.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                video.thumbnailUrl,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  video.title,
                                  style: TextStyle(
                                    color: kWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "https://www.youtube.com/watch?v=${video.videoId}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.blue),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  video.channel,
                                  style: TextStyle(
                                    color: kWhite,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
