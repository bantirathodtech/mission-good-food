// import '../../../../../core/api/base/result/operation_result.dart';
// import '../../../../../core/api/base/service/base_operational_service.dart';
// import '../../../../../core/api/root/app_root_service.dart';
// import '../../../../../core/log/loggers.dart';
// import '../../domain/model/cart_model.dart';
// import '../params/cart_request_params.dart';
//
// class CartService extends BaseOperationalService<CartModel> {
//   static const String TAG = '[CartService]';
//   final AppRootService rootService;
//
//   CartService({required this.rootService});
//
//   // GET /api/commerce/cart/{id}
//   Future<OperationResult<CartModel>> getCartById(String cartId) async {
//     try {
//       AppLogger.logInfo('$TAG Fetching cart with ID: $cartId');
//
//       final response = await rootService.sendRestRequest(
//         endpoint: '/api/commerce/cart/$cartId',
//         method: 'GET',
//       );
//
//       AppLogger.logInfo('$TAG Cart data received successfully');
//       final model = CartModel.fromJson(response);
//
//       if (model.isEmpty) {
//         return OperationResult.failure('Cart not found');
//       }
//
//       return OperationResult.success(model);
//     } catch (e) {
//       AppLogger.logError('$TAG Error fetching cart: $e');
//       return OperationResult.failure(e.toString());
//     }
//   }
//
//   // POST /api/commerce/cart
//   Future<OperationResult<CartModel>> createUpdateCart(
//       CartRequestParams params) async {
//     try {
//       params.validate();
//       AppLogger.logInfo(
//           '$TAG Creating/updating cart with params: ${params.toJson()}');
//
//       final response = await rootService.sendRestRequest(
//         endpoint: '/api/commerce/cart',
//         method: 'POST',
//         queryParams: {'cart_id': params.cartId},
//         body: params.toJson(),
//       );
//
//       AppLogger.logInfo('$TAG Cart created/updated successfully');
//       return OperationResult.success(CartModel.fromJson(response));
//     } catch (e) {
//       AppLogger.logError('$TAG Error creating/updating cart: $e');
//       return OperationResult.failure(e.toString());
//     }
//   }
//
//   // PUT /api/commerce/cart/{id}
//   Future<OperationResult<CartModel>> updateCartItem(
//       String cartId, String itemId, int quantity) async {
//     try {
//       AppLogger.logInfo(
//           '$TAG Updating cart item. CartID: $cartId, ItemID: $itemId, Quantity: $quantity');
//
//       final response = await rootService.sendRestRequest(
//         endpoint: '/api/commerce/cart/$cartId',
//         method: 'PUT',
//         body: {
//           'item_id': itemId,
//           'quantity': quantity.toString(),
//         },
//       );
//
//       AppLogger.logInfo('$TAG Cart item updated successfully');
//       return OperationResult.success(CartModel.fromJson(response));
//     } catch (e) {
//       AppLogger.logError('$TAG Error updating cart item: $e');
//       return OperationResult.failure(e.toString());
//     }
//   }
//
//   // DELETE /api/commerce/cart/{id}
//   Future<OperationResult<bool>> deleteCartItem(
//       String cartId, String productId) async {
//     try {
//       AppLogger.logInfo(
//           '$TAG Deleting item from cart. CartID: $cartId, ProductID: $productId');
//
//       await rootService.sendRestRequest(
//         endpoint: '/api/commerce/cart/$cartId',
//         method: 'DELETE',
//         queryParams: {'product_id': productId},
//       );
//
//       AppLogger.logInfo('$TAG Cart item deleted successfully');
//       return OperationResult.success(true);
//     } catch (e) {
//       AppLogger.logError('$TAG Error deleting cart item: $e');
//       return OperationResult.failure(e.toString());
//     }
//   }
//
//   // PUT /api/commerce/mergeUserToCart/{id}
//   Future<OperationResult<CartModel>> mergeUserToCart(
//       String cartId, String userId) async {
//     try {
//       AppLogger.logInfo(
//           '$TAG Merging user to cart. CartID: $cartId, UserID: $userId');
//
//       final response = await rootService.sendRestRequest(
//         endpoint: '/api/commerce/mergeUserToCart/$cartId',
//         method: 'PUT',
//         body: {'user_id': userId},
//       );
//
//       AppLogger.logInfo('$TAG User merged to cart successfully');
//       return OperationResult.success(CartModel.fromJson(response));
//     } catch (e) {
//       AppLogger.logError('$TAG Error merging user to cart: $e');
//       return OperationResult.failure(e.toString());
//     }
//   }
//
//   // DELETE /api/commerce/deleteCart/{id}
//   Future<OperationResult<bool>> deleteEntireCart(String cartId) async {
//     try {
//       AppLogger.logInfo('$TAG Deleting entire cart. CartID: $cartId');
//
//       await rootService.sendRestRequest(
//         endpoint: '/api/commerce/deleteCart/$cartId',
//         method: 'DELETE',
//       );
//
//       AppLogger.logInfo('$TAG Cart deleted successfully');
//       return OperationResult.success(true);
//     } catch (e) {
//       AppLogger.logError('$TAG Error deleting cart: $e');
//       return OperationResult.failure(e.toString());
//     }
//   }
//
//   @override
//   Future<OperationResult<CartModel>> execute<R>(
//     String path, {
//     Map<String, dynamic>? params,
//     CartModel? data,
//     String method = 'GET',
//     R Function(Map<String, dynamic>)? fromJson,
//   }) async {
//     try {
//       final response = await rootService.sendRestRequest(
//         endpoint: path,
//         method: method,
//         queryParams: params,
//         body: data?.toJson(),
//       );
//
//       if (response == null) {
//         return OperationResult.failure('Empty response received');
//       }
//
//       final model = CartModel.fromJson(response);
//       return OperationResult.success(model);
//     } catch (e) {
//       return OperationResult.failure(e.toString());
//     }
//   }
// }
