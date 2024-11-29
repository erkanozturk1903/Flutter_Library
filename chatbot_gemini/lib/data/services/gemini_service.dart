import 'dart:convert';
import 'package:chatbot_gemini/data/models/message_model.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

class GeminiService {
  final String apiKey = AppConstants.apiKey;
  final String endpoint = AppConstants.apiEndpoint;

 Future<String> generateResponse(List<Message> conversationHistory) async {
    try {
      final url = Uri.parse('$endpoint?key=$apiKey');
      
      // Tüm konuşma geçmişini içeren istek gövdesi
      final requestBody = {
        'contents': conversationHistory.map((msg) => msg.toJson()).toList(),
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        throw Exception('API yanıt üretemedi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gemini API bağlantı hatası: $e');
    }
  }
}