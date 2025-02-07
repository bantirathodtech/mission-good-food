// lib/features/cart/handlers/cart_handler_mixin.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/api/base/result/operation_result.dart';
import '../../../../../core/data/share_preference/app_preferences.dart';
import '../../../../products/model/document.dart';
import '../../../../routes/app_route_manager.dart';
import '../../../api/params/cart_request_params.dart';
import '../../../domain/model/cart_model.dart';
import '../state_management/provider/cart_provider.dart';

mixin CartHandlerMixin<T extends StatefulWidget> on State<T> {
  Future<void> handleAddToCart(BuildContext context, Document product) async {
    try {
      final cartProvider = context.read<CartProvider>();
      String? cartId = cartProvider.cartId;

      final cartParams = CartRequestParams(
        cartId: cartId,
        items: [CartItemParams.fromDocument(product)],
      );

      final result = await cartProvider.addToCart(cartParams);

      if (result is OperationSuccess<CartModel>) {
        final newCartId = (result as OperationSuccess<CartModel>).data.cartId;
        if (newCartId != null) {
          await AppPreference.saveCartData(newCartId);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.name} added to cart'),
              action: SnackBarAction(
                label: 'View Cart',
                onPressed: () => AppRouteManager.navigateToCart(context),
              ),
            ),
          );
        }
      } else {
        throw (result as OperationFailure).message ?? 'Failed to add to cart';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }
}
