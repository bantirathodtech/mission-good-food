import 'package:flutter/material.dart';

class OutlineButton448 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;

  const OutlineButton448({
    super.key,
    required this.text,
    required this.onPressed,
    // this.borderColor = Colors.black,
    // this.textColor = Colors.black,
    this.borderColor = const Color.fromRGBO(138, 148, 163, 1),
    this.textColor = const Color.fromRGBO(65, 61, 50, 1),
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      margin: const EdgeInsets.all(16),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor), // Border color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor, // Text color
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
