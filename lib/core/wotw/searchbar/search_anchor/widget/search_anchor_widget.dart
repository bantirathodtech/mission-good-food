import 'package:flutter/material.dart';

typedef SuggestionsBuilder = List<Widget> Function(
  BuildContext context,
  SearchController controller,
);

class SearchAnchorWidget extends StatelessWidget {
  final Color? barBackgroundColor;
  final double? barElevation;
  final Color? viewBackgroundColor;
  final double? viewElevation;
  final OutlinedBorder? viewShape;

  // Suggestions builder for reuse
  final SuggestionsBuilder suggestionsBuilder;

  const SearchAnchorWidget({
    super.key,
    this.barBackgroundColor,
    this.barElevation,
    this.viewBackgroundColor,
    this.viewElevation,
    this.viewShape,
    required this.suggestionsBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      barBackgroundColor:
          WidgetStateProperty.all(barBackgroundColor ?? Colors.white),
      barElevation: WidgetStateProperty.all(barElevation ?? 2.0),
      viewBackgroundColor: viewBackgroundColor,
      viewElevation: viewElevation,
      viewShape: viewShape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
      suggestionsBuilder: suggestionsBuilder,
    );
  }
}
