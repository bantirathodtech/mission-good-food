import 'dart:convert';

import 'attribute.dart';
import 'attribute_group.dart';

/// attribute : {"name":"Colour"}
/// attribute_group : {"name":null}
/// value : "Red"

ProductAttributes productAttributesFromJson(String str) =>
    ProductAttributes.fromJson(json.decode(str));
String productAttributesToJson(ProductAttributes data) =>
    json.encode(data.toJson());

class ProductAttributes {
  ProductAttributes({
    this.attribute,
    this.attributeGroup,
    this.value,
  });

  ProductAttributes.fromJson(dynamic json) {
    attribute = json['attribute'] != null
        ? Attribute.fromJson(json['attribute'])
        : null;
    attributeGroup = json['attribute_group'] != null
        ? AttributeGroup.fromJson(json['attribute_group'])
        : null;
    value = json['value'];
  }
  Attribute? attribute;
  AttributeGroup? attributeGroup;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (attribute != null) {
      map['attribute'] = attribute?.toJson();
    }
    if (attributeGroup != null) {
      map['attribute_group'] = attributeGroup?.toJson();
    }
    map['value'] = value;
    return map;
  }
}
