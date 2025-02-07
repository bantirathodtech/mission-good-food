// lib/features/wishlist/repository/wishlist_repository.dart

import '../../../core/api/base/repository/base_repository.dart';
import '../../../core/api/base/result/operation_result.dart';
import '../../../core/log/loggers.dart';
import '../../products/model/products_model.dart';
import '../service/wishlist_service.dart';

class WishlistRepository extends BaseRepository<ProductsModel> {
  static const String TAG = '[WishlistRepository]';
  final WishlistService _wishlistService;

  WishlistRepository(this._wishlistService);

  Future<OperationResult<List<String>>> getWishlistProducts(String customerId) async {
    AppLogger.logInfo('$TAG Getting wishlist products for customer: $customerId');
    return await _wishlistService.getWishlist(customerId);
  }

  Future<OperationResult<bool>> toggleProductWishlist(
    String productId,
    String customerId,
    bool isWishlisted,
  ) async {
    AppLogger.logInfo(
      '$TAG Toggling product $productId for customer $customerId, current status: $isWishlisted'
    );
    
    return isWishlisted
        ? _wishlistService.addToWishlist(
            customerId: customerId,
            productId: productId,
          )
        : _wishlistService.removeFromWishlist(
            customerId: customerId,
            productId: productId,
          );
  }

  Future<OperationResult<bool>> updateWishlistItem(
    String wishlistId,
    String customerId,
    String productId,
  ) async {
    AppLogger.logInfo('$TAG Updating wishlist item $wishlistId');
    return await _wishlistService.updateWishlist(
      wishlistId: wishlistId,
      customerId: customerId,
      productId: productId,
    );
  }
}