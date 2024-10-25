import 'package:flutter/material.dart';
import 'package:mira_academy/common/utils/app_colors.dart';

BoxDecoration appBoxShadow(
  {
    Color color = AppColors.primaryElement, 
    double radius = 15,
  double sR= 1.0,
  double bR=2.0,
  }
) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        spreadRadius: sR,
        blurRadius: bR,
        offset: const Offset(0, 1),
      )
    ],
  );
}
