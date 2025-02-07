import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  final double length;
  final double thickness;
  final Color color;
  final double borderRadius;

  const LineWidget({
    super.key,
    required this.length,
    required this.thickness,
    required this.color,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: length,
      height: thickness,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/*
const Spacer(), // Dynamically takes up available space
Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
       padding: const EdgeInsets.only(bottom: 8),
       child: LineWidget(
         length: 200,
         thickness: 5,
         color: const Color.fromRGBO(29, 191, 115, 1),
         borderRadius: 12.0,
       ),
    ),
 ),
*/
