import 'package:flutter/cupertino.dart';
// lib/features/products/state/products_state.dart

import 'package:flutter/foundation.dart';

import '../../../../core/api/base/state/extension/base_wishlist_state.dart';
import '../../../../core/api/base/state/view_state.dart';
import '../../model/document.dart';
import '../../model/products_model.dart';

@immutable
class ProductsState extends BaseWishlistState<ProductsModel> {
  final String? selectedCategoryName;
  final String sortOrder;
  final String? selectedBrand;
  final String? minPrice;
  final String? maxPrice;
  final int currentPage;
  final bool hasMoreProducts;

  const ProductsState({
    super.status = const ViewInitial(),
    super.data,
    super.error,
    super.wishlistedProductIds = const [],
    this.selectedCategoryName,
    this.sortOrder = 'asc',
    this.selectedBrand,
    this.minPrice,
    this.maxPrice,
    this.currentPage = 1,
    this.hasMoreProducts = true,
  });

  @override
  ProductsState copyWith({
    ViewState<ProductsModel>? status,
    ProductsModel? data,
    String? error,
    List<String>? wishlistedProductIds,
    String? selectedCategoryName,
    String? sortOrder,
    String? selectedBrand,
    String? minPrice,
    String? maxPrice,
    int? currentPage,
    bool? hasMoreProducts,
  }) {
    return ProductsState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
      wishlistedProductIds: wishlistedProductIds ?? this.wishlistedProductIds,
      selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,
      sortOrder: sortOrder ?? this.sortOrder,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      currentPage: currentPage ?? this.currentPage,
      hasMoreProducts: hasMoreProducts ?? this.hasMoreProducts,
    );
  }

  List<Document> get products =>
      data?.hits
          ?.map((hit) => Document.fromJson(hit.document!.toJson() ?? {}))
          .toList() ??
      [];

  List<Document> get bestSellerProducts =>
      products.where((product) => product.isbestSeller == true).toList();

  bool get isEmpty => products.isEmpty;
  bool get hasFilters =>
      selectedBrand != null || minPrice != null || maxPrice != null;
}
