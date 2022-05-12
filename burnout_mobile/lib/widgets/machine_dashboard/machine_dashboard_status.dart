import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class MachineDashboardStatus extends StatefulWidget {
  const MachineDashboardStatus({Key? key, required this.mockMachinePayload})
      : super(key: key);

  final MockMachinePayload mockMachinePayload;

  @override
  State<MachineDashboardStatus> createState() => _MachineDashboardStatusState();
}

class _MachineDashboardStatusState extends State<MachineDashboardStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: MachineDashboardSizes.machineDashboardStatusMargin,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                MachineDashboardSizes.machineDashBoardBorderRadius),
            color: Colors.white),
        child: _buildMachineStatus(widget.mockMachinePayload.machineStatus));
  }

  Text _buildTitleText() {
    return Text(
      MachineDashboardUiStrings.machineDashboardStatus,
      style: Theme.of(context)
          .textTheme
          .headline6
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  GestureDetector _buildMachineIdleButton(String buttonText, IconData icon) {
    return GestureDetector();
  }

  Widget _buildMachineStatus(MachineStatus machineStatus) {
    switch (machineStatus) {
      case MachineStatus.IDLE:
        return _buildMachineStatusIdle();
      case MachineStatus.WAITING:
        return _buildMachineStatusWaiting();
      case MachineStatus.ONPROGRAM:
        return _buildMachineStatusOnProgram();
    }
  }

  Widget _buildMachineStatusIdle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitleText(),
            Text(
              MachineDashboardUiStrings.machineDashboardIdle,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.redPrimary,
                  ),
            )
          ],
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ),
      ],
    );
  }

  Widget _buildMachineStatusWaiting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTitleText(),
        Text(
          MachineDashboardUiStrings.machineDashboardIdle,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.yellowPrimary,
              ),
        )
      ],
    );
  }

  Widget _buildMachineStatusOnProgram() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTitleText(),
        Text(
          MachineDashboardUiStrings.machineDashboardIdle,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.greenPrimary,
              ),
        )
      ],
    );
  }
}
