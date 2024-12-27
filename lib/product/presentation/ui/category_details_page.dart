import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_task/cart/presentation/ui/cart_page.dart';
import 'package:loadserv_task/common/presentation/ui/widgets/failure_page.dart';
import 'package:loadserv_task/common/presentation/ui/widgets/loading_widget.dart';
import 'package:loadserv_task/common/presentation/utils/bottom_sheets/show_bottom_sheet_common.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';
import 'package:loadserv_task/product/domain/entity/product_entity.dart';
import 'package:loadserv_task/product/presentation/manager/category_cubit.dart';
import 'package:loadserv_task/product/presentation/manager/category_state.dart';
import 'package:loadserv_task/product/presentation/ui/widget/category_header.dart';
import 'package:loadserv_task/product/presentation/ui/widget/custome_widgets.dart';
import 'package:loadserv_task/product/presentation/ui/widget/product_component.dart';
import 'package:loadserv_task/product/presentation/ui/widget/search_component.dart';

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({super.key});

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  void _retry() => BlocProvider.of<CategoryCubit>(context).getCategoryDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
          child: const CustomIcon(
            icon: Icons.shopping_cart_outlined,
            color: Colors.white,
            borderRadius: 24,
            size: 32,
            padding: PaddingDimensions.normal,
          ),
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
          if (state.categoryDetails.isSuccess) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CategoryHeader(
                    item:
                        state.categoryDetails.data ?? CategoryEntity.initial(),
                  ),
                  const SearchComponent(),
                   const SizedBox(
                    height: PaddingDimensions.normal,
                  ),
                  Flexible(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // number of items in each row
                              mainAxisSpacing: 20.0, // spacing between rows
                              crossAxisSpacing: 20.0,
                              childAspectRatio: .81 // spacing between columns
                              ),
                      padding: const EdgeInsets.all(8.0),
                      // padding around the grid
                      itemCount: state.categoryDetails.data?.products.length,
                      // total number of items
                      itemBuilder: (context, index) {
                        return ProductComponent(
                          onTapCard: () {
                            CommonBottomSheet.openProductDetailsSheet(context,
                                (state.categoryDetails.data?.products[index].id??'113').toString());

                          },
                          item: state.categoryDetails.data?.products[index] ??
                              const ProductEntity.initial(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: PaddingDimensions.x6Large,
                  ),
                ],
              ),
            );
          }
          if (state.categoryDetails.isLoading) {
            return const LoadingWidget();
          }
          if (state.categoryDetails.isFailure) {
            return FailurePage(onPressed: _retry);
          }

          return const SizedBox.shrink();
        }));
  }
}
