import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care_flutter/core/presentation/phone/countries.dart';
import 'package:health_care_flutter/core/presentation/phone/country_picker_dialog.dart';
import 'package:health_care_flutter/core/presentation/phone/phone_number.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/font_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';

class IntlPhoneField extends StatefulWidget {
  const IntlPhoneField({
    super.key,
    this.elevation,
    this.filledColorFlag,
    this.isRoundedBorder = false,
    this.filledColorNumberField,
    this.initialCountryCode,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.phone,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.style,
    this.dropdownTextStyle,
    this.onSubmitted,
    this.fillColor,
    this.validator,
    this.onChanged,
    this.countries,
    this.onCountryChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance,
    this.searchTitle = 'Search country',
    this.dropdownIconPosition = IconPosition.trailing,
    this.dropdownIcon = const Icon(
      Icons.arrow_drop_down,
      size: AppSize.s20,
    ),
    this.autofocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showCountryFlag = true,
    this.cursorColor,
    this.disableLengthCheck = false,
    this.flagsButtonPadding = EdgeInsets.zero,
    this.invalidNumberMessage = 'Invalid Mobile Number',
    this.cursorHeight,
    this.cursorRadius = Radius.zero,
    this.cursorWidth = 2.0,
    this.showCursor = true,
    this.pickerDialogStyle,
    this.flagsButtonMargin = EdgeInsets.zero,
    this.onDone,
    this.isCard = true,
    this.isCardFlag = false,
    this.border1,
    this.contentPadding,
  });

  final bool obscureText;

  final TextAlign textAlign;
  final double? elevation;
  final bool isRoundedBorder;
  final InputBorder? border1;
  final bool isCard;
  final bool isCardFlag;
  final Color? filledColorFlag;
  final Color? filledColorNumberField;
  final TextAlignVertical? textAlignVertical;
  final VoidCallback? onTap;

  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldSetter<MyphoneNumber>? onSaved;

  final ValueChanged<MyphoneNumber>? onChanged;

  final ValueChanged<Country>? onCountryChanged;

  final Future<String?> Function(MyphoneNumber?)? validator;

  final TextInputType keyboardType;

  final TextEditingController? controller;

  final FocusNode? focusNode;
  final Color? fillColor;

  final void Function(String)? onSubmitted;
  final void Function(bool)? onDone;

  final bool enabled;

  final Brightness? keyboardAppearance;

  /// Initial Value for the field.
  /// This property can be used to pre-fill the field.
  final String? initialValue;

  /// 2 Letter ISO Code
  final String? initialCountryCode;
  final List<String>? countries;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// Disable view Min/Max Length check
  final bool disableLengthCheck;

  /// Won't work if [enabled] is set to `false`.
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;

  /// The style use for the country dial code.
  final TextStyle? dropdownTextStyle;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  final String searchTitle;

  /// Position of an icon [leading, trailing]
  final IconPosition dropdownIconPosition;

  /// Icon of the drop down button.

  /// Default is [Icon(Icons.arrow_drop_down)]
  final Icon dropdownIcon;

  final bool autofocus;

  final AutovalidateMode? autovalidateMode;

  /// Whether to show or hide country flag.
  ///
  /// Default value is `true`.
  final bool showCountryFlag;

  /// Message to be displayed on autoValidate error
  ///
  /// Default value is `Invalid Mobile Number`.
  final String? invalidNumberMessage;

  /// The color of the cursor.
  final Color? cursorColor;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// How rounded the corners of the cursor should be.
  final Radius? cursorRadius;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// Whether to show cursor.
  final bool? showCursor;

  /// The padding of the Flags Button.
  ///
  /// The amount of insets that are applied to the Flags Button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry flagsButtonPadding;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Optional set of styles to allow for customizing the country search
  /// & pick dialog
  final PickerDialogStyle? pickerDialogStyle;

  /// The margin of the country selector button.
  ///
  /// The amount of space to surround the country selector button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsets flagsButtonMargin;

  @override
  _IntlPhoneFieldState createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  late List<Country> _countryList;
  late Country _selectedCountry;
  late List<Country> filteredCountries;
  late String number;

