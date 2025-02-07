// lib/features/cart/domain/repository/cart_repository.dart
import '../../../../core/api/base/repository/base_repository.dart';
import '../../../../core/api/base/result/operation_result.dart';
import '../../../../core/data/share_preference/app_preferences.dart';
import '../../api/params/cart_request_params.dart';
import '../../api/service/cart_operational_service.dart';
import '../model/cart_model.dart';

class CartRepository implements BaseRepository<CartModel> {
  final CartOperationalService _operationalService;

  CartRepository(this._operationalService);

  Future<OperationResult<CartModel>> getCart(String cartId) async {
    final result = await _operationalService.getCartById(cartId);
    if (result is OperationSuccess<CartModel>) {
      await AppPreference.saveCartData(cartId);
    }
    return result;
  }

  Future<OperationResult<CartModel>> addToCart(CartRequestParams params) async {
    final result = await _operationalService.createUpdateCart(params);
    if (result is OperationSuccess<CartModel>) {
      await AppPreference.saveCartData(params.cartId ?? '');
    }
    return result;
  }

  Future<OperationResult<CartModel>> updateCartItem(
    String cartId,
    String itemId,
    int quantity,
  ) async {
    return await _operationalService.updateCartItem(cartId, itemId, quantity);
  }

  Future<OperationResult<bool>> removeCartItem(
    String cartId,
    String itemId,
  ) async {
    return await _operationalService.deleteCartItem(cartId, itemId);
  }

  Future<OperationResult<bool>> clearCart(String cartId) async {
    final result = await _operationalService.deleteEntireCart(cartId);
    if (result is OperationSuccess<bool>) {
      await AppPreference.clearCartData();
    }
    return result;
  }

  @override
  Future<OperationResult<CartModel>> execute<R>(
    String path, {
    Map<String, dynamic>? params,
    CartModel? data,
    String method = 'GET',
    R Function(Map<String, dynamic>)? fromJson,
  }) async {
    return await _operationalService.execute(
      path,
      params: params,
      data: data,
      method: method,
      fromJson: fromJson,
    );
  }

  @override
  Future<OperationResult<CartModel>>? create(CartModel data) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<OperationResult<bool>>? delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<OperationResult<CartModel>>? update(String id, CartModel data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

// // lib/features/cart/domain/repository/cart_repository.dart
// import 'package:good_food_app/core/data/share_preference/app_preferences.dart';
//
// import '../../../../core/api/base/repository/base_repository.dart';
// import '../../../../core/api/base/result/operation_result.dart';
// import '../../api/params/cart_request_params.dart';
// import '../../api/service/cart_service.dart';
// import '../model/cart_model.dart';
//
// class CartRepository extends BaseRepository<CartModel> {
//   static const String TAG = '[CartRepository]';
//   final CartService _cartService;
//   final AppPreference _appPreference;
//
//   CartRepository(this._cartService, this._appPreference);
//
//   // Gets cart data including shipping and payment info
//   Future<OperationResult<CartModel>> getCart(String cartId) async {
//     return await _cartService.getCartById(cartId);
//   }
//
//   // Adds/updates items in cart with optional shipping/payment
//   Future<OperationResult<CartModel>> addToCart(CartRequestParams params) async {
//     return await _cartService.createUpdateCart(params);
//   }
//
//   // Updates quantity for specific item
//   Future<OperationResult<CartModel>> updateCartItem(
//     String cartId,
//     String itemId,
//     int quantity,
//   ) async {
//     return await _cartService.updateCartItem(cartId, itemId, quantity);
//   }
//
//   // Removes specific item from cart
//   Future<OperationResult<bool>> removeCartItem(
//     String cartId,
//     String productId,
//   ) async {
//     return await _cartService.deleteCartItem(cartId, productId);
//   }
//
//   // Clears entire cart
//   Future<OperationResult<bool>> clearCart(String cartId) async {
//     return await _cartService.deleteEntireCart(cartId);
//   }
//
//   // Merges guest cart with user cart after login
//   Future<OperationResult<CartModel>> mergeCart(
//     String cartId,
//     String userId,
//   ) async {
//     return await _cartService.mergeUserToCart(cartId, userId);
//   }
// }
