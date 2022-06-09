import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/machine_dashboard_utility_menu.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/utility/common_outline_button.dart';
import 'package:flutter/material.dart';

class MachineDashboardUtility extends StatelessWidget {
  const MachineDashboardUtility({Key? key, required this.machineStatus})
      : super(key: key);

  final MachineStatus machineStatus;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MachineDashboardUtilityMenu
          .machineDashboardUtilityMenuOnProgram.length,
      child: _buildTabController(context),
    );
  }

  Widget _buildTabController(BuildContext context) {
    switch (machineStatus) {
      case MachineStatus.IDLE:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                MachineDashboardSizes.machineDashboardUtilityContainerRadius),
            color: Colors.white,
          ),
          height:
              MachineDashboardSizes.machineDashboardUtilityContainerHeightIdle,
          child: Column(
            children: [
              _buildCustomTabbar(),
              Flexible(
                child: TabBarView(
                  children: MachineDashboardUtilityMenu
                      .machineDashboardUtilityMenuOnProgramTabbarViewOperating,
                ),
              ),
            ],
          ),
        );
      case MachineStatus.ONPROGRAM:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                MachineDashboardSizes.machineDashboardUtilityContainerRadius),
            color: Colors.white,
          ),
          height: MachineDashboardSizes
              .machineDashboardUtilityContainerHeightOperating,
          child: Column(
            children: [
              _buildCustomTabbar(),
              Flexible(
                child: TabBarView(
                  children: MachineDashboardUtilityMenu
                      .machineDashboardUtilityMenuOnProgramTabbarViewOperating,
                ),
              ),
            ],
          ),
        );
      case MachineStatus.WAITING:
        return Container(
          padding:
              MachineDashboardSizes.machineDashboardUtilityContianerPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                MachineDashboardSizes.machineDashboardUtilityContainerRadius),
            color: Colors.white,
          ),
          height: MachineDashboardSizes
              .machineDashboardUtilityContainerHeightWaiting,
          child: Column(
            children: [
              _buildCustomTabbar(),
              Expanded(
                child: Flexible(
                  child: TabBarView(
                    children: MachineDashboardUtilityMenu
                        .machineDashboardUtilityMenuOnProgramTabbarViewWaiting,
                  ),
                ),
              ),
              const SizedBox(
                height: MachineDashboardSizes.machineDashboardWidgetSpacing,
              ),
              SizedBox(
                width: MachineDashboardSizes
                    .machineDashboardUtilityEditProgramProgramWidth,
                height: MachineDashboardSizes
                    .machineDashboardUtilityEditProgramProgramHeight,
                child: CommonOutlineButton(
                    titlieButton: Text(
                      MachineDashboardUiStrings
                          .machineDashboardUtilityEditProgramButton,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: AppTheme.yellowPrimary,
                          ),
                    ),
                    appthemeColor: AppTheme.yellowPrimary,
                    onPress: () {}),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildCustomTabbar() {
    return Container(
      margin: MachineDashboardSizes.machineDashboardUtilityContainerMargin,
      height: MachineDashboardSizes.machineDashboardUtilityTabbarHeight,
      decoration: BoxDecoration(
        color: AppTheme.yellowPrimary100,
        borderRadius: BorderRadius.circular(
          MachineDashboardSizes.machineDashboardUtilityTabbarRadius,
        ),
      ),
      child: TabBar(
        padding: MachineDashboardSizes.machineDashboardUtilityTabbarPadding,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            MachineDashboardSizes.machineDashboardUtilityTabbarRadius,
          ),
        ),
        labelColor: AppTheme.yellowPrimary,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:
              MachineDashboardSizes.machineDashboardUtilityTabbarLabelSize,
        ),
        unselectedLabelColor: AppTheme.greyPrimary,
        tabs: MachineDashboardUtilityMenu.machineDashboardUtilityMenuOnProgram,
      ),
    );
  }
}
