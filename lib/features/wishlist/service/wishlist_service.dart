// lib/features/wishlist/service/wishlist_service.dart

import '../../../core/api/base/result/operation_result.dart';
import '../../../core/api/endpoints/api_url_manager.dart';
import '../../../core/api/root/app_root_service.dart';
import '../../../core/log/loggers.dart';

class WishlistService {
  static const String TAG = '[WishlistService]';
  final AppRootService rootService;

  WishlistService(this.rootService);

  Future<OperationResult<List<String>>> getWishlist(String customerId) async {
    try {
      AppLogger.logInfo('$TAG Fetching wishlist for customer: $customerId');
      final response = await rootService.sendRestRequest(
        endpoint: AppUrls.fetchWishlist.replaceAll("{id}", customerId),
        method: 'GET',
      );

      if (response == null || !response.containsKey('data')) {
        AppLogger.logError('$TAG Invalid response format');
        return OperationResult.failure('Invalid response format');
      }

      final List<dynamic> items = response['data'] as List;
      final productIds = items
          .where((item) => item['product_id'] != null)
          .map((item) => item['product_id'] as String)
          .toList();

      AppLogger.logInfo('$TAG Successfully fetched ${productIds.length} items');
      return OperationResult.success(productIds);
    } catch (e) {
      AppLogger.logError('$TAG Error fetching wishlist: $e');
      return OperationResult.failure(e.toString());
    }
  }

  Future<OperationResult<bool>> addToWishlist({
    required String customerId,
    required String productId,
  }) async {
    try {
      AppLogger.logInfo('$TAG Adding product $productId to wishlist');
      final response = await rootService.sendRestRequest(
        endpoint: AppUrls.addToWishlist,
        method: 'POST',
        body: {
          'customer_id': customerId,
          'product_id': productId,
        },
      );

      if (response['success'] == true || response['message'] == 'Wishlist Successfully Created') {
        AppLogger.logInfo('$TAG Successfully added to wishlist');
        return OperationResult.success(true);
      }
      
      AppLogger.logError('$TAG Failed to add to wishlist: ${response['message']}');
      return OperationResult.failure('Failed to add to wishlist');
    } catch (e) {
      AppLogger.logError('$TAG Error adding to wishlist: $e');
      return OperationResult.failure(e.toString());
    }
  }

  Future<OperationResult<bool>> updateWishlist({
    required String wishlistId,
    required String customerId,
    required String productId,
  }) async {
    try {
      AppLogger.logInfo('$TAG Updating wishlist item $wishlistId');
      final response = await rootService.sendRestRequest(
        endpoint: AppUrls.updateWishlist.replaceAll("{id}", wishlistId),
        method: 'PUT',
        body: {
          'customer_id': customerId,
          'product_id': productId,
        },
      );

      if (response['success'] == true || response['message'] == 'Wishlist Updated Successfully') {
        AppLogger.logInfo('$TAG Successfully updated wishlist');
        return OperationResult.success(true);
      }
      
      AppLogger.logError('$TAG Failed to update wishlist: ${response['message']}');
      return OperationResult.failure('Failed to update wishlist');
    } catch (e) {
      AppLogger.logError('$TAG Error updating wishlist: $e');
      return OperationResult.failure(e.toString());
    }
  }

  Future<OperationResult<bool>> removeFromWishlist({
    required String customerId,
    required String productId,
  }) async {
    try {
      AppLogger.logInfo('$TAG Removing product $productId from wishlist');
      final response = await rootService.sendRestRequest(
        endpoint: AppUrls.removeFromWishlist,
        method: 'DELETE',
        queryParams: {
          'customer_id': customerId,
          'product_id': productId,
        },
      );

      if (response['success'] == true || response['message'] == 'Wishlist item deleted successfully') {
        AppLogger.logInfo('$TAG Successfully removed from wishlist');
        return OperationResult.success(true);
      }
      
      AppLogger.logError('$TAG Failed to remove from wishlist: ${response['message']}');
      return OperationResult.failure('Failed to remove from wishlist');
    } catch (e) {
      AppLogger.logError('$TAG Error removing from wishlist: $e');
      return OperationResult.failure(e.toString());
    }
  }
}