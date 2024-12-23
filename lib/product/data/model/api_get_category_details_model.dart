// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ApiWelcomeModel welcomeFromJson(String str) => ApiWelcomeModel.fromJson(json.decode(str));

String welcomeToJson(ApiWelcomeModel data) => json.encode(data.toJson());

class ApiWelcomeModel {
  String? message;
  ApiCategoryModel? categoryModel;

  ApiWelcomeModel({
    this.message,
    this.categoryModel,
  });

  factory ApiWelcomeModel.fromJson(Map<String, dynamic> json) => ApiWelcomeModel(
    message: json["message"],
    categoryModel: json["data"] == null ? null : ApiCategoryModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": categoryModel?.toJson(),
  };
}

class ApiCategoryModel {
  int? id;
  String? name;
  String? backgroundImage;
  String? image;
  List<ApiProductModel>? products;

  ApiCategoryModel({
    this.id,
    this.name,
    this.backgroundImage,
    this.image,
    this.products,
  });

  factory ApiCategoryModel.fromJson(Map<String, dynamic> json) => ApiCategoryModel(
    id: json["id"],
    name: json["name"],
    backgroundImage: json["background_image"],
    image: json["image"],
    products: json["products"] == null ? [] : List<ApiProductModel>.from(json["products"]!.map((x) => ApiProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "background_image": backgroundImage,
    "image": image,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class ApiProductModel {
  int? id;
  String? name;
  String? description;
  String? image;
  bool? isSingle;
  int? price;
  int? priceBeforeDiscount;
  int? points;

  ApiProductModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.isSingle,
    this.price,
    this.priceBeforeDiscount,
    this.points,
  });

  factory ApiProductModel.fromJson(Map<String, dynamic> json) => ApiProductModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    isSingle: json["is_single"],
    price: json["price"],
    priceBeforeDiscount: json["price_before_discount"],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "is_single": isSingle,
    "price": price,
    "price_before_discount": priceBeforeDiscount,
    "points": points,
  };
}
