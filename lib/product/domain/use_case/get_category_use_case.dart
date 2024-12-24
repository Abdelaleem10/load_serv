import 'package:loadserv_task/product/domain/entity/product_entity.dart';
import 'package:loadserv_task/product/domain/repository/product_repository.dart';

class GetCategoryUseCase {
  final CategoryRepository repository;

  GetCategoryUseCase( this.repository);

  Future<CategoryEntity> execute() async {
    return await repository.getCategory();
  }
}
