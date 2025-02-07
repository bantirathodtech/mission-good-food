// lib/widgets/navigate_pop_back_button.dart
import 'package:flutter/material.dart';

class NavigatePopBackButton extends StatelessWidget {
  final Color color;
  final double size;

  const NavigatePopBackButton({
    super.key,
    this.color = Colors.black,
    this.size = 20.0,
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
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
