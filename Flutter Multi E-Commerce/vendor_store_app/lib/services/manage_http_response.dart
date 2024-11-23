import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  try {
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');  // Debug için response body'yi yazdırıyoruz

    switch (response.statusCode) {
      case 200:
        onSuccess();
        break;
      case 201:
        onSuccess();
        break;
      case 400:
        final responseData = json.decode(response.body);
        final message = responseData is Map 
            ? (responseData['msg'] ?? responseData['message'] ?? 'Bad Request Error') 
            : responseData.toString();
        showSnackBar(context, message);
        break;
      case 500:
        String errorMessage;
        try {
          final responseData = json.decode(response.body);
          if (responseData is Map) {
            errorMessage = responseData['error'] ?? 
                         responseData['message'] ?? 
                         responseData['msg'] ??
                         'Internal Server Error';
          } else {
            errorMessage = responseData.toString();
          }
        } catch (e) {
          errorMessage = response.body ?? 'Internal Server Error';
        }
        showSnackBar(context, errorMessage);
        print('Server Error Details: $errorMessage'); // Debug için detaylı hata
        break;
      default:
        showSnackBar(context, 'Unexpected error occurred (Status: ${response.statusCode})');
        break;
    }
  } catch (e) {
    print('Error in manageHttpResponse: $e');
    showSnackBar(context, 'An error occurred while processing the response');
  }
}

void showSnackBar(BuildContext context, String message) {
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}