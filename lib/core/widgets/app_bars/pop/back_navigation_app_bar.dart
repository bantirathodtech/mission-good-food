// lib/widgets/app_bars/back_navigation_app_bar.dart
import 'package:flutter/material.dart';

/// A custom AppBar with back button navigation.
/// Features:
/// - Back button with customizable action
/// - Single line title
/// - Optional action buttons
class BackNavigationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback onBackPressed;
  final double toolbarHeight;
  final bool centerTitle;

  const BackNavigationAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
    this.actions,
    this.toolbarHeight = 50.0,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: toolbarHeight,
      centerTitle: centerTitle,
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
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
