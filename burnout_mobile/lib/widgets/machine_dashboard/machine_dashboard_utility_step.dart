import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:flutter/material.dart';

class MachineDashboardUtilityStep extends StatelessWidget {
  const MachineDashboardUtilityStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        MachineDashboardUiStrings.machineDashboardUtilityMenuOnProgramStep,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
