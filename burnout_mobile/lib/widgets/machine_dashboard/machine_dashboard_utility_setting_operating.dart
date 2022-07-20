import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/provider/machine_data_provider.dart';

import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/utility/common_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineDashboardUtilitySettingOperating extends StatelessWidget {
  const MachineDashboardUtilitySettingOperating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MachineDataProvider(),
      child: Consumer<MachineDataProvider>(
        builder: (context, value, child) {
          return Padding(
            padding:
                MachineDashboardSizes.machineDashboardUtilityContainerPadding,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildTubeHeater(
                      value.machineUtilitySetting
                          .machineUtilitySettingTubeOnTempReach
                          .toString(),
                      context,
                      const Key('TubeHeater')),
                  _buildDivider(),
                  _buildFloorHeater(
                      value.machineUtilitySetting
                          .machineUtilitySettingFloorOnTempReach
                          .toString(),
                      context,
                      const Key('FloorHeater')),
                  _buildDivider(),
                  _buildAfterBurner(
                      value.machineUtilitySetting
                          .machineUtilitySettingAfterBurnerOnTempReach
                          .toString(),
                      value.machineUtilitySetting
                          .machineUtilitySettingAfterBurnerOffTempReach
                          .toString(),
                      value.machineUtilitySetting
                          .machineUtilitySettingAfterBurnerTurnOffDelay
                          .toString(),
                      context,
                      const Key('AfterBurner')),
                  _buildDivider(),
                  _buildOverHeatAlarm(
                      value.machineUtilitySetting
                          .machineUtilitySettingOverHeatAlarmOvenTempLimit
                          .toString(),
                      value.machineUtilitySetting
                          .machineUtilitySettingOverHeatAlarmAfterBurnerTempLimit
                          .toString(),
                      context,
                      const Key('HeatAlarm')),
                  _buildDivider(),
                  _buildAirFlowSetting(
                      value.machineUtilitySetting
                          .machineUtilitySettingAirFlowOnTempReach
                          .toString(),
                      value.machineUtilitySetting
                          .machineUtilitySettingAirFlowOffTempReach
                          .toString(),
                      value.machineUtilitySetting
                          .machineUtilitySettingAirFlowTurnOffDelay
                          .toString(),
                      context,
                      const Key('AirflowSetting')),
                  _buildDivider(),
                  _buildAdditionalSetting(
                      value.machineUtilitySetting
                          .machineUtilitySettingAdditionalHoldLastStep,
                      value.machineUtilitySetting
                          .machineUtilitySettingAdditionalScheduleOperationStatus,
                      context,
                      const Key('AdditionalSetting')),
                  _buildDivider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      thickness:
          MachineDashboardSizes.machineDashboardUtilitySettingDividerThickness,
      color: AppTheme.greyPrimary100,
    );
  }

  Widget _buildTubeHeater(String data, BuildContext context, Key key) {
    print('TubeHeater');
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
        key: key,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MachineDashboardUiStrings.machineDashboardUtilitySettingTubeHeater,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            children: [
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingOnCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                data,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloorHeater(String data, BuildContext context, Key key) {
    print('FloorHeater');
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
        key: key,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MachineDashboardUiStrings.machineDashboardUtilitySettingFloorHeater,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            children: [
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingOnCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                data,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAfterBurner(String onTempReach, String offTempReach,
      String turnOffDelay, BuildContext context, Key key) {
    print('AfterBurner');
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
        key: key,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MachineDashboardUiStrings.machineDashboardUtilitySettingAfterBurner,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            children: [
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingOnCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                onTempReach,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            children: [
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingOffCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                offTempReach,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            children: [
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingTurnOffDelayCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                turnOffDelay,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverHeatAlarm(String ovenTempLimit, String afterBurnerTempLimit,
      BuildContext context, Key key) {
    print('OverHeatAlarm');
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
        key: key,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MachineDashboardUiStrings
                .machineDashboardUtilitySettingOverHeatAlarm,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            children: [
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingOvenTempLimitCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                ovenTempLimit,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            children: [
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingOvenAfterBurnerTempLimitCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                afterBurnerTempLimit,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAirFlowSetting(String onTempReach, String offTempReach,
      String turnOffDelay, BuildContext context, Key key) {
    print('AirFlow');
    return Padding(
      key: const Key('AirFLowSetting'),
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
        key: key,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MachineDashboardUiStrings
                .machineDashboardUtilitySettingAirFlowSetting,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            children: [
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingOnCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                onTempReach,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            children: [
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingOffCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                offTempReach,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            children: [
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingTurnOffDelayCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                turnOffDelay,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalSetting(bool holdLastStepStatus, bool scheduleStatus,
      BuildContext context, Key key) {
    print('Additional');
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
        key: key,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MachineDashboardUiStrings
                .machineDashboardUtilitySettingAdditionalSetting,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonCheckbox(
                key: const Key('HoldLastStepCheckbox'),
                isCheck: holdLastStepStatus,
                onCheck: (isChecked) {
                  context
                      .read<MachineDataProvider>()
                      .isCheckAdditionalHoldLastStep(isChecked);
                },
              ),
              const SizedBox(
                  width: MachineDashboardSizes
                      .machineDashboardUtilitySettingAdditionalCheckboxSpacing),
              Text(
                MachineDashboardUiStrings
                    .machineDashboardUtilitySettingOnCaption,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          const SizedBox(
              height: MachineDashboardSizes
                  .machineDashboardUtilitySettingItemSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonCheckbox(
                key: const Key('ScheduleCheckbox'),
                isCheck: scheduleStatus,
                onCheck: (isChecked) {
                  context
                      .read<MachineDataProvider>()
                      .isCheckAdditionalScheduleOperation(isChecked);
                },
              ),
              const SizedBox(
                  width: MachineDashboardSizes
                      .machineDashboardUtilitySettingAdditionalCheckboxSpacing),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MachineDashboardUiStrings
                        .machineDashboardUtilitySettingScheduleOperation,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Row(
                    children: [
                      Text(
                        MachineDashboardUiStrings
                            .machineDashboardUtilitySettingStartAt,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        MachineDashboardUiStrings
                            .machineDashboardUtilitySettingStartAt,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
