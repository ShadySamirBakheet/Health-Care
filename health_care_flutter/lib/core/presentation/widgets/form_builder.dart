import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:health_care_flutter/core/domain/entities/image_type.dart';
import 'package:health_care_flutter/core/presentation/cubit/core_cubit.dart';
import 'package:health_care_flutter/core/presentation/phone/intl_phone_field.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/strings_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';
import 'package:image_picker/image_picker.dart';

const defaultPadding =
    EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p6);

class TextFieldApp extends StatelessWidget {
  const TextFieldApp({
    super.key,
    this.label,
    this.validator,
    this.errorText,
    this.controller,
    this.keyboardType,
    this.prefix,
    this.suffixIcon,
    this.onChanged,
    this.inputBackground,
    this.labelStyle,
    this.style,
    this.focusedBorder,
    this.margin,
    this.padding,
    this.focused,
    this.obscureText = false,
    this.decoration,
    this.border,
    this.maxLines = 1,
    this.hint,
    this.onSubmitted,
    this.filled,
    this.colorFilled,
    this.hintStyle,
  });

  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final int maxLines;

  final Widget? prefix;
  final Widget? suffixIcon;

  final Color? inputBackground;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final FocusNode? focused;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final InputBorder? border;
  final bool? filled;
  final Color? colorFilled;
  final void Function(String?)? onSubmitted;

  final void Function(String?)? onChanged;

  final List<FormFieldValidator<String>>? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(AppPadding.p12),
      child: FormBuilderTextField(
        name: label ?? '',
        controller: controller,
        focusNode: focused,
        onSubmitted: onSubmitted,
        keyboardType: keyboardType,
        validator: FormBuilderValidators.compose(validator ?? []),
        onChanged: onChanged,
        style: style ?? Theme.of(context).textTheme.bodyLarge,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: decoration?.copyWith(
              hintText: hint,
              hintStyle: hintStyle,
              labelStyle: labelStyle ??
                  const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff555555),
                  ),
              helperStyle: style,
              prefixIcon: prefix,
              labelText: label,
              focusedBorder: focusedBorder,
              suffixIcon: suffixIcon,
              contentPadding: padding ?? defaultPadding,
              border: border,
              enabledBorder: border,
              disabledBorder: border,
            ) ??
            InputDecoration(
              hintStyle: hintStyle,
              hintText: hint,
              labelStyle: labelStyle,
              helperStyle: style,
              filled: filled,
              fillColor: colorFilled,
              prefixIcon: prefix,
              labelText: label,
              focusedBorder: focusedBorder ?? border,
              suffixIcon: suffixIcon,
              contentPadding: padding ?? defaultPadding,
              border: border,
              errorBorder: border?.copyWith(
                borderSide: const BorderSide(color: ColorManager.error),
              ),
              enabledBorder: border,
              disabledBorder: border,
              focusedErrorBorder: border?.copyWith(
                borderSide: const BorderSide(color: ColorManager.error),
              ),
            ),
      ),
    );
  }
}

class TimePickerField extends StatelessWidget {
  const TimePickerField({
    required this.label,
    required this.validator,
    super.key,
    this.errorText,
    this.inputBackground,
    this.focusedBorder,
    this.padding,
    this.margin,
    this.onChanged,
  });

  final String label;
  final String? errorText;
  final Color? inputBackground;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final void Function(DateTime?)? onChanged;

  final List<FormFieldValidator<String>> validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ??
          const EdgeInsets.symmetric(
            horizontal: AppPadding.p30,
          ),
      child: FormBuilderDateTimePicker(
        name: label,
        initialDate: DateTime.now(),
        onChanged: onChanged,
        inputType: InputType.date,
        validator: (val) =>
            FormBuilderValidators.compose(validator)(val.toString()),
        decoration: InputDecoration(
          hintText: label,
          fillColor: inputBackground,
          contentPadding: padding ?? defaultPadding,
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    required this.label,
    super.key,
    this.errorText,
    this.prefix,
    this.suffixIcon,
    this.inputBackground,
    this.style,
    this.focusedBorder,
    this.padding,
    this.focused,
    this.controller,
    this.labelStyle,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.margin,
  });

  final String label;
  final String? errorText;

  final Widget? prefix;
  final Widget? suffixIcon;

