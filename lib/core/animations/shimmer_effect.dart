import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

//TODO: for the first time shimmer effect
class ShimmerEffect extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final bool isLoading;

  const ShimmerEffect({
    super.key,
    required this.child,
    required this.isLoading,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Shimmer.fromColors(
      baseColor: baseColor ?? colorScheme.surfaceVariant,
      highlightColor: highlightColor ?? colorScheme.surface,
      child: child,
    );
  }
}
