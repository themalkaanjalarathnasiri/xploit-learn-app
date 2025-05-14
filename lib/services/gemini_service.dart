import 'package:http/http.dart' as http;
import 'dart:convert';
import '../secrets.dart'; // Make sure GEMINI_API_KEY is here

class GeminiService {
  Future<List<String>> generateSearchQueries(
      String skillLevel, List<String> selectedTopics) async {
    final prompt =
        "I am a $skillLevel in ${selectedTopics.join(', ')}. I want YouTube video recommendations to further my knowledge.";

    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$GEMINI_API_KEY');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text =
          data['candidates'][0]['content']['parts'][0]['text'] as String;
      return text.split('\n').map((e) => e.trim()).toList();
    } else {
      print('Gemini API error: ${response.statusCode}');
      print('Response body: ${response.body}');
      return [];
    }
  }

  Future<String> getGeminiAnswer(String prompt) async {
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$GEMINI_API_KEY');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'] as String;
    } else {
      print('Gemini API error: ${response.statusCode}');
      print('Response body: ${response.body}');
      return 'Error: ${response.statusCode}';
    }
  }
}
