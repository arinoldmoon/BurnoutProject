import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class CommonCloseButton extends StatefulWidget {
  const CommonCloseButton({Key? key, required this.onPress}) : super(key: key);

  final VoidCallback onPress;

  @override
  State<CommonCloseButton> createState() => _CommonCloseButtonState();
}

class _CommonCloseButtonState extends State<CommonCloseButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPress,
      style: ElevatedButton.styleFrom(
        primary: AppTheme.redPrimary100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            MachineDashboardSizes.machineDashboardPageCancelButtonRadius,
          ),
        ),
      ),
      child: const FittedBox(
        fit: BoxFit.fitWidth,
        child: Icon(Icons.close),
      ),
    );
  }
}
