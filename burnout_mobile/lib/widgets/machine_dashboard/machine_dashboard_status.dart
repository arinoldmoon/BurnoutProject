import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
        padding: MachineDashboardSizes.machineDashboardStatusPadding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                MachineDashboardSizes.machineDashboardBorderRadius),
            color: Colors.white),
        child: _buildMachineStatus(widget.mockMachinePayload.machineStatus));
  }

  Text _buildTitleText(String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.normal),
    );
  }

  GestureDetector _buildMachineIdleButton(
      String buttonText, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: AppTheme.yellowPrimary,
            ),
            Text(
              buttonText,
              style: Theme.of(context).textTheme.button,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMachineStatusWaitingStatus() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: MachineDashboardSizes.machineDashboardSpaceBetween,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitleText(
                MachineDashboardUiStrings.machineDashboardProgramName),
            Text(
              widget.mockMachinePayload.machineProgram!,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: MachineDashboardSizes.machineDashboardSpaceBetween,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitleText(
                MachineDashboardUiStrings.machineDashboardNumberOfSteps),
            Text(
              "${widget.mockMachinePayload.machineProgramSteps!}",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildOnProgramPercentLinear() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LinearPercentIndicator(
          padding: MachineDashboardSizes.machineDashboardLinearindicatorPadding,
          percent: widget.mockMachinePayload.machineOnProgramPercent!,
          progressColor: AppTheme.yellowPrimary,
          lineHeight:
              MachineDashboardSizes.machineDashboardLinearindicatorHeight,
        ),
        const SizedBox(
          height: MachineDashboardSizes.machineDashboardSpaceBetween,
        ),
        Padding(
          padding: MachineDashboardSizes.machineDashboardPercentPadding,
          child: Text(
            '${widget.mockMachinePayload.machineOnProgramPercent! * 100}%',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
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
            _buildTitleText(MachineDashboardUiStrings.machineDashboardStatus),
            Text(
              MachineDashboardUiStrings.machineDashboardIdle,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.redPrimary,
                  ),
            )
          ],
        ),
        const SizedBox(
          height: MachineDashboardSizes.machineDashboardSpaceBetween,
        ),
        Container(
          height: MachineDashboardSizes.machineDashboardIdleProgramHeight,
          padding: MachineDashboardSizes.machineDashboardIdleProgramPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMachineIdleButton(
                MachineDashboardUiStrings.machineDashboardNewProgram,
                Icons.add_circle_outline,
                () {},
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 2,
              ),
              _buildMachineIdleButton(
                  MachineDashboardUiStrings.machineDashboardLoadProgram,
                  Icons.drive_folder_upload_outlined,
                  () {})
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMachineStatusWaiting() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitleText(
              MachineDashboardUiStrings.machineDashboardStatus,
            ),
            Text(
              MachineDashboardUiStrings.machineDashboardWaiting,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.yellowPrimary,
                  ),
            )
          ],
        ),
        _buildMachineStatusWaitingStatus(),
      ],
    );
  }

  Widget _buildMachineStatusOnProgram() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitleText(
              MachineDashboardUiStrings.machineDashboardStatus,
            ),
            Text(
              MachineDashboardUiStrings.machineDashboardOnProgram,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.greenPrimary,
                  ),
            )
          ],
        ),
        _buildOnProgramPercentLinear(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.mockMachinePayload.machineTimeRemaing! / 60} hr ',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            Text(
              '${widget.mockMachinePayload.machineTimeRemaing! % 60} min remaining ',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ],
    );
  }
}
