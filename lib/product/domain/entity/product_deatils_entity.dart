import 'package:equatable/equatable.dart';

class ProductDetailsEntity extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final bool? isSingle;
  final int? points;
  final List<ExtraItemEntity> extraItems;
  final List<ExtraItemEntity> salads;
  final List<WeightEntity> weights;

  ProductDetailsEntity.initial()
      : this(
          id: null,
          name: null,
          description: null,
          image: null,
          isSingle: null,
          points: null,
          extraItems: [],
          salads: [],
          weights: [],
        );

  const ProductDetailsEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.isSingle,
    required this.points,
    required this.extraItems,
    required this.salads,
    required this.weights,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        isSingle,
        points,
        extraItems,
        salads,
        weights
      ];
}

class ExtraItemEntity extends Equatable {
  final int? id;
  final String? name;
  final int? price;
  final String? image;
   bool isChoose;

   ExtraItemEntity(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.isChoose});


  @override
  List<Object?> get props => [id, name, price, image, isChoose];
}

class WeightEntity extends Equatable {
  final int? id;
  final String? name;
  final int? price;
  final int? points;
  final int? priceBeforeDiscount;
  final int? numberOfSalad;

  const WeightEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.points,
    required this.priceBeforeDiscount,
    required this.numberOfSalad,
  });

  @override
  List<Object?> get props =>
      [id, name, price, points, priceBeforeDiscount, numberOfSalad];
}
