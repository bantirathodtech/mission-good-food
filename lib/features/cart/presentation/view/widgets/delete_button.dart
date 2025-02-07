import 'package:flutter/material.dart';

import '../../../../../core/dialog/show_custom_dialog.dart';
import '../../../domain/model/cart_model.dart';
import '../../viewmodel/state_management/provider/cart_provider.dart';
// lib/features/cart/widgets/delete_button.dart

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_outline),
      onPressed: onPressed,
      color: Colors.red[400],
    );
  }
}

// Update showCustomDialog call in CartItemCard
void _showDeleteConfirmation(
    BuildContext context, CartProvider provider, CartItem item) {
  showCustomDialog(
    context: context,
    title: 'Remove Item',
    message: 'Are you sure you want to remove this item from cart?',
    cancelButtonText: 'Cancel',
    confirmButtonText: 'Remove',
    onConfirm: () {
      provider.removeCartItem(provider.cartId!, item.itemId!);
      Navigator.pop(context);
    },
    onCancel: () => Navigator.pop(context),
  );
}

// Extension method for CartItem
extension CartItemExtension on CartItem {
  String? get productImageUrl => product?.imageUrl;
}
