// lib/features/cart/presentation/widgets/checkout_button.dart
import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles/global_text_style.dart';
import '../../viewmodel/state_management/provider/cart_provider.dart';

class CheckoutButton extends StatelessWidget {
  final int itemCount;
  final num totalAmount;
  final VoidCallback onPressed;

  const CheckoutButton({
    super.key,
    required this.itemCount,
    required this.totalAmount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('₹$totalAmount', style: GlobalTextStyles.small7Black),
          Text('$itemCount items', style: GlobalTextStyles.small3Black),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color.fromRGBO(79, 165, 111, 1),
              ),
              child: const Text('Proceed to Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}

// Update CartProvider to include applyCoupon method
extension CartProviderExtension on CartProvider {
  Future<void> applyCoupon(String code) async {
    // Implementation for applying coupon
  }
}
