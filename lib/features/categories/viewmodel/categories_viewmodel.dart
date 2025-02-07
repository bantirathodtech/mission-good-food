// categories_viewmodel.dart
// categories_viewmodel.dart
import '../../../core/api/base/result/operation_result.dart';
import '../model/categories_model.dart';
import '../repository/categories_repository.dart';

/// CategoriesViewModel handles only business logic for the UI
class CategoriesViewModel {
  final CategoriesRepository _repository;

  CategoriesViewModel(this._repository);

  /// Business Logic Methods

  /// Get first level categories from data
  List<String> getFirstLevelCategories(CategoriesModel data) {
    return _repository.getFirstLevelCategories(data);
  }

  /// Get second level categories for selected first level
  List<SecondLevelCategory> getSecondLevelCategories(
      CategoriesModel data, String firstLevel) {
    return _repository.getSecondLevelCategories(data, firstLevel);
  }

  /// Get third level categories for selected levels
  List<ThirdLevelCategory> getThirdLevelCategories(
    CategoriesModel data,
    String firstLevel,
    String secondLevel,
  ) {
    return _repository.getThirdLevelCategories(data, firstLevel, secondLevel);
  }

  /// Get fourth level categories for selected levels
  List<FourthLevelCategory> getFourthLevelCategories(
    CategoriesModel data,
    String firstLevel,
    String secondLevel,
    String thirdLevel,
  ) {
    return _repository.getFourthLevelCategories(
      data,
      firstLevel,
      secondLevel,
      thirdLevel,
    );
  }

  /// Fetch categories data from repository
  Future<OperationResult<CategoriesModel>> fetchCategories(String themeName) {
    return _repository.getCategories(themeName);
  }

  /// Get category IDs
  String? getSecondLevelCategoryId(CategoriesModel data, String categoryName) {
    return _repository.getSecondLevelCategoryId(data, categoryName);
  }

  String? getThirdLevelCategoryId(
    CategoriesModel data,
    String firstLevel,
    String secondLevel,
    String thirdLevel,
  ) {
    return _repository.getThirdLevelCategoryId(
      data,
      firstLevel,
      secondLevel,
      thirdLevel,
    );
  }

  String? getFourthLevelCategoryId(
    CategoriesModel data,
    String firstLevel,
    String secondLevel,
    String thirdLevel,
    String fourthLevel,
  ) {
    return _repository.getFourthLevelCategoryId(
      data,
      firstLevel,
      secondLevel,
      thirdLevel,
      fourthLevel,
    );
  }
}

// // categories_viewmodel.dart
// // Purpose: Handles UI business logic and state management coordination
//
// import '../../../core/api/base/viewmodel/base_view_model.dart';
// import '../model/categories_model.dart';
// import '../provider/categories_provider.dart';
//
// class CategoriesViewModel extends BaseViewModel<CategoriesModel> {
//   final CategoriesProvider _provider;
//
//   CategoriesViewModel(super.repository, this._provider);
//
//   // Initialize categories for a theme
//   Future<void> initializeCategories(String themeName) async {
//     await _provider.loadCategories(themeName);
//   }
//
//   // Category selection methods
//   void selectParentCategory(String category) {
//     _provider.selectParentCategory(category);
//   }
//
//   void selectChildCategory(String category) {
//     _provider.selectChildCategory(category);
//   }
//
//   void selectSubChildCategory(String category) {
//     _provider.selectSubChildCategory(category);
//   }
//
//   // Get selected category IDs for filtering
//   String? getSelectedChildCategoryId() {
//     return _provider.getSelectedChildCategoryId();
//   }
//
//   String? getSelectedSubChildCategoryId() {
//     return _provider.getSelectedSubChildCategoryId();
//   }
//
//   // Clear selections
//   void clearCategorySelections() {
//     _provider.clearSelections();
//   }
//
//   // Reset everything
//   void reset() {
//     _provider.reset();
//   }
//
//   // Status checks
//   bool isParentCategorySelected(String category) {
//     return _provider.isParentCategorySelected(category);
//   }
//
//   bool isChildCategorySelected(String category) {
//     return _provider.isChildCategorySelected(category);
//   }
//
//   bool isSubChildCategorySelected(String category) {
//     return _provider.isSubChildCategorySelected(category);
//   }
//
//   // Access categories
//   List<String> get parentCategories => _provider.parentCategories;
//   List<CategoryChild> get childCategories => _provider.childCategories;
//   List<SubChild> get subChildCategories => _provider.subChildCategories;
//
//   // Status
//   bool get isLoading => _provider.isLoading;
//   bool get hasError => _provider.hasError;
//   String? get error => _provider.error;
//   bool get hasSelectedCategory => _provider.hasSelectedCategory;
// }
