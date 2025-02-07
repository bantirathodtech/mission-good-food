// lib/features/products/model/products_response.dart
import '../../../../core/api/base/state/base_state.dart';
import '../../../../core/api/base/state/view_state.dart';
import '../products_model.dart';

class ProductsResponse {
  final ProductsModel? products;
  final String? error;
  final bool isLoading;

  ProductsResponse({
    required this.products,
    this.error,
    this.isLoading = false,
  });

  factory ProductsResponse.fromState(BaseState<ProductsModel> state) {
    return ProductsResponse(
      products: state.data,
      error: state.error,
      isLoading: state.status is ViewLoading,
    );
  }
}
