import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/product/presentation/manager/category_cubit.dart';
import 'package:loadserv_task/product/presentation/manager/category_state.dart';

class CategoryDetailsProviderPage extends StatelessWidget {
  const CategoryDetailsProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      CategoryCubit()
        ..getCategoryDetails(),
      child: const CategoryDetailsPage(),
    );
  }
}

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({super.key});

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state.categoryDetails.isSuccess) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Container(
                            width: 430,
                            height: 230,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              // Rounded corners
                              image: DecorationImage(
                                image: NetworkImage(
                                    state.categoryDetails.data
                                        ?.backgroundImage ??
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
                                          _customIcon(Icons.arrow_back),
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
                                                  state.categoryDetails.data
                                                      ?.name ??
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
                                          _customIcon(Icons.menu),

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
                                  radius: 70,
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
                                        state.categoryDetails.data?.image ?? '',
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
              return const SizedBox.shrink();
            }));
  }

  Widget _customIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Icon(
     icon, color: AppColors.grayColor),
    );
  }
}
