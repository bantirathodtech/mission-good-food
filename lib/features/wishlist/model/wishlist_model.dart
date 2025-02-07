// // lib/features/wishlist/model/wishlist_model.dart
//
// class WishlistModel {
//   final String? id;
//   final String? productId;
//   final String? customerId;
//   final DateTime? createdAt;
//
//   WishlistModel({
//     this.id,
//     this.productId,
//     this.customerId,
//     this.createdAt,
//   });
//
//   factory WishlistModel.fromJson(Map<String, dynamic> json) {
//     return WishlistModel(
//       id: json['id'] as String?,
//       productId: json['product_id'] as String?,
//       customerId: json['customer_id'] as String?,
//       createdAt: json['created_at'] != null
//           ? DateTime.parse(json['created_at'] as String)
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'product_id': productId,
//       'customer_id': customerId,
//       'created_at': createdAt?.toIso8601String(),
//     };
//   }
// }
