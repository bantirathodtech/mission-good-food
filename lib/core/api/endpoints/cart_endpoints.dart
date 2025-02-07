// lib/features/cart/data/endpoints/cart_endpoints.dart
// lib/features/cart/data/endpoints/cart_endpoints.dart
import 'api_url_manager.dart';

class CartEndpoints {
  static const String base = '${AppUrls.baseCommerceUrl}cart';
  static const String createCart = base;
  static const String fetchCartById = '$base/{id}';
  static const String updateCartById = '$base/{id}';
  static const String deleteCartById = '$base/{id}';
  static const String deleteAllCartItemsById =
      '${AppUrls.baseCommerceUrl}deleteCart/{id}';
  static const String mergeUserCart =
      '${AppUrls.baseCommerceUrl}mergeUserToCart/{id}';
}
