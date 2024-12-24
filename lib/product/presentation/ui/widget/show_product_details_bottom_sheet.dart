import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_task/common/presentation/ui/widgets/failure_page.dart';
import 'package:loadserv_task/common/presentation/ui/widgets/loading_widget.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/buttons/custom_buttons.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';
import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';
import 'package:loadserv_task/product/presentation/manager/category_cubit.dart';
import 'package:loadserv_task/product/presentation/manager/category_state.dart';
import 'package:loadserv_task/product/presentation/ui/widget/custom_product_card.dart';

class ShowProductDetailsBottomSheet extends StatefulWidget {
  final String productId;

  const ShowProductDetailsBottomSheet({super.key, required this.productId});

  @override
  State<ShowProductDetailsBottomSheet> createState() =>
      _ShowProductDetailsBottomSheetState();
}

class _ShowProductDetailsBottomSheetState
    extends State<ShowProductDetailsBottomSheet> {
  int _selectedIndex = 0;
  List<AdditionPriceEntity> _selectedAdditionList = [];
  List<ExtraItemEntity> _extraItems = [];
  final ValueNotifier<int> _totalAmount = ValueNotifier(0);
  final ValueNotifier<int> _numberOfPiecesListener = ValueNotifier(1);

  final ValueNotifier<int> _additionNumbersNotifier = ValueNotifier(0);
  CartProductEntityEntity _totalPrice = CartProductEntityEntity.initial();

  void _getData() => BlocProvider.of<CategoryCubit>(context)
      .getProductDetails(widget.productId);

  void _collectAddition(int index, int numbers, int listLength, int price) {
    if (_selectedAdditionList.isEmpty) {
      _selectedAdditionList = List.generate(listLength, (index) {
        return AdditionPriceEntity.initial();
      });

      _additionNumbersNotifier.value = 1;

      _getTotalPrice(
          addition: [AdditionPriceEntity(numbers: 1, price: price)],
          extraItems: _extraItems);
    } else {
      _selectedAdditionList[index].numbers = numbers;
      _selectedAdditionList[index].price = price;
      _additionNumbersNotifier.value = 0;
      _getTotalPrice(addition: _selectedAdditionList, extraItems: _extraItems);
    }
    _selectedAdditionList = _selectedAdditionList.map((e) {
      _additionNumbersNotifier.value =
          _additionNumbersNotifier.value + e.numbers;

      return e;
    }).toList();
  }

  void _getTotalPrice(
      {int? productPrice,
      List<AdditionPriceEntity>? addition,
      List<ExtraItemEntity>? extraItems}) {
    _totalPrice = _totalPrice.modify(
      productPrice: productPrice,
      numberOfPieces: _numberOfPiecesListener.value,
    );

    _totalAmount.value = collectedProductPrice(_totalPrice,
        addition: addition, extraItems: extraItems);
  }

  int collectedProductPrice(CartProductEntityEntity item,
      {List<AdditionPriceEntity>? addition,
      List<ExtraItemEntity>? extraItems}) {
    int priceWithoutAddition = item.productPrice * item.numberOfPieces;

    for (int i = 0; i < (addition?.length ?? 0); i++) {
      int additionPrice = (addition![i].price) * (addition[i].numbers);
      priceWithoutAddition = priceWithoutAddition + additionPrice;
    }
    for (int i = 0; i < (extraItems?.length ?? 0); i++) {
      if (extraItems![i].isChoose) {
        int additionPrice = (extraItems[i].price ?? 0);
        priceWithoutAddition = priceWithoutAddition + additionPrice;
      }
    }

    return priceWithoutAddition;
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state.productDetails.isLoading) {
          return const LoadingWidget();
        }
        if (state.productDetails.isFailure) {
          return FailurePage(onPressed: _getData);
        }
        if (state.productDetails.isSuccess) {
          _getTotalPrice(
              productPrice:
                  state.productDetails.data?.weights[_selectedIndex].price ?? 0,
              addition: _selectedAdditionList,
              extraItems: _extraItems);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ValueListenableBuilder(
                  valueListenable: _numberOfPiecesListener,
                  builder: (context, value, child) {
                    return CustomProductCard(
                      image: state.productDetails.data?.image,
                      name: state.productDetails.data?.name,
                      oldPrice: 0,
                      price: 10,
                      isAdditional: false,
                      valueTrigger: (numbers) {
                        _numberOfPiecesListener.value = numbers;
                        _getTotalPrice(
                            addition: _selectedAdditionList,
                            extraItems: _extraItems);
                      },
                      defaultValue: _numberOfPiecesListener.value,
                    );
                  },
                ),
                const SizedBox(height: 20),
                if (state.productDetails.data?.weights.isNotEmpty ?? false) ...[
                  const Text(
                    'Weights',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  StatefulBuilder(
                    builder: (context, set) {
                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                            state.productDetails.data?.weights.length ?? 0,
                            (index) {
                          return weightComponent(
                            state.productDetails.data?.weights[index].name ??
                                '',
                            state.productDetails.data?.weights[index].price
                                    .toString() ??
                                '',
                            index,
                            _selectedIndex,
                            click: (index) {
                              set(() {
                                _getTotalPrice(
                                    productPrice: state.productDetails.data
                                        ?.weights[index].price,
                                    addition: _selectedAdditionList,
                                    extraItems: _extraItems);
                                _selectedIndex = index;
                              });
                            },
                          );
                        }),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
                ValueListenableBuilder(
                  valueListenable: _additionNumbersNotifier,
                  builder: (context, value, child) {
                    return Text(
                      'Addition (select ${_additionNumbersNotifier.value.toString()}):',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                ),
                if (state.productDetails.data?.salads.isNotEmpty ?? false) ...[
                  const SizedBox(height: 10),
                  ValueListenableBuilder(
                    valueListenable: _additionNumbersNotifier,
                    builder: (context, value, child) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.productDetails.data?.salads.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomProductCard(
                            image:
                                state.productDetails.data?.salads[index].image,
                            name: state.productDetails.data?.salads[index].name,
                            price:
                                state.productDetails.data?.salads[index].price,
                            isAdditional: true,
                            valueTrigger: (int numbers) {
                              _collectAddition(
                                index,
                                numbers,
                                state.productDetails.data?.salads.length ?? 0,
                                state.productDetails.data?.salads[index]
                                        .price ??
                                    0,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
                if (state.productDetails.data?.extraItems.isNotEmpty ??
                    false) ...[
                  const Text(
                    'Extras:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  StatefulBuilder(
                    builder: (context, set) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            state.productDetails.data?.extraItems.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return extrasComponent(
                            click: (index) {
                              set(() {
                                state.productDetails.data?.extraItems[index]
                                    .isChoose = !(state.productDetails.data
                                        ?.extraItems[index].isChoose ??
                                    true);
                                _extraItems =
                                    state.productDetails.data?.extraItems ?? [];
                              });
                              _getTotalPrice(
                                  addition: _selectedAdditionList,
                                  extraItems: _extraItems);
                            },
                            item: state.productDetails.data?.extraItems[index],
                            index: index,
                          );
                        },
                      );
                    },
                  ),
                ],
                ValueListenableBuilder(
                  valueListenable: _totalAmount,
                  builder: (context, value, child) {
                    return PrimaryButton(
                        firstTitle: "Add To Cart",
                        secondTitle: _totalAmount.value.toString());
                  },
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget weightComponent(
      String label, String price, int index, int selectedValue,
      {void Function(int index)? click}) {
    return InkWell(
      splashColor: Colors.white,
      onTap: () {
        if (click != null) {
          click(index);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: TextStyles.bold(fontSize: Dimensions.large)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                price,
                style: TextStyles.regular(fontSize: Dimensions.large),
              ),
            ),
            selectedValue == index
                ? const Icon(
                    Icons.check_circle,
                    color: AppColors.orangeColor,
                    size: 20,
                  )
                : const Icon(
                    Icons.radio_button_unchecked_rounded,
                    color: Colors.black,
                    size: 20,
                  )
          ],
        ),
      ),
    );
  }

  Widget extrasComponent(
      {void Function(int index)? click,
      required ExtraItemEntity? item,
      required int index}) {
    return InkWell(
      splashColor: Colors.white,
      onTap: () {
        if (click != null) {
          click(index);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: PaddingDimensions.normal),
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingDimensions.xLarge),
                child: Text(item?.name ?? 'Sesame Paste Salad',
                    style: TextStyles.bold(fontSize: Dimensions.large)),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingDimensions.xLarge),
                child: Text(
                  item?.price.toString() ?? '',
                  style: TextStyles.bold(fontSize: Dimensions.large),
                ),
              ),
              item?.isChoose == true
                  ? const Icon(
                      Icons.check_box,
                      color: AppColors.orangeColor,
                      size: 24,
                    )
                  : const Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.black,
                      size: 24,
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget extraOption(String label, String price, bool selected) {
    return Row(
      children: [
        Expanded(
          child: Text(label),
        ),
        Text(price),
        Checkbox(
          value: selected,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
