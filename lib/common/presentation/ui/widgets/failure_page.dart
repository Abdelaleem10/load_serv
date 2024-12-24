import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/text_styles.dart';
import 'package:loadserv_task/common/presentation/utils/dimensions.dart';
import 'package:lottie/lottie.dart';

class FailurePage extends StatefulWidget {
  const FailurePage(
      {super.key,
        required this.onPressed,
        this.colorPage,
        this.useAppBar,
        this.withoutInternetChecker,
        this.isPageRemoved = false,
        this.align = Alignment.center});
  final void Function() onPressed;
  final Color? colorPage;
  final Alignment align;
  final bool? useAppBar;
  final bool? withoutInternetChecker;
  final bool isPageRemoved;

  @override
  State<FailurePage> createState() => _FailurePageState();
}

class _FailurePageState extends State<FailurePage> {
  late ImageProvider imagePath;
  bool isLoading = false;
  bool isRetryEnabled = true;

  void _retryFailedLoading() {
    if (!isRetryEnabled) {
      return; // Ignore button press if retry is disabled
    }

    setState(() {
      isLoading = true;
      isRetryEnabled = false;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        isRetryEnabled = true;
      });
      internetConnection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildFailureBody();
  }

  Widget _buildFailureBody(){
    return Align(
      alignment: widget.align,
      child: Container(
        color: widget.colorPage ?? Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset(
                  height: 140,
                  width: 140,
                  "assets/animated_json/common/pagination_failure.json",
                ),
              ),
              const SizedBox(
                height: PaddingDimensions.x4Large,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingDimensions.xxxLarge,
                    vertical: PaddingDimensions.normal),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      widget.isPageRemoved
                          ? "Media unavailable"
                          : "Oops! Something Went Wrong", //todo 2024
                      style: TextStyles.semiBold(
                        fontSize: Dimensions.xxxxLarge,
                        color: AppColors.orangeColor,
                      ),
                    ),
                    const SizedBox(
                      height: PaddingDimensions.normal,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      widget.isPageRemoved
                          ? "Looks like that this media is no longer available"
                          : "Looks like we hit an unexpected error. Please try again",
                      style: TextStyles.regular(
                        fontSize: Dimensions.xLarge,
                        color: AppColors.orangeColor,
                      ),
                    ),
                  ],
                ),
              ),
              if(!widget.isPageRemoved)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: PaddingDimensions.xxLarge,
                      horizontal: PaddingDimensions.x4Large),
                  child: MaterialButton(
                    color: AppColors.orangeColor,
                    onPressed:  _retryFailedLoading,
                    child: Text("retry",style: TextStyles.bold(
                      color: Colors.white
                    ),),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> internetConnection() async {
    if(widget.withoutInternetChecker==true){
      widget.onPressed();
    }else{
      final bool isConnected = await InternetConnectionChecker.instance.hasConnection;
      if (isConnected) {
        widget.onPressed();
      }
    }

  }
}
