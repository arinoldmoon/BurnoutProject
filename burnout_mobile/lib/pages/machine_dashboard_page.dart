import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: machinePayload.machineTemperature!
                  .map((data) =>
                      MachineDashboardTemperature(machineTemperature: data))
                  .toList(),
            ),
          ),
        ]),
      ),
    );
  }
}
