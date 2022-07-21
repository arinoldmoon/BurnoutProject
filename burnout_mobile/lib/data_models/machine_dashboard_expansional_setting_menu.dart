import 'package:flutter/material.dart';

class MachineDashboardExpansionalSettingMenu {
  MachineDashboardExpansionalSettingMenu({
    required this.machineDashboardExpansionalSettingMenuTitle,
    required this.machineDashboardExpansionalSettingValue,
    required this.machineDashboardExpansionalSettingMenuIconData,
    required this.machineDashboardExpansionalSettingOnPress,
  });

  final String machineDashboardExpansionalSettingMenuTitle;
  final List<String> machineDashboardExpansionalSettingValue;

  final IconData machineDashboardExpansionalSettingMenuIconData;
  final VoidCallback machineDashboardExpansionalSettingOnPress;
}
