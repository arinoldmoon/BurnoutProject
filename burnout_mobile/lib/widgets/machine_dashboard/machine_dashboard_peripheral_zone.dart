import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class MachineDashboardPeripheralZone extends StatefulWidget {
  const MachineDashboardPeripheralZone(
      {Key? key, required this.machinePeripheral})
      : super(key: key);

  final MachinePeripheral machinePeripheral;

  @override
  State<MachineDashboardPeripheralZone> createState() =>
      _MachineDashboardPeripheralZoneState();
}

class _MachineDashboardPeripheralZoneState
    extends State<MachineDashboardPeripheralZone> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MachineDashboardSizes.machineDashboardPeripheralHeight,
      width: MachineDashboardSizes.machineDashboardPeripheralWidth,
      padding: MachineDashboardSizes.machineDashboardPeripheralPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            MachineDashboardSizes.machineDashboardTemperatureBorderRadius),
        color: Colors.white,
      ),
      child: _buildPeripheralState(),
    );
  }

  Widget _buildPeripheralState() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: widget.machinePeripheral.machineOnOffStatus ==
                    MachineOnOffStatus.ON
                ? Border.all(color: AppTheme.greenPrimary)
                : Border.all(color: AppTheme.redPrimary),
          ),
          child: Icon(
            Icons.circle,
            size: MachineDashboardSizes
                .machineDashboardTemperaturePeripheralStatusIconsize,
            color: widget.machinePeripheral.machineOnOffStatus ==
                    MachineOnOffStatus.ON
                ? AppTheme.greenPrimary.withOpacity(0.8)
                : AppTheme.redPrimary.withOpacity(0.8),
          ),
        ),
        const SizedBox(
          width:
              MachineDashboardSizes.machineDashboardPeripheralIconNameSpacing,
        ),
        Text(
          machineDashboardPeripheralName(widget.machinePeripheral),
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  static String machineDashboardPeripheralName(
      MachinePeripheral machinePeripheral) {
    switch (machinePeripheral.machinePeripheralType) {
      case MachinePeripheralType.DOOR:
        return MachineDashboardUiStrings.machineDashboardPeripheraleDoor;
      case MachinePeripheralType.AIRFLOW:
        return MachineDashboardUiStrings.machineDashboardPeripheralAirFlow;
    }
  }
}
