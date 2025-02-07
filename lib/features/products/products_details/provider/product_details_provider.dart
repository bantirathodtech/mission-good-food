// lib/features/products/products_details/viewmodel/product_details_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:good_food_app/features/products/products_details/viewmodel/product_details_viewmodel.dart';

import '../../../../core/api/base/result/operation_result.dart';
import '../../model/document.dart';
import '../../model/products_model.dart';
import '../state/product_details_state.dart';

class ProductDetailsProvider extends ChangeNotifier {
  // final ProductsRepository _repository;
  final ProductDetailsViewModel _viewModel;
  final Document product;
  late ProductDetailsState _state;
  bool _loading = false;

  // ProductDetailsProvider(this._viewModel, this.product) {
  //   _state = ProductDetailsState(product: product);
  //   _initialize();
  // }

  ProductDetailsProvider(this._viewModel, this.product) {
    _state = ProductDetailsState(product: product);
    _initialize();
  }

  ProductDetailsState get state => _state;
  bool get isLoading => _loading;

  void _initialize() {
    _initializeWeights();
    _loadSimilarProducts();
  }

  void _initializeWeights() {
    final weightAttributes = product.productAttributes
            ?.where((attr) => attr.attribute?.name?.toLowerCase() == 'weight')
            .map((attr) => attr.value)
            .whereType<String>()
            .toList() ??
        [];

    if (weightAttributes.isNotEmpty) {
      _state = _state.copyWith(
        availableWeights: weightAttributes,
        selectedWeight: weightAttributes.first,
      );
      notifyListeners();
    }
  }

  Future<void> _loadSimilarProducts() async {
    final result = await _viewModel.loadSimilarProducts();
    if (result is OperationSuccess<List<ProductsModel>>) {
      _state = _state.copyWith(
        similarProducts: result.data.first.hits
                ?.where((hit) => hit.document?.productId != product.productId)
                .map((hit) => Document.fromJson(hit.document!.toJson()))
                .take(4)
                .toList() ??
            [],
      );
      notifyListeners();
    }
  }
  // Future<void> _loadSimilarProducts() async {
  //   if (product.productCategoryName == null) return;
  //
  //   _loading = true;
  //   notifyListeners();
  //
  //   try {
  //     final result = await _repository.getGroceryProducts(
  //       productCategoryName: product.productCategoryName,
  //       perPage: 4,
  //       salePrice: 'asc',
  //     );
  //
  //     if (result is OperationSuccess<List<ProductsModel>>) {
  //       final similarProducts = result.data.first.hits
  //               ?.where((hit) => hit.document?.productId != product.productId)
  //               .map((hit) => Document.fromJson(hit.document!.toJson()))
  //               .take(4)
  //               .toList() ??
  //           [];
  //
  //       _state = _state.copyWith(similarProducts: similarProducts);
  //     }
  //   } catch (e) {
  //     _state = _state.copyWith(error: e.toString());
  //   } finally {
  //     _loading = false;
  //     notifyListeners();
  //   }
  // }

  void updateQuantity(bool increment) {
    final maxQuantity = int.tryParse(product.value ?? '0') ?? 0;
    if (increment && _state.quantity < maxQuantity) {
      _state = _state.copyWith(quantity: _state.quantity + 1);
      notifyListeners();
    } else if (!increment && _state.quantity > 1) {
      _state = _state.copyWith(quantity: _state.quantity - 1);
      notifyListeners();
    }
  }

  void toggleSection(String section) {
    switch (section) {
      case 'info':
        _state = _state.copyWith(
            isProductInfoExpanded: !_state.isProductInfoExpanded);
        break;
      case 'nutrition':
        _state = _state.copyWith(
            isNutritionalFactsExpanded: !_state.isNutritionalFactsExpanded);
        break;
      case 'benefits':
        _state = _state.copyWith(
            isHealthBenefitsExpanded: !_state.isHealthBenefitsExpanded);
        break;
    }
    notifyListeners();
  }

  void updateSelectedWeight(String? weight) {
    if (weight != null && _state.availableWeights.contains(weight)) {
      _state = _state.copyWith(selectedWeight: weight);
      notifyListeners();
    }
  }

  Future<void> addToCart() async {
    // TODO: Implement when cart functionality is available
  }

  Future<void> subscribe() async {
    // TODO: Implement when subscription functionality is available
  }
}

// // lib/features/products/products_details/provider/product_details_provider.dart
//
// import 'package:flutter/foundation.dart';
//
// import '../../model/document.dart';
// import '../state/product_details_state.dart';
// import '../viewmodel/product_details_viewmodel.dart';
//
// class ProductDetailsProvider extends ChangeNotifier {
//   final ProductDetailsViewModel _viewModel;
//   final Document product;
//   late ProductDetailsState _state;
//
//   ProductDetailsProvider(this._viewModel, this.product) {
//     _state = ProductDetailsState(product: product);
//     _initialize();
//   }
//
//   ProductDetailsState get state => _state;
//   List<Document> get similarProducts => _viewModel.similarProducts;
//   bool get isLoading => _viewModel.isLoading;
//
//   void _initialize() {
//     _initializeWeights();
//     _loadRelatedProducts();
//   }
//
//   void _initializeWeights() {
//     final weightAttributes = product.productAttributes
//             ?.where((attr) => attr.attribute?.name?.toLowerCase() == 'weight')
//             .map((attr) => attr.value)
//             .whereType<String>()
//             .toList() ??
//         [];
//
//     if (weightAttributes.isNotEmpty) {
//       _state = _state.copyWith(
//         availableWeights: weightAttributes,
//         selectedWeight: weightAttributes.first,
//       );
//       notifyListeners();
//     }
//   }
//
//   Future<void> _loadRelatedProducts() async {
//     await _viewModel.loadRelatedProducts();
//     notifyListeners();
//   }
//
//   void updateQuantity(bool increment) {
//     final maxQuantity = int.tryParse(product.value ?? '0') ?? 0;
//     if (increment && _state.quantity < maxQuantity) {
//       _state = _state.copyWith(quantity: _state.quantity + 1);
//       notifyListeners();
//     } else if (!increment && _state.quantity > 0) {
//       _state = _state.copyWith(quantity: _state.quantity - 1);
//       notifyListeners();
//     }
//   }
//
//   void toggleSection(String section) {
//     switch (section) {
//       case 'info':
//         _state = _state.copyWith(
//             isProductInfoExpanded: !_state.isProductInfoExpanded);
//         break;
//       case 'nutrition':
//         _state = _state.copyWith(
//             isNutritionalFactsExpanded: !_state.isNutritionalFactsExpanded);
//         break;
//       case 'benefits':
//         _state = _state.copyWith(
//             isHealthBenefitsExpanded: !_state.isHealthBenefitsExpanded);
//         break;
//     }
//     notifyListeners();
//   }
//
//   void updateSelectedWeight(String? weight) {
//     if (weight != null && _state.availableWeights.contains(weight)) {
//       _state = _state.copyWith(selectedWeight: weight);
//       notifyListeners();
//     }
//   }
//
//   Future<void> addToCart() async {
//     await _viewModel.addToCart(_state.quantity, _state.selectedWeight);
//   }
//
//   Future<void> subscribe() async {
//     await _viewModel.subscribe();
//   }
//
//   double get tota
