import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;
  final Color color;
  final Color shadowColor;
  final Color surfaceTintColor;
  final double elevation;
  final ShapeBorder shape;
  final bool borderOnForeground;
  final EdgeInsetsGeometry margin;
  final Clip clipBehavior;
  final bool semanticContainer;
  final double borderRadius;

  const CustomCard({
    super.key,
    this.child,
    this.color = Colors.white,
    this.shadowColor = Colors.black26,
    this.surfaceTintColor = Colors.transparent,
    this.elevation = 8,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    this.borderOnForeground = true,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.clipBehavior = Clip.antiAlias,
    this.semanticContainer = true,
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      borderOnForeground: borderOnForeground,
      margin: margin,
      clipBehavior: clipBehavior,
      semanticContainer: semanticContainer,
      child: child,
    );
  }
}
