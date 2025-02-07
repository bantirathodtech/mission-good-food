// lib/features/products/provider/products_provider.dart

import 'package:flutter/cupertino.dart';
import 'package:good_food_app/features/products/service/products/dtos/product_request_params.dart';
import 'package:good_food_app/features/wishlist/mixins/wishlist_aware.dart';
import 'package:good_food_app/features/wishlist/viewmodel/wishlist_viewmodel.dart';

import '../../../../core/api/base/result/operation_result.dart';
import '../../../../core/api/base/state/extension/base_wishlist_provider.dart';
import '../../model/products_model.dart';
import '../state/products_state.dart';
import '../viewmodel/products_viewmodel.dart';

class ProductsProvider extends BaseWishlistProvider<ProductsModel>
    with WishlistAware {
  final ProductsViewModel _productsViewModel;
  @override
  final WishlistViewModel wishlistViewModel;

  bool _loading = false;
  bool _loadingMore = false;
  String? _error;

  ProductsProvider(
    this._productsViewModel,
    this.wishlistViewModel,
  ) : super(_productsViewModel);

  bool get isLoading => _loading;
  bool get isLoadingMore => _loadingMore;
  String? get error => _error;

  @override
  String? get customerId => super.customerId;

  @override
  List<String> get wishlistedProductIds => currentState.wishlistedProductIds;

  @override
  ProductsState get initialState => const ProductsState();
  ProductsState get currentState => state as ProductsState;

  // Products loading with filters
  Future<void> loadProducts({
    String? categoryName,
    String? brand,
    String? minPrice,
    String? maxPrice,
    String? sortOrder,
    bool reset = false,
    // String? categoryId,
  }) async {
    try {
      _loading = true;
      notifyListeners();

      await _productsViewModel.loadProducts(
        categoryName: categoryName,
        brand: brand,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sortOrder: sortOrder ?? currentState.sortOrder,
        limit: ProductRequestParams.DEFAULT_LIMIT,
      );

      state = currentState.copyWith(
        selectedCategoryName: categoryName,
        selectedBrand: brand,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sortOrder: sortOrder,
        currentPage: reset ? 1 : currentState.currentPage,
        hasMoreProducts: true,
      );

      // Load wishlist status after products are loaded
      if (customerId != null) {
        final wishlistResult = await loadWishlistedProducts();
        if (wishlistResult is OperationSuccess<List<String>>) {
          state = currentState.copyWith(
            wishlistedProductIds: wishlistResult.data,
          );
        }
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Pagination
  // In ProductsProvider class
  Future<void> loadMoreProducts() async {
    if (_loadingMore || !currentState.hasMoreProducts) return;

    try {
      _loadingMore = true;
      // Notify listeners outside of build phase
      Future.microtask(() => notifyListeners());

      await (viewModel as ProductsViewModel).loadMoreProducts(
        categoryName: currentState.selectedCategoryName,
        brand: currentState.selectedBrand,
        minPrice: currentState.minPrice,
        maxPrice: currentState.maxPrice,
        sortOrder: currentState.sortOrder,
        currentPage: currentState.currentPage,
      );

      state = currentState.copyWith(
        currentPage: currentState.currentPage + 1,
        hasMoreProducts: currentState.products.isNotEmpty,
      );
    } finally {
      _loadingMore = false;
      // Notify listeners outside of build phase
      Future.microtask(() => notifyListeners());
    }
  }

  // Category selection
  Future<void> selectCategory(String categoryName) async {
    if (currentState.selectedCategoryName == categoryName) return;
    await loadProducts(
      categoryName: categoryName,
      reset: true,
    );
  }

  // Sort order update
  Future<void> updateSortOrder(String sortOrder) async {
    if (currentState.sortOrder == sortOrder) return;
    await loadProducts(
      categoryName: currentState.selectedCategoryName,
      brand: currentState.selectedBrand,
      minPrice: currentState.minPrice,
      maxPrice: currentState.maxPrice,
      sortOrder: sortOrder,
      reset: true,
    );
  }

  // Apply filters
  Future<void> applyFilters({
    String? brand,
    String? minPrice,
    String? maxPrice,
  }) async {
    await loadProducts(
      categoryName: currentState.selectedCategoryName,
      brand: brand,
      minPrice: minPrice,
      maxPrice: maxPrice,
      reset: true,
    );
  }

  // Handle wishlist operations
  Future<void> handleWishlistToggle(String productId) async {
    if (customerId == null) return;

    final result = await toggleWishlist(productId);

    if (result is OperationSuccess<bool>) {
      final updatedIds = List<String>.from(currentState.wishlistedProductIds);
      final isCurrentlyWishlisted = isProductWishlisted(productId);

      if (isCurrentlyWishlisted) {
        updatedIds.remove(productId);
      } else {
        updatedIds.add(productId);
      }

      state = currentState.copyWith(
        wishlistedProductIds: updatedIds,
      );
      notifyListeners();
    }
  }

  @override
  Future<OperationResult<bool>> toggleWishlist(String productId) async {
    if (customerId == null) {
      debugPrint('Customer ID is null, skipping wishlist toggle');
      return OperationResult.failure('Customer ID is null');
    }
    return await wishlistViewModel.toggleWishlistedProduct(
      productId,
      customerId!,
      isProductWishlisted(productId),
    );
  }

  // Category selection, filters, etc. remain the same...

  // Refresh
  Future<void> refresh() async {
    await loadProducts(
      categoryName: currentState.selectedCategoryName,
      brand: currentState.selectedBrand,
      minPrice: currentState.minPrice,
      maxPrice: currentState.maxPrice,
      sortOrder: currentState.sortOrder,
      reset: true,
    );
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
