import 'hits.dart';
import 'request_params.dart';

class ProductsModel {
  List<dynamic> facetCounts;
  int? found;
  List<Hits>? hits;
  int? outOf;
  int? page;
  RequestParams? requestParams;
  bool? searchCutoff;
  int? searchTimeMs;

  ProductsModel({
    this.facetCounts = const [],
    this.found,
    this.hits,
    this.outOf,
    this.page,
    this.requestParams,
    this.searchCutoff,
    this.searchTimeMs,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      facetCounts: json['facet_counts'] ?? [],
      found: json['found'],
      hits: json['hits'] != null
          ? List<Hits>.from(json['hits'].map((x) => Hits.fromJson(x)))
          : null,
      outOf: json['out_of'],
      page: json['page'],
      requestParams: json['request_params'] != null
          ? RequestParams.fromJson(json['request_params'])
          : null,
      searchCutoff: json['search_cutoff'],
      searchTimeMs: json['search_time_ms'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'facet_counts': facetCounts,
      'found': found,
      'hits': hits?.map((x) => x.toJson()).toList(),
      'out_of': outOf,
      'page': page,
      'request_params': requestParams?.toJson(),
      'search_cutoff': searchCutoff,
      'search_time_ms': searchTimeMs,
    };
  }

  String? get imageUrl => hits?.firstOrNull?.document?.imageUrl;
  String? get productId => hits?.firstOrNull?.document?.productId;
  String? get name => hits?.firstOrNull?.document?.name;
  num? get salePrice => hits?.firstOrNull?.document?.salePrice;
  num? get productQty => hits?.firstOrNull?.document?.value != null ? 1 : null;

  bool get isEmpty => hits?.isEmpty ?? true;
  bool get isNotEmpty => !isEmpty;
}
