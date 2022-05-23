import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/data_models/machine_dashboard_utility_menu.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

class MachineDashboardUtility extends StatelessWidget {
  const MachineDashboardUtility({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MachineDashboardUtilityMenu
          .machineDashboardUtilityMenuOnProgram.length,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              MachineDashboardSizes.machineDashboardUtilityContainerRadius),
          color: Colors.white,
        ),
        height: MachineDashboardSizes.machineDashboardUtilityContainerHeight,
        padding: MachineDashboardSizes.machineDashboardUtilityContainerPadding,
        child: Column(
          children: [
            _buildCustomTabbar(),
            Flexible(
              child: TabBarView(
                children: MachineDashboardUtilityMenu
                    .machineDashboardUtilityMenuOnProgramTabbarView,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTabbar() {
    return Container(
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
