import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_utility_setting_provider.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/utility/common_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MachineDashboardUtilitySettingOperating extends StatelessWidget {
  const MachineDashboardUtilitySettingOperating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilityContainerPadding,
      child: Column(
        children: [
          _buildTubeHeater(context),
          _buildDivider(),
          _buildFloorHeater(context),
          _buildDivider(),
          _buildAfterBurner(context),
          _buildDivider(),
          _buildOverHeatAlarm(context),
          _buildDivider(),
          _buildAirFlowSetting(context),
          _buildDivider(),
          _buildAdditionalSetting(context),
          _buildDivider(),
        ],
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

  Widget _buildTubeHeater(BuildContext context) {
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloorHeater(BuildContext context) {
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAfterBurner(BuildContext context) {
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverHeatAlarm(BuildContext context) {
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAirFlowSetting(BuildContext context) {
    return Padding(
      padding: MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
      child: Column(
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalSetting(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MachineDashboardUtilitySettingProvider(),
      child: Padding(
        padding:
            MachineDashboardSizes.machineDashboardUtilitySettingItemPadding,
        child: Column(
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
                Consumer<MachineDashboardUtilitySettingProvider>(
                  builder: (context, value, child) {
                    return CommonCheckbox(
                      isCheck: value.machineUtilitySetting
                          .machineUtilitySettingAdditionalHoldLastStep,
                      onCheck: (isChecked) {
                        value.isCheckAdditionalHoldLastStep(isChecked);
                      },
                    );
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
                Consumer<MachineDashboardUtilitySettingProvider>(
                  builder: (context, value, child) {
                    return CommonCheckbox(
                      isCheck: value.machineUtilitySetting
                          .machineUtilitySettingAdditionalScheduleOperationStatus,
                      onCheck: (isChecked) {
                        value.isCheckAdditionalScheduleOperation(isChecked);
                      },
                    );
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
      ),
    );
  }
}
