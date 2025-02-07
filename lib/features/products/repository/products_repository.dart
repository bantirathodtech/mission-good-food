import '../../../core/api/base/repository/base_repository.dart';
import '../../../core/api/base/result/operation_result.dart';
import '../../../core/api/endpoints/api_url_manager.dart';
import '../../wishlist/service/wishlist_service.dart';
import '../model/products_model.dart';
import '../service/products/dtos/product_request_params.dart';
import '../service/products/products_service.dart';

class ProductsRepository extends BaseRepository<ProductsModel> {
  static const String TAG = '[ProductsRepository]';
  final ProductsService _productService;
  final WishlistService _wishlistService;

  ProductsRepository(this._productService, this._wishlistService);

  Future<OperationResult<List<ProductsModel>>> getGroceryProducts({
    String? productCategoryName,
    String salePrice = ProductRequestParams.DEFAULT_SORT,
    String? brand,
    String? salePriceMin,
    String? salePriceMax,
    String? limit = ProductRequestParams.DEFAULT_LIMIT,
    String? offset,
  }) async {
    final requestParams = ProductRequestParams(
      themeName: 'GROC',
      salePrice: salePrice,
      productCategoryName: productCategoryName,
      brand: brand,
      salePriceMin: salePriceMin,
      salePriceMax: salePriceMax,
      limit: limit,
      offset: offset,
    );

    final result = await _productService.getProducts(requestParams);

    return result.when(
      success: (data) => OperationResult.success([data]),
      failure: (message, code) => OperationResult.failure(message, code: code),
      loading: () => OperationResult.loading(),
    );
  }

  // Future implementations for other themes
  // Future<OperationResult<List<ProductsModel>>> getFashionProducts(...)
  // Future<OperationResult<List<ProductsModel>>> getElectronicsProducts(...)

  Future<OperationResult<ProductsModel>> getById(String id) async {
    return await _productService
        .execute(AppUrls.fetchProductById.replaceAll('{id}', id));
  }
}
