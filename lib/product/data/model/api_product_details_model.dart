import 'dart:convert';

ApiProductDetailsResponse welcomeFromJson(String str) => ApiProductDetailsResponse.fromJson(json.decode(str));

class ApiProductDetailsResponse {
  String? message;
  ApiProductDetailsModel? data;

  ApiProductDetailsResponse({
    this.message,
    this.data,
  });

  factory ApiProductDetailsResponse.fromJson(Map<String, dynamic> json) => ApiProductDetailsResponse(
        message: json["message"],
        data: json["data"] == null
            ? null
            : ApiProductDetailsModel.fromJson(json["data"]),
      );
}

class ApiProductDetailsModel {
  int? id;
  String? name;
  String? description;
  String? image;
  bool? isSingle;
  int? points;
  List<ApiExtraItemModel>? extraItems;
  List<ApiExtraItemModel>? salads;
  List<ApiWeightModel>? weights;

  ApiProductDetailsModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.isSingle,
    this.points,
    this.extraItems,
    this.salads,
    this.weights,
  });

  factory ApiProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ApiProductDetailsModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        isSingle: json["is_single"],
        points: json["points"],
        extraItems: json["extra_items"] == null
            ? []
            : List<ApiExtraItemModel>.from(
                json["extra_items"]!.map((x) => ApiExtraItemModel.fromJson(x))),
        salads: json["salads"] == null
            ? []
            : List<ApiExtraItemModel>.from(
                json["salads"]!.map((x) => ApiExtraItemModel.fromJson(x))),
        weights: json["weights"] == null
            ? []
            : List<ApiWeightModel>.from(
                json["weights"]!.map((x) => ApiWeightModel.fromJson(x))),
      );
}

class ApiExtraItemModel {
  int? id;
  String? name;
  int? price;
  String? image;

  ApiExtraItemModel({
    this.id,
    this.name,
    this.price,
    this.image,
  });

  factory ApiExtraItemModel.fromJson(Map<String, dynamic> json) =>
      ApiExtraItemModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
      );
}

class ApiWeightModel {
  int? id;
  String? name;
  int? price;
  int? points;
  int? priceBeforeDiscount;
  int? numberOfSalad;

  ApiWeightModel({
    this.id,
    this.name,
    this.price,
    this.points,
    this.priceBeforeDiscount,
    this.numberOfSalad,
  });

  factory ApiWeightModel.fromJson(Map<String, dynamic> json) => ApiWeightModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        points: json["points"],
        priceBeforeDiscount: json["price_before_discount"],
        numberOfSalad: json["number_of_salad"],
      );
}
