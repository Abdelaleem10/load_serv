import 'package:flutter/material.dart';
import 'package:loadserv_task/common/presentation/ui/widgets/custom_app_bar_icon.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/product/domain/entity/product_entity.dart';

class CategoryHeader extends StatelessWidget {
  final CategoryEntity item;
  const CategoryHeader({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding:   EdgeInsets.only(bottom: MediaQuery.of(context).size.height/22),
              child: Container(
                // width: MediaQuery.of(context).size.,
                height: MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  // Rounded corners
                  image: DecorationImage(
                    image: NetworkImage(
                        item.backgroundImage ??
                            ''),
                    // Local image path
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          // Rounded corners

                          color: AppColors.orangeColor.withOpacity(
                              0.38), // Semi-transparent overlay
                        ),
                      ),
                    ),
                    Positioned(
                        top: 56,
                        child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment
                                .start,
                            children: [
                              const CustomAppBarIcon(icon:Icons.arrow_back),
                              Expanded(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width /
                                            6),
                                    child: Text(
                                      item.name ??
                                          'Grilled Meat & Chicken',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight
                                              .bold,
                                          height: 1.2),
                                    ),
                                  ),
                                ),
                              ),
                              const CustomAppBarIcon(icon:Icons.menu),

                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(.1),
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                            ),
                            BoxShadow(
                              color: Colors.grey.withOpacity(.16),
                              blurRadius: 3.0,
                              spreadRadius: 6.0,
                            ),
                            //BoxShadow
                          ],
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(.45),
                            width: 12,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            item.image ?? '',
                            // Replace with local product image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
