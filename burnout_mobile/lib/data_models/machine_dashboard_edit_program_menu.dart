import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_edit_program_step.dart';
import 'package:flutter/material.dart';

class MachineDashboardEditProgramMenu {
  static const List<Tab> machineDashboardEditProgramMenu = [
    Tab(
      text: MachineDashboardUiStrings.machineDashboardEditProgramDialogStepMenu,
    ),
    Tab(
        text: MachineDashboardUiStrings
            .machineDashboardEditProgramDialogSettingMenu),
  ];

  static List<Widget> machineDashboardEdiProgramTabbarView = [
    const MachineDashboardEditProgramStep(),
    Container(),
  ];
}
