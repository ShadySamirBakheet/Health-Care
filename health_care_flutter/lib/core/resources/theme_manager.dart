import 'package:flutter/material.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/font_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: 'roboto',
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primary,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.grey,
    canvasColor: ColorManager.white,
    // ripple color
    splashColor: ColorManager.transparent,
    // card view theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.white,
      elevation: AppSize.s0p5,
      shadowColor: ColorManager.grey,
      titleTextStyle: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s18,
      ),
      foregroundColor: ColorManager.primary,
    ),
    // Button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.grey,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        //fixedSize: const Size.fromWidth(306),
        textStyle: getRegularStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        shadowColor: ColorManager.grey,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s22),
          side: const BorderSide(
            color: ColorManager.grey,
            width: .2,
          ),
        ),
        minimumSize: const Size.fromHeight(50),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.button,
          fontSize: FontSize.s18,
        ),
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      displayLarge: getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s36,
      ),
      displayMedium: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s30,
      ),
      displaySmall: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s22,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s18,
      ),
      headlineSmall: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s17,
      ),
      titleLarge: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s16,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s15,
      ),
      titleSmall: getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      bodyMedium: getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s13,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s14,
      ),
      labelLarge: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s18,
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppPadding.p2,
        horizontal: AppPadding.p12,
      ),
      // hint style
      hintStyle: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.s16,
      ).copyWith(),

      // label style
      labelStyle: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.s16,
      ),
      // error style
      errorStyle: getRegularStyle(
        color: ColorManager.error,
        fontSize: FontSize.s16,
      ),

      helperStyle: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.s16,
      ),
      disabledBorder: border,
      // enabled border
      enabledBorder: border,
      // focused border
      focusedBorder: border,
      // error border
      errorBorder: border.copyWith(
        borderSide: const BorderSide(color: ColorManager.error, width: 1.5),
      ),
      // focused error border
      focusedErrorBorder: border.copyWith(
        borderSide: const BorderSide(color: ColorManager.error, width: 1.5),
      ),

      border: border,
    ),

    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),
  );
}

OutlineInputBorder get border => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.s12),
      borderSide:
          const BorderSide(color: ColorManager.button, width: AppSize.s0p5),
    );

class AppTheme {
  static const orangeTextStyle = TextStyle(
    color: ColorManager.orangeColor,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static const darkBlueTextColor = TextStyle(
    color: Color(
      0xFF2F2F2F,
    ),
    fontSize: 30,
    fontFamily: 'Quicksand',
    fontWeight: FontWeight.bold,
  );

  static InputDecoration buildInputDecoration(String? hintText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(
        left: 10,
      ),
      fillColor: const Color(0xffFFFFFF),
      filled: true,
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 2, color: Color(0xffECECEC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorManager.orangeColor),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
