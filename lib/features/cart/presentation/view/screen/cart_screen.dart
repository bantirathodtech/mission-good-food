// lib/features/cart/presentation/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/decoration/single_side_shadow_decoration.dart';
import '../../../../../core/dialog/show_custom_dialog.dart';
import '../../../../../core/main_screen_navigation.dart';
import '../../../../../core/theme/text_styles/global_text_style.dart';
import '../../../../pages/payment/payment_screen.dart';
import '../../../domain/model/cart_model.dart';
import '../../viewmodel/state_management/provider/cart_provider.dart';
import '../../viewmodel/state_management/state/cart_state.dart';
import '../widgets/cart_coupon_section.dart';
import '../widgets/cart_summary_section.dart';
import '../widgets/checkout_button.dart';
import '../widgets/coupon_section.dart';
import '../widgets/delete_button.dart';
import '../widgets/empty_cart_view.dart';
import '../widgets/payment_summary_section.dart';
import '../widgets/product_card_cart.dart';
import '../widgets/product_image.dart';

// lib/features/cart/presentation/screens/cart_screen.dart
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        final cartState = cartProvider.currentState;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight),
            child: Container(
              decoration: greenShadowDecoration,
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => MainScreenNavigation.popToHomeTab(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
                title: Text('Cart', style: GlobalTextStyles.qsTitle),
                centerTitle: true,
              ),
            ),
          ),
          body: cartState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      if (cartState.isEmpty)
                        const EmptyCartView()
                      else ...[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartState.itemCount,
                          itemBuilder: (context, index) {
                            final item = cartState.data!.items![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              child: ProductCardCart(item: item),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        if (!cartState.isEmpty) ...[
                          CouponSection(
                            onApply: (code) => cartProvider.applyCoupon(code),
                          ),
                          const SizedBox(height: 16),
                          PaymentSummarySection(
                            itemCount: cartState.itemCount,
                            subtotal: cartState.subtotal,
                            shipping:
                                cartState.data?.orderSummary?.shippingCost,
                            tax: cartState.data?.orderSummary?.taxAmount,
                            total: cartState.totalAmount,
                          ),
                          CheckoutButton(
                            itemCount: cartState.itemCount,
                            totalAmount: cartState.totalAmount,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentScreen(),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class CartContentView extends StatelessWidget {
  final CartState cart;

  const CartContentView({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CartItemsList(items: cart.data?.items ?? []),
          const SizedBox(height: 16),
          CartCouponSection(),
          const SizedBox(height: 16),
          CartSummarySection(
            itemCount: cart.itemCount,
            subtotal: cart.subtotal,
            totalAmount: cart.totalAmount,
          ),
          CheckoutButton(
            itemCount: cart.itemCount,
            totalAmount: cart.totalAmount,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class CartItemsList extends StatelessWidget {
  final List<CartItem> items;

  const CartItemsList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: CartItemCard(item: items[index]),
        );
      },
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(228, 242, 228, 0.6),
                blurRadius: 15,
                spreadRadius: 1,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ProductImage(imageUrl: item.product?.imageUrl),
              const SizedBox(width: 16),
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       ProductDetails(item: item),
              //       const SizedBox(height: 8),
              //       QuantityControls(
              //         quantity: item.quantity ?? 0,
              //         onIncrement: () => cartProvider.updateItemQuantity(
              //           cartProvider.cartId!,
              //           item.itemId!,
              //           (item.quantity ?? 0) + 1,
              //         ),
              //         onDecrement: () => cartProvider.updateItemQuantity(
              //           cartProvider.cartId!,
              //           item.itemId!,
              //           (item.quantity ?? 0) - 1,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              DeleteButton(
                onPressed: () => _showDeleteConfirmation(
                  context,
                  cartProvider,
                  item,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
}
