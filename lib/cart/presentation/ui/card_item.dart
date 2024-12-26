import 'package:flutter/material.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/bottom_sheets/show_bottom_sheet_common.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';
import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';
import 'package:loadserv_task/product/presentation/ui/widget/custome_widgets.dart';

class CardItem extends StatefulWidget {
  final CartProductEntity item;
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
    if (widget.defaultValue != null) {
      _numbers.value = widget.defaultValue!;
    }
    super.initState();
  }
void _whenComplete(){

}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CommonBottomSheet.openProductDetailsSheet(context, widget.item.id,
        cartItem: widget.item,
        whenComplete:_whenComplete );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 4.4,
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
                        widget.item.image ??
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
                                      widget.item.name ??
                                          'Grilled Steak, with Boiled Basmati Rice And Salad',
                                      style: TextStyles.bold(
                                        fontSize: Dimensions.xLarge,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    if (widget.item.weightName?.isNotEmpty ??
                                        false) ...[
                                      _customRow(
                                          title: 'Weight',
                                          description:
                                              widget.item.weightName ?? '').paddingFromBottom,

                                    ],
                                    if (widget
                                        .item.additionsNumber!=0) ...[
                                      _customRow(
                                          title: 'Salads',
                                          description:
                                              '${widget.item.additionsNumber} items').paddingFromBottom,
                                    ],
                                    if (widget.item.extrasNumber!=0) ...[
                                      _customRow(
                                          title: 'Extras',
                                          description:
                                              '${widget.item.extrasNumber} items').paddingFromBottom,
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
                                        icon: Icons.add,
                                        size: 18,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
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
                                    const Spacer(),
                                    InkWell(
                                      splashColor: Colors.white,
                                      onTap: _decreasePieces,
                                      child: const CustomIcon(
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
                              child: _boldText(widget.item.totalPrice.toString()),
                            ),
                            const Spacer(),
                            Image.asset(
                              "assets/images/note.png",
                              scale: 4,
                            ),
                            const Spacer(),
                            Image.asset(
                              "assets/images/chat.png",
                              scale: 4,
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
  Widget get paddingFromBottom =>
     Padding(
      padding: const EdgeInsets.only(bottom: PaddingDimensions.small),
      child: this,
    );

}