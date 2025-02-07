// lib/features/products/di/service_locator.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../core/api/base/repository/base_repository.dart';
import '../../../core/api/endpoints/api_url_manager.dart';
import '../../../core/api/root/app_root_service.dart';
import '../cart/api/service/cart_operational_service.dart';
import '../cart/domain/repository/cart_repository.dart';
import '../cart/presentation/viewmodel/state_management/provider/cart_provider.dart';
import '../cart/presentation/viewmodel/viewmodel/cart_viewmodel.dart';
import '../products/model/document.dart';
import '../products/model/products_model.dart';
import '../products/products_card/provider/products_provider.dart';
import '../products/products_card/viewmodel/products_viewmodel.dart';
import '../products/products_details/viewmodel/product_details_viewmodel.dart';
import '../products/repository/products_repository.dart';
import '../products/service/products/products_service.dart';
import '../wishlist/repository/wishlist_reository.dart';
import '../wishlist/service/wishlist_service.dart';
import '../wishlist/viewmodel/wishlist_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> setupProductDependencies() async {
  final dio = Dio()..options.baseUrl = AppUrls.baseUrl;
  final rootService = AppRootService(dio: dio);

  // Core Services
  getIt
    ..registerLazySingleton(() => rootService)
    ..registerLazySingleton(() => WishlistService(rootService))
    ..registerLazySingleton(() => ProductsService(rootService: rootService));

  // Repositories
  getIt
    ..registerLazySingleton<ProductsRepository>(() => ProductsRepository(
          getIt<ProductsService>(),
          getIt<WishlistService>(),
        ))
    ..registerLazySingleton<BaseRepository<ProductsModel>>(
        () => getIt<ProductsRepository>())
    ..registerLazySingleton<WishlistRepository>(
        () => WishlistRepository(getIt<WishlistService>()));

  // ViewModels
  getIt
    ..registerFactory(() => ProductsViewModel(getIt<ProductsRepository>()))
    ..registerFactory(() => WishlistViewModel(getIt<WishlistRepository>()))
    ..registerFactoryParam<ProductDetailsViewModel, Document, void>(
      (product, _) => ProductDetailsViewModel(
        getIt<ProductsRepository>(),
        product,
      ),
    );

  // Providers - Updated to include WishlistViewModel
  getIt.registerFactory(
    () => ProductsProvider(
      getIt<ProductsViewModel>(),
      getIt<WishlistViewModel>(),
    ),
  );
}

// Future<void> setupCategoryDependencies() async {
//   final getIt = GetIt.instance;
//
//   // Register dependencies
//   getIt.registerLazySingleton<CategoriesService>(
//     () => CategoriesService(rootService: getIt<AppRootService>()),
//   );
//
//   getIt.registerLazySingleton<CategoriesRepository>(
//     () => CategoriesRepository(getIt<CategoriesService>()),
//   );
//
//   getIt.registerFactory<CategoriesProvider>(
//     () => CategoriesProvider(getIt<CategoriesRepository>()),
//   );
// }

Future<void> setupCartDependencies() async {
  final rootService = getIt<AppRootService>();

  // Register cart dependencies
  getIt
    ..registerLazySingleton(
        () => CartOperationalService(rootService: rootService))
    ..registerLazySingleton(
        () => CartRepository(getIt<CartOperationalService>()))
    ..registerFactory(() => CartViewModel(getIt<CartRepository>()))
    ..registerFactory(() => CartProvider(getIt<CartViewModel>()));
}

