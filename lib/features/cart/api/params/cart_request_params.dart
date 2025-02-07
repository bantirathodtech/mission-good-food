// lib/features/cart/data/params/cart_request_params.dart
import '../../../products/model/document.dart';
import '../../domain/model/cart_model.dart';

class CartRequestParams {
  final String? cartId;
  final Customer? customer;
  final List<CartItemParams>? items;
  final OrderSummary? orderSummary;

  CartRequestParams({
    this.cartId,
    this.customer,
    this.items,
    this.orderSummary,
  });

  void validate() {
    if (items == null || items!.isEmpty) {
      throw Exception('Items cannot be empty');
    }
  }

  Map<String, dynamic> toJson() => {
        "customer":
            customer?.toJson() ?? {"customer_id": null, "is_guest": true},
        "items": items?.map((item) => item.toJson()).toList(),
        "order_summary": orderSummary?.toJson(),
      };
}

class CartItemParams {
  final String productId;
  final int quantity;
  final String? itemId;
  final num? unitPrice;
  final bool? requiresShipping;
  final String? productTitle;
  final String? productDescription;
  final String? productUrl;
  final Map<String, dynamic>? featuredImage;

  CartItemParams({
    required this.productId,
    required this.quantity,
    this.itemId,
    this.unitPrice,
    this.requiresShipping,
    this.productTitle,
    this.productDescription,
    this.productUrl,
    this.featuredImage,
  });

  // Convert from Document model
  factory CartItemParams.fromDocument(Document doc, {int quantity = 1}) {
    return CartItemParams(
      productId: doc.productId ?? doc.id ?? '',
      quantity: quantity,
      unitPrice: doc.salePrice,
      productTitle: doc.name,
      productDescription: doc.description,
      featuredImage: doc.imageUrl != null
          ? {
              "url": doc.imageUrl,
              "aspect_ratio": 1.0,
              "alt_text": doc.name ?? "Product Image"
            }
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "unit_price": unitPrice,
        "item_title": productTitle,
        "product_description": productDescription,
        "featured_image": featuredImage,
      };
}

// // lib/features/cart/data/dtos/cart_request_params.dart

// class CartRequestParams {
//   final String? cartId;
//   final String? customerId;
//   final List<CartItemParams>? items;
//   final ShippingParams? shipping;
//   final PaymentParams? payment;
//
//   CartRequestParams({
//     this.cartId,
//     this.customerId,
//     this.items,
//     this.shipping,
//     this.payment,
//   });
//
//   void validate() {
//     if (items != null && items!.isEmpty) {
//       throw Exception('Items cannot be empty');
//     }
//   }
//
//   Map<String, dynamic> toJson() => {
//         'cart_id': cartId,
//         'customer': {
//           'customer_id': customerId,
//           'is_guest': customerId == null,
//         },
//         'items': items?.map((item) => item.toJson()).toList(),
//         'shipping': shipping?.toJson(),
//         'payment': payment?.toJson(),
//       };
// }
//
// class CartItemParams {
//   final String productId;
//   final int quantity;
//
//   CartItemParams({
//     required this.productId,
//     required this.quantity,
//   });
//
//   Map<String, dynamic> toJson() => {
//         'product_id': productId,
//         'quantity': quantity,
//       };
// }
//
// class ShippingParams {
//   final String? address;
//   final String? method;
//   final num? cost;
//
//   ShippingParams({this.address, this.method, this.cost});
//
//   Map<String, dynamic> toJson() => {
//         'address': address,
//         'method': method,
//         'cost': cost,
//       };
// }
//
// class PaymentParams {
//   final String? method;
//   final Map<String, dynamic>? details;
//
//   PaymentParams({this.method, this.details});
//
//   Map<String, dynamic> toJson() => {
//         'method': method,
//         'details': details,
//       };
// }
