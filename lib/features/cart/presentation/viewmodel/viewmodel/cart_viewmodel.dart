// lib/features/cart/presentation/viewmodel/cart_viewmodel.dart

import '../../../../../core/api/base/result/operation_result.dart';
import '../../../../../core/api/base/state/view_state.dart';
import '../../../../../core/api/base/viewmodel/base_view_model.dart';
import '../../../api/params/cart_request_params.dart';
import '../../../domain/model/cart_model.dart';
import '../../../domain/repository/cart_repository.dart';

class CartViewModel extends BaseViewModel<CartModel> {
  final CartRepository _repository;

  CartViewModel(this._repository) : super(_repository);

  Future<OperationResult<CartModel>> loadCart(String cartId) async {
    state = const ViewLoading();
    final result = await _repository.getCart(cartId);
    if (result is OperationSuccess<CartModel>) {
      state = ViewSuccess(result.data);
    } else {
      state = ViewError(
          (result as OperationFailure).message ?? 'Failed to load cart');
    }
    return result;
  }

  Future<OperationResult<CartModel>> addToCart(CartRequestParams params) async {
    state = const ViewLoading();
    final result = await _repository.addToCart(params);
    if (result is OperationSuccess<CartModel>) {
      state = ViewSuccess(result.data);
    } else {
      state = ViewError(
          (result as OperationFailure).message ?? 'Failed to add to cart');
    }
    return result;
  }

  Future<OperationResult<CartModel>> updateItemQuantity(
    String cartId,
    String itemId,
    int quantity,
  ) async {
    state = const ViewLoading();
    final result = await _repository.updateCartItem(cartId, itemId, quantity);
    if (result is OperationSuccess<CartModel>) {
      state = ViewSuccess(result.data);
    } else {
      state = ViewError(
          (result as OperationFailure).message ?? 'Failed to update quantity');
    }
    return result;
  }

  Future<OperationResult<bool>> removeCartItem(
      String cartId, String itemId) async {
    state = const ViewLoading();
    final result = await _repository.removeCartItem(cartId, itemId);
    if (result is OperationSuccess<bool>) {
      await loadCart(cartId);
    } else {
      state = ViewError(
          (result as OperationFailure).message ?? 'Failed to remove item');
    }
    return result;
  }
}
