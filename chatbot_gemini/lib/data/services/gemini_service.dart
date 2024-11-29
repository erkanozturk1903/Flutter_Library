import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

class GeminiService {
  final String apiKey = AppConstants.apiKey;
  final String endpoint = AppConstants.apiEndpoint;

  Future<String> generateResponse(String prompt) async {
    try {
      final url = Uri.parse('$endpoint?key=$apiKey');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [{
            'parts': [{
              'text': prompt
            }]
          }]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // API yanıt yapısına göre parse işlemi
        if (data['candidates'] != null && 
            data['candidates'].isNotEmpty && 
            data['candidates'][0]['content'] != null &&
            data['candidates'][0]['content']['parts'] != null &&
            data['candidates'][0]['content']['parts'].isNotEmpty) {
          return data['candidates'][0]['content']['parts'][0]['text'];
        } else {
          throw Exception('API yanıt formatı geçersiz');
        }
      } else {
        print('API Hata Detayı: ${response.body}'); // Hata ayıklama için
        throw Exception('API yanıt üretemedi: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata Detayı: $e'); // Hata ayıklama için
      throw Exception('Gemini API bağlantı hatası: $e');
    }
  }
}