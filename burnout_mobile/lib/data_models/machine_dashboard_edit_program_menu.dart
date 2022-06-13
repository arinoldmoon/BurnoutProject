import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:flutter/material.dart';

class MachineDashboardEditProgramMenu {
  static const List<Tab> machineDashboardEditProgramMenu = [
    Tab(
      text: MachineDashboardUiStrings
          .machineDashboardTextFormFieldEditProgramStepMenu,
    ),
    Tab(
        text: MachineDashboardUiStrings
            .machineDashboardTextFormFieldEditProgramSettingMenu),
  ];

  static List<Widget> machineDashboardEdiProgramTabbarView = [
    Container(),
    Container(),
  ];
}
