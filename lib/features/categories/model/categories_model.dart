// categories_model.dart
import '../../products/model/request_params.dart';

class CategoriesModel {
  final List<dynamic> facetCounts;
  final int? found;
  final List<CategoryHit>? hits;
  final int? outOf;
  final int? page;
  final RequestParams? requestParams;
  final bool? searchCutoff;
  final int? searchTimeMs;

  CategoriesModel({
    this.facetCounts = const [],
    this.found,
    this.hits,
    this.outOf,
    this.page,
    this.requestParams,
    this.searchCutoff,
    this.searchTimeMs,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      facetCounts: json['facet_counts'] ?? [],
      found: json['found'],
      hits: json['hits'] != null
          ? List<CategoryHit>.from(json['hits'].map((x) => CategoryHit.fromJson(x)))
          : null,
      outOf: json['out_of'],
      page: json['page'],
      requestParams: json['request_params'] != null
          ? RequestParams.fromJson(json['request_params'])
          : null,
      searchCutoff: json['search_cutoff'],
      searchTimeMs: json['search_time_ms'],
    );
  }
}

// First Level Categories (Parent)
class CategoryHit {
  final FirstLevelCategory? document;
  final Map<String, dynamic> highlight;
  final List<dynamic> highlights;

  CategoryHit({
    this.document,
    this.highlight = const {},
    this.highlights = const [],
  });

  factory CategoryHit.fromJson(Map<String, dynamic> json) {
    return CategoryHit(
      document: json['document'] != null
          ? FirstLevelCategory.fromJson(json['document'])
          : null,
      highlight: json['highlight'] ?? {},
      highlights: json['highlights'] ?? [],
    );
  }
}

// First Level (Parent) Category
class FirstLevelCategory {
  final List<SecondLevelCategory>? children;
  final String? id;
  final String? imageUrl;
  final String? parentCategory;
  final String? parentCategoryName;

  FirstLevelCategory({
    this.children,
    this.id,
    this.imageUrl,
    this.parentCategory,
    this.parentCategoryName,
  });

  factory FirstLevelCategory.fromJson(Map<String, dynamic> json) {
    return FirstLevelCategory(
      children: json['children'] != null
          ? List<SecondLevelCategory>.from(
              json['children'].map((x) => SecondLevelCategory.fromJson(x)))
          : null,
      id: json['id'],
      imageUrl: json['imageurl'],
      parentCategory: json['parentcategory'],
      parentCategoryName: json['parentcategory_iden'],
    );
  }
}

// Second Level Category
class SecondLevelCategory {
  final String? imageUrl;
  final String? categoryId;
  final String? name;
  final List<ThirdLevelCategory>? subChildren;

  SecondLevelCategory({
    this.imageUrl,
    this.categoryId,
    this.name,
    this.subChildren,
  });

  factory SecondLevelCategory.fromJson(Map<String, dynamic> json) {
    return SecondLevelCategory(
      imageUrl: json['imageurl'],
      categoryId: json['m_product_category_id'],
      name: json['name'],
      subChildren: json['sub_children'] != null
          ? List<ThirdLevelCategory>.from(
              json['sub_children'].map((x) => ThirdLevelCategory.fromJson(x)))
          : null,
    );
  }
}

// Third Level Category
class ThirdLevelCategory {
  final String? imageUrl;
  final String? categoryId;
  final String? categoryName;
  final List<FourthLevelCategory>? children;

  ThirdLevelCategory({
    this.imageUrl,
    this.categoryId,
    this.categoryName,
    this.children,
  });

  factory ThirdLevelCategory.fromJson(Map<String, dynamic> json) {
    return ThirdLevelCategory(
      imageUrl: json['sub_imageurl'],
      categoryId: json['sub_pcategory'],
      categoryName: json['sub_pcategory_name'],
      children: null, // Add fourth level if needed
    );
  }
}

// Fourth Level Category
class FourthLevelCategory {
  final String? imageUrl;
  final String? categoryId;
  final String? categoryName;

  FourthLevelCategory({
    this.imageUrl,
    this.categoryId,
    this.categoryName,
  });

