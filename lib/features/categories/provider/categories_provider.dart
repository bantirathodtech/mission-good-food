// categories_provider.dart
import 'package:flutter/material.dart';
import '../model/categories_model.dart';
import '../state/categories_state.dart';
import '../viewmodel/categories_viewmodel.dart';

class CategoriesProvider extends ChangeNotifier {
  final CategoriesViewModel _viewModel;
  CategoriesState _state = const CategoriesState();

  CategoriesProvider(this._viewModel);

  // Direct state access
  CategoriesState get state => _state;

  // State property getters
  List<String> get firstLevelCategories => _state.firstLevelCategories;
  List<SecondLevelCategory> get secondLevelCategories => _state.secondLevelCategories;
  List<ThirdLevelCategory> get thirdLevelCategories => _state.thirdLevelCategories;
  List<FourthLevelCategory> get fourthLevelCategories => _state.fourthLevelCategories;

  // Selection state methods
  bool isFirstLevelSelected(String category) => _state.isFirstLevelSelected(category);
  bool isSecondLevelSelected(String category) => _state.isSecondLevelSelected(category);
  bool isThirdLevelSelected(String category) => _state.isThirdLevelSelected(category);
  bool isFourthLevelSelected(String category) => _state.isFourthLevelSelected(category);

  // State indicators
  bool get isLoading => _state.isLoading;
  bool get hasError => _state.hasError;
  String? get error => _state.error;
  String get currentTheme => _state.currentTheme;

  // Selection states
  bool get hasFirstLevelSelection => _state.selectedFirstLevel != null;
  bool get hasSecondLevelSelection => _state.selectedSecondLevel != null;
  bool get hasThirdLevelSelection => _state.selectedThirdLevel != null;
  bool get hasFourthLevelSelection => _state.selectedFourthLevel != null;

  // Get selected IDs
  String? getSelectedSecondLevelId() => _state.getSecondLevelId(_state.selectedSecondLevel ?? '');
  String? getSelectedThirdLevelId() => _state.getThirdLevelId(_state.selectedThirdLevel ?? '');
  String? getSelectedFourthLevelId() => _state.getFourthLevelId(_state.selectedFourthLevel ?? '');

  // Category path for display
  String get currentCategoryPath {
    final List<String> path = [];
    if (_state.selectedFirstLevel != null) path.add(_state.selectedFirstLevel!);
    if (_state.selectedSecondLevel != null) path.add(_state.selectedSecondLevel!);
    if (_state.selectedThirdLevel != null) path.add(_state.selectedThirdLevel!);
    if (_state.selectedFourthLevel != null) path.add(_state.selectedFourthLevel!);
    return path.join(' > ');
  }

  // Load initial categories
  Future<void> loadCategories(String themeName) async {
    _updateState(_state.copyWith(isLoading: true));

    final result = await _viewModel.fetchCategories(themeName);

    result.when(
      success: (data) {
        final firstLevelCategories = _viewModel.getFirstLevelCategories(data);
        
        _updateState(_state.copyWith(
          data: data,
          firstLevelCategories: firstLevelCategories,
          error: null,
          isLoading: false,
        ));

        // Auto-select first category if available
        if (firstLevelCategories.isNotEmpty) {
          selectFirstLevel(firstLevelCategories.first);
        }
      },
      failure: (message, code) {
        _updateState(_state.copyWith(
          error: message,
          isLoading: false,
        ));
      },
      loading: () {
        _updateState(_state.copyWith(isLoading: true));
      },
    );
  }

  // Selection methods
  void selectFirstLevel(String category) {
    if (_state.selectedFirstLevel == category) return;
    
    final data = _state.data;
    if (data == null) return;

    final secondLevelCategories = _viewModel.getSecondLevelCategories(data, category);
    
    _updateState(_state.copyWith(
      selectedFirstLevel: category,
      selectedSecondLevel: null,
      selectedThirdLevel: null,
      selectedFourthLevel: null,
      secondLevelCategories: secondLevelCategories,
      thirdLevelCategories: [],
      fourthLevelCategories: [],
    ));
  }

