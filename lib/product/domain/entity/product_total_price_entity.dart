import 'package:equatable/equatable.dart';

class CartProductEntityEntity extends Equatable {
  final String name;
  final int productPrice;
  final int numberOfPieces;
  final int? weightPrice;
  final List<AdditionPriceEntity> additionPricesList;
  final List<AdditionPriceEntity> extrasPrice;

  CartProductEntityEntity.initial()
      : this(
            name: '',
            productPrice: 0,
            numberOfPieces: 1,
             weightPrice: null,
            additionPricesList: [],
            extrasPrice: []);

  const CartProductEntityEntity(
      {required this.name,
      required this.productPrice,
      required this.numberOfPieces,
      required this.weightPrice,
      required this.additionPricesList,
      required this.extrasPrice});

  CartProductEntityEntity modify({
    String? name,
    int? productPrice,
    int? numberOfPieces,
    int? weightPrice,
    List<AdditionPriceEntity>? additionPricesList,
    List<AdditionPriceEntity>? extrasPrice,
  }) {
    return CartProductEntityEntity(
        name: name ?? this.name,
        productPrice: productPrice ?? this.productPrice,
        numberOfPieces: numberOfPieces ?? this.numberOfPieces,
        weightPrice: weightPrice ?? this.weightPrice,
        additionPricesList: additionPricesList ?? this.additionPricesList,
        extrasPrice: extrasPrice ?? this.extrasPrice);
  }

  @override
  List<Object?> get props =>
      [name, productPrice, numberOfPieces, additionPricesList, extrasPrice];
}
//ignore: must_be_immutable
class AdditionPriceEntity extends Equatable {
   int numbers;
   int price;

   AdditionPriceEntity({required this.numbers, required this.price});


   AdditionPriceEntity.initial():this(
     numbers: 0,
     price: 0,
   );
  AdditionPriceEntity modify({
    int? numbers,
    int? price,
  }) {
    return AdditionPriceEntity(
        numbers: numbers ?? this.numbers, price: price ?? this.price);
  }

  @override
  List<Object?> get props => [numbers, price];
}
