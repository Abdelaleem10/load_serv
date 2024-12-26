import 'package:equatable/equatable.dart';
import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';

class CartState extends Equatable {
  final List<CartProductEntity> cartList;
  final int checkOutPrice;
  final String? errorMessage;

  const CartState({
    required this.cartList,
    required this.checkOutPrice,
    required this.errorMessage,
  });

  const CartState.initial() : this(cartList: const [],checkOutPrice:0, errorMessage: null);

  CartState reduce(
      {List<CartProductEntity>? cartList,
        int? checkOutPrice,
        String? errorMessage}) {
    return CartState(
      cartList: cartList ?? this.cartList,
      checkOutPrice: checkOutPrice ?? this.checkOutPrice,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [cartList,checkOutPrice, errorMessage];
}
