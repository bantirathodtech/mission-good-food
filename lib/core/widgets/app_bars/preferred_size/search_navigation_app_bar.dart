// lib/widgets/app_bars/search_navigation_app_bar.dart
import 'package:flutter/material.dart';

/// A custom AppBar with back navigation and search functionality.
/// Features:
/// - Back button with customizable action
/// - Single line title
/// - Optional action buttons
/// - Search bar in bottom widget
class SearchNavigationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback onBackPressed;
  final Widget searchBarWidget;
  final double toolbarHeight;

  const SearchNavigationAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
    required this.searchBarWidget,
    this.actions,
    this.toolbarHeight = 70.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: toolbarHeight,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        iconSize: 20.0,
        onPressed: onBackPressed,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: searchBarWidget,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight + 40);
}
