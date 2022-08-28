import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/machine_dashboard_utility_menu.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_edit_program_dialog.dart';
import 'package:burnout_mobile/widgets/utility/common_outline_button.dart';
import 'package:flutter/material.dart';

class MachineDashboardUtility extends StatelessWidget {
  const MachineDashboardUtility({Key? key, required this.machineStatus})
      : super(key: key);

  final MachineStatusRun machineStatus;

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
      case MachineStatusRun.IDLE:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                MachineDashboardSizes.machineDashboardUtilityContainerRadius),
            color: Colors.white,
          ),
          padding:
              MachineDashboardSizes.machineDashboardUtilityContianerPadding,
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
      case MachineStatusRun.ONPROGRAM:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                MachineDashboardSizes.machineDashboardUtilityContainerRadius),
            color: Colors.white,
          ),
          padding:
              MachineDashboardSizes.machineDashboardUtilityContianerPadding,
          height: MachineDashboardSizes.machineDashboardUtilityContainerHeight,
          child: Column(
            children: [
              Flexible(child: _buildCustomTabbar()),
              Flexible(
                child: TabBarView(
                  children: MachineDashboardUtilityMenu
                      .machineDashboardUtilityMenuOnProgramTabbarViewOperating,
                ),
              ),
            ],
          ),
        );
      case MachineStatusRun.WAITING:
        return Container(
          padding:
              MachineDashboardSizes.machineDashboardUtilityContianerPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                MachineDashboardSizes.machineDashboardUtilityContainerRadius),
            color: Colors.white,
          ),
          height: MachineDashboardSizes.machineDashboardUtilityContainerHeight,
          child: Column(
            children: [
              _buildCustomTabbar(),
              Flexible(
                child: TabBarView(
                  children: MachineDashboardUtilityMenu
                      .machineDashboardUtilityMenuOnProgramTabbarViewWaiting,
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
                    onPress: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return const MachineDashboardEditProgramDialog();
                        },
                      );
                    }),
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
