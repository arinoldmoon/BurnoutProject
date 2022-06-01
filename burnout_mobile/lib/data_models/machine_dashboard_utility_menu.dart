import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility_setting_operating.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility_step_operating.dart';
import 'package:flutter/material.dart';

class MachineDashboardUtilityMenu {
  static const List<Tab> machineDashboardUtilityMenuOnProgram = [
    Tab(
      text: MachineDashboardUiStrings.machineDashboardUtilityMenuOnProgramGraph,
    ),
    Tab(
        text:
            MachineDashboardUiStrings.machineDashboardUtilityMenuOnProgramStep),
    Tab(
        text: MachineDashboardUiStrings
            .machineDashboardUtilityMenuOnProgramSetting),
  ];

  static List<Widget> machineDashboardUtilityMenuOnProgramTabbarView = [
    Container(
      alignment: Alignment.center,
      child: const Text(
        MachineDashboardUiStrings.machineDashboardUtilityMenuOnProgramGraph,
      ),
    ),
    const MachineDashboardUtilityStepOperating(),
    const MachineDashboardUtilitySettingOperating(),
  ];
}
