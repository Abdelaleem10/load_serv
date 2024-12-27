import 'package:flutter/material.dart';
import 'package:loadserv_task/common/base/app_text_fields/app_text_form_field.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';
import 'package:loadserv_task/product/presentation/ui/widget/custome_widgets.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: PaddingDimensions.xxLarge,
        horizontal: PaddingDimensions.medium,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SizedBox(
              height: 35,
              child: AppTextFormField(
                borderColor: AppColors.grayColor,
                hint: "Search here",
                hintStyle: TextStyles.medium(
                  fontSize: Dimensions.large,
                  color: AppColors.grayColor
                ),
                focusBorderColor: AppColors.grayColor,
                prefixIconConstraints: const BoxConstraints(
                    maxHeight: 20, minHeight: 20, maxWidth: 35, minWidth: 35),
                prefix: const Icon(
                  Icons.search,
                  color: AppColors.grayColor,
                ),
                suffixIconConstraints: const BoxConstraints(
                    maxHeight: 20, minHeight: 20, maxWidth: 35, minWidth: 35),
                suffix: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PaddingDimensions.normal,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppColors.grayColor.withOpacity(0.38),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 18,

                    ),
                  ),
                ),
                textFieldType: TextFieldType.normal,
              ),
            ),
          ),
          const SizedBox(
            width: PaddingDimensions.normal,
          ),
          CustomIcon(icon: Icons.filter_list_rounded)
        ],
      ),
    );
  }
}
