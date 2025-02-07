// lib/features/cart/presentation/provider/cart_provider.dart
import 'package:good_food_app/core/data/share_preference/app_preferences.dart';

import '../../../../../../core/api/base/provider/base_provider.dart';
import '../../../../../../core/api/base/result/operation_result.dart';
import '../../../../../../core/api/base/state/base_state.dart';
import '../../../../api/params/cart_request_params.dart';
import '../../../../domain/model/cart_model.dart';
import '../../viewmodel/cart_viewmodel.dart';
import '../state/cart_state.dart';

class CartProvider extends BaseProvider<CartModel> {
  final CartViewModel _cartViewModel;
  String? _cartId;
  String? _error;
  bool _loading = false;

  CartProvider(this._cartViewModel) : super(_cartViewModel) {
    _initializeCart();
  }

  @override
  BaseState<CartModel> get initialState => const CartState();

  CartState get currentState => state as CartState;
  bool get isLoading => _loading;
  String? get cartId => _cartId;

  Future<void> _initializeCart() async {
    _cartId = await AppPreference.getCartData();
    if (_cartId != null) {
      await loadCart(_cartId!);
    }
  }

  Future<OperationResult<CartModel>> loadCart(String cartId) async {
    if (_loading) return OperationResult.failure('Operation in progress');

    try {
      _loading = true;
      notifyListeners();

      final result = await _cartViewModel.loadCart(cartId);

      if (result is OperationSuccess<CartModel>) {
        _cartId = cartId;
        await AppPreference.saveCartData(cartId);
        state = currentState.copyWith(data: result.data);
      } else {
        state =
            currentState.copyWith(error: (result as OperationFailure).message);
      }

      return result;
    } catch (e) {
      state = currentState.copyWith(error: e.toString());
      return OperationResult.failure(e.toString());
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<OperationResult<CartModel>> addToCart(CartRequestParams params) async {
    if (_loading) return OperationResult.failure('Operation in progress');

    final previousState = currentState;
    try {
      _loading = true;
      notifyListeners();

      state = currentState.copyWith(
          data: _getOptimisticCartUpdate(params),
          isProcessing: true,
          activeOperation: 'add_item');

      final result = await _cartViewModel.addToCart(params);

      if (result is OperationSuccess<CartModel>) {
        state = currentState.copyWith(data: result.data, isProcessing: false);
      } else {
        state = previousState.copyWith(
            error: (result as OperationFailure).message, isProcessing: false);
      }

      return result;
    } catch (e) {
      state = previousState.copyWith(error: e.toString(), isProcessing: false);
      return OperationResult.failure(e.toString());
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<OperationResult<CartModel>> updateItemQuantity(
    String cartId,
    String itemId,
    int quantity,
  ) async {
    if (quantity < 0 || _loading) {
      return OperationResult.failure('Invalid operation');
    }

    try {
      _loading = true;
      notifyListeners();

      final result =
          await _cartViewModel.updateItemQuantity(cartId, itemId, quantity);

      if (result is OperationSuccess<CartModel>) {
        state = currentState.copyWith(data: result.data);
      } else {
        state =
            currentState.copyWith(error: (result as OperationFailure).message);
      }

      return result;
    } catch (e) {
      state = currentState.copyWith(error: e.toString());
      return OperationResult.failure(e.toString());
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  CartModel _getOptimisticCartUpdate(CartRequestParams params) {
    final currentCart = currentState.data ?? CartModel();

    // Properly typed current items list
    final List<CartItem> currentItems = currentCart.items?.toList() ?? [];

    // Create new items with proper typing
    final List<CartItem> newItems = params.items
            ?.map((newItem) => CartItem(
                  productId: newItem.productId,
                  quantity: newItem.quantity,
                  unitPrice: newItem.unitPrice,
                  itemId: null, // Will be assigned by backend
                  linePrice: newItem.unitPrice != null
                      ? newItem.unitPrice! * newItem.quantity
                      : null,
                  taxRate: null, // Will be calculated by backend
                  product: null, // Will be populated by backend
                ))
            .toList() ??
        [];

    // Combine lists with proper typing
    final List<CartItem> updatedItems = [...currentItems, ...newItems];

    return CartModel(
      cartId: params.cartId ?? currentCart.cartId,
      items: updatedItems,
      customer: params.customer ?? currentCart.customer,
      orderSummary: currentCart.orderSummary,
    );
  }

  Future<OperationResult<bool>> removeCartItem(
      String cartId, String itemId) async {
    if (_loading) {
      return OperationResult.failure('Operation in progress');
    }

    try {
      _loading = true;
      notifyListeners();

      final result = await _cartViewModel.removeCartItem(cartId, itemId);

      if (result is OperationSuccess<bool>) {
        await loadCart(cartId);
      } else {
        state =
            currentState.copyWith(error: (result as OperationFailure).message);
      }

      return result;
    } catch (e) {
      state = currentState.copyWith(error: e.toString());
      return OperationResult.failure(e.toString());
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
