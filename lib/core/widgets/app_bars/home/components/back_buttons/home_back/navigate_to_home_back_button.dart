// lib/widgets/navigate_to_home_back_button.dart
import 'package:flutter/material.dart';

class NavigateToHomeBackButton extends StatelessWidget {
  final Color color;
  final double size;
  final VoidCallback onBackToHome;

  const NavigateToHomeBackButton({
    super.key,
    this.color = Colors.black,
    this.size = 20.0,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: size,
          color: color,
        ),
        onPressed: onBackToHome,
      ),
    );
  }
}
