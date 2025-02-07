// // zigzag_pattern.dart
// import 'package:flutter/material.dart';
//
// class ZigZagPattern extends StatelessWidget {
//   final double width;
//   final double height;
//   final Color color;
//
//   const ZigZagPattern({
//     super.key,
//     required this.width,
//     this.height = 10.0,
//     required this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(width, height),
//       painter: ZigZagPainter(color: color),
//     );
//   }
// }
//
// class ZigZagPainter extends CustomPainter {
//   final Color color;
//
//   ZigZagPainter({required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     final Path path = Path();
//     final double zigzagWidth = 20.0; // Width of each zigzag
//
//     path.moveTo(0, 0);
//
//     // Calculate number of zigzags needed
//     int numberOfZigzags = (size.width / zigzagWidth).ceil();
//
//     for (int i = 0; i < numberOfZigzags; i++) {
//       // Draw zigzag pattern
//       path.lineTo((i * zigzagWidth) + (zigzagWidth / 2), size.height);
//       path.lineTo((i * zigzagWidth) + zigzagWidth, 0);
//     }
//
//     // Complete the path
//     path.lineTo(size.width, 0);
//     path.lineTo(0, 0);
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