  void selectSecondLevel(String category) {
    if (_state.selectedSecondLevel == category) return;
    
    final data = _state.data;
    if (data == null || _state.selectedFirstLevel == null) return;

    final thirdLevelCategories = _viewModel.getThirdLevelCategories(
      data,
      _state.selectedFirstLevel!,
      category,
    );
    
    _updateState(_state.copyWith(
      selectedSecondLevel: category,
      selectedThirdLevel: null,
      selectedFourthLevel: null,
      thirdLevelCategories: thirdLevelCategories,
      fourthLevelCategories: [],
    ));
  }

  void selectThirdLevel(String category) {
    if (_state.selectedThirdLevel == category) return;
    
    final data = _state.data;
    if (data == null || 
        _state.selectedFirstLevel == null || 
        _state.selectedSecondLevel == null) return;

    final fourthLevelCategories = _viewModel.getFourthLevelCategories(
      data,
      _state.selectedFirstLevel!,
      _state.selectedSecondLevel!,
      category,
    );
    
    _updateState(_state.copyWith(
      selectedThirdLevel: category,
      selectedFourthLevel: null,
      fourthLevelCategories: fourthLevelCategories,
    ));
  }

  void selectFourthLevel(String category) {
    if (_state.selectedFourthLevel == category) return;
    _updateState(_state.copyWith(
      selectedFourthLevel: category,
    ));
  }

  // Helper methods
  void clearSelections() {
    _updateState(_state.copyWith(
      selectedFirstLevel: null,
      selectedSecondLevel: null,
      selectedThirdLevel: null,
      selectedFourthLevel: null,
      secondLevelCategories: [],
      thirdLevelCategories: [],
      fourthLevelCategories: [],
    ));
  }

  void reset() {
    _state = const CategoriesState();
    notifyListeners();
  }

  void _updateState(CategoriesState newState) {
    _state = newState;
    notifyListeners();
  }
}

