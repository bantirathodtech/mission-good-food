import 'dart:convert';
import 'document.dart';

class Hits {
  Document? document;
  Map<String, dynamic>? highlight;  // Changed from dynamic to Map
  List<dynamic>? highlights;

  Hits({
    this.document,
    this.highlight,
    this.highlights,
  });

  Hits.fromJson(Map<String, dynamic> json) {
    document = json['document'] != null ? Document.fromJson(json['document']) : null;
    highlight = json['highlight'] != null ? json['highlight'] as Map<String, dynamic> : null;
    highlights = json['highlights'] != null ? List<dynamic>.from(json['highlights']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (document != null) {
      data['document'] = document!.toJson();
    }
    data['highlight'] = highlight;
    data['highlights'] = highlights;
    return data;
  }
}