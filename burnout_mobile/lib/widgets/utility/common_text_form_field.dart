import 'package:burnout_mobile/constants/sizes.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField({
    Key? key,
    this.labelText,
    required this.fillColor,
    required this.borderFocusColorBorder,
    required this.controller,
    this.labelTextFontSize,
    this.keyboardType,
    this.contentPadding,
    this.validator,
  }) : super(key: key);

  final String? labelText;
  final Color fillColor;
  final Color borderFocusColorBorder;
  final double? labelTextFontSize;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validator;

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      textAlign: TextAlign.center,
      maxLines: Sizes.textFormFieldMaxLine,
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      cursorColor: Colors.black,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        isDense: true,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: AppTheme.greyPrimary200,
          fontSize: widget.labelTextFontSize,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: widget.fillColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.fillColor),
          borderRadius: BorderRadius.circular(Sizes.textFormFieldBorderRadius),
        ),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderFocusColorBorder),
          borderRadius: BorderRadius.circular(Sizes.textFormFieldBorderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderFocusColorBorder),
          borderRadius: BorderRadius.circular(Sizes.textFormFieldBorderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppTheme.redPrimary100),
          borderRadius: BorderRadius.circular(Sizes.textFormFieldBorderRadius),
          gapPadding: 0,
        ),
        errorStyle: const TextStyle(
            fontSize: Sizes.textFormFieldErrorFontSize,
            height: Sizes.textFormFieldErrorHeihgt),
      ),
    );
  }
}
