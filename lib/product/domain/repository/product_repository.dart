import 'package:loadserv_task/product/domain/entity/product_entity.dart';

abstract class CategoryRepository {

  Future<CategoryEntity> getCategory();



  }