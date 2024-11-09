import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_text.dart';
import '../../meta/utils/app_color.dart';
import '../../meta/utils/ts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.name,
      this.onSaved,
      this.focusNode,
      this.contentPadding,
      this.onTap,
      this.counterText,
      this.labelText,
      this.textInputAction,
      this.prefixIcon,
      this.textCapitalization = TextCapitalization.none,
      this.maxLines,
      this.onEditingComplete,
      this.controller,
      this.fillColor,
      this.validator,
      this.height,
      this.readOnly = false,
      this.suffixIcon,
      this.initialText,
      this.inputFormatters,
      this.onChanged,
      this.hintText,
      this.keyboardType = TextInputType.text,
      this.autofocus = false,
      this.obscureText = false,
      this.prefix,
      this.suffix,
      this.expands = false,
      this.maxLength,
      this.onFieldSubmitted,
      this.scrollPadding = const EdgeInsets.only(bottom: 200),
      this.hideBorder = false,
      this.isDense = false,
      this.enabledBorder});
  // Hint text for text field
  final String? hintText;

  final bool hideBorder;

  final String? name;
  // Callback functions

  final bool expands;

  final void Function(String)? onChanged;

  final void Function()? onEditingComplete;
  final void Function(String?)? onSaved;
  final void Function(String?)? onFieldSubmitted;

  // Other properties

  final TextInputType keyboardType;

  final TextInputAction? textInputAction;

  final FocusNode? focusNode;
  final String? labelText;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final double? height;

  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final void Function()? onTap;
  final String? Function(String?)? validator;
  final String? initialText;
  final bool readOnly;
  final int? maxLines;
  final Widget? prefix;
  final bool isDense;
  final Widget? suffix;

  final TextCapitalization textCapitalization;

  final bool autofocus;

  final List<TextInputFormatter>? inputFormatters;

  final bool obscureText;

  final int? maxLength;
  final String? counterText;

  final EdgeInsets scrollPadding;

  final InputBorder? enabledBorder;

  TextStyle get _hintTextStyle => Ts.regular15(color: AppColor.gray400);

  TextStyle _textStyle() => Ts.regular15();

  InputBorder _wInputBorder(Color? color) {
    return OutlineInputBorder(
      borderSide: hideBorder
          ?  BorderSide.none
          : color == null
              ? const BorderSide()
              : BorderSide(color: color),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _wField(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary: AppColor.secondary)),
      child: TextFormField(
        keyboardType: keyboardType,
        scrollPadding: scrollPadding,
        expands: expands,
        maxLines: obscureText ? 1 : maxLines,
        inputFormatters: inputFormatters,
        controller: controller,
        initialValue: initialText,
        textInputAction: textInputAction,
        validator: validator,
        maxLength: maxLength,
        textCapitalization: textCapitalization,
        onEditingComplete: onEditingComplete,
        style: _textStyle(),
        focusNode: focusNode,
        obscureText: obscureText,
        cursorColor: Colors.grey,
        readOnly: readOnly,
        decoration: InputDecoration(
          errorStyle: Ts.regular14(color: Colors.red),
          counterText: counterText,
          prefix: prefix,
          suffix: suffix,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: fillColor != null,
          fillColor: fillColor,
          focusedBorder: _wInputBorder(AppColor.secondary),
          enabledBorder: enabledBorder ?? _wInputBorder(AppColor.themeColor(Colors.grey, Colors.transparent)),
          errorBorder: _wInputBorder(Colors.red),
          focusedErrorBorder: _wInputBorder(Colors.red),
          border: enabledBorder ?? _wInputBorder(AppColor.themeColor(Colors.grey, Colors.transparent)),
          labelText: labelText,
          floatingLabelStyle: _textStyle(),
          labelStyle: _textStyle(),
          hintText: hintText,
          hintStyle: _hintTextStyle,
          isDense: isDense,
          contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(15, 10, 10, 10),
        ),
        onTap: onTap,
        onSaved: onSaved,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return name != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: AppText(
                  name,
                  style: Ts.medium14(),
                ),
              ),
              _wField(context),
            ],
          )
        : _wField(context);
  }
}
