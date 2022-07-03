import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  const CommonButton({
    Key? key,
    required this.buttonTitle,
    required this.onPress,
    required this.fontSize,
    required this.buttonColor,
  }) : super(key: key);

  final String buttonTitle;
  final VoidCallback onPress;
  final TextStyle? fontSize;
  final Color buttonColor;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        widget.buttonTitle,
        style: widget.fontSize!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: widget.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            MachineDashboardSizes.machineDashboardPageCancelButtonRadius,
          ),
        ),
      ),
      onPressed: widget.onPress,
    );
  }
}
