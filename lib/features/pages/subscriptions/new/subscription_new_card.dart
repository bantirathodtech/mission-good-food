import 'package:flutter/material.dart';

import '../../../products/model/document.dart';

class SubscriptionNewCard extends StatefulWidget {
  final Document product;

  const SubscriptionNewCard({super.key, required this.product});

  @override
  State<SubscriptionNewCard> createState() => _SubscriptionNewCardState();
}

class _SubscriptionNewCardState extends State<SubscriptionNewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(228, 242, 228, 0.6),
            blurRadius: 15,
            spreadRadius: 1,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.product.imageUrl ?? '',
                    width: 114,
                    height: 114,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 114,
                      height: 114,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(43, 41, 33, 1),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Price and Rating Row
                      Row(
                        children: [
                          Text(
                            '₹${widget.product.salePrice ?? 0}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(43, 41, 33, 1),
                            ),
                          ),
                          if (widget.product.value != null) ...[
                            const SizedBox(width: 4),
                            Text(
                              '(${widget.product.value})',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(43, 41, 33, 1),
                              ),
                            ),
                          ],
                          const SizedBox(width: 8),
                          Container(
                            width: 1,
                            height: 16,
                            color: const Color.fromRGBO(240, 242, 245, 1),
                          ),
                          const SizedBox(width: 8),
                          _buildRating(),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Description
                      Text(
                        widget.product.description ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(138, 141, 159, 1),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 16,
        ),
        const SizedBox(width: 4),
        const Text(
          '4.5',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(43, 41, 33, 1),
          ),
        ),
        const Text(
          ' (2.5k)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(138, 141, 159, 1),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:good_food_app/core/theme/text_styles/global_text_style.dart';
//
// import '../../../main/tabs/home/model/product_model.dart';
//
// class SubscriptionNewCard extends StatefulWidget {
//   final ProductModel product;
//
//   const SubscriptionNewCard({super.key, required this.product});
//
//   @override
//   State<SubscriptionNewCard> createState() => _ProductCardState();
// }
//
// class _ProductCardState extends State<SubscriptionNewCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: const Color.fromRGBO(228, 242, 228, 0.6),
//             blurRadius: 15,
//             spreadRadius: 1,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Product Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.asset(
//                     widget.product.productImage,
//                     width: 114,
//                     height: 114,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 // Product Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.product.productName,
//                         style: GlobalTextStyles.qs16w7Black,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       // const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Text(
//                             '₹${widget.product.productPrice}',
//                             style: GlobalTextStyles.regular7Black,
//                           ),
//                           // const SizedBox(width: 4),
//
//                           Text(
//                             '(${widget.product.productQty} kg)',
//                             style: GlobalTextStyles.tiny4Black,
//                           ),
//                           const SizedBox(width: 8),
//                           Container(
//                             width: 1,
//                             height: 16,
//                             color: Color.fromRGBO(240, 242, 245, 1),
//                           ),
//                           const SizedBox(width: 8),
//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.star,
//                                 color: Colors.amber,
//                                 size: 16,
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 '${widget.product.rate}',
//                                 style: GlobalTextStyles.tiny4Black,
//                               ),
//                               Text(
//                                 ' (${widget.product.totalRating})',
//                                 style: GlobalTextStyles.tiny4Black,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
