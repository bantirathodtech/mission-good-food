import 'dart:convert';

/// collection_name : "FASH_cw_commerce_product"
/// first_q : ""
/// per_page : 20
/// q : "*"

RequestParams requestParamsFromJson(String str) =>
    RequestParams.fromJson(json.decode(str));
String requestParamsToJson(RequestParams data) => json.encode(data.toJson());

class RequestParams {
  RequestParams({
    this.collectionName,
    this.firstQ,
    this.perPage,
    this.q,
  });

  RequestParams.fromJson(dynamic json) {
    collectionName = json['collection_name'];
    firstQ = json['first_q'];
    perPage = json['per_page'];
    q = json['q'];
  }
  String? collectionName;
  String? firstQ;
  num? perPage;
  String? q;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['collection_name'] = collectionName;
    map['first_q'] = firstQ;
    map['per_page'] = perPage;
    map['q'] = q;
    return map;
  }
}
