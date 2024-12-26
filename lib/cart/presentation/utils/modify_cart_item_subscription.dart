import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';
import 'package:rxdart/rxdart.dart';

class ModifyCartItemSubscription {
  ModifyCartItemSubscription._();

  static final PublishSubject<CartProductEntity> _subject = PublishSubject();

  static void push(CartProductEntity item) {
    _subject.add(item);
  }

  static Stream<CartProductEntity> stream() {
    return _subject.stream;
  }
}
