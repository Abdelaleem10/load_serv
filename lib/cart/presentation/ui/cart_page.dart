import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_task/cart/presentation/manager/cart_cubit.dart';
import 'package:loadserv_task/cart/presentation/manager/cart_state.dart';
import 'package:loadserv_task/cart/presentation/ui/card_item.dart';
import 'package:loadserv_task/cart/presentation/utils/modify_cart_item_subscription.dart';
import 'package:loadserv_task/common/presentation/ui/widgets/custom_app_bar_icon.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/buttons/custom_buttons.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';
import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';
import 'package:rxdart/utils.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Cart Screen",
          style: TextStyles.bold(
              color: Colors.black, fontSize: Dimensions.xxxxxLarge),
        ),
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const CustomAppBarIcon(
              icon: Icons.arrow_back,
              useShadow: true,
            )),
        actions: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CustomAppBarIcon(
                icon: Icons.menu,
                useShadow: true,
              )),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.cartList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Cart Empty",
                    style: TextStyles.bold(fontSize: Dimensions.xxxLarge),
                  ),
                  const SizedBox(
                    height: PaddingDimensions.large,
                  ),
                  PrimaryButton(
                    title: "Products page",
                    color: AppColors.orangeColor,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: PaddingDimensions.xxLarge,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CardItem(
                          key: ValueKey(state.cartList[index]),
                          item: state.cartList[index],
                          defaultValue: state.cartList[index].numberOfPieces,
                          valueTrigger: (numbers) {
                            _modifyItem(
                              state.cartList[index]
                                  .modify(numberOfPieces: numbers),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: PaddingDimensions.large,
                            horizontal: PaddingDimensions.large),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DefaultButton(
                              firstTitle: "Check out",
                              secondTitle: "${state.checkOutPrice} EGP",
                              onTap: () {},
                            ),
                            InkWell(
                                onTap: _deleteAllCart,
                                child: PrimaryButton(
                                  title: "Delete All",
                                  onTap: _deleteAllCart,
                                )),
                            const SizedBox(
                              height: PaddingDimensions.large,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _modifyItem(ProductDetailsEntity item) {
    BlocProvider.of<CartCubit>(context).modifyProduct(item);
  }

  void _deleteAllCart() => BlocProvider.of<CartCubit>(context).deleteCart();
}
