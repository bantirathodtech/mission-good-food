// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../products_card/card/product_card.dart';
// import '../../products_card/provider/products_provider.dart';
// import '../../products_details/ui/product_details_screen.dart';
//
// // Create FashionProductsScreen (similar structure)
// class GroceryProductsScreen extends StatelessWidget {
//   const GroceryProductsScreen({super.key, required String themeName});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Grocery Products'),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: Consumer<ProductsProvider>(
//         builder: (context, provider, child) {
//           return GridView.builder(
//             padding: EdgeInsets.all(16),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 16,
//               childAspectRatio: 0.82,
//             ),
//             itemCount:
//                 provider.products.length + (provider.hasMoreProducts ? 1 : 0),
//             itemBuilder: (context, index) {
//               if (index == provider.products.length) {
//                 if (provider.isLoadingMore) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (provider.hasMoreProducts) {
//                   provider.loadMoreProducts();
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 return SizedBox();
//               }
//
//               final product = provider.products[index];
//               return ProductCard(
//                 product: product,
//                 isWishlisted: provider.isProductWishlisted(product.id ?? ''),
//                 onWishlistedPressed: () =>
//                     provider.toggleWishlist(product.id ?? ''),
//                 onAddToCart: () {},
//                 onProductTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           ProductDetailsScreen(product: product),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
