import 'package:http/http.dart' as http;
import '../models/video.dart';
import 'dart:convert';
import '../secrets.dart';

class YoutubeService {
  Future<List<Video>> getVideos(List<String> queries) async {
    List<Video> videos = [];
    for (final query in queries) {
      final url = Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=5&q=$query&key=$YOUTUBE_API_KEY');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final items = data['items'] as List;
        for (final item in items) {
          final videoId = item['id']['videoId'] as String;
          final title = item['snippet']['title'] as String;
          final thumbnailUrl =
              item['snippet']['thumbnails']['default']['url'] as String;
          final channel = item['snippet']['channelTitle'] as String;
          final video = Video(
              title: title,
              videoId: videoId,
              thumbnailUrl: thumbnailUrl,
              channel: channel);
          videos.add(video);
        }
      } else {
        print('YouTube API error: ${response.statusCode}');
      }
    }
    return videos;
  }
}
