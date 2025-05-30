import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lab.dart';

class LabService {
  static const String baseUrl = 'http://10.0.2.2:5000/api/lab-recommendations';

  static Future<List<Lab>> getLabRecommendations(
      String skillLevel, List<String> topics) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'skillLevel': skillLevel,
          'topics': topics,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body
            .map((json) => Lab(
                  name: json['title'],
                  description: json['description'],
                  source: json['source'],
                ))
            .toList();
      } else {
        throw Exception(
            'Failed to load lab recommendations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load lab recommendations: ${e.toString()}');
    }
  }
}
