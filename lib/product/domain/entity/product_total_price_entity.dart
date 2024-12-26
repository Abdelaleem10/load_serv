import 'package:equatable/equatable.dart';

class CartProductEntity extends Equatable {
  final String id;
  final String? name;
  final String? image;
  final int productPrice;
  final int numberOfPieces;
  final String? weightName;
  final int? weightPrice;
  final int weightIndex;
  final List<AdditionPriceEntity> additionPricesList;
  final List<AdditionPriceEntity> extrasPriceList;
  final int additionsNumber;
  final int extrasNumber;
  final int totalPrice;

  CartProductEntity.initial()
      : this(
          id: '',
          name: null,
          image: null,
          productPrice: 0,
          numberOfPieces: 1,
          weightName: null,
          weightPrice: null,
          weightIndex: 0,
          additionPricesList: [],
          extrasPriceList: [],
          additionsNumber: 0,
          extrasNumber: 0,
          totalPrice: 0,
        );

  const CartProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.productPrice,
    required this.numberOfPieces,
    required this.weightName,
    required this.weightPrice,
    required this.weightIndex,
    required this.additionPricesList,
    required this.extrasPriceList,
    required this.additionsNumber,
    required this.extrasNumber,
    required this.totalPrice,
  });

  CartProductEntity modify({
    String? id,
    String? name,
    String? image,
    int? productPrice,
    int? numberOfPieces,
    String? weightName,
    int? weightPrice,
    int? weightIndex,
    List<AdditionPriceEntity>? additionPricesList,
    List<AdditionPriceEntity>? extrasPriceList,
    int? additionsNumber,
    int? extrasNumber,
    int? totalPrice,
  }) {
    return CartProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      productPrice: productPrice ?? this.productPrice,
      numberOfPieces: numberOfPieces ?? this.numberOfPieces,
      weightPrice: weightPrice ?? this.weightPrice,
      weightIndex: weightIndex ?? this.weightIndex,
      weightName: weightName ?? this.weightName,
      additionPricesList: additionPricesList ?? this.additionPricesList,
      extrasPriceList: extrasPriceList ?? this.extrasPriceList,
      additionsNumber: additionsNumber ?? this.additionsNumber,
      extrasNumber: extrasNumber ?? this.extrasNumber,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        productPrice,
        weightName,
        weightPrice,
        weightIndex,
        numberOfPieces,
        additionPricesList,
        extrasPriceList,
        additionsNumber,
        extrasNumber,
        totalPrice,
      ];
}

//ignore: must_be_immutable
class AdditionPriceEntity extends Equatable {
  int id;
  String name;
  int numbers;
  int price;

  AdditionPriceEntity(
      {required this.id,required this.name, required this.numbers, required this.price});

  AdditionPriceEntity.initial()
      : this(
    id: 1,
          name: '',
          numbers: 0,
          price: 0,
        );

  AdditionPriceEntity modify({
    int? id,
    String? name,
    int? numbers,
    int? price,
  }) {
    return AdditionPriceEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        numbers: numbers ?? this.numbers,
        price: price ?? this.price);
  }

  @override
  List<Object?> get props => [id, name, numbers, price];
}
