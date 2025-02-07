// lib/features/wishlist/viewmodel/wishlist_viewmodel.dart

import '../../../core/api/base/result/operation_result.dart';
import '../../../core/api/base/viewmodel/base_view_model.dart';
import '../../../core/log/loggers.dart';
import '../../products/model/products_model.dart';
import '../repository/wishlist_reository.dart';

class WishlistViewModel extends BaseViewModel<ProductsModel> {
  static const String TAG = '[WishlistViewModel]';
  final WishlistRepository _repository;

  WishlistViewModel(this._repository) : super(_repository);

  Future<OperationResult<List<String>>> getWishlistedProducts(
      String customerId) async {
    AppLogger.logInfo(
        '$TAG Getting wishlisted products for customer: $customerId');
    return await _repository.getWishlistProducts(customerId);
  }

  Future<OperationResult<bool>> toggleWishlistedProduct(
    String productId,
    String customerId,
    bool isWishlisted,
  ) async {
    AppLogger.logInfo(
        '$TAG Toggling product $productId for customer $customerId, current status: $isWishlisted');
    return await _repository.toggleProductWishlist(
      productId,
      customerId,
      isWishlisted,
    );
  }

  Future<OperationResult<bool>> updateWishlistItem(
    String wishlistId,
    String customerId,
    String productId,
  ) async {
    AppLogger.logInfo('$TAG Updating wishlist item $wishlistId');
    return await _repository.updateWishlistItem(
      wishlistId,
      customerId,
      productId,
    );
  }
}
