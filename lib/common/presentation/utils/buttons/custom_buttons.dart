import 'package:flutter/material.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';

class PrimaryButton extends StatelessWidget {
  final String firstTitle;
  final String secondTitle;

  const PrimaryButton({super.key, required this.firstTitle, required this.secondTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }

  Widget _staticTextComponent(String title) => Text(
        title,
        style: TextStyles.bold(color: Colors.white),
      );
}
