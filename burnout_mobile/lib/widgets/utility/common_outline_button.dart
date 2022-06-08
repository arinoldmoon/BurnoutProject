import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/pages/machine_dashboard/machine_dashboard_page.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class CommonOutlineButton extends StatefulWidget {
  const CommonOutlineButton(
      {Key? key,
      required this.titlieButton,
      required this.appthemeColor,
      required this.onPress})
      : super(key: key);

  final Widget titlieButton;
  final Color appthemeColor;
  final VoidCallback onPress;

  @override
  State<CommonOutlineButton> createState() => _CommonOutlineButtonState();
}

class _CommonOutlineButtonState extends State<CommonOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPress,
      child: widget.titlieButton,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: widget.appthemeColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              MachineDashboardSizes.machineDashboardUtilityEditProgramProgram),
        ),
      ),
    );
  }
}
