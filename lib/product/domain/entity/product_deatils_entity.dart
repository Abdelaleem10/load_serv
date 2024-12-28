import 'package:equatable/equatable.dart';

class ProductDetailsEntity extends Equatable {
  final int? id;
  final int productPrice;
  final String? name;
  final String? description;
  final String? image;
  final bool? isSingle;
  final int? points;
  final int numberOfPieces;
  final WeightEntity? choosesWeight;
  final int totalPrice;
  final int additionNumbers;
  final int extraNumbers;
  final List<ExtraItemEntity> extraItems;
  final List<ExtraItemEntity> salads;
  final List<WeightEntity> weights;
  final String? notes;

  ProductDetailsEntity.initial()
      : this(
          id: null,
          name: null,
          description: null,
          image: null,
          isSingle: null,
          points: null,
          choosesWeight: null,
          totalPrice: 0,
          additionNumbers: 0,
          extraNumbers: 0,
          productPrice: 100,
          numberOfPieces: 1,
          extraItems: [],
          salads: [],
          weights: [],
          notes: null,
        );

  ProductDetailsEntity modify({
    int? numberOfPieces,
    int? totalPrice,
    int? productPrice,
    int? additionNumbers,
    int? extraNumbers,
    String? notes,
    WeightEntity? choosesWeight,
    List<ExtraItemEntity>? extraItems,
    List<ExtraItemEntity>? salads,
  }) {
    return ProductDetailsEntity(
        id: id,
        name: name,
        description: description,
        image: image,
        isSingle: isSingle,
        points: points,
        totalPrice: totalPrice ?? this.totalPrice,
        additionNumbers: additionNumbers ?? this.additionNumbers,
        extraNumbers: extraNumbers ?? this.extraNumbers,
        productPrice: productPrice ?? this.productPrice,
        numberOfPieces: numberOfPieces ?? this.numberOfPieces,
        extraItems: extraItems ?? this.extraItems,
        salads: salads ?? this.salads,
        weights: weights,
        notes: notes ?? this.notes,
        choosesWeight: choosesWeight ?? this.choosesWeight);
  }

  const ProductDetailsEntity({
    required this.id,
    required this.name,
    required this.productPrice,
    required this.description,
    required this.image,
    required this.isSingle,
    required this.totalPrice,
    required this.additionNumbers,
    required this.extraNumbers,
    required this.points,
    required this.choosesWeight,
    required this.numberOfPieces,
    required this.extraItems,
    required this.salads,
    required this.weights,
    required this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        numberOfPieces,
        isSingle,
        points,
        extraItems,
        totalPrice,
        salads,
        weights,
        choosesWeight,
        additionNumbers,
        extraNumbers,
        productPrice,
        notes,
      ];
}

class ExtraItemEntity extends Equatable {
  final int? id;
  final String? name;
  final int? price;
  final String? image;
  bool? isChoose;
  int numberOfPieces;

  ExtraItemEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.isChoose,
    required this.numberOfPieces,
  });

  ExtraItemEntity modify({
    bool? isChoose,
    int? numberOfPieces,
  }) {
    return ExtraItemEntity(
        id: id,
        name: name,
        price: price,
        image: image,
        numberOfPieces: numberOfPieces ?? this.numberOfPieces,
        isChoose: isChoose ?? this.isChoose);
  }

  @override
  List<Object?> get props => [id, name, price, image, isChoose, numberOfPieces];
}

class WeightEntity extends Equatable {
  final int? id;
  final String? name;
  final int? price;
  final int? points;
  final int? priceBeforeDiscount;
  final int? numberOfSalad;
  final bool isSelected;

  const WeightEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.points,
    required this.priceBeforeDiscount,
    required this.numberOfSalad,
    required this.isSelected,
  });

  @override
  List<Object?> get props =>
      [id, name, price, points, priceBeforeDiscount, numberOfSalad, isSelected];
}
