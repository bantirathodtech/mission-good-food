// categories_repository.dart
// Purpose: Acts as a middleman between service and provider, handles business logic

import '../../../core/api/base/repository/base_repository.dart';
import '../../../core/api/base/result/operation_result.dart';
import '../model/categories_model.dart';
import '../service/categories_service.dart';

class CategoriesRepository extends BaseRepository<CategoriesModel> {
  static const String TAG = '[CategoriesRepository]';
  final CategoriesService categoriesService;

  CategoriesRepository(this.categoriesService);

  @override
  Future<OperationResult<CategoriesModel>> execute<R>(String path,
      {Map<String, dynamic>? params,
      CategoriesModel? data,
      String method = 'GET',
      R Function(Map<String, dynamic>)? fromJson}) {
    return categoriesService.execute(path,
        params: params, data: data, method: method, fromJson: fromJson);
  }

  // Fetch categories from service
  Future<OperationResult<CategoriesModel>> getCategories(
      String themeName) async {
    return await categoriesService.getCategories(themeName);
  }

  // First Level Operations
  List<String> getFirstLevelCategories(CategoriesModel model) {
    return model.hits
            ?.map((hit) => hit.document?.parentCategoryName ?? '')
            .where((category) => category.isNotEmpty)
            .toList() ??
        [];
  }

  // Second Level Operations
  List<SecondLevelCategory> getSecondLevelCategories(
      CategoriesModel model, String firstLevel) {
    final categoryHit = model.hits?.firstWhere(
      (hit) => hit.document?.parentCategoryName == firstLevel,
      orElse: () => CategoryHit(),
    );
    return categoryHit?.document?.children ?? [];
  }

  // Third Level Operations
  List<ThirdLevelCategory> getThirdLevelCategories(
      CategoriesModel model, String firstLevel, String secondLevel) {
    final secondLevelCategories = getSecondLevelCategories(model, firstLevel);
    final category = secondLevelCategories.firstWhere(
      (category) => category.name == secondLevel,
      orElse: () => SecondLevelCategory(),
    );
    return category.subChildren ?? [];
  }

// Fourth Level Operations
  List<FourthLevelCategory> getFourthLevelCategories(CategoriesModel model,
      String firstLevel, String secondLevel, String thirdLevel) {
    final thirdLevelCategories =
        getThirdLevelCategories(model, firstLevel, secondLevel);
    final category = thirdLevelCategories.firstWhere(
      (category) => category.categoryName == thirdLevel,
      orElse: () => ThirdLevelCategory(),
    );
    return category.children ?? [];
  }

  // Get Category IDs
  String? getSecondLevelCategoryId(CategoriesModel model, String categoryName) {
    for (final hit in model.hits ?? []) {
      for (final category in hit.document?.children ?? []) {
        if (category.name == categoryName) {
          return category.categoryId;
        }
      }
    }
    return null;
  }

  String? getThirdLevelCategoryId(CategoriesModel model, String firstLevel,
      String secondLevel, String thirdLevel) {
    final thirdLevelCategories =
        getThirdLevelCategories(model, firstLevel, secondLevel);
    final category = thirdLevelCategories.firstWhere(
      (category) => category.categoryName == thirdLevel,
      orElse: () => ThirdLevelCategory(),
    );
    return category.categoryId;
  }

  String? getFourthLevelCategoryId(CategoriesModel model, String firstLevel,
      String secondLevel, String thirdLevel, String fourthLevel) {
    final fourthLevelCategories =
        getFourthLevelCategories(model, firstLevel, secondLevel, thirdLevel);
    final category = fourthLevelCategories.firstWhere(
      (category) => category.categoryName == fourthLevel,
      orElse: () => FourthLevelCategory(),
    );
    return category.categoryId;
  }
}
