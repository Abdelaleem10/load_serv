import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_task/cart/presentation/manager/cart_state.dart';
import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState.initial()) {
    _loadInjectors();
  }

  void _loadInjectors() {}

//this function must be connect with api but collection not contain add to cart ,
  //so i will do it manual
  void addToCart(CartProductEntityEntity item) {
    final updateState = [...state.cartList];
    updateState.add(item);
    emit(state.reduce(cartList: updateState));
  }
}