  String? validatorMessage;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries == null
        ? countries
        : countries
            .where((country) => widget.countries!.contains(country.code))
            .toList();
    filteredCountries = _countryList;
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && number.startsWith('+')) {
      number = number.substring(1);
      // parse initial value
      _selectedCountry = countries.firstWhere(
        (country) => number.startsWith(country.dialCode),
        orElse: () => _countryList.first,
      );
      number = number.substring(_selectedCountry.dialCode.length);
    } else {
      _selectedCountry = _countryList.firstWhere(
        (item) => item.code == (widget.initialCountryCode ?? 'US'),
        orElse: () => _countryList.first,
      );
    }

    if (widget.autovalidateMode == AutovalidateMode.always) {
      final initialPhoneNumber = MyphoneNumber(
        countryISOCode: _selectedCountry.code,
        countryCode: '+${_selectedCountry.dialCode}',
        number: widget.initialValue ?? '',
      );

      final value = widget.validator?.call(initialPhoneNumber);

      value?.then((msg) {
        validatorMessage = msg;
      });
    }
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog<dynamic>(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => CountryPickerDialog(
          style: widget.pickerDialogStyle,
          filteredCountries: filteredCountries,
          searchText: widget.searchTitle,
          countryList: _countryList,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) async {
            _selectedCountry = country;
            widget.onCountryChanged?.call(country);
            final phone = MyphoneNumber(
              countryISOCode: country.code,
              countryCode: '+${country.dialCode}',
              number: widget.controller?.text ?? number,
            );
            widget.onChanged?.call(phone);
            setState(
              () {},
            );

            validatorMessage = await widget.validator?.call(
              phone,
            );
            log('$phone');
          },
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isCard || widget.isCardFlag)
          Card(
            shape: widget.isRoundedBorder
                ? const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    side: BorderSide(
                      color: Color(0xffDDDDDD),
                    ),
                  )
                : null,
            color: widget.filledColorFlag,
            elevation: widget.elevation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: _buildFlagsButton(),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(AppPadding.p10),
            child: _buildFlagsButton(),
          ),
        const SizedBox(
          width: AppSize.s8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isCard)
                Card(
                  shape: widget.isRoundedBorder
                      ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(
                            color: Color(0xffDDDDDD),
                          ),
                        )
                      : null,
                  color: widget.filledColorNumberField,
                  elevation: widget.elevation,
                  child: TextFormField(
                    initialValue: (widget.controller == null) ? number : null,
                    readOnly: widget.readOnly,
                    obscureText: widget.obscureText,
                    textAlign: widget.textAlign,
                    textAlignVertical: widget.textAlignVertical,
                    cursorColor: widget.cursorColor,
                    onTap: widget.onTap,
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    cursorHeight: widget.cursorHeight,
                    cursorRadius: widget.cursorRadius,
                    cursorWidth: widget.cursorWidth,
                    showCursor: widget.showCursor,
                    onFieldSubmitted: widget.onSubmitted,
                    decoration: widget.decoration.copyWith(
                      labelStyle: widget.style,
                      border: widget.border1 ?? border,
                      errorBorder: widget.border1 ?? border,
                      enabledBorder: widget.border1 ?? border,
                      focusedBorder: widget.border1 ?? border,
                      disabledBorder: widget.border1 ?? border,
                      focusedErrorBorder: widget.border1 ?? border,
                      filled: true,
                      fillColor: widget.fillColor,
                      //fillColor: ColorManager.inputBackground,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p16,
                        vertical: AppPadding.p2,
                      ),
                    ),
                    style: widget.style,
                    onSaved: (value) {
                      widget.onSaved?.call(
                        MyphoneNumber(
                          countryISOCode: _selectedCountry.code,
                          countryCode: '+${_selectedCountry.dialCode}',
                          number: value!,
                        ),
                      );
                    },
                    onChanged: (value) async {
                      final phoneNumber = MyphoneNumber(
                        countryISOCode: _selectedCountry.code,
                        countryCode: '+${_selectedCountry.dialCode}',
                        number: value,
                      );
                      number = value;
                      // setState(() async {
                      //   validatorMessage =
                      //       await widget.validator?.call(phoneNumber);
                      // });
                      if (widget.autovalidateMode !=
                          AutovalidateMode.disabled) {
                        validatorMessage =
                            await widget.validator?.call(phoneNumber);
                      }

                      widget.onChanged?.call(phoneNumber);
                      setState(() {});
                    },

                    validator: (value) {
                      if (!widget.disableLengthCheck && value != null) {
                        return null;
                        // return value.length >= _selectedCountry.minLength &&
                        //         value.length <= _selectedCountry.maxLength
                        //     ? null
                        //     : widget.invalidNumberMessage;
                      }
                      return '';
                    },

                    // if (!widget.disableLengthCheck && value != null) {
                    //   return value.length >= _selectedCountry.minLength &&
                    //           value.length <= _selectedCountry.maxLength
                    //       ? null
                    //       : widget.invalidNumberMessage;
                    // }

                    // return '';
                    //},
                    // maxLength:
                    //     widget.disableLengthCheck ? null : _selectedCountry.maxLength,
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.inputFormatters,
                    enabled: widget.enabled,
                    keyboardAppearance: widget.keyboardAppearance,
                    autofocus: widget.autofocus,
                    textInputAction: widget.textInputAction,
                    autovalidateMode: AutovalidateMode.disabled,
                  ),
                )
              else
                TextFormField(
                  initialValue: (widget.controller == null) ? number : null,
                  readOnly: widget.readOnly,
                  obscureText: widget.obscureText,
                  textAlign: widget.textAlign,
                  textAlignVertical: widget.textAlignVertical,
                  cursorColor: widget.cursorColor,
                  onTap: widget.onTap,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  cursorHeight: widget.cursorHeight,
                  cursorRadius: widget.cursorRadius,
                  cursorWidth: widget.cursorWidth,
                  showCursor: widget.showCursor,
                  onFieldSubmitted: widget.onSubmitted,
                  decoration: widget.decoration.copyWith(
                    // prefixIcon: ,
                    // counterText: !widget.enabled ? '' : null,
                    labelStyle: const TextStyle(
                      fontSize: FontSize.s10,
                      fontWeight: FontWeight.w500,
                    ),
                    border: widget.border1 ?? border,
                    errorBorder: widget.border1?.copyWith(
                          borderSide: const BorderSide(color: Colors.red),
                        ) ??
                        const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                    enabledBorder: widget.border1 ?? border,
                    focusedBorder: widget.border1 ?? border,
                    disabledBorder: widget.border1 ?? border,
                    focusedErrorBorder: widget.border1?.copyWith(
                          borderSide: const BorderSide(color: Colors.red),
                        ) ??
                        border,

                    filled: true,
                    //fillColor: ColorManager.inputBackground,
                    contentPadding: widget.contentPadding ??
                        const EdgeInsets.symmetric(
                          vertical: AppPadding.p2,
                        ),
                    fillColor: widget.fillColor,
                  ),
                  style: widget.style,
                  onSaved: (value) {
                    widget.onSaved?.call(
                      MyphoneNumber(
                        countryISOCode: _selectedCountry.code,
                        countryCode: '+${_selectedCountry.dialCode}',
                        number: value!,
                      ),
                    );
                  },
                  onChanged: (value) async {
                    final phoneNumber = MyphoneNumber(
                      countryISOCode: _selectedCountry.code,
                      countryCode: '+${_selectedCountry.dialCode}',
                      number: value,
                    );
                    number = value;

                    // setState(() async {
                    //   validatorMessage =
                    //       await widget.validator?.call(phoneNumber);
                    // });
                    if (widget.autovalidateMode != AutovalidateMode.disabled) {
                      validatorMessage =
                          await widget.validator?.call(phoneNumber);
                    }

                    widget.onChanged?.call(phoneNumber);
                  },
                  validator: (value) {
                    if (!widget.disableLengthCheck && value != null) {
                      if (value.isEmpty) {
                        validatorMessage = 'This field cannot be empty';
                        setState(() {});
                      }
                      return null;
                      // return value.length >= _selectedCountry.minLength &&
                      //         value.length <= _selectedCountry.maxLength
                      //     ? null
                      //     : widget.invalidNumberMessage;
                    }

                    return '';
                  },
                  // maxLength:
                  //     widget.disableLengthCheck ? null : _selectedCountry.maxLength,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  enabled: widget.enabled,
                  keyboardAppearance: widget.keyboardAppearance,
                  autofocus: widget.autofocus,
                  textInputAction: widget.textInputAction,
                  autovalidateMode: AutovalidateMode.disabled,
                ),
              const SizedBox(
                width: AppSize.s8,
                height: AppSize.s4,
              ),
              Text(
                validatorMessage ?? '',
                style: const TextStyle(
                  color: ColorManager.red,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlagsButton() {
    return InkWell(
      borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
      onTap: widget.enabled ? _changeCountry : null,
      child: Padding(
        padding: widget.flagsButtonPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (widget.showCountryFlag) ...[
              Image.asset(
                'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
                width: AppSize.s28,
                height: AppSize.s28,
              ),
              // const SizedBox(width: AppSize.s8),
            ],
            if (widget.enabled &&
                widget.showDropdownIcon &&
                widget.dropdownIconPosition == IconPosition.trailing)
              // SvgPicture.asset(
              //   SVGAssets.dropdown,
              //   width: AppSize.s10,
              // ),
              const Icon(
                Icons.arrow_drop_down,
                size: AppSize.s20,
              )
          ],
        ),
      ),
    );
  }
}

enum IconPosition {
  leading,
  trailing,
}

OutlineInputBorder get border => OutlineInputBorder(
      borderRadius: BordersRadius.borderRadius8dp,
      borderSide: BorderSide.none,
    );
