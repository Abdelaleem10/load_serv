import 'package:flutter/material.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  double begin = 1;
  double end = 0.75;

  void _playingAnimation() {
    _scaleController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    _fadeController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);

    _scaleAnimation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(_scaleController);

    _fadeAnimation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(_fadeController);

    _scaleController.repeat(reverse: true);
    _fadeController.repeat(reverse: true);
  }

  @override
  void initState() {
    _playingAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
            color: AppColors.grayColor),
        clipBehavior: Clip.hardEdge,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
              opacity: _fadeAnimation,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: FittedBox(
                    child: Icon(
                  Icons.downloading,
                  color: AppColors.orangeColor,
                )),
              )),
        ),
      )),
    );
  }
}
