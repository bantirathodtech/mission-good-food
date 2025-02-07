// lib/features/cart/presentation/widgets/coupon_section.dart
import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles/global_text_style.dart';

class CouponSection extends StatelessWidget {
  final void Function(String) onApply;
  final TextEditingController _controller = TextEditingController();

  CouponSection({Key? key, required this.onApply}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Apply Coupon', style: GlobalTextStyles.qs16w7Black),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter coupon code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => onApply(_controller.text),
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
