import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_peripheral_zone.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_status.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_temperature.dart';
import 'package:flutter/material.dart';

class MachineDashboardPage extends StatelessWidget {
  const MachineDashboardPage({Key? key, required this.machinePayload})
      : super(key: key);

  final MockMachinePayload machinePayload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: MachineDashboardSizes.machineDashboardPagePadding,
        child: Column(children: [
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
                      indent:
                          MachineDashboardSizes.machineDashboardWidgetSpacing,
                      color: Colors.transparent,
                    ),
                itemCount: machinePayload.machineTemperature!.length),
          ),
          const SizedBox(
            height: MachineDashboardSizes.machineDashboardWidgetSpacing,
          ),
          SizedBox(
            height: MachineDashboardSizes.machineDashboardTemperatureHeight,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return MachineDashboardPeripheralZone(
                      machinePeripheral:
                          machinePayload.machinePeripheral![index]);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      indent: MachineDashboardSizes
                          .machineDashboardPeripheralItemSpacing,
                      color: Colors.transparent,
                    ),
                itemCount: machinePayload.machinePeripheral!.length),
          ),
        ]),
      ),
    );
  }
}
