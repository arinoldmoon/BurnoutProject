import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_peripheral_zone_provider.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_peripheral_zone.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_status.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_temperature.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineDashboardPage extends StatelessWidget {
  const MachineDashboardPage({Key? key, required this.machinePayload})
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
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
            color: AppTheme.titleAppbarIconColor,
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                machinePayload.machineName,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: MachineDashboardSizes.machineDashboardPageTitleSpacing,
              ),
              Text(machinePayload.machineModel,
                  style: Theme.of(context).textTheme.headline5),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded),
              onPressed: () {},
              color: AppTheme.titleAppbarIconColor,
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: MachineDashboardSizes.machineDashboardPagePadding,
          child: _buildPage(),
        ),
      ),
    );
  }

  Widget _buildPage() {
    switch (machinePayload.machineStatus) {
      case MachineStatus.ONPROGRAM:
        return Column(
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
                            machinePeripheral:
                                value.machinePeripheralZone[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                            indent: MachineDashboardSizes
                                .machineDashboardPeripheralItemSpacing,
                            color: Colors.transparent,
                          ),
                      itemCount: context
                          .watch<MachineDashboardPeripheralZoneProvider>()
                          .count);
                },
              ),
            ),
          ],
        );
      case MachineStatus.IDLE:
        return Container();
      case MachineStatus.WAITING:
        return Container();
    }
  }
}
