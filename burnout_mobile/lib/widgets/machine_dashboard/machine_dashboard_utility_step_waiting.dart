import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_utility_step_provider.dart';
import 'package:burnout_mobile/provider/machine_data_provider.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class MachineDashboardUtilityStepWaiting extends StatefulWidget {
  const MachineDashboardUtilityStepWaiting({Key? key}) : super(key: key);

  @override
  State<MachineDashboardUtilityStepWaiting> createState() =>
      _MachineDashboardUtilityStepWaitingState();
}

class _MachineDashboardUtilityStepWaitingState
    extends State<MachineDashboardUtilityStepWaiting> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      key: const Key('ListViewStepWaiting'),
      onReorder: (oldIndex, newIndex) {
        context.read<MachineDataProvider>().reOrder(oldIndex, newIndex);
      },
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (_, index) {
        return _buildListTileStep(
            context
                .read<MachineDataProvider>()
                .machineDashboardUtilityStepList[index],
            context,
            index);
      },
      itemCount: context
          .read<MachineDataProvider>()
          .countMachineDashboardUtilityStepList,
    );
  }

  Widget _buildListTileStep(
      MachineUtilityStep machineUtilityStep, BuildContext context, int index) {
    return Card(
      shadowColor: Colors.transparent,
      elevation: MachineDashboardSizes.machineDashboardUtilityStepCardElevation,
      key: Key('$index'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              MachineDashboardSizes.machineDashboardUtilityStepListTileRadius)),
      color: (() {
        switch (machineUtilityStep.machineUtilityStepStatus) {
          case MachineUtilityStepStatus.DONE:
            return AppTheme.greyPrimary100;
          case MachineUtilityStepStatus.WORKINGON:
            return AppTheme.yellowPrimary200;
          case MachineUtilityStepStatus.UPCOMING:
            return Colors.white;
        }
      }()),
      child: ListTile(
        key: const Key('listTileStepWaiting'),
        contentPadding: MachineDashboardSizes
            .machineDashboardUtilityStepListTileContentPadding,
        leading: (() {
          switch (machineUtilityStep.machineUtilityStepProcess) {
            case MachineUtilityStepProcess.COOLING:
              return const Icon(
                PhosphorIcons.arrowDownRight,
                key: Key('coolingStepIcon'),
                size: MachineDashboardSizes
                    .machineDashboardUtilityStepListTileIconSize,
                color: AppTheme.bluePrimary,
              );
            case MachineUtilityStepProcess.HEATING:
              return const Icon(
                PhosphorIcons.arrowUpRight,
                key: Key('heatingStepIcon'),
                size: MachineDashboardSizes
                    .machineDashboardUtilityStepListTileIconSize,
                color: AppTheme.redPrimary100,
              );
            case MachineUtilityStepProcess.MAINTAIN:
              return const Icon(
                PhosphorIcons.arrowRight,
                key: Key('maintainStepIcon'),
                size: MachineDashboardSizes
                    .machineDashboardUtilityStepListTileIconSize,
                color: AppTheme.greenPrimary100,
              );
          }
        }()),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              machineUtilityStep.machineUtilityStepTitle,
              key: const Key('stepTitle'),
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              MachineDashboardUiStrings.machineDashboardTemperatureTempDigit(
                      machineUtilityStep.machineUtilityStepTemp) +
                  '°C',
              key: const Key('stepTemp'),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              MachineDashboardUiStrings.machineDashboardHourRemaining(
                  machineUtilityStep.machineUtilityStepTimeRemaining),
              key: const Key('stepTimeRemaining'),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
