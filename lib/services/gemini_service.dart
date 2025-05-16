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

  Future<List<Map<String, String>>> getRoadmap(
      String skillLevel, List<String> selectedTopics) async {
    final prompt = '''
    Generate a detailed roadmap in JSON format for a $skillLevel in the following specific topics: ${selectedTopics.join(', ')}. 
    The roadmap MUST be based on these topics. The JSON should be a list of roadmap steps, where each step is a JSON object with a "title" key (string) and a "description" key (string). The description should be a concise, one-sentence summary of the step.
    Example:
    [
      {"title": "Step 1: Learn the basics", "description": "Understand the fundamental concepts."},
      {"title": "Step 2: Practice coding", "description": "Write code to reinforce your understanding."}
    ]
    ''';

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

      print('Gemini API Response: $text'); // Print the raw response

      // Remove backticks and trim whitespace
      String cleanedText =
          text.replaceAll('```json', '').replaceAll('```', '').trim();

      // Remove any leading text before the JSON start character
      final jsonStartIndex = cleanedText.indexOf('[');
      if (jsonStartIndex != -1) {
        cleanedText = cleanedText.substring(jsonStartIndex);
      }

      // Check for valid JSON
      if (!cleanedText.startsWith('[')) {
        print('Invalid JSON format: Missing start character');
        return [
          {
            'title': 'Learn the Basics',
            'description': 'Understand the fundamental concepts.'
          },
          {
            'title': 'Practice Coding',
            'description': 'Write code to reinforce your understanding.'
          },
          {
            'title': 'Build Projects',
            'description': 'Apply your knowledge to real-world scenarios.'
          },
        ];
      }

      // Parse the JSON response
      try {
        final List<dynamic> jsonList = jsonDecode(cleanedText);
        List<Map<String, String>> roadmapSteps = jsonList.map((item) {
          return {
            'title': item['title'] != null ? item['title'].toString() : "",
            'description': item['description'] != null
                ? item['description'].toString()
                : "",
          };
        }).toList();
        return roadmapSteps;
      } catch (e) {
        print('Error parsing JSON: $e');
        return [
          {
            'title': 'Learn the Basics',
            'description': 'Understand the fundamental concepts.'
          },
          {
            'title': 'Practice Coding',
            'description': 'Write code to reinforce your understanding.'
          },
          {
            'title': 'Build Projects',
            'description': 'Apply your knowledge to real-world scenarios.'
          },
        ];
      }
    } else {
      print('Gemini API error: ${response.statusCode}');
      print('Response body: ${response.body}');
      return [
        {
          'title': 'Learn the Basics',
          'description': 'Understand the fundamental concepts.'
        },
        {
          'title': 'Practice Coding',
          'description': 'Write code to reinforce your understanding.'
        },
        {
          'title': 'Build Projects',
          'description': 'Apply your knowledge to real-world scenarios.'
        },
      ];
    }
  }
}
