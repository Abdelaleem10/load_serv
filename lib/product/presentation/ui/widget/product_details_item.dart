import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loadserv_task/cart/presentation/manager/cart_cubit.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/buttons/custom_buttons.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';
import 'package:loadserv_task/common/presentation/utils/toasts/add_to_cart_toast.dart';
import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/presentation/ui/widget/custom_product_card.dart';

class ProductDetailsItem extends StatefulWidget {
  final ProductDetailsEntity item;
  final bool fromCart;

  const ProductDetailsItem(
      {super.key, required this.item, required this.fromCart});

  @override
  State<ProductDetailsItem> createState() => _ProductDetailsItemState();
}

class _ProductDetailsItemState extends State<ProductDetailsItem> {
  late ProductDetailsEntity _item;

  late FToast fToast;

  @override
  void initState() {
    _item = widget.item;
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);

                },
                child: const Icon(Icons.close,
                color: AppColors.grayColor,
                size: 18,),
              ),
            ],
          ),
          const SizedBox(
            height: PaddingDimensions.xLarge,
          ),
          CustomProductCard(
            image: _item.image,
            name: _item.name,
            oldPrice: 10,
            price: _item.weights.isEmpty?  _item.productPrice :null,
            isAdditional: false,
            valueTrigger: (numbers) {
              setState(() {
                _item = _item.modify(numberOfPieces: numbers);
              });
            },
            defaultValue: _item.numberOfPieces,
          ),
          if (_item.weights.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: PaddingDimensions.large),
              child: Text(
                'Weights',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(_item.weights.length, (index) {
                return weightComponent(
                  _item.weights[index].name ?? '',
                  _item.weights[index].price.toString(),
                  index,
                  _item.weights
                      .indexWhere((e) => e.id == _item.choosesWeight?.id),
                  click: (index) {
                    setState(() {
                      _item = _item.modify(choosesWeight: _item.weights[index]);
                    });
                  },
                );
              }),
            ),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: PaddingDimensions.large),
            child: Text(
              'Addition (select ${_item.additionNumbers}):',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (_item.salads.isNotEmpty) ...[
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _item.salads.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CustomProductCard(
                  image: _item.salads[index].image,
                  name: _item.salads[index].name,
                  price: _item.salads[index].price,
                  isAdditional: true,
                  defaultValue: _item.salads[index].numberOfPieces,
                  valueTrigger: (int numbers) {
                    setState(() {
                      _item = _item.modify(
                        salads: _item.salads.map((e) {
                          if (e.id == _item.salads[index].id) {
                            return e.modify(
                              numberOfPieces: numbers,
                            );
                          }
                          return e;
                        }).toList(),
                      );
                      _collectAddition(_item);
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
          if (_item.extraItems.isNotEmpty) ...[
            const Text(
              'Extras:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            StatefulBuilder(
              builder: (context, set) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _item.extraItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return extrasComponent(
                      click: (index) {
                        setState(() {
                          _item = _item.modify(
                            extraItems: _item.extraItems.map((e) {
                              if (e.id == _item.extraItems[index].id) {
                                return e.modify(
                                  isChoose:
                                      (!(_item.extraItems[index].isChoose ??
                                          false)),
                                );
                              }
                              return e;
                            }).toList(),
                          );
                          _collectExtraNumbers(_item);
                        });
                      },
                      item: _item.extraItems[index],
                      index: index,
                    );
                  },
                );
              },
            ),
          ],
          widget.fromCart
              ? InkWell(
                  child: DefaultButton(
                      onTap: _caveChanges,
                      firstTitle: "Save Changes",
                      secondTitle: collectedProductPrice().toString()),
                )
              : InkWell(
                  child: DefaultButton(
                      onTap: _addProductToCart,
                      firstTitle: "Add To Cart",
                      secondTitle: collectedProductPrice().toString()),
                ),
        ],
      ),
    );
  }

  void _caveChanges() {
    _addingItem();
    Navigator.pop(context);
  }

  int collectedProductPrice() {
    int total = 0;
    if (_item.weights.isNotEmpty) {

      if (_item.choosesWeight == null) {
        total = (_item.weights.first.price ?? 1) * _item.numberOfPieces;
      } else {
        total = (_item.choosesWeight?.price ?? 1) * _item.numberOfPieces;
      }
    } else {
      print('aaaa${_item.productPrice} ${_item.numberOfPieces}');

      total = _item.productPrice * _item.numberOfPieces;
    }

    for (int i = 0; i < (_item.salads.length); i++) {
      int additionPrice =
          (_item.salads[i].price ?? 1) * (_item.salads[i].numberOfPieces);
      total = total + additionPrice;
    }
    for (int i = 0; i < (_item.extraItems.length); i++) {
      if ((_item.extraItems[i].isChoose ?? false)) {
        int additionPrice = (_item.extraItems[i].price ?? 0);
        total = total + additionPrice;
      }
    }
    setState(() {
      _item = _item.modify(totalPrice: total);
    });

    return total;
  }

  void _collectAddition(ProductDetailsEntity entity) {
    int total = 0;
    for (int i = 0; i < entity.salads.length; i++) {
      total = total + entity.salads[i].numberOfPieces;
    }
    _item = _item.modify(additionNumbers: total);
  }

  void _collectExtraNumbers(ProductDetailsEntity entity) {
    int total = 0;
    for (int i = 0; i < entity.extraItems.length; i++) {
      if (entity.extraItems[i].isChoose == true) {
        total = total + 1;
      }
    }
    _item = _item.modify(extraNumbers: total);
  }

  void _addingItem() => BlocProvider.of<CartCubit>(context).addToCart(_item);

  void _addProductToCart() {
    _addingItem();
    AppToast.addToCartToast(fToast);
    Navigator.pop(context);
  }

  Widget weightComponent(
      String label, String price, int index, int selectedValue,
      {void Function(int index)? click}) {
    if (selectedValue < 0) {
      selectedValue = 0;
    }
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
                "$price EGP",
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

  Widget extrasComponent({
    void Function(int index)? click,
    required ExtraItemEntity? item,
    required int index,
  }) {
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
