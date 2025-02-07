import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;
  final IndicatorEffect effect;

  const CustomSmoothPageIndicator({
    Key? key,
    required this.controller,
    required this.count,
    this.effect = const ScrollingDotsEffect(
      dotHeight: 8,
      dotWidth: 8,
      activeDotColor: Colors.black,
      dotColor: Colors.black26,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: effect,
    );
  }
}