  factory FourthLevelCategory.fromJson(Map<String, dynamic> json) {
    return FourthLevelCategory(
      imageUrl: json['imageurl'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
    );
  }
}

// // categories_model.dart
// // Purpose: Defines data structures for categories and handles JSON serialization
//
// import '../../products/model/request_params.dart';
//
// class CategoriesModel {
//   final List<dynamic> facetCounts;
//   final int? found;
//   final List<CategoryHit>? hits;
//   final int? outOf;
//   final int? page;
//   final RequestParams? requestParams;
//   final bool? searchCutoff;
//   final int? searchTimeMs;
//
//   CategoriesModel({
//     this.facetCounts = const [],
//     this.found,
//     this.hits,
//     this.outOf,
//     this.page,
//     this.requestParams,
//     this.searchCutoff,
//     this.searchTimeMs,
//   });
//
//   // Factory constructor for JSON deserialization
//   factory CategoriesModel.fromJson(Map<String, dynamic> json) {
//     return CategoriesModel(
//       facetCounts: json['facet_counts'] ?? [],
//       found: json['found'],
//       hits: json['hits'] != null
//           ? List<CategoryHit>.from(
//               json['hits'].map((x) => CategoryHit.fromJson(x)))
//           : null,
//       outOf: json['out_of'],
//       page: json['page'],
//       requestParams: json['request_params'] != null
//           ? RequestParams.fromJson(json['request_params'])
//           : null,
//       searchCutoff: json['search_cutoff'],
//       searchTimeMs: json['search_time_ms'],
//     );
//   }
// }
//
// class CategoryHit {
//   final CategoryDocument? document;
//   final Map<String, dynamic> highlight;
//   final List<dynamic> highlights;
//
//   CategoryHit({
//     this.document,
//     this.highlight = const {},
//     this.highlights = const [],
//   });
//
//   factory CategoryHit.fromJson(Map<String, dynamic> json) {
//     return CategoryHit(
//       document: json['document'] != null
//           ? CategoryDocument.fromJson(json['document'])
//           : null,
//       highlight: json['highlight'] ?? {},
//       highlights: json['highlights'] ?? [],
//     );
//   }
// }
//
// class CategoryDocument {
//   final List<CategoryChild>? children;
//   final String? id;
//   final String? imageUrl;
//   final String? parentCategory;
//   final String? parentCategoryIdentifier;
//
//   CategoryDocument({
//     this.children,
//     this.id,
//     this.imageUrl,
//     this.parentCategory,
//     this.parentCategoryIdentifier,
//   });
//
//   factory CategoryDocument.fromJson(Map<String, dynamic> json) {
//     return CategoryDocument(
//       children: json['children'] != null
//           ? List<CategoryChild>.from(
//               json['children'].map((x) => CategoryChild.fromJson(x)))
//           : null,
//       id: json['id'],
//       imageUrl: json['imageurl'],
//       parentCategory: json['parentcategory'],
//       parentCategoryIdentifier: json['parentcategory_iden'],
//     );
//   }
// }
//
// class CategoryChild {
//   final String? imageUrl;
//   final String? categoryId;
//   final String? name;
//   final List<SubChild>? subChildren;
//
//   CategoryChild({
//     this.imageUrl,
//     this.categoryId,
//     this.name,
//     this.subChildren,
//   });
//
//   factory CategoryChild.fromJson(Map<String, dynamic> json) {
//     return CategoryChild(
//       imageUrl: json['imageurl'],
//       categoryId: json['m_product_category_id'],
//       name: json['name'],
//       subChildren: json['sub_children'] != null
//           ? List<SubChild>.from(
//               json['sub_children'].map((x) => SubChild.fromJson(x)))
//           : null,
//     );
//   }
// }
//
// class SubChild {
//   final String? subImageUrl;
//   final String? subCategoryId;
//   final String? subCategoryName;
//
//   SubChild({
//     this.subImageUrl,
//     this.subCategoryId,
//     this.subCategoryName,
//   });
//
//   factory SubChild.fromJson(Map<String, dynamic> json) {
//     return SubChild(
//       subImageUrl: json['sub_imageurl'],
//       subCategoryId: json['sub_pcategory'],
//       subCategoryName: json['sub_pcategory_name'],
//     );
//   }
// }
