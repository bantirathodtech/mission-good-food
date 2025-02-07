import 'dart:convert';

CategoryModel categoryFromJson(String str) => CategoryModel.fromJson(json.decode(str));
String categoryToJson(CategoryModel categoryModel) => json.encode(categoryModel.toJson());

class CategoryModel {
  String? categoryName;
  String? categoryImage;

  CategoryModel({
    this.categoryName,
    this.categoryImage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      categoryName: json["categoryName"],
      categoryImage: json["categoryImage"]
  );

  Map<String, dynamic> toJson() => {
    "categoryName": categoryName,
    "categoryImage": categoryImage
  };
}