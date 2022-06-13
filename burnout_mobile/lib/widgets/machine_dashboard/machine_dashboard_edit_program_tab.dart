import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/data_models/machine_dashboard_edit_program_menu.dart';
import 'package:burnout_mobile/data_models/machine_dashboard_utility_menu.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class MachineDashboardEditProgramTab extends StatelessWidget {
  const MachineDashboardEditProgramTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: MachineDashboardEditProgramMenu
            .machineDashboardEditProgramMenu.length,
        child: _buildTabController());
  }

  Widget _buildTabController() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            MachineDashboardSizes.machineDashboardUtilityContainerRadius),
        color: Colors.white,
      ),
      height: MachineDashboardSizes.machineDashboardUtilityContainerHeightIdle,
      child: Column(
        children: [
          _buildCustomTabbar(),
          Flexible(
            child: TabBarView(
              children: MachineDashboardEditProgramMenu
                  .machineDashboardEdiProgramTabbarView,
            ),
          ),
        ],
      ),
    );
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
        tabs: MachineDashboardEditProgramMenu.machineDashboardEditProgramMenu,
      ),
    );
  }
}
