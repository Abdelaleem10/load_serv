import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_task/cart/presentation/manager/cart_cubit.dart';
import 'package:loadserv_task/common/base/app_text_fields/app_text_form_field.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/bottom_sheets/show_bottom_sheet_common.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';
import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';
import 'package:loadserv_task/product/presentation/ui/widget/custome_widgets.dart';

class CardItem extends StatefulWidget {
  final ProductDetailsEntity item;
  final void Function(int numbers) valueTrigger;
  final int? defaultValue;

  const CardItem(
      {super.key,
      required this.item,
      required this.valueTrigger,
      this.defaultValue});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  final ValueNotifier<int> _numbers = ValueNotifier(0);

  late ProductDetailsEntity _item;
  final TextEditingController _noteController = TextEditingController();

  void _increasePieces() {
    _numbers.value += 1;
    widget.valueTrigger(_numbers.value);
  }

  void _decreasePieces() {
    if (_numbers.value > 1) {
      _numbers.value -= 1;
      widget.valueTrigger(_numbers.value);
    }
  }

  @override
  void initState() {
    _item = widget.item;

    if (widget.defaultValue != null) {
      _numbers.value = widget.defaultValue!;
    }
    _noteController.text = _item.notes ?? '';
    super.initState();
  }

  void _whenComplete() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CommonBottomSheet.openProductDetailsSheet(
            context, widget.item.id.toString(),
            cartItem: widget.item, whenComplete: _whenComplete);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3.6,
          child: Card(
            // shadowColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: PaddingDimensions.normal),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.network(
                        _item.image ??
                            "https://www.trendapp.org/test-project/public/storage/product/1728285739_67038c2be6775.jpg",
                        height: MediaQuery.of(context).size.height / 4.4,
                        width: MediaQuery.of(context).size.width / 3,
                        // width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.start,
                                      _item.name ??
                                          'Grilled Steak, with Boiled Basmati Rice And Salad',
                                      style: TextStyles.bold(
                                        fontSize: Dimensions.xLarge,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    if (_item.choosesWeight != null) ...[
                                      _customRow(
                                              title: 'Weight',
                                              description:
                                                  _item.choosesWeight?.name ??
                                                      '')
                                          .paddingFromBottom,
                                    ],
                                    if (_item.additionNumbers != 0) ...[
                                      _customRow(
                                              title: 'Salads',
                                              description:
                                                  '${_item.additionNumbers} items')
                                          .paddingFromBottom,
                                    ],
                                    if (_item.extraItems
                                        .any((e) => e.isChoose == true)) ...[
                                      _customRow(
                                              title: 'Extras',
                                              description:
                                                  '${_item.extraNumbers} items')
                                          .paddingFromBottom,
                                    ],
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: PaddingDimensions.large),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.white,
                                      onTap: _increasePieces,
                                      child: const CustomIcon(
                                        gradient: AppColors.iconGradient,
                                        icon: Icons.add,
                                        size: 18,
                                      ),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width / 8,
                                        child: ValueListenableBuilder(
                                          valueListenable: _numbers,
                                          builder: (context, value, child) {
                                            return Center(
                                              child: Text(
                                                _numbers.value.toString(),
                                                style: TextStyles.medium(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      splashColor: Colors.white,
                                      onTap: _decreasePieces,
                                      child: const CustomIcon(
                                        gradient: AppColors.iconGradient,
                                        icon: Icons.remove,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child:
                                  _boldText(widget.item.totalPrice.toString()),
                            ),
                            const Spacer(),
                            Image.asset(
                              "assets/images/done_note.png",
                              scale: 3,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                _showAlert();
                              },
                              child: Image.asset(
                                _item.notes != null
                                    ? "assets/images/chat.png"
                                    : "assets/images/note.png",
                                scale: 3,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAlert() {
    if ((_item.notes?.isEmpty ?? true)) {
      _noteController.text = '';
    } else {
      _noteController.text = _item.notes!;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Dialog(
              insetPadding: const EdgeInsets.all(
                PaddingDimensions.xxLarge,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingDimensions.xxLarge,
                    vertical: PaddingDimensions.xLarge),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Add Note",
                        style: TextStyles.bold(
                            color: Colors.black, fontSize: Dimensions.xLarge),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: PaddingDimensions.large),
                      child: AppTextFormField(
                        controller: _noteController,
                        maxLines: 5,
                        fillColor: Colors.grey.withOpacity(.1),
                        borderColor: AppColors.grayColor,
                        hint: "",
                        hintStyle: TextStyles.medium(
                            fontSize: Dimensions.large,
                            color: AppColors.grayColor),
                        focusBorderColor: AppColors.grayColor,
                        textFieldType: TextFieldType.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PaddingDimensions.large,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black45,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: PaddingDimensions.medium,
                                      horizontal: PaddingDimensions.large),
                                  child: Center(
                                      child: Text(
                                    "cancel",
                                    style: TextStyles.bold(
                                        color: Colors.white,
                                        fontSize: Dimensions.large),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: PaddingDimensions.xxLarge,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (_noteController.text.trim().isNotEmpty) {
                                    _item = _item.modify(
                                        notes: _noteController.text);
                                    BlocProvider.of<CartCubit>(context)
                                        .modifyProduct(_item);

                                    Navigator.pop(context);
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),

                                  color: AppColors
                                      .orangeColor, // Semi-transparent overlay
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: PaddingDimensions.medium,
                                      horizontal: PaddingDimensions.large),
                                  child: Center(
                                      child: Text(
                                    "confirm",
                                    style: TextStyles.bold(
                                        color: Colors.white,
                                        fontSize: Dimensions.large),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }

  Widget _customRow({required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _boldText("$title:"),
          const SizedBox(
            width: 4,
          ),
          _regularText(description),
        ],
      ),
    );
  }

  Widget _boldText(String title) {
    return Text(
      title,
      style: TextStyles.semiBold(
        color: Colors.black,
        fontSize: Dimensions.xLarge,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _regularText(String title) {
    return Expanded(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.regular(
            color: AppColors.grayColor, fontSize: Dimensions.xLarge),
      ),
    );
  }
}

extension PaddingFromOneSide on Widget {
  Widget get paddingFromBottom => Padding(
        padding: const EdgeInsets.only(bottom: PaddingDimensions.small),
        child: this,
      );
}
