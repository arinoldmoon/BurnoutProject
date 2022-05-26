import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_peripheral_zone_provider.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_peripheral_zone.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_status.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_temperature.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineDashboardPageOperating extends StatelessWidget {
  const MachineDashboardPageOperating({Key? key, required this.machinePayload})
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
          SizedBox(
            height: MachineDashboardSizes.machineDashboardTemperatureHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return MachineDashboardTemperature(
                    machineTemperature:
                        machinePayload.machineTemperature![index]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                indent: MachineDashboardSizes.machineDashboardWidgetSpacing,
                color: Colors.transparent,
              ),
              itemCount: machinePayload.machineTemperature!.length,
            ),
          ),
          const SizedBox(
            height: MachineDashboardSizes.machineDashboardWidgetSpacing,
          ),
          SizedBox(
            height: MachineDashboardSizes.machineDashboardTemperatureHeight,
            child: Consumer<MachineDashboardPeripheralZoneProvider>(
              builder: (context, value, child) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return MachineDashboardPeripheralZone(
                        machinePeripheral: value.machinePeripheralZone[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    indent: MachineDashboardSizes
                        .machineDashboardPeripheralItemSpacing,
                    color: Colors.transparent,
                  ),
                  itemCount: context
                      .watch<MachineDashboardPeripheralZoneProvider>()
                      .count,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
