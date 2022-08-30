import 'package:burnout_mobile/constants/machine_setting/machine_setting_sizes.dart';
import 'package:burnout_mobile/data_models/machine_setting_panel_list.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MachineSettingExpandPanel extends StatefulWidget {
  const MachineSettingExpandPanel({Key? key}) : super(key: key);

  @override
  State<MachineSettingExpandPanel> createState() =>
      _MachineSettingExpandPanelState();
}

class _MachineSettingExpandPanelState extends State<MachineSettingExpandPanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: MachineSettingPanelList.machineSettingPanelList.map((item) {
      return _buildExpansionTile(item);
    }).toList());
  }

  Widget _buildExpansionTile(MachineSettingPanelList item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            MachineSettingSizes.machineSettingExpansionTileBorderRadius),
      ),
      child: ExpansionTile(
        leading: Icon(
          item.leadingIcon,
          color: AppTheme.yellowPrimary,
        ),
        title: Text(
          item.headerValue,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          item.subTitleValue,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Icon(
          item.isExpanded ? PhosphorIcons.caretDown : PhosphorIcons.caretRight,
          color: AppTheme.greyPrimary,
        ),
        children: [
          Column(
            children: item.expandedValue.map(
              (expandItem) {
                return ListTile(
                  title: Text(
                    expandItem,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                );
              },
            ).toList(),
          ),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => item.isExpanded = expanded);
        },
      ),
    );
  }
}
