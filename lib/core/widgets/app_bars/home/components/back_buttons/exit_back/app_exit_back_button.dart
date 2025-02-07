// lib/widgets/app_exit_back_button.dart
import 'package:flutter/material.dart';

class AppExitBackButton extends StatelessWidget {
  final Color color;
  final double size;

  const AppExitBackButton({
    super.key,
    this.color = Colors.black,
    this.size = 20.0,
  });

  Future<bool> _showExitConfirmation(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final shouldPop = await _showExitConfirmation(context);
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: size,
            color: color,
          ),
          onPressed: () async {
            final shouldExit = await _showExitConfirmation(context);
            if (shouldExit && context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
