import 'package:flutter/material.dart';
import 'package:loadserv_task/common/data/di/localizations_container.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:sizer/sizer.dart';

class TextStyles {
  static final String appLanguage = isAppInArabic() ? "ar" : "en";
  static const double _baseFontSize = 14.0;

  static TextStyle regular(
      {Color color = Colors.black,
      double fontSize = _baseFontSize,
      TextOverflow? textOverFlow,
      double? height}) {
    return TextStyle(
        height: height,
        color: color,
        fontFamily: 'Apercu',
        overflow: textOverFlow ?? TextOverflow.visible,
        fontWeight: FontWeight.w400,

        // textScaleFactor: 1.0,
        fontSize: fontSize);
  }

  static TextStyle light(
          {Color color = Colors.black,
          double fontSize = 14.0,
          double? height}) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w300,
          fontSize: fontSize);

  static TextStyle bold({
    Color color = Colors.black,
    double fontSize = 14.0,
    double? height,
    TextOverflow? textOverFlow,
  }) =>
      TextStyle(
        height: height,
        color: color,
        fontFamily: 'Apercu',
        overflow: textOverFlow,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
      );

  static TextStyle boldUnderlined(
          {Color color = Colors.black, double fontSize = 14.0}) =>
      TextStyle(
          color: color,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          decoration: TextDecoration.underline);

  static TextStyle regularUnderlined({
    Color color = Colors.black,
    Color decorationColor = AppColors.grayColor,
    double fontSize = 14.0,
  }) =>
      TextStyle(
          color: color,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          decoration: TextDecoration.underline,
          decorationColor: decorationColor);

  static TextStyle medium(
          {Color color = Colors.black,
          double fontSize = 14.0,
          TextOverflow? textOverFlow,
          double? height}) =>
      TextStyle(
          height: height,
          color: color,
          overflow: textOverFlow ?? TextOverflow.visible,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w500,
          fontSize: fontSize);

  static TextStyle mediumUnderlined(
          {Color color = Colors.black, double fontSize = 14.0}) =>
      TextStyle(
        color: color,
        fontFamily: 'Apercu',
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        decoration: TextDecoration.underline,
      );

  static TextStyle semiBold(
          {Color color = Colors.black,
          double fontSize = 14.0,
          double? height}) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w600,
          fontSize: fontSize);

  static TextStyle thin(
          {Color color = Colors.black,
          double fontSize = 14.0,
          double height = 1}) =>
      TextStyle(
          color: color,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w100,
          height: height,
          fontSize: fontSize);

  static TextStyle thinUnderlined(
      {Color color = Colors.black, double fontSize = 14.0,
        double height = 1}) =>
      TextStyle(
        color: color,
        fontFamily: 'Apercu',
        fontWeight: FontWeight.w100,
        fontSize: fontSize,
        height: height,
        decoration: TextDecoration.underline,
      );
}

class ConstTextStyles {
  static final String appLanguage = isAppInArabic() ? "ar" : "en";
  static const double _baseFontSize = 14.0;

  static TextStyle regular(
      {Color color = Colors.black,
      double fontSize = _baseFontSize,
      TextOverflow? textOverFlow,
      double? height}) {
    return TextStyle(
        height: height,
        color: color,
        fontFamily: 'Apercu',
        overflow: textOverFlow ?? TextOverflow.visible,
        fontWeight: FontWeight.w400,

        // textScaleFactor: 1.0,
        fontSize: fontSize);
  }

  static TextStyle light(
          {Color color = Colors.black,
          double fontSize = 14.0,
          double? height}) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w300,
          fontSize: fontSize);

  static TextStyle bold({
    Color color = Colors.black,
    double fontSize = 14.0,
    double? height,
    TextOverflow? textOverFlow,
  }) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'Apercu',
          overflow: textOverFlow,
          fontWeight: FontWeight.w700,
          fontSize: fontSize);

  static TextStyle boldUnderlined(
          {Color color = Colors.black, double fontSize = 14.0}) =>
      TextStyle(
          color: color,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          decoration: TextDecoration.underline);

  static TextStyle regularUnderlined({
    Color color = Colors.black,
    Color decorationColor = AppColors.grayColor,
    double fontSize = 14.0,
  }) =>
      TextStyle(
          color: color,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          decoration: TextDecoration.underline,
          decorationColor: decorationColor);

  static TextStyle medium(
          {Color color = Colors.black,
          double fontSize = 14.0,
          TextOverflow? textOverFlow,
          double? height}) =>
      TextStyle(
          height: height,
          color: color,
          overflow: textOverFlow ?? TextOverflow.visible,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w500,
          fontSize: fontSize);

  static TextStyle mediumUnderlined(
          {Color color = Colors.black, double fontSize = 14.0}) =>
      TextStyle(
        color: color,
        fontFamily: 'Apercu',
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        decoration: TextDecoration.underline,
      );

  static TextStyle semiBold(
          {Color color = Colors.black,
          double fontSize = 14.0,
          double? height}) =>
      TextStyle(
          height: height,
          color: color,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w600,
          fontSize: fontSize);

  static TextStyle thin(
          {Color color = Colors.black,
          double fontSize = 14.0,
          double height = 1}) =>
      TextStyle(
          color: color,
          fontFamily: 'Apercu',
          fontWeight: FontWeight.w100,
          height: height,
          fontSize: fontSize);
}