  final Color? inputBackground;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focused;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  final void Function(String?)? onChanged;
  final List<FormFieldValidator<String>>? validator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordManageCubit(),
      child: BlocBuilder<PasswordManageCubit, PasswordManageState>(
        builder: (context, state) {
          return TextFieldApp(
            label: label,
            validator: validator,
            controller: controller,
            errorText: errorText,
            style: style,
            labelStyle: labelStyle,
            focused: focused,
            focusedBorder: focusedBorder,
            inputBackground: inputBackground,
            keyboardType: TextInputType.visiblePassword,
            obscureText: PasswordManageCubit.cubit(context).isVisible,
            prefix: prefix,
            margin: margin,
            padding: padding,
            suffixIcon: prefix == null
                ? GestureDetector(
                    onTap: () {
                      PasswordManageCubit.cubit(context).changeVisibility(
                        isVisible:
                            !PasswordManageCubit.cubit(context).isVisible,
                      );
                    },
                    child: const Icon(
                      FontAwesomeIcons.lock,
                      size: AppSize.s18,
                    ),
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    this.title,
    super.key,
    this.padding,
    this.margin,
    this.onChanged,
    this.suffixIcon,
    this.inputBorder,
    this.controller,
    this.focusNode,
    this.onSubmitted,
  });
  final String? title;
  final Widget? suffixIcon;
  final InputBorder? inputBorder;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final textEditingController = controller ?? TextEditingController();
    final focused = focusNode ?? FocusNode();
    return TextFieldApp(
      padding: padding ?? const EdgeInsets.all(AppPadding.p8),
      margin: margin,
      hint: title ?? AppStrings.searching,
      keyboardType: TextInputType.name,
      onSubmitted: onSubmitted,
      controller: textEditingController,
      focused: focused,
      suffixIcon: suffixIcon,
      style: FontStyles.regular15Black,
      validator: const [],
      onChanged: onChanged,
      prefix: IconButton(
        onPressed: () {
          onChanged?.call(textEditingController.text);
          focused.nextFocus();
        },
        icon: const Icon(
          Icons.search,
          color: ColorManager.primary,
        ),
      ),
    );
  }
}

class PhoneField extends StatelessWidget {
  const PhoneField({
    required this.label,
    required this.validator,
    super.key,
    this.errorText,
    this.inputBackground,
    this.focusedBorder,
    this.padding,
    this.onChanged,
    this.controller,
    this.focused,
    this.isRoundedBorder = false,
    this.onDone,
    this.elevation,
    this.hintTextStyle,
    this.enabledBorder,
  });
  final String label;
  final String? errorText;
  final Color? inputBackground;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final TextStyle? hintTextStyle;
  final void Function(String?)? onChanged;
  final void Function(bool?)? onDone;
  final List<FormFieldValidator<String>> validator;
  final TextEditingController? controller;
  final FocusNode? focused;
  final InputBorder? enabledBorder;
  final bool isRoundedBorder;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
          ),
      child: IntlPhoneField(
        isRoundedBorder: isRoundedBorder,
        elevation: elevation,
        searchTitle: AppStrings.searchText,
        controller: controller,
        focusNode: focused,
        validator: (phoneNumber) async {
          onDone?.call(
            phoneNumber?.completeNumber.isNotEmpty,
          );
          return FormBuilderValidators.compose(validator)(
            phoneNumber?.completeNumber ?? '',
          );
        },
        decoration: InputDecoration(
          hintText: AppStrings.phoneNumber,
          hintStyle: hintTextStyle,
          focusedBorder: focusedBorder,
          enabledBorder: enabledBorder,
        ),
        style: Theme.of(context).textTheme.bodyLarge,
        initialCountryCode: 'SA',
        onChanged: (phone) {
          if (onChanged != null) {
            print(phone.completeNumber);
            onChanged!(phone.number);
          }
        },
      ),
    );
  }
}

class GenderFiled extends StatelessWidget {
  const GenderFiled({
    required this.label,
    super.key,
    this.errorText,
    this.prefix,
    this.inputBackground,
    this.style,
    this.focusedBorder,
    this.padding,
    this.margin,
    this.onChanged,
    this.initialValue,
    this.validator,
  });

  final String? label;
  final String? errorText;

  final Widget? prefix;
  final bool? initialValue;

  final Color? inputBackground;
  final TextStyle? style;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final void Function({bool? myChoose})? onChanged;

