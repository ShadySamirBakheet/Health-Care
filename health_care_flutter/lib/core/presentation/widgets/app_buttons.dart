import 'package:flutter/material.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/font_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    required this.title,
    super.key,
    this.borderRadius,
    this.fontSize,
    this.fixedSize,
    this.minimumSize,
    this.elevation,
    this.verticalPadding,
    this.horizontalPadding,
    this.textColor,
    this.backgroundColor,
  });

  final double? borderRadius;
  final double? fontSize;
  final double? fixedSize;
  final double? minimumSize;
  final double? elevation;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? textColor;
  final Color? backgroundColor;
  final void Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textStyle = getSemiBoldStyle(
      color: textColor ?? ColorManager.white,
      fontSize: fontSize ?? FontSize.s18,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding ?? 0,
        horizontal: horizontalPadding ?? 0,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: fixedSize == null ? null : Size.fromWidth(fixedSize ?? 0),
          backgroundColor: backgroundColor ?? ColorManager.primary,
          shadowColor: backgroundColor?.withOpacity(.7) ?? ColorManager.grey,
          elevation: elevation ?? 5,
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s22),
            side: const BorderSide(
              color: ColorManager.grey,
              width: .2,
            ),
          ),
          minimumSize: Size.fromHeight(minimumSize ?? AppSize.s56),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: textStyle,
        ),
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.title,
    super.key,
    this.onPressed,
  });
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: getRegularStyle(
          color: ColorManager.button,
          fontSize: FontSize.s18,
        ),
      ),
    );
  }
}
