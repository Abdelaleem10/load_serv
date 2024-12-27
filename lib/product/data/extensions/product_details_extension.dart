import 'package:loadserv_task/product/data/model/api_product_details_model.dart';
import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';

extension ProductDetailsConverter on ApiProductDetailsModel {
  ProductDetailsEntity map() {
    return ProductDetailsEntity(
      id: id,
      name: name,
      description: description,
      image: image,
      isSingle: isSingle,
      points: points,
      extraItems: extraItems?.map((e) => e.map()).toList() ?? [],
      salads: salads?.map((e) => e.map()).toList() ?? [],
      weights: weights?.map((e) => e.map()).toList() ?? [],
      numberOfPieces:1 ,
      totalPrice: 0,
      additionNumbers: 0,
      extraNumbers: 0,
      choosesWeight:null ,
      productPrice: 100,

    );
  }
}

extension ExtraItemEntityConverter on ApiExtraItemModel {
  ExtraItemEntity map() {
    return ExtraItemEntity(
        id: id, name: name, price: price, image: image, isChoose: false, numberOfPieces: 0);
  }
}

extension WeightEntityConverter on ApiWeightModel {
  WeightEntity map() {
    return WeightEntity(
        id: id,
        name: name,
        price: price,
        points: points,
        priceBeforeDiscount: priceBeforeDiscount,
        numberOfSalad: numberOfSalad, isSelected: false);
  }
}
