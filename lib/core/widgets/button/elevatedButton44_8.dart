import 'package:flutter/material.dart';

class ElevatedButton448 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;

  const ElevatedButton448({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color.fromRGBO(79, 165, 111, 1),
    this.textColor = Colors.white,
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
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
