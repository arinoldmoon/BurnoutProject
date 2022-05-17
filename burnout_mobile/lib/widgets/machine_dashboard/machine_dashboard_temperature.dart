import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class MachineDashboardTemperature extends StatefulWidget {
  const MachineDashboardTemperature(
      {Key? key, required this.machineTemperature})
      : super(key: key);

  final MachineTemperature machineTemperature;

  @override
  State<MachineDashboardTemperature> createState() =>
      _MachineDashboardTemperatureState();
}

class _MachineDashboardTemperatureState
    extends State<MachineDashboardTemperature> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MachineDashboardSizes.machineDashboardTemperatureHeight,
      width: MachineDashboardSizes.machineDashboardTemperatureWidth,
      padding: MachineDashboardSizes.machineDashboardTemperaturePadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            MachineDashboardSizes.machineDashboardTemperatureBorderRadius),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildTempState(widget.machineTemperature)],
      ),
    );
  }

  Widget _buildTempState(MachineTemperature machineTemperature) {
    switch (machineTemperature.machineHeaterStatus!) {
      case MachineHeaterStatus.ON:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              PhosphorIcons.thermometer_simple,
              color: AppTheme.greenPrimary,
              size: MachineDashboardSizes.machineDashboardIconSize,
            ),
            const SizedBox(
              width: MachineDashboardSizes.machineDashboardIconTempSpacing,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MachineDashboardUiStrings
                          .machineDashboardTemperatureTempDigit(
                              machineTemperature.machineTemp!),
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      MachineDashboardUiStrings
                          .machineDashboardTemperatureCelciusSymbol,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Text(
                  MachineDashboardUiStrings.machineDashboardTemperatureName(
                      machineTemperature),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        );

      case MachineHeaterStatus.OFF:
        return const Icon(
          PhosphorIcons.thermometer_simple,
          color: AppTheme.redPrimary,
        );
    }
  }
}
