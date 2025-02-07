// // 3. Let's add a test file
// // test/features/categories/test/categories_provider_test.dart
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
//
// import '../provider/categories_provider.dart';
//
// class MockCategoriesViewModel extends Mock implements CategoriesViewModel {}
//
// void main() {
//   late CategoriesProvider provider;
//   late MockCategoriesViewModel mockViewModel;
//
//   setUp(() {
//     mockViewModel = MockCategoriesViewModel();
//     provider = CategoriesProvider(mockViewModel);
//   });
//
//   group('CategoriesProvider', () {
//     test('loadCategories calls viewModel.loadCategories', () async {
//       // Arrange
//       const themeName = 'test_theme';
//       when(mockViewModel.loadCategories(any)).thenAnswer((_) async {});
//
//       // Act
//       await provider.loadCategories(themeName);
//
//       // Assert
//       verify(mockViewModel.loadCategories(themeName)).called(1);
//     });
//
//     // Add more tests...
//   });
// }
