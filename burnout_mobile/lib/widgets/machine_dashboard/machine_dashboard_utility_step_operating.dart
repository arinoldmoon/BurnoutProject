import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_utility_step_provider.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class MachineDashboardUtilityStepOperating extends StatelessWidget {
  const MachineDashboardUtilityStepOperating({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MachineDashboardUtilityStepProvider(),
      child: Consumer<MachineDashboardUtilityStepProvider>(
          builder: (context, value, child) {
        return ListView.separated(
          key: const Key('ListViewStepOperating'),
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (_, index) {
            return _buildStep(
                value.machineDashboardUtilityStepList[index], context);
          },
          itemCount: context.watch<MachineDashboardUtilityStepProvider>().count,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              indent:
                  MachineDashboardSizes.machineDashboardPeripheralItemSpacing,
              color: Colors.transparent,
            );
          },
        );
      }),
    );
  }

  Widget _buildStep(
      MachineUtilityStep machineUtilityStep, BuildContext context) {
    switch (machineUtilityStep.machineUtilityStepStatus) {
      case MachineUtilityStepStatus.DONE:
        return _buildListTileStep(
            AppTheme.greyPrimary100, machineUtilityStep, context);
      case MachineUtilityStepStatus.WORKINGON:
        return _buildListTileStep(
            AppTheme.yellowPrimary200, machineUtilityStep, context);
      case MachineUtilityStepStatus.UPCOMING:
        return _buildListTileStep(Colors.white, machineUtilityStep, context);
    }
  }

  Widget _buildListTileStep(Color listTileColor,
      MachineUtilityStep machineUtilityStep, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MachineDashboardSizes.machineDashboardUtilityStepListTileHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          MachineDashboardSizes.machineDashboardUtilityStepListTileRadius,
        ),
        color: listTileColor,
      ),
      child: ListTile(
        key: const Key('ListTileStepOperating'),
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