// // categories_provider.dart
// import 'package:flutter/material.dart';
//
// import '../model/categories_model.dart';
// import '../state/categories_state.dart';
// import '../viewmodel/categories_viewmodel.dart';
//
// class CategoriesProvider extends ChangeNotifier {
//   final CategoriesViewModel _viewModel;
//   CategoriesState _state = const CategoriesState();
//
//   CategoriesProvider(this._viewModel);
//
//   // Direct state access
//   CategoriesState get state => _state;
//
//   // State property getters
//   List<String> get firstLevelCategories => _state.firstLevelCategories;
//   List<SecondLevelCategory> get secondLevelCategories =>
//       _state.secondLevelCategories;
//   List<ThirdLevelCategory> get thirdLevelCategories =>
//       _state.thirdLevelCategories;
//   List<FourthLevelCategory> get fourthLevelCategories =>
//       _state.fourthLevelCategories;
//
//   // Selection state methods
//   bool isFirstLevelSelected(String category) =>
//       _state.isFirstLevelSelected(category);
//   bool isSecondLevelSelected(String category) =>
//       _state.isSecondLevelSelected(category);
//   bool isThirdLevelSelected(String category) =>
//       _state.isThirdLevelSelected(category);
//   bool isFourthLevelSelected(String category) =>
//       _state.isFourthLevelSelected(category);
//
//   // State indicators
//   bool get isLoading => _state.isLoading;
//   bool get hasError => _state.hasError;
//   String? get error => _state.error;
//   String get currentTheme => _state.currentTheme;
//
//   // Selection states
//   bool get hasFirstLevelSelection => _state.selectedFirstLevel != null;
//   bool get hasSecondLevelSelection => _state.selectedSecondLevel != null;
//   bool get hasThirdLevelSelection => _state.selectedThirdLevel != null;
//   bool get hasFourthLevelSelection => _state.selectedFourthLevel != null;
//
// // Category path for display
//   String get currentCategoryPath {
//     final List<String> path = [];
//     if (_state.selectedFirstLevel != null) path.add(_state.selectedFirstLevel!);
//     if (_state.selectedSecondLevel != null)
//       path.add(_state.selectedSecondLevel!);
//     if (_state.selectedThirdLevel != null) path.add(_state.selectedThirdLevel!);
//     if (_state.selectedFourthLevel != null)
//       path.add(_state.selectedFourthLevel!);
//     return path.join(' > ');
//   }
//
//   // Load initial categories
//   Future<void> loadCategories(String themeName) async {
//     _updateState(_state.copyWith(isLoading: true));
//
//     final result = await _viewModel.fetchCategories(themeName);
//
//     result.when(
//       success: (data) {
//         final firstLevelCategories = _viewModel.getFirstLevelCategories(data);
//
//         _updateState(_state.copyWith(
//           data: data,
//           firstLevelCategories: firstLevelCategories,
//           error: null,
//           isLoading: false,
//         ));
//
//         // Auto-select first category if available
//         if (firstLevelCategories.isNotEmpty) {
//           selectFirstLevel(firstLevelCategories.first);
//         }
//       },
//       failure: (message, code) {
//         _updateState(_state.copyWith(
//           error: message,
//           isLoading: false,
//         ));
//       },
//       loading: () {
//         _updateState(_state.copyWith(isLoading: true));
//       },
//     );
//   }
//
//   // Selection methods
//   void selectFirstLevel(String category) {
//     if (_state.selectedFirstLevel == category) return;
//
//     final data = _state.data;
//     if (data == null) return;
//
//     final secondLevelCategories =
//         _viewModel.getSecondLevelCategories(data, category);
//
//     _updateState(_state.copyWith(
//       selectedFirstLevel: category,
//       selectedSecondLevel: null,
//       selectedThirdLevel: null,
//       selectedFourthLevel: null,
//       secondLevelCategories: secondLevelCategories,
//     ));
//   }
//
//   void selectSecondLevel(String category) {
//     if (_state.selectedSecondLevel == category) return;
//
//     final data = _state.data;
//     if (data == null || _state.selectedFirstLevel == null) return;
//
//     final thirdLevelCategories = _viewModel.getThirdLevelCategories(
//       data,
//       _state.selectedFirstLevel!,
//       category,
//     );
//
//     _updateState(_state.copyWith(
//       selectedSecondLevel: category,
//       selectedThirdLevel: null,
//       selectedFourthLevel: null,
//       thirdLevelCategories: thirdLevelCategories,
//     ));
//   }
//
//   void selectThirdLevel(String category) {
//     if (_state.selectedThirdLevel == category) return;
//
//     final data = _state.data;
//     if (data == null ||
//         _state.selectedFirstLevel == null ||
//         _state.selectedSecondLevel == null) return;
//
//     final fourthLevelCategories = _viewModel.getFourthLevelCategories(
//       data,
//       _state.selectedFirstLevel!,
//       _state.selectedSecondLevel!,
//       category,
//     );
//
//     _updateState(_state.copyWith(
//       selectedThirdLevel: category,
//       selectedFourthLevel: null,
//       fourthLevelCategories: fourthLevelCategories,
//     ));
//   }
//
//   void selectFourthLevel(String category) {
//     if (_state.selectedFourthLevel == category) return;
//     _updateState(_state.copyWith(selectedFourthLevel: category));
//   }
//
//   // Helper methods
//   void clearSelections() {
//     _updateState(_state.copyWith(
//       selectedFirstLevel: null,
//       selectedSecondLevel: null,
//       selectedThirdLevel: null,
//       selectedFourthLevel: null,
//       secondLevelCategories: [],
//       thirdLevelCategories: [],
//       fourthLevelCategories: [],
//     ));
//   }
//
//   void reset() {
//     _state = const CategoriesState();
//     notifyListeners();
//   }
//
//   void _updateState(CategoriesState newState) {
//     _state = newState;
//     notifyListeners();
//   }
// }
