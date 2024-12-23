import 'package:equatable/equatable.dart';
import 'package:loadserv_task/common/base/async.dart';
import 'package:loadserv_task/product/domain/entity/product_entity.dart';

class CategoryState extends Equatable {
  const CategoryState(
    this.categoryDetails,
    this.errorMessage,
  );

  final Async<CategoryEntity> categoryDetails;

  final String? errorMessage;

  const CategoryState.initial() : this(const Async.initial(), null);

  CategoryState reduce({Async<CategoryEntity>? categoryDetails, String? errorMessage}) {
    return CategoryState(categoryDetails ?? this.categoryDetails, errorMessage);
  }

  @override
  List<Object?> get props => [categoryDetails, errorMessage];
}
