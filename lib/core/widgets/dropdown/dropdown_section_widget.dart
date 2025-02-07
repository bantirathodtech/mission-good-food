import 'package:flutter/material.dart';
import 'package:good_food_app/core/theme/text_styles/global_text_style.dart';

class DropdownSectionWidgets extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final Widget Function()? expandedBuilder;

  const DropdownSectionWidgets({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onTap,
    this.expandedBuilder, // Optional builder for expanded section
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: GlobalTextStyles.dmSansFont,
                    color: Color.fromRGBO(57, 61, 70, 1),
                  ),
                ),
                Icon(
                  isExpanded
                      // ? Icons.keyboard_arrow_up_rounded
                      // : Icons.keyboard_arrow_down_rounded,
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  color: const Color.fromRGBO(43, 41, 33, 1),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded && expandedBuilder != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 16, 16),
            child: expandedBuilder!(),
          ),
      ],
    );
  }
}
