import 'package:flutter/material.dart';

const List<Color> colorsList = [
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  final int selectedColor;

  AppTheme({
    this.selectedColor = 0,
  }) : assert(selectedColor >= 0 && selectedColor < colorsList.length - 1,
            'Colors must be between 0 and ${colorsList.length}');

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorsList[selectedColor],
      appBarTheme:const  AppBarTheme(
        centerTitle: false,
      ));
}
