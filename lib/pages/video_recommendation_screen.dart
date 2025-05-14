import 'package:flutter/material.dart';
import '../models/video.dart';
import '../services/gemini_service.dart';
import '../services/youtube_service.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoRecommendationScreen extends StatefulWidget {
  final String skillLevel;
  final List<String> selectedTopics;

  VideoRecommendationScreen(
      {required this.skillLevel, required this.selectedTopics});

  @override
  _VideoRecommendationScreenState createState() =>
      _VideoRecommendationScreenState();
}

class _VideoRecommendationScreenState extends State<VideoRecommendationScreen> {
  final GeminiService _geminiService = GeminiService();
  final YoutubeService _youtubeService = YoutubeService();
  List<Video> _videos = [];
  bool _useMockData = true; // Optional: Mock Data Mode

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
      final prompt =
          "I am a ${widget.skillLevel} in ${widget.selectedTopics.join(', ')}. I want YouTube video recommendations to further my knowledge.";
      final queries = await _geminiService.generateSearchQueries(
          widget.skillLevel, widget.selectedTopics);
      final videos = await _youtubeService.getVideos(queries);
      setState(() {
        _videos = videos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Recommendations'),
      ),
      body: _videos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                final video = _videos[index];
                return Card(
                  child: InkWell(
                    onTap: () async {
                      final url =
                          "https://www.youtube.com/watch?v=${video.videoId}";
                      await launchUrl(Uri.parse(url));
                    },
                    child: Row(
                      children: [
                        Image.network(
                          video.thumbnailUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  video.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  video.channel,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
