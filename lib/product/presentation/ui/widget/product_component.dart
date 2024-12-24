import 'package:flutter/material.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';
import 'package:loadserv_task/product/domain/entity/product_entity.dart';
import 'package:loadserv_task/product/presentation/ui/widget/custome_widgets.dart';

class ProductComponent extends StatefulWidget {
  final ProductEntity item;
  final void Function()? onTapCard;

  const ProductComponent({super.key, required this.item, this.onTapCard});

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTapCard,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        widget.item.image ?? '', // Replace with your image URL
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            widget.item.name ?? 'name',
                            style: TextStyles.bold(
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: PaddingDimensions.normal),
                            child: Text(
                              widget.item.description ?? 'description',
                              style: TextStyles.regular(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(24)),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 28,
                    margin: const EdgeInsets.only(top: 8.0),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(4, 0),
                        ),
                      ],
                    ),
                    // color: Colors.red,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ((widget.item.price == 0))
                                ? Text(
                                    "price upon selection",
                                    style: TextStyles.regular(
                                      color: AppColors.orangeColor,
                                      fontSize: Dimensions.large,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                : Text(
                                    "\$${widget.item.price}",
                                    style: TextStyles.bold(
                                      color: AppColors.orangeColor,
                                      fontSize: Dimensions.xxLarge,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
                bottom: 18,
                child: CustomIcon(
                  icon: Icons.add,
                  size: 22,
                  borderRadius: 10,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
