import 'dart:convert';

/// name : "Colour"

Attribute attributeFromJson(String str) => Attribute.fromJson(json.decode(str));
String attributeToJson(Attribute data) => json.encode(data.toJson());

class Attribute {
  Attribute({
    this.name,
  });

  Attribute.fromJson(dynamic json) {
    name = json['name'];
  }
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }
}
