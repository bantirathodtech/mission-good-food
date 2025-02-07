//TODO: For first-time shimmer loading
// lib/core/loading_indicators/screen_load.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ScreenLoadShimmer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;

  const ScreenLoadShimmer({
    super.key,
    required this.child,
    required this.isLoading,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    final colorScheme = Theme.of(context).colorScheme;
    
    return Shimmer.fromColors(
      baseColor: baseColor ?? colorScheme.surfaceVariant,
      highlightColor: highlightColor ?? colorScheme.surface,
      child: child,
    );
  }
}