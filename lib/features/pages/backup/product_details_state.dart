// //lib/features/products/state/product_details_state.dart
// import '../../core/api/base/state/base_state.dart';
// import '../../core/api/base/state/view_state.dart';
// import '../products/model/products_model.dart';
//
// class ProductDetailsState extends BaseState<ProductsModel> {
//   final int quantity;
//   final String selectedWeight;
//   final bool isProductInfoExpanded;
//   final bool isNutritionalFactsExpanded;
//   final bool isHealthBenefitsExpanded;
//
//   const ProductDetailsState({
//     super.status = const ViewInitial(),
//     super.data,
//     super.error,
//     this.quantity = 0,
//     this.selectedWeight = '500 g',
//     this.isProductInfoExpanded = false,
//     this.isNutritionalFactsExpanded = false,
//     this.isHealthBenefitsExpanded = false,
//   });
//
//   @override
//   ProductDetailsState copyWith({
//     ViewState<ProductsModel>? status,
//     ProductsModel? data,
//     String? error,
//     int? quantity,
//     String? selectedWeight,
//     bool? isProductInfoExpanded,
//     bool? isNutritionalFactsExpanded,
//     bool? isHealthBenefitsExpanded,
//   }) {
//     return ProductDetailsState(
//       status: status ?? this.status,
//       data: data ?? this.data,
//       error: error ?? this.error,
//       quantity: quantity ?? this.quantity,
//       selectedWeight: selectedWeight ?? this.selectedWeight,
//       isProductInfoExpanded:
//           isProductInfoExpanded ?? this.isProductInfoExpanded,
//       isNutritionalFactsExpanded:
//           isNutritionalFactsExpanded ?? this.isNutritionalFactsExpanded,
//       isHealthBenefitsExpanded:
//           isHealthBenefitsExpanded ?? this.isHealthBenefitsExpanded,
//     );
//   }
// }
