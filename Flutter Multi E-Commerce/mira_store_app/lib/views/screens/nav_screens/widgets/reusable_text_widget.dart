import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTextWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const ReusableTextWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subTitle,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
