// lib/features/cart/presentation/widgets/empty_cart_view.dart
import 'package:flutter/material.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 300.0),
            child: Icon(Icons.shopping_cart_outlined, size: 64),
          ),
          SizedBox(height: 16),
          Text('Your cart is empty'),
        ],
      ),
    );
  }
}
