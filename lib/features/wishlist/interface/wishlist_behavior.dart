// lib/features/wishlist/interface/wishlist_behavior.dart

import '../../../core/api/base/result/operation_result.dart';

abstract class WishlistBehavior {
  String? get customerId;
  bool isProductWishlisted(String productId);
  Future<OperationResult<bool>> toggleWishlist(String productId);
  Future<OperationResult<List<String>>> loadWishlistedProducts();
  List<String> getWishlistedProductIds();
}