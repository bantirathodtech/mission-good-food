//TODO: Lottie animation for empty states
// lib/core/widgets/state_indicators/empty_state_indicator.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyStateIndicator extends StatelessWidget {
  final String? title;
  final String? message;
  final String lottieAsset;
  final VoidCallback? onActionPressed;
  final String? actionLabel;
  final double? lottieSize;
  final Color? textColor;
  final Color? buttonColor;

  const EmptyStateIndicator({
    Key? key,
    this.title,
    this.message,
    required this.lottieAsset,
    this.onActionPressed,
    this.actionLabel,
    this.lottieSize = 200.0,
    this.textColor,
    this.buttonColor,
  }) : super(key: key);

  // Predefined empty states
  factory EmptyStateIndicator.noData({
    String? message,
    VoidCallback? onRetry,
  }) {
    return EmptyStateIndicator(
      title: 'No Data Found',
      message: message ?? 'We couldn\'t find any data to display',
      lottieAsset: 'assets/animations/empty_box.json',
      onActionPressed: onRetry,
      actionLabel: onRetry != null ? 'Retry' : null,
    );
  }

  factory EmptyStateIndicator.noResults({
    String? message,
    VoidCallback? onClear,
  }) {
    return EmptyStateIndicator(
      title: 'No Results Found',
      message: message ?? 'Try adjusting your search or filters',
      lottieAsset: 'assets/animations/no_results.json',
      onActionPressed: onClear,
      actionLabel: onClear != null ? 'Clear Filters' : null,
    );
  }

  factory EmptyStateIndicator.noConnection({
    String? message,
    VoidCallback? onRetry,
  }) {
    return EmptyStateIndicator(
      title: 'No Connection',
      message: message ?? 'Please check your internet connection',
      lottieAsset: 'assets/animations/no_connection.json',
      onActionPressed: onRetry,
      actionLabel: 'Retry',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              lottieAsset,
              width: lottieSize,
              height: lottieSize,
              fit: BoxFit.contain,
              repeat: true,
            ),
            if (title != null) ...[
              const SizedBox(height: 24),
              Text(
                title!,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: textColor ?? theme.textTheme.titleLarge?.color,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (message != null) ...[
              const SizedBox(height: 12),
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textColor ?? theme.textTheme.bodyMedium?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onActionPressed != null && actionLabel != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onActionPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor ?? theme.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
