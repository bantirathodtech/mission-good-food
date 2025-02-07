// lib/features/products/products_details/viewmodel/product_details_viewmodel.dart

import '../../../../core/api/base/result/operation_result.dart';
import '../../../../core/api/base/viewmodel/base_view_model.dart';
import '../../model/document.dart';
import '../../model/products_model.dart';
import '../../repository/products_repository.dart';

class ProductDetailsViewModel extends BaseViewModel<ProductsModel> {
  final Document product;
  bool _loading = false;

  ProductDetailsViewModel(
    ProductsRepository repository,
    this.product,
  ) : super(repository);

  bool get isLoading => _loading;

  Future<void> refresh() async {
    _loading = true;
    notifyListeners();
    try {
      await loadSimilarProducts();
      await getProductDetails();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<OperationResult<List<ProductsModel>>> loadSimilarProducts() async {
    return await (repository as ProductsRepository).getGroceryProducts(
      productCategoryName: product.productCategoryName,
      limit: "240",
    );
  }

  Future<OperationResult<ProductsModel>> getProductDetails() async {
    return await (repository as ProductsRepository).getById(product.id ?? '');
  }

  Future<void> addToCart(int quantity, String selectedWeight) async {
    // Implement cart functionality
  }

  Future<void> subscribe() async {
    // Implement subscription functionality
  }
}
