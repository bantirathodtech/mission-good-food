// import 'package:flutter/material.dart';
//
// import '../../../core/theme/text_styles/global_text_style.dart';
// import '../model/cart_model.dart';
//
// // lib/features/cart/widgets/product_details.dart
// class ProductDetails extends StatelessWidget {
//   final CartItem item;
//
//   const ProductDetails({Key? key, required this.item}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           item.product?.name ?? '',
//           style: GlobalTextStyles.qs16w7Black,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         const SizedBox(height: 4),
//         Row(
//           children: [
//             Text(
//               '₹${item.unitPrice}',
//               style: GlobalTextStyles.small7Black,
//             ),
//             if (item.product?.salePrice != null) ...[
//               const SizedBox(width: 4),
//               Text(
//                 '(${item.product!.salePrice}g)',
//                 style: GlobalTextStyles.tiny4Black,
//               ),
//             ],
//           ],
//         ),
//       ],
//     );
//   }
// }
