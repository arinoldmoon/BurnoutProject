import 'package:burnout_mobile/constants/sizes.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField({Key? key, required this.labelText})
      : super(key: key);

  final String labelText;

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: AppTheme.greyPrimary200),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
        fillColor: AppTheme.primaryBackGroungColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppTheme.yellowPrimary),
          borderRadius: BorderRadius.circular(Sizes.textFormFieldBorderRadius),
        ),
      ),
    );
  }
}
