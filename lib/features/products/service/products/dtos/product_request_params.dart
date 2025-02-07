class ProductRequestParams {
  // Constants for default values
  static const DEFAULT_LIMIT = "240";
  static const DEFAULT_THEME = "GROC";
  static const DEFAULT_SORT = "asc";

  final String themeName;
  final String salePrice;
  final String? limit; // Changed from perPage
  final String? offset;
  final String? salePriceMin;
  final String? salePriceMax;
  final String? brand;
  final String? productCategoryName;

  ProductRequestParams({
    String? themeName,
    String? salePrice,
    this.limit,
    this.offset,
    this.salePriceMin,
    this.salePriceMax,
    this.brand,
    this.productCategoryName,
  })  : themeName = themeName ?? DEFAULT_THEME,
        salePrice = salePrice ?? DEFAULT_SORT;

  Map<String, dynamic> toJson() {
    final params = {
      'themeName': themeName,
      'salePrice': salePrice,
      if (limit != null) 'limit': limit, // Changed from per_page
      if (offset != null) 'offset': offset,
      if (salePriceMin != null) 'salePriceMin': salePriceMin,
      if (salePriceMax != null) 'salePriceMax': salePriceMax,
      if (brand != null) 'brand': Uri.encodeComponent(brand!),
      if (productCategoryName != null)
        'productCategoryName': productCategoryName,
    };
    return params;
  }

  void validate() {
    if (themeName.isEmpty) throw Exception('themeName is required');
    if (salePrice.isEmpty) throw Exception('salePrice is required');
  }

  factory ProductRequestParams.fromMap(Map? params) {
    // final perPageValue = params?['per_page'];
    return ProductRequestParams(
      themeName: params?['themeName'] ?? 'GROC',
      salePrice: params?['salePrice'] ?? 'asc',
      limit: params?['limit']?.toString(),
      offset: params?['offset']?.toString(),
      salePriceMin: params?['salePriceMin']?.toString(),
      salePriceMax: params?['salePriceMax']?.toString(),
      brand: params?['brand']?.toString(),
      productCategoryName: params?['productCategoryName']?.toString(),
    );
  }
}

// import 'package:good_food_app/features/products/service/products/dtos/theme_names.dart';
//
// class ProductRequestParams {
//   final AppTheme theme;
//   final String salePrice;
//   final String? perPage;
//   final String? salePriceMin;
//   final String? salePriceMax;
//   final String? brand;
//   final String? productCategoryName;
//
//   ProductRequestParams({
//     AppTheme? theme,
//     String? salePrice,
//     this.perPage,
//     this.salePriceMin,
//     this.salePriceMax,
//     this.brand,
//     this.productCategoryName,
//   })  : theme = theme ?? AppTheme.GROC,
//         salePrice = salePrice ?? 'asc';
//
//   Map<String, dynamic> toJson() {
//     final params = {
//       'themeName': theme.name,
//       'salePrice': salePrice,
//       if (perPage != null) 'per_page': perPage,
//       if (salePriceMin != null) 'salePriceMin': salePriceMin,
//       if (salePriceMax != null) 'salePriceMax': salePriceMax,
//       if (brand != null) 'brand': Uri.encodeComponent(brand!),
//       if (productCategoryName != null)
//         'productCategoryName': productCategoryName,
//     };
//     return params;
//   }
//
//   void validate() {
//     if (salePrice.isEmpty) throw Exception('salePrice is required');
//   }
//
//   factory ProductRequestParams.fromMap(Map? params) {
//     AppTheme theme;
//     try {
//       theme = AppTheme.values.firstWhere(
//         (e) => e.name == (params?['themeName'] ?? 'GROC'),
//         orElse: () => AppTheme.GROC,
//       );
//     } catch (_) {
//       theme = AppTheme.GROC;
//     }
//
//     return ProductRequestParams(
//       theme: theme,
//       salePrice: params?['salePrice'],
//       perPage: params?['per_page']?.toString(),
//       salePriceMin: params?['salePriceMin']?.toString(),
//       salePriceMax: params?['salePriceMax']?.toString(),
//       brand: params?['brand']?.toString(),
//       productCategoryName: params?['productCategoryName']?.toString(),
//     );
//   }
// }
