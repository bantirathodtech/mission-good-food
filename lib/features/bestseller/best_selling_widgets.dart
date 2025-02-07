import 'package:flutter/material.dart';
import 'package:good_food_app/features/cart/presentation/viewmodel/handlers/cart_handler_mixin.dart';
import 'package:provider/provider.dart';

import '../cart/presentation/viewmodel/state_management/provider/cart_provider.dart';
import '../products/products_card/card/product_card.dart';
import '../products/products_card/provider/products_provider.dart';
import '../products/products_details/ui/product_details_screen.dart';
import 'best_sellers_screen.dart';

class BestSellingWidget extends StatefulWidget {
  const BestSellingWidget({super.key});

  @override
  State<BestSellingWidget> createState() => _BestSellingWidgetState();
}

class _BestSellingWidgetState extends State<BestSellingWidget>
    with CartHandlerMixin {
  @override
  void initState() {
    super.initState();
    _loadBestSellers();
  }

  Future<void> _loadBestSellers() async {
    // Initial load of products which will populate bestSellerProducts through state
    await context.read<ProductsProvider>().loadProducts(
          sortOrder: 'asc',
          reset: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBestSellingHeader(),
            const SizedBox(height: 8),
            _buildBestSellingProductGridView(provider),
            const SizedBox(height: 8),
            _buildSeeAllButton(context),
          ],
        );
      },
    );
  }

  Widget _buildBestSellingHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Best Selling',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 27,
            child: Row(
              children: [
                _buildFilterButton(
                  'New launches offers',
                  Colors.white,
                  const Color(0xFF4FA56F),
                ),
                const SizedBox(width: 8),
                _buildFilterButton(
                  'Combos',
                  const Color(0xFF4FA56F),
                  const Color(0xFFE2F1E8),
                ),
                const SizedBox(width: 8),
                _buildFilterButton(
                  'Members Only',
                  const Color(0xFF4FA56F),
                  const Color(0xFFE2F1E8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String title, Color textColor, Color bgColor) {
    return Expanded(
      flex: 2,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildBestSellingProductGridView(ProductsProvider provider) {
    // if (provider.isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${provider.error}'),
            ElevatedButton(
              onPressed: _loadBestSellers,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final bestSellers = provider.currentState.bestSellerProducts;
    if (bestSellers.isEmpty) {
      return const SizedBox(
        height: 160,
        child: Center(
          child: Text(
            'No best selling products found',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    // Show only first 4 products in the widget
    final displayProducts = bestSellers.take(4).toList();

    return SizedBox(
      height: 440,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 16,
          childAspectRatio: 0.82,
        ),
        itemCount: displayProducts.length,
        itemBuilder: (context, index) {
          final product = displayProducts[index];
          return ProductCard(
            product: product,
            isWishlisted: provider.isProductWishlisted(product.id ?? ''),
            onWishlistedPressed: () =>
                provider.toggleWishlist(product.id ?? ''),
            // onAddToCart: () {},
            onAddToCart: (product) => handleAddToCart(context, product),

            onProductTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSeeAllButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BestSellersScreen(),
            ),
          );
        },
        child: const Text(
          'See All',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Future<void> _handleAddToCart(BuildContext context, Document product) async {
  //   try {
  //     final cartProvider = context.read<CartProvider>();
  //
  //     final cartParams = CartRequestParams(
  //       cartId: cartProvider.cartId,
  //       items: [
  //         CartItemParams(
  //           productId: product.id ?? '',
  //           quantity: 1,
  //         ),
  //       ],
  //     );
  //
  //     await cartProvider.addToCart(cartParams);
  //
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('${product.name} added to cart'),
  //           duration: const Duration(seconds: 2),
  //           action: SnackBarAction(
  //             label: 'View Cart',
  //             onPressed: () => AppRouteManager.navigateToCart(context),
  //           ),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to add to cart: ${e.toString()}'),
  //           duration: const Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   }
  // }
}

// Add this extension to handle cart badge updates
extension CartBadgeHelper on BuildContext {
  void updateCartBadge() {
    final cartProvider = read<CartProvider>();
    // Trigger cart count update if you have a badge system
    cartProvider.loadCart(cartProvider.cartId ?? '');
  }
}
