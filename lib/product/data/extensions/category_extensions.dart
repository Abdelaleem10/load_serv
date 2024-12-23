import 'dart:math';

import 'package:loadserv_task/product/data/model/api_get_category_details_model.dart';
import 'package:loadserv_task/product/domain/entity/product_entity.dart';

extension CategoryExtensions on ApiCategoryModel {
  CategoryEntity map() {
    return CategoryEntity(
        id: id ?? Random().nextInt(999),
        name: name,
        backgroundImage: backgroundImage,
        image: image,
        products: products?.map((e) => e.map()).toList() ?? []);
  }
}

extension ProductConverter on ApiProductModel {
  ProductEntity map() {
    return ProductEntity(
        id: id ??Random().nextInt(999),
        name: name,
        description: description ,
        image: image ,
        isSingle: isSingle ,
        price: price,
        priceBeforeDiscount: priceBeforeDiscount ,
        points: points );
  }
}
