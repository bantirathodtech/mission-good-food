//TODO: Step progress indicator for pull-to-refresh
// lib/core/widgets/refresh_indicators/manual_refresh_indicator.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ManualRefreshIndicator extends StatelessWidget {
  final bool isRefreshing;
  final String? message;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double size;
  final double strokeWidth;

  const ManualRefreshIndicator({
    Key? key,
    required this.isRefreshing,
    this.message = 'Refreshing...',
    this.selectedColor,
    this.unselectedColor,
    this.size = 40.0,
    this.strokeWidth = 3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isRefreshing) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.1),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: CircularStepProgressIndicator(
                  totalSteps: 30,
                  currentStep: (DateTime.now().millisecond ~/ 33.33) % 30,
                  stepSize: strokeWidth,
                  selectedColor: selectedColor ?? theme.primaryColor,
                  unselectedColor: unselectedColor ?? Colors.grey[200]!,
                  padding: 0,
                  selectedStepSize: strokeWidth,
                  roundedCap: (_, __) => true,
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: 12),
                Text(
                  message!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedRefreshIndicator extends StatefulWidget {
  final bool isRefreshing;
  final String? message;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double size;
  final double strokeWidth;

  const AnimatedRefreshIndicator({
    Key? key,
    required this.isRefreshing,
    this.message,
    this.selectedColor,
    this.unselectedColor,
    this.size = 40.0,
    this.strokeWidth = 3.0,
  }) : super(key: key);

  @override
  State<AnimatedRefreshIndicator> createState() =>
      _AnimatedRefreshIndicatorState();
}

class _AnimatedRefreshIndicatorState extends State<AnimatedRefreshIndicator>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _currentStep = 0;
  final int _totalSteps = 30;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (mounted) {
        setState(() {
          _currentStep = (_currentStep + 1) % _totalSteps;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isRefreshing) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.1),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: widget.size,
                height: widget.size,
                child: CircularStepProgressIndicator(
                  totalSteps: _totalSteps,
                  currentStep: _currentStep,
                  stepSize: widget.strokeWidth,
                  selectedColor: widget.selectedColor ?? theme.primaryColor,
                  unselectedColor: widget.unselectedColor ?? Colors.grey[200]!,
                  padding: 0,
                  selectedStepSize: widget.strokeWidth,
                  roundedCap: (_, __) => true,
                ),
              ),
              if (widget.message != null) ...[
                const SizedBox(height: 12),
                Text(
                  widget.message!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Example wrapper for easy implementation
class RefreshableView extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final String? refreshMessage;

  const RefreshableView({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.refreshMessage,
  }) : super(key: key);

  @override
  State<RefreshableView> createState() => _RefreshableViewState();
}

class _RefreshableViewState extends State<RefreshableView> {
  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _handleRefresh,
          child: widget.child,
        ),
        AnimatedRefreshIndicator(
          isRefreshing: _isRefreshing,
          message: widget.refreshMessage,
        ),
      ],
    );
  }
}
