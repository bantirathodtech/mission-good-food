import 'package:flutter/material.dart'; // lib/features/cart/widgets/quantity_controls.dart

class QuantityControls extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityControls({
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
          onPressed: quantity > 1 ? onDecrement : null,
          color: const Color.fromRGBO(224, 241, 231, 1),
          iconColor: const Color.fromRGBO(79, 165, 111, 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('$quantity'),
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
  final VoidCallback? onPressed;
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
    return SizedBox(
      width: 24,
      height: 24,
      child: Material(
        color: onPressed == null ? Colors.grey[300] : color,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Icon(icon,
              size: 16, color: onPressed == null ? Colors.grey : iconColor),
        ),
      ),
    );
  }
}
