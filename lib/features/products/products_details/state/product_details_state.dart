// lib/features/products/products_details/viewmodel/product_details_viewmodel.dart

// lib/features/products/products_details/state/product_details_state.dart

import 'package:flutter/foundation.dart';

import '../../model/document.dart';

@immutable
class ProductDetailsState {
  final Document product;
  final int quantity;
  final String selectedWeight;
  final List<String> availableWeights;
  final bool isProductInfoExpanded;
  final bool isNutritionalFactsExpanded;
  final bool isHealthBenefitsExpanded;
  final String? error;
  final List<Document> similarProducts;

  const ProductDetailsState({
    required this.product,
    this.quantity = 1,
    this.selectedWeight = "",
    this.availableWeights = const [],
    this.isProductInfoExpanded = false,
    this.isNutritionalFactsExpanded = false,
    this.isHealthBenefitsExpanded = false,
    this.error,
    this.similarProducts = const [],
  });

  // double get totalPrice {
  //   final price = double.tryParse(product.salePrice ?? '0') ?? 0;
  //   return quantity * price;
  // }

  num get totalPrice {
  // Convert product.salePrice safely to num
  final price = (product.salePrice is num) ? product.salePrice as num : 0;
  // Or if you want to handle potential numeric strings as well:
  // final price = num.tryParse('${product.salePrice ?? 0}') ?? 0;
  return quantity * price;
}

  ProductDetailsState copyWith({
    Document? product,
    int? quantity,
    String? selectedWeight,
    List<String>? availableWeights,
    bool? isProductInfoExpanded,
    bool? isNutritionalFactsExpanded,
    bool? isHealthBenefitsExpanded,
    String? error,
    List<Document>? similarProducts,
  }) {
    return ProductDetailsState(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedWeight: selectedWeight ?? this.selectedWeight,
      availableWeights: availableWeights ?? this.availableWeights,
      isProductInfoExpanded:
          isProductInfoExpanded ?? this.isProductInfoExpanded,
      isNutritionalFactsExpanded:
          isNutritionalFactsExpanded ?? this.isNutritionalFactsExpanded,
      isHealthBenefitsExpanded:
          isHealthBenefitsExpanded ?? this.isHealthBenefitsExpanded,
      error: error ?? this.error,
      similarProducts: similarProducts ?? this.similarProducts,
    );
  }
}

// // lib/features/products/products_details/state/product_details_state.dart
//
// import 'package:flutter/foundation.dart';
//
// import '../../model/document.dart';
//
// @immutable
// class ProductDetailsState {
//   final Document product;
//   final int quantity;
//   final String selectedWeight;
//   final List<String> availableWeights;
//   final bool isProductInfoExpanded;
//   final bool isNutritionalFactsExpanded;
//   final bool isHealthBenefitsExpanded;
//   final bool isLoading;
//   final String? error;
//
//   const ProductDetailsState({
//     required this.product,
//     this.quantity = 0,
//     this.selectedWeight = "",
//     this.availableWeights = const [],
//     this.isProductInfoExpanded = false,
//     this.isNutritionalFactsExpanded = false,
//     this.isHealthBenefitsExpanded = false,
//     this.isLoading = false,
//     this.error,
//   });
//
//   double get totalPrice {
//     final price = double.tryParse(product.salePrice ?? '0') ?? 0;
//     return quantity * price;
//   }
//
//   ProductDetailsState copyWith({
//     Document? product,
//     int? quantity,
//     String? selectedWeight,
//     List<String>? availableWeights,
//     bool? isProductInfoExpanded,
//     bool? isNutritionalFactsExpanded,
//     bool? isHealthBenefitsExpanded,
//     bool? isLoading,
//     String? error,
//   }) {
//     return ProductDetailsState(
//       product: product ?? this.product,
//       quantity: quantity ?? this.quantity,
//       selectedWeight: selectedWeight ?? this.selectedWeight,
//       availableWeights: availableWeights ?? this.availableWeights,
//       isProductInfoExpanded:
//           isProductInfoExpanded ?? this.isProductInfoExpanded,
//       isNutritionalFactsExpanded:
//           isNutritionalFactsExpanded ?? this.isNutritionalFactsExpanded,
//       isHealthBenefitsExpanded:
//           isHealthBenefitsExpanded ?? this.isHealthBenefitsExpanded,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//     );
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is ProductDetailsState &&
//           runtimeType == other.runtimeType &&
//           product == other.product &&
//           quantity == other.quantity &&
//           selectedWeight == other.selectedWeight &&
//           isProductInfoExpanded == other.isProductInfoExpanded &&
//           isNutritionalFactsExpanded == other.isNutritionalFactsExpanded &&
//           isHealthBenefitsExpanded == other.isHealthBenefitsExpanded &&
//           isLoading == other.isLoading &&
//           error == other.error;
//
//   @override
//   int get hashCode =>
//       product.hashCode ^
//       quantity.hashCode ^
//       selectedWeight.hashCode ^
//       isProductInfoExpanded.hashCode ^
//       isNutritionalFactsExpanded.hashCode ^
//       isHealthBenefitsExpanded.hashCode ^
//       isLoading.hashCode ^
//       error.hashCode;
// }
