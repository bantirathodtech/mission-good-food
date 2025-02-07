// categories_state.dart
import 'package:flutter/foundation.dart';
import '../model/categories_model.dart';

@immutable
class CategoriesState {
  // Core data
  final CategoriesModel? data;
  
  // Selected categories
  final String? selectedFirstLevel;
  final String? selectedSecondLevel;
  final String? selectedThirdLevel;
  final String? selectedFourthLevel;
  
  // Category lists for each level
  final List<String> firstLevelCategories;
  final List<SecondLevelCategory> secondLevelCategories;
  final List<ThirdLevelCategory> thirdLevelCategories;
  final List<FourthLevelCategory> fourthLevelCategories;
  
  // State indicators
  final bool isLoading;
  final String? error;
  final String currentTheme;

  const CategoriesState({
    this.data,
    this.selectedFirstLevel,
    this.selectedSecondLevel,
    this.selectedThirdLevel,
    this.selectedFourthLevel,
    this.firstLevelCategories = const [],
    this.secondLevelCategories = const [],
    this.thirdLevelCategories = const [],
    this.fourthLevelCategories = const [],
    this.isLoading = false,
    this.error,
    this.currentTheme = 'GROC',
  });

  CategoriesState copyWith({
    CategoriesModel? data,
    String? selectedFirstLevel,
    String? selectedSecondLevel,
    String? selectedThirdLevel,
    String? selectedFourthLevel,
    List<String>? firstLevelCategories,
    List<SecondLevelCategory>? secondLevelCategories,
    List<ThirdLevelCategory>? thirdLevelCategories,
    List<FourthLevelCategory>? fourthLevelCategories,
    bool? isLoading,
    String? error,
    String? currentTheme,
  }) {
    return CategoriesState(
      data: data ?? this.data,
      selectedFirstLevel: selectedFirstLevel ?? this.selectedFirstLevel,
      selectedSecondLevel: selectedSecondLevel ?? this.selectedSecondLevel,
      selectedThirdLevel: selectedThirdLevel ?? this.selectedThirdLevel,
      selectedFourthLevel: selectedFourthLevel ?? this.selectedFourthLevel,
      firstLevelCategories: firstLevelCategories ?? this.firstLevelCategories,
      secondLevelCategories: secondLevelCategories ?? this.secondLevelCategories,
      thirdLevelCategories: thirdLevelCategories ?? this.thirdLevelCategories,
      fourthLevelCategories: fourthLevelCategories ?? this.fourthLevelCategories,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentTheme: currentTheme ?? this.currentTheme,
    );
  }

  // Selection state checks
  bool isFirstLevelSelected(String category) => selectedFirstLevel == category;
  bool isSecondLevelSelected(String category) => selectedSecondLevel == category;
  bool isThirdLevelSelected(String category) => selectedThirdLevel == category;
  bool isFourthLevelSelected(String category) => selectedFourthLevel == category;

  // Get category IDs
  String? getSecondLevelId(String categoryName) {
    return secondLevelCategories
        .firstWhere(
          (category) => category.name == categoryName,
          orElse: () => SecondLevelCategory(),
        )
        .categoryId;
  }

  String? getThirdLevelId(String categoryName) {
    return thirdLevelCategories
        .firstWhere(
          (category) => category.categoryName == categoryName,
          orElse: () => ThirdLevelCategory(),
        )
        .categoryId;
  }

  String? getFourthLevelId(String categoryName) {
    return fourthLevelCategories
        .firstWhere(
          (category) => category.categoryName == categoryName,
          orElse: () => FourthLevelCategory(),
        )
        .categoryId;
  }

  // State checks
  bool get hasError => error != null;
  bool get hasData => data != null;
  bool get hasSelectedCategory => selectedFirstLevel != null;
}

// // categories_state.dart
// // Purpose: Manages the state and provides computed properties
//
// import 'package:flutter/cupertino.dart';
//
// import '../../../core/api/base/state/view_state.dart';
// import '../model/categories_model.dart';
// // categories_state.dart
// // Purpose: Manages state and computed properties for all category levels
//
// @immutable
// class CategoriesState {
//   final ViewState<CategoriesModel> status;
//   final CategoriesModel? data;
//   final String? selectedParentCategory;
//   final String? selectedChildCategory;
//   final String? selectedSubChildCategory;
//   final String? error;
//
//   const CategoriesState({
//     this.status = const ViewInitial(),
//     this.data,
//     this.selectedParentCategory,
//     this.selectedChildCategory,
//     this.selectedSubChildCategory,
//     this.error,
//   });
//
//   CategoriesState copyWith({
//     ViewState<CategoriesModel>? status,
//     CategoriesModel? data,
//     String? selectedParentCategory,
//     String? selectedChildCategory,
//     String? selectedSubChildCategory,
//     String? error,
//   }) {
//     return CategoriesState(
//       status: status ?? this.status,
//       data: data ?? this.data,
//       selectedParentCategory:
//           selectedParentCategory ?? this.selectedParentCategory,
//       selectedChildCategory:
//           selectedChildCategory ?? this.selectedChildCategory,
//       selectedSubChildCategory:
//           selectedSubChildCategory ?? this.selectedSubChildCategory,
//       error: error ?? this.error,
//     );
//   }
//
//   // Get list of parent categories
//   List<String> get parentCategories {
//     return data?.hits
//             ?.map((hit) => hit.document?.parentCategoryIdentifier ?? '')
//             .where((category) => category.isNotEmpty)
//             .toList() ??
//         [];
//   }
//
//   // Get child categories for selected parent
//   List<CategoryChild> get childrenForSelectedParent {
//     if (selectedParentCategory == null) return [];
//
//     final categoryHit = data?.hits?.firstWhere(
//       (hit) => hit.document?.parentCategoryIdentifier == selectedParentCategory,
//       orElse: () => CategoryHit(),
//     );
//
//     return categoryHit?.document?.children ?? [];
//   }
//
//   // Get subchild categories for selected child
//   List<SubChild> get subChildrenForSelectedChild {
//     if (selectedChildCategory == null) return [];
//
//     final child = childrenForSelectedParent.firstWhere(
//       (child) => child.name == selectedChildCategory,
//       orElse: () => CategoryChild(),
//     );
//
//     return child.subChildren ?? [];
//   }
//
//   // Get category IDs
//   String? getChildCategoryId(String childName) {
//     for (final hit in data?.hits ?? []) {
//       for (final child in hit.document?.children ?? []) {
//         if (child.name == childName) {
//           return child.categoryId;
//         }
//       }
//     }
//     return null;
//   }
//
//   String? getSubChildCategoryId(String subChildName) {
//     if (selectedChildCategory == null) return null;
//
//     final subChildren = subChildrenForSelectedChild;
//     final subChild = subChildren.firstWhere(
//       (subChild) => subChild.subCategoryName == subChildName,
//       orElse: () => SubChild(),
//     );
//     return subChild.subCategoryId;
//   }
//
//   // State checks
//   bool get isLoading => status is ViewLoading;
//   bool get hasError => error != null;
//   bool get hasData => data != null;
// }
