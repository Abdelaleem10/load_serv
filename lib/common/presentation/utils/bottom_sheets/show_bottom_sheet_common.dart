import 'package:flutter/material.dart';
import 'package:loadserv_task/product/presentation/ui/widget/show_product_details_bottom_sheet.dart';

class CommonBottomSheet {
  CommonBottomSheet._();

  static void openProductDetailsSheet(BuildContext context,String productId) {
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
            height: MediaQuery.of(context).size.height/1.2,
            child: ShowProductDetailsBottomSheet(productId: productId,));
      },
    );
  }
}
