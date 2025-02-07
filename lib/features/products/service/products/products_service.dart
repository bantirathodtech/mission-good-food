import '../../../../core/api/base/result/operation_result.dart';
import '../../../../core/api/base/service/base_operational_service.dart';
import '../../../../core/api/root/app_root_service.dart';
import '../../../../core/log/loggers.dart';
import '../../model/products_model.dart';
import 'dtos/product_request_params.dart';

class ProductsService extends BaseOperationalService<ProductsModel> {
  static const String TAG = '[ProductsService]';
  final AppRootService rootService;

  ProductsService({required this.rootService});

  Future<OperationResult<ProductsModel>> getProducts(
      ProductRequestParams params) async {
    try {
      params.validate();
      AppLogger.logInfo(
          '$TAG Executing request with params: ${params.toJson()}');

      final response = await rootService.sendRestRequest(
        endpoint: '/api/commerce/products',
        method: 'GET',
        queryParams: params.toJson(),
      );

      AppLogger.logInfo('$TAG Response received successfully');
      final model = ProductsModel.fromJson(response);

      if (model.isEmpty) {
        return OperationResult.failure('No products found');
      }

      return OperationResult.success(model);
    } catch (e) {
      AppLogger.logError('$TAG Error during execution: $e');
      return OperationResult.failure(e.toString());
    }
  }

  @override
  Future<OperationResult<ProductsModel>> execute<R>(
    String path, {
    Map<String, dynamic>? params,
    ProductsModel? data,
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

      final model = ProductsModel.fromJson(response);
      return OperationResult.success(model);
    } catch (e) {
      return OperationResult.failure(e.toString());
    }
  }
}
