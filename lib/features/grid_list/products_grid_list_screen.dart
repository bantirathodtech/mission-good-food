// products_grid_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/animations/shimmer_effect.dart';
import '../cart/presentation/viewmodel/handlers/cart_handler_mixin.dart';
import '../categories/provider/categories_provider.dart';
import '../categories/widget/category_fourth_level_widgets.dart';
import '../categories/widget/category_third_level_widgets.dart';
import '../products/products_card/card/product_card.dart';
import '../products/products_card/provider/products_provider.dart';
import '../products/products_details/ui/product_details_screen.dart';
import '../products/service/products/dtos/theme_names.dart';

class ProductsGridListScreen extends StatefulWidget {
  final String categoryName;
  final AppTheme theme;

  const ProductsGridListScreen({
    super.key,
    required this.categoryName,
    this.theme = AppTheme.GROC,
  });

  @override
  State<ProductsGridListScreen> createState() => _ProductsGridListScreenState();
}

class _ProductsGridListScreenState extends State<ProductsGridListScreen>
    with CartHandlerMixin {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final categoriesProvider = context.read<CategoriesProvider>();

    // Load third level categories based on the second level selection
    if (categoriesProvider.hasSecondLevelSelection) {
      // No need to await since selectSecondLevel is synchronous
      categoriesProvider.selectSecondLevel(widget.categoryName);
    }

    // Load initial products for the category
    // await _loadProducts(widget.categoryName);
    await _loadProductsForCurrentLevel(widget.categoryName);
  }

  Future<void> _handleThirdLevelCategorySelected(String categoryName) async {
    final categoriesProvider = context.read<CategoriesProvider>();

    // No need to await since selectThirdLevel is synchronous
    categoriesProvider.selectThirdLevel(categoryName);

    // Load products for the selected third level category
    // await _loadProducts(categoryName);

    // Check if this third level category has fourth level categories
    if (categoriesProvider.firstLevelCategories.isEmpty) {
      // If no fourth level, load products for third level
      await _loadProductsForCurrentLevel(categoryName);
    }
  }

  Future<void> _handleFourthLevelCategorySelected(String categoryName) async {
    final categoriesProvider = context.read<CategoriesProvider>();

    // No need to await since selectFourthLevel is synchronous
    categoriesProvider.selectFourthLevel(categoryName);

    // Load products for the selected fourth level category
    // await _loadProducts(categoryName);
    await _loadProductsForCurrentLevel(categoryName);
  }

  Future<void> _loadProductsForCurrentLevel(String categoryName) async {
    if (!mounted) return;

    setState(() => _isLoading = true);

    try {
      final categoriesProvider = context.read<CategoriesProvider>();
      // Determine which category name to use based on selection depth
      String? categoryName;

      if (categoriesProvider.hasFourthLevelSelection) {
        categoryName = categoriesProvider.state.selectedFourthLevel!;
      } else if (categoriesProvider.hasThirdLevelSelection &&
          categoriesProvider.fourthLevelCategories.isEmpty) {
        categoryName = categoriesProvider.state.selectedThirdLevel!;
      } else {
        categoryName = widget.categoryName;
      }

      await context.read<ProductsProvider>().loadProducts(
            categoryName: categoryName,
            reset: true,
            sortOrder: 'asc',
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading products: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Optional: Add error handling for products loading
  // Future<void> _loadProducts(String categoryName) async {
  //   if (!mounted) return;
  //
  //   setState(() => _isLoading = true);
  //
  //   try {
  //     await context.read<ProductsProvider>().loadProducts(
  //           categoryName: categoryName,
  //           reset: true,
  //           sortOrder: 'asc',
  //         );
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error loading products: ${e.toString()}')),
  //       );
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() => _isLoading = false);
  //     }
  //   }
  // }

  Widget _buildLoadingShimmer() {
    return ShimmerEffect(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      isLoading: true,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 16,
          childAspectRatio: 0.82,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 16,
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 8),
                        ),
                        Container(
                          height: 14,
                          width: 80,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            // Consumer<CategoriesProvider>(
            //   builder: (context, provider, _) {
            //     return Text(provider.currentCategoryPath);
            //   },
            // ),
            Text(widget.categoryName),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer2<CategoriesProvider, ProductsProvider>(
        builder: (context, categoriesProvider, productsProvider, child) {
          return Column(
            children: [
              // Third level categories
              if (categoriesProvider.hasSecondLevelSelection &&
                  categoriesProvider.thirdLevelCategories.isNotEmpty) ...[
                CategoryThirdLevelWidgets(
                  onCategorySelected: _handleThirdLevelCategorySelected,
                ),
                const SizedBox(height: 10),
              ],

              // Fourth level categories (shown only when a third level is selected)
              if (categoriesProvider.hasThirdLevelSelection &&
                  categoriesProvider.fourthLevelCategories.isNotEmpty) ...[
                CategoryFourthLevelWidgets(
                  onCategorySelected: _handleFourthLevelCategorySelected,
                ),
                const SizedBox(height: 10),
              ],

              // Products grid
              Expanded(
                child: _buildProductsGrid(productsProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid(ProductsProvider provider) {
    if (_isLoading || provider.isLoading) {
      return _buildLoadingShimmer();
    }

    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider.error ?? 'Error loading products'),
            const SizedBox(height: 16),
            ElevatedButton(
              // onPressed: () => _loadProducts(widget.categoryName),
              onPressed: () =>
                  _loadProductsForCurrentLevel(widget.categoryName),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final products = provider.currentState.products;

    if (products.isEmpty) {
      return const Center(
        child: Text('No products found for this category'),
      );
    }

    return RefreshIndicator(
      // onRefresh: () => _loadProducts(widget.categoryName),
      onRefresh: () => _loadProductsForCurrentLevel(widget.categoryName),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 16,
          childAspectRatio: 0.82,
        ),
        itemCount:
            products.length + (provider.currentState.hasMoreProducts ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == products.length) {
            if (provider.isLoadingMore) {
              return _buildLoadingShimmer();
            } else if (provider.currentState.hasMoreProducts) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  provider.loadMoreProducts();
                }
              });
              return _buildLoadingShimmer();
            }
            return const SizedBox();
          }

          final product = products[index];
          return ProductCard(
            product: product,
            isWishlisted: provider.isProductWishlisted(product.id ?? ''),
            onWishlistedPressed: () =>
                provider.handleWishlistToggle(product.id ?? ''),
            onAddToCart: (product) {
              handleAddToCart(context, product);
            },
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
}
