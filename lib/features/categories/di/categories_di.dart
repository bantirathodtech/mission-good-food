// 4. Let's update the dependency injection configuration
// lib/features/di/categories_di.dart
import 'package:get_it/get_it.dart';

import '../provider/categories_provider.dart';
import '../repository/categories_repository.dart';
import '../service/categories_service.dart';
import '../viewmodel/categories_viewmodel.dart';

/// Configures all category-related dependencies in the dependency injection container.
class CategoriesDI {
  static void init(GetIt getIt) {
    // Services
    getIt.registerLazySingleton<CategoriesService>(
      () => CategoriesService(rootService: getIt()),
    );

    // Repository
    getIt.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepository(getIt()),
    );

    // ViewModel
    getIt.registerFactory<CategoriesViewModel>(
      () => CategoriesViewModel(getIt()),
    );

    // Provider
    getIt.registerFactory<CategoriesProvider>(
      () => CategoriesProvider(getIt()),
    );
  }
}
