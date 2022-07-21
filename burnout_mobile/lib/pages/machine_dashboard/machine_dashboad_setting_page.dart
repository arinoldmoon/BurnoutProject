import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_data_provider.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_expansional_setting.dart';
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../data_models/machine_dashboard_expansional_setting_menu.dart';

class MachineDashboardSettingPage extends StatelessWidget {
  const MachineDashboardSettingPage({Key? key, required this.machinePayload})
      : super(key: key);

  final MockMachinePayload machinePayload;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return MachineDataProvider();
      },
      child: Scaffold(
        body: Consumer<MachineDataProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                MachineDashboardExpansionalSetting(
                  expansionTitle: MachineDashboardUiStrings
                      .machineDashboardExpansionSettingAboutMachine,
                  leadingExpansionTileIcon: PhosphorIcons.info,
                  expansionSubTitle: MachineDashboardUiStrings
                      .machineDashboardExpansionSettingAboutMachineSubTitle,
                  trailingExpansionTileIcon: PhosphorIcons.caretRight,
                  expansionalExpandMenu: [
                    MachineDashboardExpansionalSettingMenu(
                      machineDashboardExpansionalSettingMenuIconData:
                          PhosphorIcons.pen,
                      machineDashboardExpansionalSettingValue: [
                        value.getMockMachinePayloadOnProgram.machineModel
                      ],
                      machineDashboardExpansionalSettingMenuTitle: '',
                      machineDashboardExpansionalSettingOnPress: () {},
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
