import 'package:flutter/material.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';

class CustomAppBarIcon extends StatelessWidget {
  final IconData icon;
  final bool? useShadow;

  const CustomAppBarIcon({super.key, required this.icon, this.useShadow});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: (useShadow == true) ? .2 : 0,
          ),
          boxShadow: (useShadow == true)
              ? [
                  const BoxShadow(
                      color: Colors.grey, offset: Offset(2, 4), blurRadius: 2),
                ]
              : [],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: AppColors.grayColor),
    );
  }
}
