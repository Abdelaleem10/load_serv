import 'package:flutter/material.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final double? borderRadius;
  final Color? color;
  final double? padding;
  final Gradient? gradient;

  const CustomIcon(
      {super.key,
      required this.icon,
      this.size,
      this.borderRadius,
      this.color,
        this.padding,
        this.gradient,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PaddingDimensions.normal,
      ),
      child: Container(
        padding:  EdgeInsets.all(
          padding??  PaddingDimensions.small,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            gradient:gradient,
            color: AppColors.orangeColor),
        child: Icon(
          icon,
          color: color ?? Colors.white,
          size: size,
        ),
      ),
    );
  }
}
