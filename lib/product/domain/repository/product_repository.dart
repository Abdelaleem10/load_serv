import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/domain/entity/product_entity.dart';

abstract class CategoryRepository {
  Future<CategoryEntity> getCategory();

  Future<ProductDetailsEntity> getProductDetails(String productId);
}
