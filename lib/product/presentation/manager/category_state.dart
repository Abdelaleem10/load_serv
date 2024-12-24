import 'package:equatable/equatable.dart';
import 'package:loadserv_task/common/base/async.dart';
import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/domain/entity/product_entity.dart';

class CategoryState extends Equatable {
  final Async<CategoryEntity> categoryDetails;
  final Async<ProductDetailsEntity> productDetails;
  final String? errorMessage;

  const CategoryState({
    required this.categoryDetails,
    required this.productDetails,
    required this.errorMessage,
  });

  const CategoryState.initial()
      : this(
            categoryDetails: const Async.initial(),
            productDetails: const Async.initial(),
            errorMessage: null);

  CategoryState reduce(
      {Async<CategoryEntity>? categoryDetails,
      Async<ProductDetailsEntity>? productDetails,
      String? errorMessage}) {
    return CategoryState(
      categoryDetails: categoryDetails ?? this.categoryDetails,
      productDetails: productDetails ?? this.productDetails,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [categoryDetails, productDetails, errorMessage];
}
