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
    return Row(
      key: const Key('machineTempWidget'),
      children: [
        Container(
          height: MachineDashboardSizes.machineDashboardTemperatureHeight,
          width: MachineDashboardSizes.machineDashboardTemperatureWidth,
          padding: MachineDashboardSizes.machineDashboardTemperaturePadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                MachineDashboardSizes.machineDashboardTemperatureBorderRadius),
            color: Colors.white,
          ),
          child: _buildTempState(),
        ),
      ],
    );
  }

  Widget _buildTempState() {
    switch (widget.machineTemperature.machineHeaterStatus!) {
      case MachineOnOffStatus.ON:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              PhosphorIcons.thermometer_simple,
              key: Key('machineTempIconOn'),
              color: AppTheme.greenPrimary,
              size: MachineDashboardSizes.machineDashboardTemperatureIconSize,
            ),
            const SizedBox(
              width: MachineDashboardSizes
                  .machineDashboardTemperatureIconTempSpacing,
            ),
            _buildTempText()
          ],
        );

      case MachineOnOffStatus.OFF:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              PhosphorIcons.thermometer_simple,
              key: Key('machineTempIconOff'),
              color: AppTheme.redPrimary,
              size: MachineDashboardSizes.machineDashboardTemperatureIconSize,
            ),
            const SizedBox(
              width: MachineDashboardSizes
                  .machineDashboardTemperatureIconTempSpacing,
            ),
            _buildTempText()
          ],
        );
    }
  }

  Widget _buildTempText() {
    return Column(
      key: const Key('machineTempText'),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MachineDashboardUiStrings.machineDashboardTemperatureTempDigit(
                  widget.machineTemperature.machineTemp!),
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
          machineDashboardTemperatureName(widget.machineTemperature),
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  static String machineDashboardTemperatureName(
      MachineTemperature machineTemperature) {
    switch (machineTemperature.machineTempName!) {
      case MachineHeater.FLOOR:
        return MachineDashboardUiStrings.machineDashboardTemperatureFloor;
      case MachineHeater.AFB:
        return MachineDashboardUiStrings.machineDashboardTemperatureAfb;
      case MachineHeater.OVEN:
        return MachineDashboardUiStrings.machineDashboardTemperatureOven;
      case MachineHeater.TUBE:
        return MachineDashboardUiStrings.machineDashboardTemperatureTube;
    }
  }
}
