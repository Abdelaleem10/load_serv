import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';

class AppToast {
  AppToast._();

  static addToCartToast(FToast toast) {
    toast.removeCustomToast();
    toast.showToast(
        child: _cartToast(),
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 2));
  }
}

Widget _cartToast() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.orangeColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            "item add to cart",
            style: TextStyles.bold(color: Colors.white),
          ),
        ],
      ),
    );

