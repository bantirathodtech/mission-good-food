//TODO:  Loaders for background processes
// lib/core/loading_indicators/background_task.dart
import 'package:flutter/material.dart';

class BackgroundTaskIndicator extends StatelessWidget {
  final bool isLoading;
  final String? message;
  final Color? color;

  const BackgroundTaskIndicator({
    super.key,
    required this.isLoading,
    this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? Colors.white,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(width: 8),
            Text(
              message!,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}