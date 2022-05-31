import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class CommonCheckbox extends StatefulWidget {
  const CommonCheckbox({Key? key, required this.isCheck, required this.onCheck})
      : super(key: key);

  final bool isCheck;
  final Function(bool?) onCheck;

  @override
  State<CommonCheckbox> createState() => _CommonCheckboxState();
}

class _CommonCheckboxState extends State<CommonCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.isCheck,
      onChanged: widget.onCheck,
      checkColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MachineDashboardSizes
              .machineDashboardUtilitySettingAdditionalCheckboxBorderRadius)),
      activeColor: AppTheme.yellowPrimary,
    );
  }
}
