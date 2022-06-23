import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_peripheral_zone_provider.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_temperature_provider.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_peripheral_zone.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_status.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_temperature.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineDashboardPageOperating extends StatefulWidget {
  const MachineDashboardPageOperating({Key? key, this.machinePayload})
      : super(key: key);

  final MockMachinePayload? machinePayload;
  @override
  State<MachineDashboardPageOperating> createState() =>
      _MachineDashboardPageOperatingState();
}

class _MachineDashboardPageOperatingState
    extends State<MachineDashboardPageOperating> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return MachineDashboardPeripheralZoneProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return MachineDashboardTemperatureProvider();
          },
        ),
      ],
      child: Column(
        children: [
          MachineDashboardStatus(
            mockMachinePayload: widget.machinePayload,
          ),
          const SizedBox(
            height: MachineDashboardSizes.machineDashboardWidgetSpacing,
          ),
          SizedBox(
            height: MachineDashboardSizes.machineDashboardTemperatureHeight,
            child: Consumer<MachineDashboardTemperatureProvider>(
                builder: (context, value, child) {
              value.fetchMonitorDevice();
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return MachineDashboardTemperature(
                      machineTemperature:
                          value.machineTemperatureList[index]);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  indent: MachineDashboardSizes.machineDashboardWidgetSpacing,
                  color: Colors.transparent,
                ),
                itemCount: value.machineTemperatureList.length,
              );
            }),
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
          const SizedBox(
            height: MachineDashboardSizes.machineDashboardWidgetSpacing,
          ),
          const MachineDashboardUtility(
            machineStatus: MachineStatusRun.ONPROGRAM,
          ),
        ],
      ),
    );
  }
}
