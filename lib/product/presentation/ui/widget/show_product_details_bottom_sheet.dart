import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_task/common/presentation/ui/widgets/failure_page.dart';
import 'package:loadserv_task/common/presentation/ui/widgets/loading_widget.dart';
import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/presentation/manager/category_cubit.dart';
import 'package:loadserv_task/product/presentation/manager/category_state.dart';
import 'package:loadserv_task/product/presentation/ui/widget/product_details_item.dart';

class ShowProductDetailsBottomSheet extends StatefulWidget {
  final ProductDetailsEntity? cartItem;
  final String productId;

  const ShowProductDetailsBottomSheet(
      {super.key, required this.productId, this.cartItem});

  @override
  State<ShowProductDetailsBottomSheet> createState() =>
      _ShowProductDetailsBottomSheetState();
}

class _ShowProductDetailsBottomSheetState
    extends State<ShowProductDetailsBottomSheet> {
  void _getData() => BlocProvider.of<CategoryCubit>(context)
      .getProductDetails(widget.productId);

  @override
  void initState() {
    if (widget.cartItem == null) {
      _getData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cartItem == null) {
      return BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state.productDetails.isLoading) {
            return const LoadingWidget();
          }
          if (state.productDetails.isFailure) {
            return FailurePage(onPressed: _getData);
          }
          if (state.productDetails.isSuccess) {
            return ProductDetailsItem(
              item: state.productDetails.data ?? ProductDetailsEntity.initial(),
              fromCart: false,
            );
          }
          return const SizedBox.shrink();
        },
      );
    }
    return ProductDetailsItem(
      item: widget.cartItem ?? ProductDetailsEntity.initial(),
      fromCart: true,
    );
  }
}
