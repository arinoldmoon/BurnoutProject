import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility_setting_operating.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility_step_operating.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility_step_waiting.dart';
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

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

  static List<Widget> machineDashboardUtilityMenuOnProgramTabbarViewOperating =
      [
    const Nil(),
    const MachineDashboardUtilityStepOperating(),
    const MachineDashboardUtilitySettingOperating(),
  ];

  static List<Widget> machineDashboardUtilityMenuOnProgramTabbarViewWaiting = [
    const Nil(),
    const MachineDashboardUtilityStepWaiting(),
    const MachineDashboardUtilitySettingOperating(),
  ];
}
