import 'package:flutter/material.dart';
import 'package:good_food_app/core/decoration/single_side_shadow_decoration.dart';
import 'package:good_food_app/core/theme/text_styles/global_text_style.dart';
import 'package:good_food_app/core/widgets/button/elevatedButton44_8.dart';
import 'package:good_food_app/features/pages/subscriptions/old/subscription_card.dart';

import '../../../screens/tabs/home/model/product_model.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({
    super.key,
  });

  @override
  State<SubscriptionScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<SubscriptionScreen> {
  late List<ProductModel> favoriteProducts;

  @override
  void initState() {
    super.initState();
    // Convert the map data to ProductModel objects
    favoriteProducts = [
      ProductModel(
          productName: 'Whole Wheat Flour Chakki 1 kg',
          productPrice: 299,
          productImage: 'assets/images/whole_wheat_1.png',
          productQty: 1,
          isFavorite: true,
          rate: 4.3,
          totalRating: 1533),
      ProductModel(
          productName: 'Whole Wheat Flour Chakki 1 kg',
          productPrice: 299,
          productImage: 'assets/images/whole_wheat_2.png',
          productQty: 1,
          isFavorite: true,
          rate: 5,
          totalRating: 1533),
      ProductModel(
          productName: 'Whole Wheat Flour Chakki 1 kg',
          productPrice: 299,
          productImage: 'assets/images/whole_wheat_3.png',
          productQty: 3,
          isFavorite: true,
          rate: 5,
          totalRating: 1533),
      ProductModel(
          productName: 'Whole Wheat Flour Chakki 1 kg',
          productPrice: 299,
          productImage: 'assets/images/whole_wheat_4.png',
          productQty: 1,
          isFavorite: true,
          rate: 5,
          totalRating: 1533),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: Container(
            decoration: greenShadowDecoration,
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'My Subscriptions',
                style: GlobalTextStyles.qsTitle,
              ),
              actions: [
                // Padding(
                //   padding: const EdgeInsets.only(right: 32),
                //   child: SvgPicture.asset('assets/icons/ic_search.svg'),
                // ),
              ],
              centerTitle: true,
            ),
          ),
        ),
        body: Column(
          children: [
            // Scrollable ListView
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: favoriteProducts.map((product) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: SubscriptionCard(
                        product: product,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Fixed Button at the Bottom
            // Container(
            //   width: double.infinity, // Full width
            //   height: 44, // Fixed height
            //   margin: const EdgeInsets.all(16), // Margin around the button
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Handle button press
            //       // Navigate to checkout screen
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             // builder: (context) => CartProductDetailsScreen(
            //             //   product: favoriteProducts.first,
            //             // ),
            //             builder: (context) => AddSubscriptionScreen()),
            //       );
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor:
            //           Color.fromRGBO(79, 165, 111, 1), // Button color
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8), // Rounded corners
            //       ),
            //     ),
            //     child: const Text(
            //       'Proceed',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //   ),
            // ),
            ElevatedButton448(
                text: 'Proceed',
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => AddSubscriptionScreen()),
                  // );
                })
          ],
        ));
  }
}