  final List<FormFieldValidator<String>>? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(AppPadding.p12),
      child: FormBuilderDropdown<bool>(
        name: label!,
        onChanged: (val) => onChanged?.call(myChoose: val),
        style: style,
        isDense: false,
        initialValue: initialValue,
        validator: (val) => FormBuilderValidators.compose(
          validator ?? <FormFieldValidator>[],
        )(val.toString()),
        decoration: InputDecoration(
          label: label == null ? null : Text(label!),
          prefixIcon: prefix,
          hintText: label,
          errorText: errorText,
          hintStyle: style,
          labelStyle: style,
          contentPadding: padding ?? defaultPadding,
          border: Theme.of(context).inputDecorationTheme.border,
        ),
        items: [
          DropdownMenuItem(
            value: true,
            child: Text(
              AppStrings.male,
              style: style ??
                  const TextStyle(
                    color: ColorManager.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
          DropdownMenuItem(
            value: false,
            child: Text(
              AppStrings.female,
              style: style ??
                  const TextStyle(
                    color: ColorManager.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownMenuFiled extends StatelessWidget {
  const DropdownMenuFiled({
    required this.items,
    required this.label,
    super.key,
    this.errorText,
    this.prefix,
    this.inputBackground,
    this.style,
    this.focusedBorder,
    this.padding,
    this.onChanged,
    this.validator,
    this.border,
    this.suffixIcon,
    this.margin,
  });

  final String label;
  final String? errorText;
  final List<String> items;

  final Widget? prefix;

  final Color? inputBackground;
  final TextStyle? style;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final void Function(String?)? onChanged;
  final Widget? suffixIcon;

  final List<FormFieldValidator<String>>? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(AppPadding.p12),
      child: FormBuilderDropdown<String>(
        name: label,
        onChanged: onChanged,
        style: style,
        isDense: false,
        icon: suffixIcon,
        validator: (val) => FormBuilderValidators.compose(
          validator ?? <FormFieldValidator>[],
        )(val.toString()),
        decoration: InputDecoration(
          prefixIcon: prefix,
          hintText: label,
          hintStyle: style,
          errorText: errorText,
          labelStyle: style,
          border: border,
          errorBorder: border?.copyWith(
            borderSide: const BorderSide(color: ColorManager.error),
          ),
          enabledBorder: border,
          disabledBorder: border,
          focusedErrorBorder: border?.copyWith(
            borderSide: const BorderSide(color: ColorManager.error),
          ),
          contentPadding: padding ?? defaultPadding,
        ),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: style ?? const TextStyle(color: ColorManager.black),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class DropDownMenuApp extends StatelessWidget {
  const DropDownMenuApp({
    required this.items,
    required this.title,
    super.key,
    this.onChanged,
    this.padding,
    this.margin,
  });

  final void Function(String?)? onChanged;
  final List<String> items;
  final String title;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: DropdownButton<String>(
        value: title,
        elevation: 0,
        onTap: () {},
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: onChanged,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: padding ?? const EdgeInsets.all(AppPadding.p8),
              child: Text(value),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SelectImageFiled extends StatelessWidget {
  const SelectImageFiled({
    required this.label,
    super.key,
    this.inputBackground,
    this.style,
    this.margin,
    this.padding,
    this.filled,
    this.colorFilled,
    this.onChanged,
    this.borderRadius,
    this.images,
    this.onDelete,
  });

  final String label;
  final Color? inputBackground;
  final TextStyle? style;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final bool? filled;
  final Color? colorFilled;
  final double? borderRadius;
  final void Function(List<ImageData>?)? onChanged;
  final void Function(ImageData)? onDelete;
  final List<ImageData>? images;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagePickerCubit(
        ImagePickerInitial(),
        images: images ?? [],
        onChanged: onChanged,
        onDelete: onDelete,
      ),
      child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
        builder: (context, state) {
          return Container(
            margin: margin,
            padding: padding ?? defaultPadding,
            decoration: BoxDecoration(
              color: inputBackground,
              borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s12),
              border: Border.all(
                color: colorFilled ?? ColorManager.primary,
                width: AppSize.s0p5,
              ),
            ),
            child: Column(
              children: [
                if (ImagePickerCubit.cubit(context).images.isNotEmpty)
                  SizedBox(
                    height: AppSize.s130,
                    child: ListView.builder(
                      itemCount: ImagePickerCubit.cubit(context).images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final e = ImagePickerCubit.cubit(context).images[index];
                        return SizedBox(
                          height: AppSize.s130,
                          width: AppSize.s130,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p4),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s10),
                                  child: Image.file(
                                    File(e.file.path),
                                    height: AppSize.s130,
                                    width: AppSize.s130,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ImagePickerCubit.cubit(context)
                                          .deleteImage(e);
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      size: AppSize.s20,
                                      color: ColorManager.error,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: style ?? FontStyles.semiBold15Black,
                    ),
                    IconButton(
                      onPressed: () {
                        showBottomSheet<dynamic>(
                          context: context,
                          builder: (ctx) {
                            return selectImageSource(context);
                          },
                          backgroundColor: ColorManager.black.withOpacity(.1),
                          elevation: AppSize.s4,
                        );
                      },
                      icon: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: colorFilled ?? ColorManager.primary,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget selectImageSource(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      duration: const Duration(milliseconds: DurationConstant.d500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListTile(
            onTap: () {
              Navigator.pop(context);
              ImagePickerCubit.cubit(context)
                  .pickImage(source: ImageSource.camera);
            },
            trailing: const Icon(
              Icons.camera_alt,
              color: ColorManager.primary,
            ),
            title: Text(
              AppStrings.camera,
              style: FontStyles.semiBold15Black,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              ImagePickerCubit.cubit(context).pickImage();
            },
            trailing: const Icon(
              Icons.photo,
              color: ColorManager.primary,
            ),
            title: Text(
              AppStrings.gallery,
              style: FontStyles.semiBold15Black,
            ),
          ),
        ],
      ),
    );
  }
}
