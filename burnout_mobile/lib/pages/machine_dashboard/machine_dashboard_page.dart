import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_status.dart';
import 'package:flutter/material.dart';

class MachineDashboardPage extends StatelessWidget {
  const MachineDashboardPage({Key? key, required this.machinePayload})
      : super(key: key);

  final MockMachinePayload machinePayload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        padding: MachineDashboardSizes.machineDashboardPagePadding,
        child: Column(
          children: [
            MachineDashboardStatus(
              mockMachinePayload: machinePayload,
            ),
          ],
        ),
      ),
    );
  }
}
