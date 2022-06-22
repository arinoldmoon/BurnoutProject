import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_peripheral_zone_provider.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_peripheral_zone.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_status.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_temperature.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineDashboardPageWaiting extends StatelessWidget {
  const MachineDashboardPageWaiting({Key? key, required this.machinePayload})
      : super(key: key);

  final MockMachinePayload machinePayload;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return MachineDashboardPeripheralZoneProvider();
          },
        ),
      ],
      child: Column(
        children: [
          MachineDashboardStatus(
            mockMachinePayload: machinePayload,
          ),
          const SizedBox(
            height: MachineDashboardSizes.machineDashboardWidgetSpacing,
          ),
          const MachineDashboardUtility(
            machineStatus: MachineStatusRun.WAITING,
          ),
        ],
      ),
    );
  }
}
