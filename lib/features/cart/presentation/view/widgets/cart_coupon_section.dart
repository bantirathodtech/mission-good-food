import 'package:flutter/material.dart';

// lib/features/cart/presentation/widgets/cart_coupon_section.dart
class CartCouponSection extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  CartCouponSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter coupon code',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Apply'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
