// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:good_food_app/core/theme/text_styles/global_text_style.dart';
// import 'package:hexcolor/hexcolor.dart';
//
// import '../../products/model/products_model.dart';
// import '../main_screen.dart';
//
// class ProductCardMore extends StatefulWidget {
//   final ProductsModel product;
//
//   const ProductCardMore({super.key, required this.product});
//
//   @override
//   State<ProductCardMore> createState() => _ProductCardState();
// }
//
// class _ProductCardState extends State<ProductCardMore> {
//   int quantity = 0;
//
//   void toggleFavorite() {
//     setState(() {
//       widget.product.isFavorite = !widget.product.isFavorite;
//     });
//   }
//
//   void incrementQuantity() {
//     setState(() {
//       quantity++;
//     });
//   }
//
//   void decrementQuantity() {
//     if (quantity > 0) {
//       setState(() {
//         quantity--;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12), // Added border radius
//         boxShadow: [
//           BoxShadow(
//             color: Color.fromRGBO(
//                 228, 242, 228, 0.6), // Lighter green shadow color
//             blurRadius: 15, // Controls the softness of the shadow
//             spreadRadius: 1, // Controls the spread of the shadow
//             offset: Offset(0, 8), // Moves the shadow downward
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Product Image with Favorite Button
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.asset(
//                   widget.product.productImage,
//                   width: 114,
//                   height: 114,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 right: 8,
//                 top: 8,
//                 child: GestureDetector(
//                   onTap: toggleFavorite,
//                   child: Container(
//                     width: 21,
//                     height: 21,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                     child: Icon(
//                       widget.product.isFavorite
//                           ? Icons.favorite
//                           : Icons.favorite_border,
//                       color: const Color(0xFFEFA4C8),
//                       size: 14,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 16),
//           // Product Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.product.productName,
//                   style: GlobalTextStyles.qs16w7Black,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Text('₹${widget.product.productPrice}',
//                         style: GlobalTextStyles.small7Black),
//                     const SizedBox(width: 4),
//                     Text('(${widget.product.productQty} kg)',
//                         style: GlobalTextStyles.tiny4Black),
//                     const SizedBox(width: 4),
//                     Container(
//                       width: 1,
//                       height: 16,
//                       color: Color.fromRGBO(240, 242, 245, 1),
//                     ),
//                     const SizedBox(width: 8),
//                     Row(
//                       children: [
//                         SvgPicture.asset(
//                           'assets/icons/star.svg',
//                           color: Colors.amber,
//                           height: 11.54,
//                           width: 12.08,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           '${widget.product.rate}',
//                           style: GlobalTextStyles.tiny4Black,
//                         ),
//                         Text(
//                           ' (${widget.product.totalRating})',
//                           style: GlobalTextStyles.tiny4Black,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     quantity == 0
//                         ? SizedBox(
//                             height: 24,
//                             width: 72,
//                             child: ElevatedButton.icon(
//                               onPressed: () {
//                                 setState(() {
//                                   quantity = 1;
//                                 });
//                               },
//                               label: const Text(
//                                 '+ Add',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 // minimumSize: const Size(0, 16),
//                                 // maximumSize: const Size(72, 23),
//                                 // fixedSize: const Size(72, 16),
//                                 backgroundColor:
//                                     const Color.fromRGBO(239, 164, 200, 1),
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(24),
//                                 ),
//                               ),
//                             ),
//                           )
//                         : Row(
//                             children: [
//                               Container(
//                                 width: 20,
//                                 height: 20,
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Color.fromRGBO(224, 241, 231, 1),
//                                 ),
//                                 child: Center(
//                                   child: GestureDetector(
//                                     onTap: decrementQuantity,
//                                     child: const Icon(
//                                       Icons.remove,
//                                       color: Color.fromRGBO(79, 165, 111, 1),
//                                       size: 16,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 '$quantity',
//                                 style: GlobalTextStyles.small5Black.copyWith(
//                                     color: Color.fromRGBO(138, 141, 159, 1)),
//                               ),
//                               const SizedBox(width: 8),
//                               Container(
//                                 width: 20,
//                                 height: 20,
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Color.fromRGBO(79, 165, 111, 1),
//                                 ),
//                                 child: Center(
//                                   child: GestureDetector(
//                                     onTap: incrementQuantity,
//                                     child: const Icon(
//                                       Icons.add,
//                                       color: Color.fromRGBO(255, 255, 255, 1),
//                                       size: 16,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                     const SizedBox(width: 16),
//                     IconButton(
//                       icon: SvgPicture.asset(
//                         'assets/icons/ic_delete.svg',
//                         height: 20,
//                         width: 20,
//                       ),
//                       onPressed: () {
//                         print('Delete product');
//                         _showPasswordResetPopup(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showPasswordResetPopup(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           backgroundColor: HexColor("#F0F0F0"),
//           child: SizedBox(
//             width: 315,
//             height: 201,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
//                   child: Column(
//                     children: [
//                       const Center(
//                         child: Text(
//                           'Are you sure',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                             color: Color.fromRGBO(38, 43, 46, 1),
//                           ),
//                         ),
//                       ),
//                       const Center(
//                         child: Text(
//                           'you want to Unfavorite ?',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                             color: Color.fromRGBO(38, 43, 46, 1),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.of(context).pushReplacement(
//                                 MaterialPageRoute(
//                                   builder: (context) => MainScreen(),
//                                 ),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color.fromRGBO(239, 164, 200, 1),
//                               foregroundColor: Colors.white,
//                               minimumSize: const Size(130, 40),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text(
//                               'Cancel',
//                               style: GlobalTextStyles.roboto16w7White,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 16,
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.of(context).pushReplacement(
//                                 MaterialPageRoute(
//                                   builder: (context) => MainScreen(),
//                                 ),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color.fromRGBO(79, 165, 111, 1),
//                               foregroundColor: Colors.white,
//                               minimumSize: const Size(130, 40),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text(
//                               'Sure',
//                               style: GlobalTextStyles.roboto16w7White,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
