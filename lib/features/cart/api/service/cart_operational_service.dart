// lib/features/cart/data/operational/cart_operational_service.dart
import '../../../../core/api/base/result/operation_result.dart';
import '../../../../core/api/base/service/base_operational_service.dart';
import '../../../../core/api/endpoints/cart_endpoints.dart';
import '../../../../core/api/root/app_root_service.dart';
import '../../../../core/log/loggers.dart';
import '../../domain/model/cart_model.dart';
import '../params/cart_request_params.dart';

class CartOperationalService extends BaseOperationalService<CartModel> {
  static const String TAG = '[CartOperationalService]';
  final AppRootService rootService;

  CartOperationalService({required this.rootService});

  Future<OperationResult<CartModel>> getCartById(String cartId) async {
    try {
      AppLogger.logInfo('$TAG Fetching cart with ID: $cartId');
      final response = await rootService.sendRestRequest(
        endpoint: CartEndpoints.fetchCartById.replaceAll('{id}', cartId),
        method: 'GET',
      );

      final model = CartModel.fromJson(response);
      if (model.isEmpty) {
        return OperationResult.failure('Cart not found');
      }

      return OperationResult.success(model);
    } catch (e) {
      AppLogger.logError('$TAG Error fetching cart: $e');
      return OperationResult.failure(e.toString());
    }
  }

  Future<OperationResult<CartModel>> createUpdateCart(
      CartRequestParams params) async {
    try {
      params.validate();

      final response = await rootService.sendRestRequest(
        endpoint: CartEndpoints.createCart,
        method: 'POST',
        queryParams: params.cartId != null ? {'cart_id': params.cartId} : null,
        body: params.toJson(),
      );

      return OperationResult.success(CartModel.fromJson(response));
    } catch (e) {
      AppLogger.logError('$TAG Error creating/updating cart: $e');
      return OperationResult.failure(e.toString());
    }
  }

  Future<OperationResult<CartModel>> updateCartItem(
    String cartId,
    String itemId,
    int quantity,
  ) async {
    try {
      final response = await rootService.sendRestRequest(
        endpoint: CartEndpoints.updateCartById.replaceAll('{id}', cartId),
        method: 'PUT',
        body: {
          'item_id': itemId,
          'quantity': quantity.toString(),
        },
      );
      return OperationResult.success(CartModel.fromJson(response));
    } catch (e) {
      return OperationResult.failure(e.toString());
    }
  }

  Future<OperationResult<bool>> deleteCartItem(
    String cartId,
    String itemId,
  ) async {
    try {
      await rootService.sendRestRequest(
        endpoint: CartEndpoints.deleteCartById.replaceAll('{id}', cartId),
        method: 'DELETE',
        queryParams: {'item_id': itemId},
      );
      return OperationResult.success(true);
    } catch (e) {
      return OperationResult.failure(e.toString());
    }
  }

  Future<OperationResult<bool>> deleteEntireCart(String cartId) async {
    try {
      await rootService.sendRestRequest(
        endpoint:
            CartEndpoints.deleteAllCartItemsById.replaceAll('{id}', cartId),
        method: 'DELETE',
      );
      return OperationResult.success(true);
    } catch (e) {
      return OperationResult.failure(e.toString());
    }
  }

@override
Future<OperationResult<CartModel>> execute<R>(String path, {
  Map<String, dynamic>? params,
  CartModel? data,
  String method = 'GET',
  R Function(Map<String, dynamic>)? fromJson,
}) async {
  try {
    final response = await rootService.sendRestRequest(
      endpoint: path,
      method: method,
      queryParams: params,
      body: data?.toJson(),
    );

    return OperationResult.success(CartModel.fromJson(response));
  } catch (e) {
    return OperationResult.failure(e.toString());
  }
}
}
