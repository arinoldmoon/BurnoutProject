import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class CommonCancelButton extends StatefulWidget {
  const CommonCancelButton(
      {Key? key, required this.buttonTitle, required this.onPress})
      : super(key: key);

  final String buttonTitle;
  final VoidCallback onPress;

  @override
  State<CommonCancelButton> createState() => _CommonCancelButtonState();
}

class _CommonCancelButtonState extends State<CommonCancelButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        widget.buttonTitle,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
      style: ElevatedButton.styleFrom(
        primary: AppTheme.redPrimary100,
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
