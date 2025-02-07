// // lib/features/products/products_details/ui/product_details_scope.dart
//
// import 'package:flutter/material.dart';
// import 'package:good_food_app/features/products/products_details/viewmodel/product_details_viewmodel.dart';
// import 'package:provider/provider.dart';
//
// import '../../../di/service_locator.dart';
// import '../../model/document.dart';
// import '../provider/product_details_provider.dart';
//
// // lib/features/products/products_details/ui/product_details_scope.dart
//
// class ProductDetailsScope extends StatelessWidget {
//   final Document product;
//   final Widget child;
//
//   const ProductDetailsScope({
//     super.key,
//     required this.product,
//     required this.child,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // Change to ChangeNotifierProvider
//         ChangeNotifierProvider(
//           create: (context) => getIt<ProductDetailsViewModel>(param1: product),
//         ),
//         ChangeNotifierProxyProvider<ProductDetailsViewModel, ProductDetailsProvider>(
//           create: (context) => ProductDetailsProvider(
//             getIt<ProductDetailsViewModel>(param1: product),
//             product,
//           ),
//           update: (context, viewModel, previous) =>
//             previous ?? ProductDetailsProvider(viewModel, product),
//         ),
//       ],
//       child: child,
//     );
//   }
// }