// // lib/features/products/di/service_locator.dart
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/single_child_widget.dart';
//
// import '../../../core/api/base/repository/base_repository.dart';
// import '../../../core/api/endpoints/api_url_manager.dart';
// import '../../../core/api/root/app_root_service.dart';
// import '../categories/provider/categories_provider.dart';
// import '../categories/repository/categories_repository.dart';
// import '../categories/service/categories_service.dart';
// import '../products/model/document.dart';
// import '../products/model/products_model.dart';
// import '../products/products_card/provider/products_provider.dart';
// import '../products/products_card/viewmodel/products_viewmodel.dart';
// import '../products/products_details/provider/product_details_provider.dart';
// import '../products/products_details/viewmodel/product_details_viewmodel.dart';
// import '../products/repository/products_repository.dart';
// import '../products/service/products/products_service.dart';
// import '../products/service/wishlist/wishlist_service.dart';
//
// final getIt = GetIt.instance;
//
// Future<void> setupProductDependencies() async {
//   // Services
//   final dio = Dio()..options.baseUrl = AppUrls.baseUrl;
//   final rootService = AppRootService(dio: dio);
//
//   // Register Services
//   getIt
//     ..registerLazySingleton(() => rootService)
//     ..registerLazySingleton(() => WishlistService(rootService))
//     ..registerLazySingleton(() => ProductsService(rootService: rootService));
//
//   // Register Repository
//   getIt
//     ..registerLazySingleton<ProductsRepository>(() => ProductsRepository(
//           getIt<ProductsService>(),
//           getIt<WishlistService>(),
//         ))
//     ..registerLazySingleton<BaseRepository<ProductsModel>>(
//         () => getIt<ProductsRepository>());
//
//   // Register Product List ViewModels and Providers
//   getIt
//     ..registerFactory(() => ProductsViewModel(getIt<ProductsRepository>()))
//     ..registerFactory(() => ProductsProvider(getIt<ProductsViewModel>()));
//
//   // Register Product Details ViewModels and Providers
//   getIt
//     ..registerFactoryParam<ProductDetailsViewModel, Document, BuildContext>(
//       (product, context) => ProductDetailsViewModel(
//         getIt<ProductsRepository>(),
//         product,
//       ),
//     )
//     ..registerFactoryParam<ProductDetailsProvider, Document, BuildContext>(
//       (product, context) => ProductDetailsProvider(
//         getIt<ProductDetailsViewModel>(param1: product, param2: context),
//         product,
//       ),
//     );
// }
//
// // Provider setup helper
// List<SingleChildWidget> get globalProviders {
//   return [
//     ChangeNotifierProvider(create: (_) => getIt<ProductsProvider>()),
//   ];
// }
//
// // Helper method to create product details providers
// List<SingleChildWidget> createProductDetailsProviders(
//     Document product, BuildContext context) {
//   return [
//     ChangeNotifierProvider(
//       create: (_) => getIt<ProductDetailsProvider>(
//         param1: product,
//         param2: context,
//       ),
//     ),
//   ];
// }
//

///oldest
// // lib/core/di/service_locator.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get_it/get_it.dart';
// import 'package:good_food_app/core/api/base/repository/base_repository.dart';
//
// import '../../../core/api/endpoints/api_url_manager.dart';
// import '../../../core/api/root/app_root_service.dart';
// import '../model/document.dart';
// import '../model/products_model.dart';
// import '../products_card/provider/products_provider.dart';
// import '../products_card/viewmodel/products_viewmodel.dart';
// import '../products_details/viewmodel/product_details_viewmodel.dart';
// import '../repository/products_repository.dart';
// import '../service/products/products_service.dart';
// import '../service/wishlist/wishlist_service.dart';
//
// final getIt = GetIt.instance;
//
// // lib/core/di/service_locator.dart
// Future<void> setupProductDependencies() async {
//   final dio = Dio()..options.baseUrl = AppUrls.baseUrl;
//   final rootService = AppRootService(dio: dio);
//
//   getIt
//     ..registerLazySingleton(() => rootService)
//     ..registerLazySingleton(() => WishlistService(rootService))
//     ..registerLazySingleton(
//         () => ProductsService(rootService: getIt<AppRootService>()))
//     // Register ProductsRepository
//     ..registerLazySingleton<ProductsRepository>(() => ProductsRepository(
//           getIt<ProductsService>(),
//           getIt<WishlistService>(),
//         ))
//     // Register as BaseRepository
//     ..registerLazySingleton<BaseRepository<ProductsModel>>(
//         () => getIt<ProductsRepository>())
//     // Register ViewModels and Providers
//     ..registerFactory(
//         () => ProductsViewModel(getIt<BaseRepository<ProductsModel>>()))
//     ..registerFactory(() => ProductsProvider(getIt<ProductsViewModel>()))
//     // Factory for ProductDetailsViewModel
//     ..registerFactoryParam<ProductDetailsViewModel, Document, BuildContext>(
//       (product, context) => ProductDetailsViewModel(
//         getIt<ProductsRepository>(),
//         product,
//         context,
//       ),
//     );
// }
