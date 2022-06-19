import 'package:burnout_mobile/constants/sizes.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField(
      {Key? key,
      required this.labelText,
      required this.fillColor,
      required this.borderFocusColorBorder,
      required this.controller,
      this.labelTextFontSize})
      : super(key: key);

  final String labelText;
  final Color fillColor;
  final Color borderFocusColorBorder;
  final double? labelTextFontSize;
  final TextEditingController controller;

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
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
      ),
    );
  }
}
