//TODO: Circular progress during API calls
// lib/core/loading_indicators/api_loading.dart
import 'package:flutter/material.dart';

class ApiLoadingIndicator extends StatelessWidget {
  final bool isLoading;
  final Color? color;
  final double size;
  final double strokeWidth;

  const ApiLoadingIndicator({
    super.key,
    required this.isLoading,
    this.color,
    this.size = 24.0,
    this.strokeWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();

    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}