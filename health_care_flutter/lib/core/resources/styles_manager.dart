import 'package:flutter/material.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/font_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  String fontFamily,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

// regular style
TextStyle getRegularStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.regular,
    color,
  );
}
// light text style

TextStyle getLightStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.light,
    color,
  );
}
// bold text style

TextStyle getBoldStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.bold,
    color,
  );
}

// semi bold text style

TextStyle getSemiBoldStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.semiBold,
    color,
  );
}

// medium text style

TextStyle getMediumStyle({
  required Color color,
  double fontSize = FontSize.s12,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.medium,
    color,
  );
}

class BordersRadius {
  static BorderRadius get borderRadius8dp => BorderRadius.circular(AppSize.s8);
  static BorderRadius get borderRadius6dp => BorderRadius.circular(AppSize.s6);
  static BorderRadius get borderRadius4dp => BorderRadius.circular(AppSize.s4);
  static BorderRadius get borderRadius10dp =>
      BorderRadius.circular(AppSize.s10);
  static BorderRadius get borderRadius14dp =>
      BorderRadius.circular(AppSize.s14);
  static BorderRadius get borderRadius20dp =>
      BorderRadius.circular(AppSize.s20);
  static BorderRadius get borderRadius50dp =>
      BorderRadius.circular(AppSize.s50);
}

class FontStyles {
  //! bold
  static TextStyle get bold32Primary => getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s32,
      );
  static TextStyle get bold22Primary => getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s22,
      );

  //! semi bold
  static TextStyle get semiBold17Black => getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s17,
      );

  static TextStyle get semiBold22Black => getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s22,
      );
  static TextStyle get semiBold15Black => getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s15,
      );
  static TextStyle get semiBold15White => getSemiBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s15,
      );

  //! regular
  static TextStyle get regular17White70O => getRegularStyle(
        color: ColorManager.white.withOpacity(.7),
        fontSize: FontSize.s17,
      );
  static TextStyle get regular15White => getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s15,
      );
  static TextStyle get regular15Black => getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s15,
      );
  static TextStyle get regular17Black => getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s17,
      );
  static TextStyle get regular15Grey => getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s15,
      );
  static TextStyle get regular15Red => getRegularStyle(
        color: ColorManager.red,
        fontSize: FontSize.s15,
      );
}
