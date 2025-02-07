// lib/features/products/viewmodel/products_viewmodel.dart
import 'package:good_food_app/core/log/loggers.dart';

import '../../../../core/api/base/result/operation_result.dart';
import '../../../../core/api/base/state/view_state.dart';
import '../../../../core/api/base/viewmodel/base_view_model.dart';
import '../../model/products_model.dart';
import '../../repository/products_repository.dart';
import '../../service/products/dtos/product_request_params.dart';

class ProductsViewModel extends BaseViewModel<ProductsModel> {
  ProductsViewModel(super.repository);

  Future<void> loadProducts({
    String? categoryName,
    String sortOrder = ProductRequestParams.DEFAULT_SORT,
    String? brand,
    String? minPrice,
    String? maxPrice,
    String? limit = ProductRequestParams.DEFAULT_LIMIT,
    String? offset,
  }) async {
    AppLogger.logInfo('[ProductsViewModel] Loading products');
    state = const ViewLoading();

    final result = await (repository as ProductsRepository).getGroceryProducts(
      productCategoryName: categoryName,
      salePrice: sortOrder,
      brand: brand,
      salePriceMin: minPrice,
      salePriceMax: maxPrice,
      limit: limit,
      offset: offset,
    );

    if (result is OperationSuccess<List<ProductsModel>>) {
      state = result.data.isEmpty
          ? ViewSuccess(ProductsModel())
          : ViewSuccess(result.data.first);
    } else {
      state = ViewError((result as OperationFailure).message ?? 'Load failed');
    }
  }

  Future<void> loadMoreProducts({
    String? categoryName,
    String? brand,
    String? minPrice,
    String? maxPrice,
    String sortOrder = ProductRequestParams.DEFAULT_SORT,
    required int currentPage,
    int itemsPerPage = 240,
  }) async {
    final offset = (currentPage * itemsPerPage).toString();

    await loadProducts(
      categoryName: categoryName,
      brand: brand,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sortOrder: sortOrder,
      limit: itemsPerPage.toString(),
      offset: offset,
    );
  }

  // Future implementation for other themes
  // Future<void> loadFashionProducts(...)
  // Future<void> loadElectronicsProducts(...)
}
