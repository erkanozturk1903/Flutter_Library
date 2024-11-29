import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            Icons.assistant,
            size: 64,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 16),
          Text(
            "Merhaba! Size nasıl yardımcı olabilirim?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Aşağıdaki önerilerden birini seçebilir veya kendi sorunuzu sorabilirsiniz:",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}