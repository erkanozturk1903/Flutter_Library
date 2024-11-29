import 'package:flutter/material.dart';

class Suggestions extends StatelessWidget {
  final Function(String) onSuggestionTap;

  const Suggestions({Key? key, required this.onSuggestionTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      "Hava durumu nasıl?",
      "En yakın restoran nerede?",
      "Bugün ne yapmalıyım?",
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        children: suggestions.map((suggestion) => 
          ActionChip(
            label: Text(suggestion),
            onPressed: () => onSuggestionTap(suggestion),
          ),
        ).toList(),
      ),
    );
  }
}