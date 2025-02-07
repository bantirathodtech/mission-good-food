import 'package:flutter/material.dart';
import 'package:good_food_app/features/cart/presentation/viewmodel/handlers/cart_handler_mixin.dart';
import 'package:provider/provider.dart';

import '../products/products_card/card/product_card.dart';
import '../products/products_card/provider/products_provider.dart';
import '../products/products_details/ui/product_details_screen.dart';

class BestSellersScreen extends StatefulWidget {
  const BestSellersScreen({super.key});

  @override
  State<BestSellersScreen> createState() => _BestSellersScreenState();
}

class _BestSellersScreenState extends State<BestSellersScreen>
    with CartHandlerMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadBestSellers();
    _setupScrollListener();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final provider = context.read<ProductsProvider>();
        if (!provider.isLoadingMore && !provider.currentState.hasMoreProducts) {
          provider.loadMoreProducts();
        }
      }
    });
  }

  Future<void> _loadBestSellers() async {
    await context.read<ProductsProvider>().loadProducts(
          sortOrder: 'asc',
          reset: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Sellers'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, provider, child) {
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
            return const Center(
              child: Text(
                'No best selling products found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadBestSellers,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 16,
                childAspectRatio: 0.82,
              ),
              itemCount: bestSellers.length +
                  (provider.currentState.hasMoreProducts ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == bestSellers.length) {
                  if (provider.isLoadingMore) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (provider.currentState.hasMoreProducts) {
                    provider.loadMoreProducts();
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const SizedBox();
                }

                final product = bestSellers[index];
                return ProductCard(
                  product: product,
                  isWishlisted: provider.isProductWishlisted(product.id ?? ''),
                  onWishlistedPressed: () =>
                      provider.handleWishlistToggle(product.id ?? ''),
                  // onAddToCart: () {},
                  onAddToCart: (product) =>
                      handleAddToCart(context, product), // Using the mixin

                  onProductTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
