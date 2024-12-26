import 'package:flutter/material.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';

class DefaultButton extends StatelessWidget {
  final String firstTitle;
  final String secondTitle;
  final void Function() onTap;

  const DefaultButton({super.key, required this.firstTitle, required this.secondTitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: PaddingDimensions.large),
        child: Container(
            decoration: BoxDecoration(
              color: AppColors.orangeColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.orangeColor,
                width: 2,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: PaddingDimensions.large,
                horizontal: PaddingDimensions.normal,
              ),
              child: Row(
                children: [
                  _staticTextComponent(firstTitle),
                  const Spacer(),
                  _staticTextComponent(secondTitle)
                ],
              ),
            )),
      ),
    );
  }

}
class PrimaryButton extends StatelessWidget {
  final String title;
  final Color? color;
  final void Function() onTap;

  const PrimaryButton({super.key, required this.title,  this.color, required this.onTap});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: color?? AppColors.binkColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.orangeColor,
              width: 2,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: PaddingDimensions.large,
              horizontal: PaddingDimensions.normal,
            ),
            child: Center(child: _staticTextComponent(title)),
          )),
    );
  }


}
Widget _staticTextComponent(String title) => Text(
  title,
  style: TextStyles.bold(color: Colors.white),
);
