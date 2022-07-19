import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../data_models/machine_dashboard_expansional_setting_menu.dart';

class MachineDashboardExpansionalSetting extends StatefulWidget {
  const MachineDashboardExpansionalSetting({
    Key? key,
    required this.expansionTitle,
    required this.leadingExpansionTileIcon,
    required this.expansionSubTitle,
    required this.trailingExpansionTileIcon,
    required this.expansionalExpandMenu,
  }) : super(key: key);

  final IconData leadingExpansionTileIcon;
  final String expansionTitle;
  final String expansionSubTitle;
  final IconData trailingExpansionTileIcon;
  final List<MachineDashboardExpansionalSettingMenu> expansionalExpandMenu;

  @override
  State<MachineDashboardExpansionalSetting> createState() =>
      _MachineDashboardExpansionalSettingState();
}

class _MachineDashboardExpansionalSettingState
    extends State<MachineDashboardExpansionalSetting> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(
        widget.leadingExpansionTileIcon,
        color: AppTheme.yellowPrimary,
      ),
      title: Text(widget.expansionTitle),
      subtitle: Text(widget.expansionSubTitle),
      trailing: _customTileExpanded
          ? const Icon(
              PhosphorIcons.caretRight,
              size: MachineDashboardSizes
                  .machineDashboardSettingExpasnsionalTrailingSize,
            )
          : const Icon(
              PhosphorIcons.caretDown,
              size: MachineDashboardSizes
                  .machineDashboardSettingExpasnsionalTrailingSize,
            ),
      children: widget.expansionalExpandMenu
          .map(
            (data) => ListTile(
              title: Text(data.machineDashboardExpansionalSettingMenuTitle),
              subtitle: Column(
                  children: data.machineDashboardExpansionalSettingMenuSubtitle
                      .map((data) => Text(data))
                      .toList()),
              trailing: IconButton(
                icon: Icon(data.machineDashboardExpansionalSettingMenuIconData),
                onPressed: data.machineDashboardExpansionalSettingOnPress,
              ),
            ),
          )
          .toList(),
      onExpansionChanged: (bool expanded) {
        setState(() => _customTileExpanded = expanded);
      },
    );
  }
}
