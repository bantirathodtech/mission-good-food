import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_food_app/features/cart/presentation/viewmodel/handlers/cart_handler_mixin.dart';
import 'package:provider/provider.dart';

import '../../../../core/decoration/single_side_shadow_decoration.dart';
import '../../../../core/main_screen_navigation.dart';
import '../../../../core/theme/text_styles/global_text_style.dart';
import '../../../products/products_card/card/product_card.dart';
import '../../../products/products_card/provider/products_provider.dart';
import '../../../products/products_details/ui/product_details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with CartHandlerMixin {
  @override
  void initState() {
    super.initState();
    _loadWishlistedProducts();
  }

  Future<void> _loadWishlistedProducts() async {
    final provider = context.read<ProductsProvider>();
    // Load all products to ensure we have the data
    await provider.loadProducts(reset: true);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: _buildBody(),
      );

  PreferredSize _buildAppBar() => PreferredSize(
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
            title: Text('Favorite', style: GlobalTextStyles.qsTitle),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: SvgPicture.asset('assets/icons/ic_search.svg'),
              ),
            ],
            centerTitle: true,
          ),
        ),
      );

  Widget _buildBody() => Consumer<ProductsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final wishlisted = provider.currentState.wishlistedProductIds;
          final products = provider.currentState.products
              .where((product) => wishlisted.contains(product.id))
              .toList();

          if (products.isEmpty) {
            return const Center(child: Text('No favorite products yet'));
          }

          return RefreshIndicator(
            onRefresh: _loadWishlistedProducts,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (_, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  isWishlisted: true,
                  onWishlistedPressed: () async {
                    await provider.handleWishlistToggle(product.id ?? '');
                    // Refresh products after toggling
                    await _loadWishlistedProducts();
                  },
                  // onAddToCart: () {}, // TODO: Implement
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
      );
}

// // lib/features/screens/favorite/favorite_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../core/decoration/single_side_shadow_decoration.dart';
// import '../../../../core/main_screen_navigation.dart';
// import '../../../../core/theme/text_styles/global_text_style.dart';
// import '../../../products/products_card/card/product_card.dart';
// import '../../../products/products_card/provider/products_provider.dart';
//
// class FavoriteScreen extends StatefulWidget {
//   const FavoriteScreen({super.key});
//
//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }
//
// class _FavoriteScreenState extends State<FavoriteScreen> {
//   late ProductsProvider _productsProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     _productsProvider = context.read<ProductsProvider>();
//     _loadWishlistedProducts();
//   }
//
//   Future<void> _loadWishlistedProducts() async {
//     final wishlistedIds = _productsProvider.state.wishlistedProductIds;
//     if (wishlistedIds.isNotEmpty) {
//       await _productsProvider.loadProducts();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         backgroundColor: Colors.white,
//         appBar: _buildAppBar(),
//         body: _buildBody(),
//       );
//
//   PreferredSize _buildAppBar() => PreferredSize(
//         preferredSize: const Size.fromHeight(kTextTabBarHeight),
//         child: Container(
//           decoration: greenShadowDecoration,
//           child: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             leading: IconButton(
//               onPressed: () => MainScreenNavigation.popToHomeTab(context),
//               icon: const Icon(Icons.arrow_back, color: Colors.black),
//             ),
//             title: Text('Favorite', style: GlobalTextStyles.qsTitle),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 32),
//                 child: SvgPicture.asset('assets/icons/ic_search.svg'),
//               ),
//             ],
//             centerTitle: true,
//           ),
//         ),
//       );
//
//   Widget _buildBody() => Consumer<ProductsProvider>(
//         builder: (context, provider, _) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           final products = provider.products;
//           if (products.isEmpty) {
//             return const Center(child: Text('No favorite products yet'));
//           }
//
//           return GridView.builder(
//             padding: const EdgeInsets.all(16),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.75,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//             ),
//             itemCount: products.length,
//             itemBuilder: (_, index) {
//               final document = products[index];
//               return ProductCard(
//                 product: document,
//                 isWishlisted: provider.isProductWishlisted(document.id ?? ''),
//                 onWishlistedPressed: () =>
//                     provider.toggleWishlist(document.id ?? ''),
//                 onAddToCart: () {}, // TODO: Implement
//                 onProductTap: () {}, // TODO: Implement
//               );
//             },
//           );
//         },
//       );
// }
