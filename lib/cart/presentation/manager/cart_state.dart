import 'package:equatable/equatable.dart';
import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';

class CartState extends Equatable {
  final List<CartProductEntityEntity> cartList;
  final String? errorMessage;

  const CartState({
    required this.cartList,
    required this.errorMessage,
  });

  const CartState.initial() : this(cartList: const [], errorMessage: null);

  CartState reduce(
      {List<CartProductEntityEntity>? cartList, String? errorMessage}) {
    return CartState(
      cartList: cartList ?? this.cartList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [cartList, errorMessage];
}
