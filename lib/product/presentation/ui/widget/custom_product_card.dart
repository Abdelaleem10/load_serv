import 'package:flutter/material.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';
import 'package:loadserv_task/product/presentation/ui/widget/custome_widgets.dart';

class CustomProductCard extends StatefulWidget {
  final String? image;
  final String? name;
  final int? price;
  final int? oldPrice;
  final bool isAdditional;
  final void Function(int numbers) valueTrigger;
  final int? defaultValue;

  const CustomProductCard(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      this.oldPrice,
      required this.isAdditional,
      required this.valueTrigger,
      this.defaultValue});

  @override
  State<CustomProductCard> createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> {
  final ValueNotifier<int> _numbers = ValueNotifier(0);

  void _increasePieces() {
    _numbers.value += 1;
    widget.valueTrigger(_numbers.value);
  }

  void _decreasePieces() {
    if (_numbers.value > 0) {
      if (widget.isAdditional) {
        _numbers.value -= 1;
      } else {
        if (_numbers.value > 1) {
          _numbers.value -= 1;
        }
      }
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

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: PaddingDimensions.normal,
                horizontal: PaddingDimensions.normal),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: Image.network(
                widget.image ??
                    "https://www.trendapp.org/test-project/public/storage/product/1728285739_67038c2be6775.jpg",
                height: widget.isAdditional ? 60 : 120,
                width: widget.isAdditional ? 60 : 120,
                // width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              widget.name ??
                                  'Grilled Steak, with Boiled Basmati Rice And Salad',
                              style: TextStyles.bold(
                                fontSize: widget.isAdditional
                                    ? Dimensions.large
                                    : Dimensions.xxLarge,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              if (widget.isAdditional == false) ...[
                                Text(
                                  (widget.oldPrice ?? '400 EGP').toString(),
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                              const SizedBox(height: PaddingDimensions.small),
                              Text(
                                ((widget.price) ?? '178 EGP').toString(),
                                style: TextStyles.semiBold(
                                    color: Colors.black,
                                    fontSize: widget.isAdditional
                                        ? Dimensions.large
                                        : Dimensions.xLarge),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                splashColor: Colors.white,
                                onTap: _increasePieces,
                                child: CustomIcon(
                                  icon: Icons.add,
                                  size: widget.isAdditional ? 14 : 18,
                                ),
                              ),
                              // Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 8,
                                child: ValueListenableBuilder(
                                  valueListenable: _numbers,
                                  builder: (context, value, child) {
                                    return Center(
                                      child: Text(
                                        _numbers.value.toString(),
                                        style: TextStyles.medium(
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Spacer(),

                              InkWell(
                                splashColor: Colors.white,
                                onTap: _decreasePieces,
                                child: CustomIcon(
                                  icon: Icons.remove,
                                  size: widget.isAdditional ? 14 : 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
