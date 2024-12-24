import 'package:equatable/equatable.dart';

class ExtraEntity extends Equatable {
  final String extraName;
  final double price;
  final bool isChoose;

  const ExtraEntity(
      {required this.extraName, required this.price, required this.isChoose});

  ExtraEntity modify({
    String? extraName,
    double? price,
    bool? isChoose,
  }) {
    return ExtraEntity(
        extraName: extraName ?? this.extraName,
        price: price ?? this.price,
        isChoose: isChoose ?? this.isChoose);
  }

  @override
  List<Object?> get props => [extraName, price, isChoose];
}



