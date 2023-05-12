import 'package:flutter/material.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/font_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';

class DoubleText extends StatelessWidget {
  const DoubleText({
    required this.title,
    super.key,
    this.color1,
  });

  final String title;
  final Color? color1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            title,
            style: getBoldStyle(
              color: color1 ?? ColorManager.white,
              fontSize: FontSize.s42,
            ),
          ),
        ),
        Center(
          child: Text(
            title,
            style: getRegularStyle(
              color: ColorManager.button,
              fontSize: FontSize.s43,
            ),
          ),
        ),
      ],
    );
  }
}
