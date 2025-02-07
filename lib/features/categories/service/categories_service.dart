// categories_service.dart
// Purpose: Handles API communication and data fetching

import '../../../core/api/base/result/operation_result.dart';
import '../../../core/api/base/service/base_operational_service.dart';
import '../../../core/api/root/app_root_service.dart';
import '../../../core/log/loggers.dart';
import '../model/categories_model.dart';

class CategoriesService extends BaseOperationalService<CategoriesModel> {
  static const String TAG = '[CategoriesService]';
  final AppRootService rootService;

  CategoriesService({required this.rootService});

  // Fetches categories data from the API
  Future<OperationResult<CategoriesModel>> getCategories(
      String themeName) async {
    try {
      // Log the request
      AppLogger.logInfo('$TAG Fetching categories for theme: $themeName');

      // Make API request
      final response = await rootService.sendRestRequest(
        endpoint: '/api/commerce/typesenseCategories',
        method: 'GET',
        queryParams: {'themeName': themeName},
      );

      // Log success
      AppLogger.logInfo('$TAG Categories received successfully');

      // Parse response into model
      final model = CategoriesModel.fromJson(response);

      // Validate response
      if (model.hits?.isEmpty ?? true) {
        return OperationResult.failure('No categories found');
      }

      return OperationResult.success(model);
    } catch (e) {
      // Log and handle errors
      AppLogger.logError('$TAG Error fetching categories: $e');
      return OperationResult.failure(e.toString());
    }
  }

  @override
  Future<OperationResult<CategoriesModel>> execute<R>(
    String path, {
    Map<String, dynamic>? params,
    CategoriesModel? data,
    String method = 'GET',
    R Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await rootService.sendRestRequest(
        endpoint: path,
        method: method,
        queryParams: params,
      );

      if (response == null) {
        return OperationResult.failure('Empty response received');
      }

      final model = CategoriesModel.fromJson(response);
      return OperationResult.success(model);
    } catch (e) {
      return OperationResult.failure(e.toString());
    }
  }
}
