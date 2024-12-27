import 'package:flutter/material.dart';
import 'package:loadserv_task/product/domain/entity/product_deatils_entity.dart';
import 'package:loadserv_task/product/domain/entity/product_total_price_entity.dart';
import 'package:loadserv_task/product/presentation/ui/widget/show_product_details_bottom_sheet.dart';

class CommonBottomSheet {
  CommonBottomSheet._();

  static void openProductDetailsSheet(BuildContext context,String productId,{ProductDetailsEntity? cartItem,

  void Function()? whenComplete}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height/1.1,
            child: ShowProductDetailsBottomSheet(productId: productId,cartItem:cartItem ,));
      },
    ).whenComplete((){
      if(whenComplete!=null) {
        whenComplete();
      }
    });
  }
}
