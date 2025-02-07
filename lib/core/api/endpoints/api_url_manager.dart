class AppUrls {
  // Base URLs
  static const String baseUrl = 'https://hub.ecom.cwcloud.in/';
  static const String baseCommerceUrl = '${baseUrl}api/commerce/';

  // User Endpoints
  static const String fetchUserData = '${baseCommerceUrl}customers';
  static const String createCustomer = '${baseCommerceUrl}customers';
  static const String fetchUserById = '${baseCommerceUrl}customers/{id}';
  static const String deleteAddressById =
      '${baseCommerceUrl}customers/address/{id}';

  // Product Endpoints
  // static const String fetchProducts = '${baseCommerceUrl}products';
  static const String fetchProducts = '${baseUrl}api/commerce/products';
  static const String fetchProductById = '${baseUrl}api/commerce/products';
  static const String fetchCategories = '${baseCommerceUrl}typesenseCategories';

  // Cart Endpoints
  static const String createCart = '${baseCommerceUrl}cart/{cart_id}';
  static const String fetchCartById = '${baseCommerceUrl}cart/{id}';
  static const String updateCartById = '${baseCommerceUrl}cart/{id}';
  static const String deleteCartById = '${baseCommerceUrl}cart/{id}';
  static const String deleteAllCartItemsById =
      '${baseCommerceUrl}deleteCart/{id}';

  // Checkout Endpoint
  static const String fetchCheckoutById = '${baseCommerceUrl}checkout/{id}';

  // Wishlist Endpoints
  static const String fetchWishlist = '${baseCommerceUrl}wishlist/{id}';
  static const String addToWishlist = '${baseCommerceUrl}wishlist';
  static const String updateWishlist = '${baseCommerceUrl}wishlist/{id}';
  static const String removeFromWishlist = '${baseCommerceUrl}wishlist';
}
