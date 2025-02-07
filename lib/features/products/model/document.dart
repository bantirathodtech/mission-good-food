// lib/features/products/model/document.dart (renamed from Document.dart)
import 'dart:convert';

import 'product_attributes.dart';

Document documentFromJson(String str) => Document.fromJson(json.decode(str));
String documentToJson(Document data) => json.encode(data.toJson());

class Document {
  Document({
    this.brand,
    this.colorCode,
    this.description,
    this.id,
    this.imageUrl,
    this.images,
    this.isbestSeller,
    this.listPrice,
    this.metaData,
    this.name,
    this.name2,
    this.productCategoryId,
    this.productAddons,
    this.productAttributes,
    this.productCategoryName,
    this.productId,
    this.productionCenter,
    this.promoApplicable,
    this.returnDays,
    this.returnable,
    this.salePrice,
    this.shelfLife,
    this.shortDescription,
    this.taxRate,
    this.uomName,
    this.upc,
    this.value,
    this.variants,
    this.varientFlag,
  });

  Document.fromJson(dynamic json) {
    brand = json['brand'];
    colorCode = json['color_code'];
    description = json['description'];
    id = json['id'];
    imageUrl = json['image_url'];
    images = json['images'] != null ? List<dynamic>.from(json['images']) : null;

    // isbestSeller = json['isbest_seller'] is bool
    //     ? json['isbest_seller']
    //     : json['isbest_seller'].toString().toLowerCase() == 'true';

    isbestSeller = json['isbest_seller'] ?? false;

    listPrice = json['list_price'];
    metaData = json['meta_data'] != null
        ? List<dynamic>.from(json['meta_data'])
        : null;

    name = json['name'];
    name2 = json['name2'];
    productCategoryId = json['productCategoryId'];
    productAddons = json['productAddons'] != null
        ? List<dynamic>.from(json['productAddons'])
        : null;

    if (json['product_attributes'] != null) {
      productAttributes = [];
      json['product_attributes'].forEach((v) {
        productAttributes?.add(ProductAttributes.fromJson(v));
      });
    }
    productCategoryName = json['product_category_name'];
    productId = json['product_id'];
    productionCenter = json['production_center'];
    promoApplicable = json['promo_applicable'];
    returnDays = json['return_days'];
    returnable = json['returnable'];
    salePrice = json['sale_price'];
    shelfLife = json['shelf_life'];
    shortDescription = json['short_description'];
    taxRate = json['tax_rate'];
    uomName = json['uom_name'];
    upc = json['upc'];
    value = json['value'];
    variants =
        json['variants'] != null ? List<dynamic>.from(json['variants']) : null;

    varientFlag = json['varientFlag'];
  }
  String? brand;
  String? colorCode;
  String? description;
  String? id;
  String? imageUrl;
  List<dynamic>? images;
  bool? isbestSeller;
  String? listPrice;
  List<dynamic>? metaData;
  String? name;
  String? name2;
  String? productCategoryId;
  List<dynamic>? productAddons;
  List<ProductAttributes>? productAttributes;
  String? productCategoryName;
  String? productId;
  String? productionCenter;
  String? promoApplicable;
  String? returnDays;
  bool? returnable;
  num? salePrice;
  String? shelfLife;
  String? shortDescription;
  String? taxRate;
  String? uomName;
  String? upc;
  String? value;
  List<dynamic>? variants;
  String? varientFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['brand'] = brand;
    map['color_code'] = colorCode;
    map['description'] = description;
    map['id'] = id;
    map['image_url'] = imageUrl;
    if (images != null) {
      // Fixed: Don't try to call toJson on dynamic values
      map['images'] = images;
    }
    map['isbest_seller'] = isbestSeller;
    map['list_price'] = listPrice;
    if (metaData != null) {
      // Fixed: Don't try to call toJson on dynamic values
      map['meta_data'] = metaData;
    }
    map['name'] = name;
    map['name2'] = name2;
    map['productCategoryId'] = productCategoryId;
    if (productAddons != null) {
      // Fixed: Don't try to call toJson on dynamic values
      map['product_addons'] = productAddons;
    }
    if (productAttributes != null) {
      map['product_attributes'] =
          productAttributes?.map((v) => v.toJson()).toList();
    }
    map['product_category_name'] = productCategoryName;
    map['product_id'] = productId;
    map['production_center'] = productionCenter;
    map['promo_applicable'] = promoApplicable;
    map['return_days'] = returnDays;
    map['returnable'] = returnable;
    map['sale_price'] = salePrice;
    map['shelf_life'] = shelfLife;
    map['short_description'] = shortDescription;
    map['tax_rate'] = taxRate;
    map['uom_name'] = uomName;
    map['upc'] = upc;
    map['value'] = value;
    if (variants != null) {
      // Fixed: Don't try to call toJson on dynamic values
      map['variants'] = variants;
    }
    map['varientFlag'] = varientFlag;
    return map;
  }
}
