import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_task/cart/presentation/manager/cart_state.dart';
import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState.initial()) {
    _loadInjectors();
  }

  void _loadInjectors() {}

//this function must be connect with api but collection not contain add to cart ,
  //so i will do it manual
  void addToCart(ProductDetailsEntity item) {
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

  void modifyProduct(ProductDetailsEntity item) {
    final newItem = _collectedProductPrice(item);

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


  ProductDetailsEntity _collectedProductPrice(ProductDetailsEntity item) {
    int total = 0;
    if (item.weights.isNotEmpty) {
      if (item.choosesWeight == null) {
        total = (item.weights.first.price ?? 1) * item.numberOfPieces;
      } else {
        total = (item.choosesWeight?.price ?? 1) * item.numberOfPieces;
      }
    } else {
      total = item.productPrice * item.numberOfPieces;
    }

    for (int i = 0; i < (item.salads.length); i++) {
      int additionPrice =
          (item.salads[i].price ?? 1) * (item.salads[i].numberOfPieces);
      total = total + additionPrice;
    }
    for (int i = 0; i < (item.extraItems.length); i++) {
      if ((item.extraItems[i].isChoose ?? false)) {
        int additionPrice = (item.extraItems[i].price ?? 0);
        total = total + additionPrice;
      }
    }
      item = item.modify(totalPrice: total);

    return item;
  }

}
