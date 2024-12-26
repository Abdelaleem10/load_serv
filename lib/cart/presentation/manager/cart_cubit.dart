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
  void addToCart(CartProductEntity item) {
    final updateState = [...state.cartList];
    if ((updateState.any((e) => e.id == item.id))) {
      int index = updateState.indexWhere((e) => e.id == item.id);
      updateState.removeAt(index);
      updateState.insert(index, item);
      emit(state.reduce(cartList: updateState));
    } else {
      updateState.add(item);
      emit(state.reduce(cartList: updateState));
    }
    _collectCheckOutPrice();
  }

  void deleteCart() => emit(state.reduce(cartList: []));

  void _collectCheckOutPrice() {
    int totalPrice = 0;
    final updateState = [...state.cartList];
    updateState.map((e) {
      totalPrice = totalPrice + e.totalPrice;
      return e;
    }).toList();
    emit(state.reduce(checkOutPrice: totalPrice));
  }

  void modifyProduct(CartProductEntity item) {
    final newItem = _collectSingleProductPrice(item);

    var updateState = [...state.cartList];
    updateState = updateState.map((e) {
      if (e.id == newItem.id) {
        return newItem;
      }
      return e;
    }).toList();
    emit(state.reduce(cartList: updateState));
    _collectCheckOutPrice();
  }

  CartProductEntity _collectSingleProductPrice(CartProductEntity item) {
    int priceWithoutAddition = item.productPrice * item.numberOfPieces;

    for (int i = 0; i < (item.additionPricesList.length); i++) {
      int additionPrice = (item.additionPricesList[i].price) *
          (item.additionPricesList[i].numbers);
      priceWithoutAddition = priceWithoutAddition + additionPrice;
    }
    for (int i = 0; i < (item.extrasPriceList.length); i++) {
      int additionPrice = (item.extrasPriceList[i].price);
      priceWithoutAddition = priceWithoutAddition + additionPrice;
    }
    item = item.modify(totalPrice: priceWithoutAddition);
    return item;
  }
}
