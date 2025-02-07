//TODO: Linear progress bar for uploads/downloads
// lib/core/loading_indicators/file_upload.dart
import 'package:flutter/material.dart';

class FileProgressIndicator extends StatelessWidget {
  final double progress;
  final Color? color;
  final double height;
  final String? label;

  const FileProgressIndicator({
    super.key,
    required this.progress,
    this.color,
    this.height = 4.0,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
        ],
        LinearProgressIndicator(
          value: progress,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).primaryColor,
          ),
          minHeight: height,
        ),
      ],
    );
  }
}