import 'package:flutter/material.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    super.key,
    this.titleText,
    this.titleWidget,
    this.menu,
    this.withBack = true,
  });

  final String? titleText;
  final Widget? titleWidget;
  final List<Widget>? menu;
  final bool withBack;

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      title: titleWidget ??
          Text(
            titleText ?? '',
            style: FontStyles.semiBold17Black,
            textAlign: TextAlign.center,
          ),
      //  backgroundColor: ColorManager.white,
      actions: menu,
      elevation: AppSize.s0,
      leading: withBack
          ? BackButton(
              color: ColorManager.black,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : const SizedBox(),
      titleSpacing: 0,
    );
  }
}
