import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';

class CustomScrollbarWidget extends StatelessWidget {
  final Widget child;
  final ScrollController scrollController;
  final bool? isHome;
  final Color? scrollbarColor;
  final bool? withoutPadding;
  final Gradient? scrollbarGradientColor;
  final double? width;
  const CustomScrollbarWidget(
      {super.key,
      required this.child,
      required this.scrollController,
      this.isHome,
      this.scrollbarColor,
      this.withoutPadding,
      this.scrollbarGradientColor,
      this.width,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:(withoutPadding==true) ?EdgeInsets.zero:  const EdgeInsets.symmetric(
          vertical: PaddingDimensions.xLarge,
          ),
      child: AdaptiveScrollbar(
        position:
           ScrollbarPosition.right,
        controller: scrollController,
        underSpacing:
        (withoutPadding==true) ? EdgeInsets.zero:  const EdgeInsets.symmetric(horizontal: PaddingDimensions.small),
        sliderSpacing: const EdgeInsets.all(0.0),
        width: width ??6,
        underDecoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(PaddingDimensions.normal))),
        sliderDecoration: BoxDecoration(

          // color: Colors.white,
          color: scrollbarColor ?? AppColors.orangeColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(PaddingDimensions.normal),
          ),
        ),
        child: child,
      ),
    );
  }
}
