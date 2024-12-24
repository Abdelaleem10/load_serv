import 'package:loadserv_task/common/data/di/app_injector.dart';
import 'package:loadserv_task/product/data/repository/product_repository.dart';
import 'package:loadserv_task/product/domain/repository/product_repository.dart';
import 'package:loadserv_task/product/domain/use_case/get_category_use_case.dart';
import 'package:loadserv_task/product/domain/use_case/get_product_details_use_case.dart';

class ProductInjector {
  static Future<void> initialize() async {
    injector.registerFactory(() => GetCategoryUseCase(injector()));
    injector.registerFactory(() => GetProductDetailsUseCase(injector()));
    injector.registerLazySingleton<CategoryRepository>(
            () => CategoryRepositoryImp());



  }
}
