//TODO: PageView dot indicators
// lib/core/widgets/state_indicators/page_progress_indicator.dart
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

enum PageIndicatorStyle {
  dots,
  worm,
  expanding,
  jumping,
  scrolling,
  swapping,
}

class PageProgressIndicator extends StatelessWidget {
  final PageController controller;
  final int count;
  final PageIndicatorStyle style;
  final Color? activeColor;
  final Color? inactiveColor;
  final double dotSize;
  final double spacing;
  final EdgeInsets padding;

  const PageProgressIndicator({
    Key? key,
    required this.controller,
    required this.count,
    this.style = PageIndicatorStyle.dots,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8.0,
    this.spacing = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActiveColor = activeColor ?? theme.primaryColor;
    final effectiveInactiveColor = inactiveColor ?? theme.disabledColor;

    return Padding(
      padding: padding,
      child: SmoothPageIndicator(
        controller: controller,
        count: count,
        effect: _getIndicatorEffect(
          effectiveActiveColor,
          effectiveInactiveColor,
        ),
        onDotClicked: (index) {
          controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }

  BasicIndicatorEffect _getIndicatorEffect(Color active, Color inactive) {
    switch (style) {
      case PageIndicatorStyle.dots:
        return SwapEffect(
          activeDotColor: active,
          dotColor: inactive,
          dotHeight: dotSize,
          dotWidth: dotSize,
          spacing: spacing,
        );
      case PageIndicatorStyle.worm:
        return WormEffect(
          activeDotColor: active,
          dotColor: inactive,
          dotHeight: dotSize,
          dotWidth: dotSize,
          spacing: spacing,
        );
      case PageIndicatorStyle.expanding:
        return ExpandingDotsEffect(
          activeDotColor: active,
          dotColor: inactive,
          dotHeight: dotSize,
          dotWidth: dotSize,
          spacing: spacing,
        );
      case PageIndicatorStyle.jumping:
        return JumpingDotEffect(
          activeDotColor: active,
          dotColor: inactive,
          dotHeight: dotSize,
          dotWidth: dotSize,
          spacing: spacing,
        );
      case PageIndicatorStyle.scrolling:
        return ScrollingDotsEffect(
          activeDotColor: active,
          dotColor: inactive,
          dotHeight: dotSize,
          dotWidth: dotSize,
          spacing: spacing,
        );
      case PageIndicatorStyle.swapping:
        return SwapEffect(
          activeDotColor: active,
          dotColor: inactive,
          dotHeight: dotSize,
          dotWidth: dotSize,
          spacing: spacing,
        );
    }
  }
}

// Example usage wrapper for PageView
class PaginatedView extends StatefulWidget {
  final List<Widget> pages;
  final PageIndicatorStyle indicatorStyle;
  final Color? activeColor;
  final Color? inactiveColor;
  final ScrollPhysics? physics;
  final bool keepAlive;

  const PaginatedView({
    Key? key,
    required this.pages,
    this.indicatorStyle = PageIndicatorStyle.dots,
    this.activeColor,
    this.inactiveColor,
    this.physics,
    this.keepAlive = true,
  }) : super(key: key);

  @override
  State<PaginatedView> createState() => _PaginatedViewState();
}

class _PaginatedViewState extends State<PaginatedView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: widget.physics,
            itemCount: widget.pages.length,
            itemBuilder: (context, index) {
              if (widget.keepAlive) {
                return KeepAliveWrapper(child: widget.pages[index]);
              }
              return widget.pages[index];
            },
          ),
        ),
        PageProgressIndicator(
          controller: _pageController,
          count: widget.pages.length,
          style: widget.indicatorStyle,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
        ),
      ],
    );
  }
}

// Helper widget to keep pages alive
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
