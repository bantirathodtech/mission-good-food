// lib/features/cart/presentation/widgets/product_card_cart.dart
import 'package:flutter/material.dart';
import 'package:good_food_app/features/cart/presentation/view/widgets/quantity_selector.dart';
import 'package:provider/provider.dart';

import '../../../../../core/dialog/show_custom_dialog.dart';
import '../../../../../core/theme/text_styles/global_text_style.dart';
import '../../../domain/model/cart_model.dart';
import '../../viewmodel/state_management/provider/cart_provider.dart';

class ProductCardCart extends StatelessWidget {
  final CartItem item;

  const ProductCardCart({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(228, 242, 228, 0.6),
                blurRadius: 15,
                spreadRadius: 1,
                offset: Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image
              Image.network(
                item.product?.imageUrl ?? '',
                width: 114,
                height: 114,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 114,
                  height: 114,
                  color: Colors.grey[200],
                  child: const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 16),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product?.name ?? '',
                      style: GlobalTextStyles.qs16w7Black,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '₹${item.unitPrice}',
                          style: GlobalTextStyles.small7Black,
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 1,
                          height: 16,
                          color: const Color.fromRGBO(240, 242, 245, 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Quantity Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuantitySelector(
                          quantity: item.quantity ?? 0,
                          onIncrement: () => cartProvider.updateItemQuantity(
                            cartProvider.cartId!,
                            item.itemId!,
                            (item.quantity ?? 0) + 1,
                          ),
                          onDecrement: () {
                            if ((item.quantity ?? 0) > 1) {
                              cartProvider.updateItemQuantity(
                                cartProvider.cartId!,
                                item.itemId!,
                                (item.quantity ?? 0) - 1,
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _showDeleteConfirmation(
                            context,
                            cartProvider,
                            item,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    CartProvider provider,
    CartItem item,
  ) {
    showCustomDialog(
      context: context,
      title: 'Are you sure',
      message: 'you want to remove from cart?',
      cancelButtonText: 'Cancel',
      confirmButtonText: 'Sure',
      onCancel: () => Navigator.pop(context),
      onConfirm: () {
        provider.removeCartItem(provider.cartId!, item.itemId!);
        Navigator.pop(context);
      },
    );
  }
}
