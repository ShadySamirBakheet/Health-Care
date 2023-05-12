import 'package:flutter/material.dart';
import 'package:health_care_flutter/core/presentation/phone/countries.dart';
import 'package:health_care_flutter/core/presentation/phone/helpers.dart';
import 'package:health_care_flutter/core/presentation/widgets/app_bar.dart';
import 'package:health_care_flutter/core/presentation/widgets/form_builder.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/core/resources/strings_manager.dart';
import 'package:health_care_flutter/core/resources/styles_manager.dart';
import 'package:health_care_flutter/core/resources/values_manager.dart';

class PickerDialogStyle {
  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;
}

class CountryPickerDialog extends StatefulWidget {
  const CountryPickerDialog({
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    super.key,
    this.style,
  });
  final List<Country> countryList;
  final Country selectedCountry;
  final Future<dynamic> Function(Country) onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;

  @override
  _CountryPickerDialogState createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: widget.style?.backgroundColor,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              children: <Widget>[
                const SizedBox(height: AppSize.s16),
                MyAppBar(
                  titleText: AppStrings.selectCountry,
                ).getAppBar(context),
                const SizedBox(height: AppSize.s35),
                TextFieldApp(
                  label: widget.searchText,
                  labelStyle: const TextStyle(fontSize: 14),
                  validator: const [],
                  prefix: const Icon(
                    Icons.search,
                    color: ColorManager.grey,
                  ),
                  onChanged: (value) {
                    _filteredCountries = isNumeric(value!)
                        ? widget.countryList
                            .where(
                              (country) => country.dialCode.contains(value),
                            )
                            .toList()
                        : widget.countryList
                            .where(
                              (country) => country.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()),
                            )
                            .toList();
                    if (mounted) setState(() {});
                  },
                ),
                const SizedBox(height: AppSize.s48),
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                    shrinkWrap: true,
                    itemCount: _filteredCountries.length,
                    itemBuilder: (ctx, index) => Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text(
                            _filteredCountries[index].flag,
                          ),
                          contentPadding: widget.style?.listTilePadding,
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _filteredCountries[index].name,
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              const SizedBox(width: AppSize.s8),
                              Text(
                                '(+${_filteredCountries[index].dialCode})',
                                style: FontStyles.regular15Grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          onTap: () async {
                            _selectedCountry = _filteredCountries[index];
                            await widget.onCountryChanged(_selectedCountry);
                            if (mounted) Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
