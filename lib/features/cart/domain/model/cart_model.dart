import 'dart:convert';

import '../../../products/model/document.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));
String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.cartId,
    this.customer,
    this.items,
    this.orderSummary,
  });

  String? cartId;
  Customer? customer;
  List<CartItem>? items;
  OrderSummary? orderSummary;

  bool get isEmpty => items?.isEmpty ?? true;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        cartId: json["cart_id"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        items: json["items"] == null
            ? []
            : List<CartItem>.from(
                json["items"]!.map((x) => CartItem.fromJson(x))),
        orderSummary: json["order_summary"] == null
            ? null
            : OrderSummary.fromJson(json["order_summary"]),
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "customer": customer?.toJson(),
        "items": items?.map((x) => x.toJson()).toList(),
        "order_summary": orderSummary?.toJson(),
      };
}

class Customer {
  Customer({
    this.customerId,
    this.name,
    this.email,
    this.phone,
    this.isGuest,
  });

  String? customerId;
  String? name;
  String? email;
  String? phone;
  bool? isGuest;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json["customer_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        isGuest: json["is_guest"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "name": name,
        "email": email,
        "phone": phone,
        "is_guest": isGuest,
      };
}

class CartItem {
  CartItem({
    this.itemId,
    this.productId,
    this.quantity,
    this.unitPrice,
    this.linePrice,
    this.taxRate,
    this.product, // Added product field
  });

  String? itemId;
  String? productId;
  int? quantity;
  num? unitPrice;
  num? linePrice;
  num? taxRate;
  Document? product; // Holds product details

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        itemId: json["item_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        linePrice: json["line_price"],
        taxRate: json["tax_rate"],
        product:
            json["product"] != null ? Document.fromJson(json["product"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "product_id": productId,
        "quantity": quantity,
        "unit_price": unitPrice,
        "line_price": linePrice,
        "tax_rate": taxRate,
        "product": product?.toJson(),
      };
}

class OrderSummary {
  OrderSummary({
    this.subtotal,
    this.shippingCost,
    this.taxAmount,
    this.totalDiscount,
    this.grandTotal,
  });

  num? subtotal;
  num? shippingCost;
  num? taxAmount;
  num? totalDiscount;
  num? grandTotal;

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
        subtotal: json["subtotal"],
        shippingCost: json["shipping_cost"],
        taxAmount: json["tax_amount"],
        totalDiscount: json["total_discount"],
        grandTotal: json["grand_total"],
      );

  Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "shipping_cost": shippingCost,
        "tax_amount": taxAmount,
        "total_discount": totalDiscount,
        "grand_total": grandTotal,
      };
}
