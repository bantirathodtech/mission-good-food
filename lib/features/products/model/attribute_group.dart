import 'dart:convert';

/// name : null

AttributeGroup attributeGroupFromJson(String str) =>
    AttributeGroup.fromJson(json.decode(str));
String attributeGroupToJson(AttributeGroup data) => json.encode(data.toJson());

class AttributeGroup {
  AttributeGroup({
    this.name,
  });

  AttributeGroup.fromJson(dynamic json) {
    name = json['name'];
  }
  dynamic name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }
}
