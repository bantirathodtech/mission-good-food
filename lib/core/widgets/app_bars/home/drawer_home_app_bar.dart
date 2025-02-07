// lib/widgets/app_bars/drawer_home_app_bar.dart
import 'package:flutter/material.dart';

/// A custom AppBar with drawer menu, typically used for home screens.
/// Features:
/// - Drawer menu icon
/// - Two-line title (main title and subtitle)
/// - Optional action buttons
/// - Optional bottom widget (like search bar)
class DrawerHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? bottomWidget;
  final double toolbarHeight;
  final VoidCallback? onDrawerPressed;

  const DrawerHomeAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.bottomWidget,
    this.toolbarHeight = 70.0,
    this.onDrawerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: toolbarHeight,
      // Drawer menu icon
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: onDrawerPressed ?? () => Scaffold.of(context).openDrawer(),
      ),
      // Two-line title
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
        ],
      ),
      actions: actions,
      bottom: bottomWidget != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: bottomWidget!,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      bottomWidget != null ? toolbarHeight + 40 : toolbarHeight);
}
