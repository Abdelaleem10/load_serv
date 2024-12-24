import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_task/common/base/async.dart';
import 'package:loadserv_task/common/data/di/app_injector.dart';
import 'package:loadserv_task/common/presentation/utils/bloc_utils.dart';
import 'package:loadserv_task/product/domain/use_case/get_category_use_case.dart';
import 'package:loadserv_task/product/domain/use_case/get_product_details_use_case.dart';
import 'package:loadserv_task/product/presentation/manager/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryState.initial()) {
    _loadInjectors();
  }

  late final GetCategoryUseCase _getCategoryUseCase;
  late final GetProductDetailsUseCase _getProductDetailsUseCase;

  void _loadInjectors() {
    _getCategoryUseCase = injector();
    _getProductDetailsUseCase = injector();
  }

  Future<void> getCategoryDetails() async {
    emit(state.reduce(categoryDetails: const Async.loading()));
    await collect(
      task: () async {
        final data = await _getCategoryUseCase.execute();
        emit(state.reduce(categoryDetails: Async.success(data)));
      },
      onError: (errorMessage) {
        emit(state.reduce(
            errorMessage: errorMessage,
            categoryDetails: Async.failure(errorMessage)));
      },
    );
  }


  Future<void> getProductDetails(String productId) async {
    emit(state.reduce(productDetails: const Async.loading()));
    await collect(
      task: () async {
        final data = await _getProductDetailsUseCase.execute(productId);
        emit(state.reduce(productDetails: Async.success(data)));
      },
      onError: (errorMessage) {
        emit(state.reduce(
            productDetails: Async.failure(errorMessage)));
      },
    );
  }

}
