// // lib/features/products/provider/product_details_provider.dart
// import 'package:flutter/foundation.dart';
//
// import '../products/model/products_model.dart';
//
// class ProductDetailsProvider extends ChangeNotifier {
//   final ProductsModel product;
//   String selectedWeight = "500 g";
//   int quantity = 0;
//   bool isProductInfoExpanded = false;
//   bool isNutritionalFactsExpanded = false;
//   bool isHealthBenefitsExpanded = false;
//
//   ProductDetailsProvider(this.product);
//
//   void updateSelectedWeight(String weight) {
//     selectedWeight = weight;
//     notifyListeners();
//   }
//
//   void incrementQuantity() {
//     quantity++;
//     notifyListeners();
//   }
//
//   void decrementQuantity() {
//     if (quantity > 0) {
//       quantity--;
//       notifyListeners();
//     }
//   }
//
//   void toggleProductInfo() {
//     isProductInfoExpanded = !isProductInfoExpanded;
//     notifyListeners();
//   }
//
//   void toggleNutritionalFacts() {
//     isNutritionalFactsExpanded = !isNutritionalFactsExpanded;
//     notifyListeners();
//   }
//
//   void toggleHealthBenefits() {
//     isHealthBenefitsExpanded = !isHealthBenefitsExpanded;
//     notifyListeners();
//   }
// }
