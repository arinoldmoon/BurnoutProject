import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class CommonSubmitButton extends StatefulWidget {
  const CommonSubmitButton(
      {Key? key, required this.buttonTitle, required this.onPress})
      : super(key: key);

  final String buttonTitle;
  final VoidCallback onPress;

  @override
  State<CommonSubmitButton> createState() => _CommonCancelButtonState();
}

class _CommonCancelButtonState extends State<CommonSubmitButton> {
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
        primary: AppTheme.greenPrimary200,
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
