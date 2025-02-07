// lib/features/wishlist/mixins/wishlist_aware.dart

import 'package:flutter/foundation.dart';
import '../../../core/api/base/result/operation_result.dart';
import '../interface/wishlist_behavior.dart';
import '../viewmodel/wishlist_viewmodel.dart';

mixin WishlistAware implements WishlistBehavior {
  abstract final WishlistViewModel wishlistViewModel;
  abstract final String? customerId;
  abstract final List<String> wishlistedProductIds;

  @override
  bool isProductWishlisted(String productId) {
    return wishlistedProductIds.contains(productId);
  }

  @override
  List<String> getWishlistedProductIds() {
    return List.unmodifiable(wishlistedProductIds);
  }

  @override
  Future<OperationResult<List<String>>> loadWishlistedProducts() async {
    if (customerId == null) {
      debugPrint('Customer ID is null, skipping wishlist load');
      return OperationResult.failure('Customer ID is null');
    }

    try {
      return await wishlistViewModel.getWishlistedProducts(customerId!);
    } catch (e) {
      debugPrint('Error loading wishlist: $e');
      return OperationResult.failure(e.toString());
    }
  }

  @override
  Future<OperationResult<bool>> toggleWishlist(String productId) async {
    if (customerId == null) {
      debugPrint('Customer ID is null, skipping wishlist toggle');
      return OperationResult.failure('Customer ID is null');
    }

    try {
      return await wishlistViewModel.toggleWishlistedProduct(
        productId,
        customerId!,
        isProductWishlisted(productId),
      );
    } catch (e) {
      debugPrint('Error toggling wishlist: $e');
      return OperationResult.failure(e.toString());
    }
  }
}