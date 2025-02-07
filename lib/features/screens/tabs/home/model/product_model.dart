class ProductModel {
  final String productImage; // Image URL or asset path
  final String productName; // Name of the product
  final double productPrice; // Price of the product
  final int productQty; // Quantity of the product
  final num? rate; // Rating of the product (0-5)
  final num? totalRating; // Total rating of the product
  late final bool isFavorite; // Whether the product is marked as favorite

  // Constructor to initialize the product details
  ProductModel({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productQty,
    this.rate,
    this.totalRating,
    required this.isFavorite,
  });

  // Optionally, you can add a method to display product info
  String getProductInfo() {
    return 'Product: $productName\nPrice: \$${productPrice.toStringAsFixed(2)}\nQuantity: $productQty\nFavorite: $isFavorite';
  }

  // Method to toggle the favorite status
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
