import 'package:flutter/material.dart';

class MachineDashboardExpansionalSettingMenu {
  MachineDashboardExpansionalSettingMenu({
    required this.machineDashboardExpansionalSettingMenuTitle,
    required this.machineDashboardExpansionalSettingMenuSubtitle,
    required this.machineDashboardExpansionalSettingMenuIconData,
    required this.machineDashboardExpansionalSettingOnPress,
  });

  final String machineDashboardExpansionalSettingMenuTitle;
  final List<String> machineDashboardExpansionalSettingMenuSubtitle;

  final IconData machineDashboardExpansionalSettingMenuIconData;
  final VoidCallback machineDashboardExpansionalSettingOnPress;
}
