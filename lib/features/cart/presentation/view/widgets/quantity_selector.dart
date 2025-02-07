// lib/features/cart/widgets/quantity_selector.dart
import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles/global_text_style.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QuantityButton(
          icon: Icons.remove,
          onPressed: onDecrement,
          color: const Color.fromRGBO(224, 241, 231, 1),
          iconColor: const Color.fromRGBO(79, 165, 111, 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '$quantity',
            style: GlobalTextStyles.small5Black.copyWith(
              color: const Color.fromRGBO(138, 141, 159, 1),
            ),
          ),
        ),
        _QuantityButton(
          icon: Icons.add,
          onPressed: onIncrement,
          color: const Color.fromRGBO(79, 165, 111, 1),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final Color iconColor;

  const _QuantityButton({
    required this.icon,
    required this.onPressed,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16, color: iconColor),
        onPressed: onPressed,
      ),
    );
  }
}
