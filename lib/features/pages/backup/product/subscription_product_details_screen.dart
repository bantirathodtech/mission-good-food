// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:good_food_app/core/widgets/button/elevatedButton.dart';
// import 'package:good_food_app/features/main/tabs/home/category_first_level_widgets.dart';
// import 'package:good_food_app/features/main/tabs/home/model/product_model.dart';
// import 'package:good_food_app/features/pages/subscriptions/new/add_subscription_screen.dart';
//
// import '../../core/theme/text_styles/global_text_style.dart';
// import '../main/tabs/home/home_screen.dart';
// import '../products/card/product_card.dart';
// import '../products/model/products_model.dart';
//
// class SubscriptionProductDetailsScreen extends StatefulWidget {
//   final ProductsModel productsModel;
//   const SubscriptionProductDetailsScreen(
//       {super.key, required this.productsModel});
//
//   @override
//   State<SubscriptionProductDetailsScreen> createState() =>
//       _SubscriptionProductDetailsScreenState();
// }
//
// class _SubscriptionProductDetailsScreenState
//     extends State<SubscriptionProductDetailsScreen> {
//   int quantity = 0;
//   String selectedWeight = "500g";
//
//   void toggleFavorite() {
//     setState(() {
//       widget.productsModel.isFavorite = !widget.productsModel.isFavorite;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//         title: SvgPicture.asset(
//           'assets/images.logo.svg',
//           height: 40,
//           width: 100,
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CategoryWidgets(),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Product Image Section
//                 Stack(
//                   children: [
//                     // Background container with rounded corners
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(0),
//                       child: Container(
//                         height: 300,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                         ),
//                         child: Image.asset(
//                           'assets/images/product_1.png',
//                           height: 300,
//                           width:
//                               double.infinity, // Ensures it fills the container
//                           fit: BoxFit
//                               .cover, // Covers the area while maintaining aspect ratio
//                         ),
//                       ),
//                     ),
//                     // Favorite icon positioned at the top-right
//                     Positioned(
//                       right: 16, // Positioned slightly away from edges
//                       top: 16,
//                       child: GestureDetector(
//                         onTap: toggleFavorite,
//                         child: Container(
//                           width: 24,
//                           height: 24,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(
//                                 0.9), // Slightly lighter background
//                           ),
//                           child: Icon(
//                             widget.productsModel.isFavorite
//                                 ? Icons.favorite
//                                 : Icons.favorite_border,
//                             color: Color.fromRGBO(239, 164, 200, 1),
//                             size: 18, // Adjusted icon size for better fit
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     // Share icon positioned at the top-right below the favorite
//                     Positioned(
//                       right: 16, // Positioned slightly away from edges
//                       top: 48,
//                       child: GestureDetector(
//                         onTap: toggleFavorite,
//                         child: Container(
//                           width: 24,
//                           height: 24,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(
//                                 0.9), // Slightly lighter background
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/ic_share.svg',
//                             height: 14,
//                             width: 14,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 8),
//
//                 // Product Title and Price
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 4.0),
//                   child: Text(
//                     'Whole Wheat Flour Chakki 1 Kg',
//                     style: GlobalTextStyles.qs20w7black,
//                     // TextStyle(
//                     //     fontSize: 20,
//                     //     fontWeight: FontWeight.w700,
//                     //     fontFamily: GlobalTextStyles.quicksandFont),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
//                   child: Row(
//                     children: [
//                       const Text(
//                         '₹299',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       const Text(
//                         '(1 kg)',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     'Barnyard millet is effective for diabetics due to its high magnesium and mineral content. It also helps to monitor your blood pressure and cholesterol.',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ),
//                 // Quantity and Weight Section
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Select Quantity',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: Color.fromRGBO(65, 61, 50, 1),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             height: 34,
//                             width: 140,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Color.fromRGBO(138, 141, 159, 1),
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(Icons.remove),
//                                   onPressed: () => setState(() {
//                                     if (quantity > 1) quantity--;
//                                   }),
//                                 ),
//                                 Text('$quantity'),
//                                 IconButton(
//                                   icon: const Icon(Icons.add),
//                                   onPressed: () => setState(() {
//                                     quantity++;
//                                   }),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Net Weight',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: Color.fromRGBO(65, 61, 50, 1),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             height: 34,
//                             width: 140,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Color.fromRGBO(138, 141, 159, 1)!),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: DropdownButton<String>(
//                               value: selectedWeight,
//                               isExpanded: true,
//                               underline: Container(),
//                               icon: const Icon(Icons.keyboard_arrow_down_sharp),
//                               items:
//                                   ['500 g', '1 kg', '2 kg'].map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   selectedWeight = newValue!;
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 CustomElevatedButton(
//                   onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AddSubscriptionScreen(),
//                     ),
//                   ),
//                   text: 'Subscribe',
//                   color: Colors.white,
//                   // onPressed: onPressed,
//                 ),
//                 const SizedBox(height: 24),
//                 Padding(
//                   padding: EdgeInsets.all(8),
//                   child: Text('More Like This'),
//                 ),
//                 // Similar Products
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                   child: const Text(
//                     'You might also like',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 // const SizedBox(height: 4),
//                 _buildProductGridView(products)
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProductGridView(List<ProductsModel> products) {
//     return GridView.builder(
//       shrinkWrap: true,
//       // Prevent GridView from taking up more space than needed
//       physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       // Disable scrolling if inside a scrollable parent
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2, // Number of columns
//         mainAxisSpacing: 12, // Increased space between columns
//         crossAxisSpacing: 16, // Increased space between rows
//         childAspectRatio: 0.82, // Adjusted aspect ratio for better card sizing
//       ),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return ProductCardHome(
//             product: product); // Pass the product to ProductCard
//       },
//     );
//   }
// }
