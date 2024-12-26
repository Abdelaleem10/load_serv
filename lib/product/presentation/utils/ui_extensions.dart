import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';

extension ExtraItemEntityConverter on ExtraItemEntity{
  AdditionPriceEntity map() {
    return AdditionPriceEntity(name: name ?? '',
        numbers: isChoose == true ? 1 : 0,
        price: price ?? 0,
        id: id ?? 1);
  }
}