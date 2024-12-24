import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/domain/repository/product_repository.dart';

class GetProductDetailsUseCase {
  final CategoryRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<ProductDetailsEntity> execute(String productId) async {
    return await repository.getProductDetails(productId);
  }
}
