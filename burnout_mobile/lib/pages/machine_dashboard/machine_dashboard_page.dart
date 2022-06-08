import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/pages/machine_dashboard/machine_dashboard_page_operating.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_peripheral_zone_provider.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/utility/common_cancel_button.dart';
import 'package:burnout_mobile/widgets/utility/common_close_button.dart';
import 'package:burnout_mobile/widgets/utility/common_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import 'machine_dashboard_page_waiting.dart';

class MachineDashboardPage extends StatelessWidget {
  const MachineDashboardPage({Key? key, required this.machinePayload})
      : super(key: key);

  final MockMachinePayload machinePayload;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return MachineDashboardPeripheralZoneProvider();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
            color: AppTheme.titleAppbarIconColor,
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                machinePayload.machineName,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: MachineDashboardSizes.machineDashboardPageTitleSpacing,
              ),
              Text(machinePayload.machineModel,
                  style: Theme.of(context).textTheme.headline5),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded),
              onPressed: () {},
              color: AppTheme.titleAppbarIconColor,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: MachineDashboardSizes.machineDashboardPagePadding,
                child: _buildPage(),
              ),
            ),
            Padding(
              padding: MachineDashboardSizes.machineDashboardPagePadding,
              child: _buildBottom(context),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.yellowPrimary,
          unselectedItemColor: AppTheme.yellowPrimary.withOpacity(.50),
          onTap: (value) {},
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                PhosphorIcons.activity,
                size: MachineDashboardSizes
                    .machineDashboardPageBottomNavItemIconSize,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                PhosphorIcons.chartLine,
                size: MachineDashboardSizes
                    .machineDashboardPageBottomNavItemIconSize,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                PhosphorIcons.gearSix,
                size: MachineDashboardSizes
                    .machineDashboardPageBottomNavItemIconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage() {
    switch (machinePayload.machineStatus) {
      case MachineStatus.ONPROGRAM:
        return MachineDashboardPageOperating(
          machinePayload: machinePayload,
        );
      case MachineStatus.IDLE:
        return Container();
      case MachineStatus.WAITING:
        return MachineDashboardPageWaiting(
          machinePayload: machinePayload,
        );
    }
  }

  Widget _buildBottom(BuildContext context) {
    switch (machinePayload.machineStatus) {
      case MachineStatus.ONPROGRAM:
        return SizedBox(
          height: MachineDashboardSizes.machineDashboardPageCancelButtonHeight,
          width: double.infinity,
          child: CommonCancelButton(
            buttonTitle: UiStrings.common_cancel,
            onPress: () {},
          ),
        );

      case MachineStatus.IDLE:
        return Container();

      case MachineStatus.WAITING:
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: MachineDashboardSizes
                    .machineDashboardPageCancelButtonHeight,
                child: CommonSubmitButton(
                  buttonTitle: UiStrings.common_start,
                  onPress: () {},
                ),
              ),
            ),
            const SizedBox(
              width: MachineDashboardSizes
                  .machineDashboardUitlityStartCloseButtonSpacing,
            ),
            SizedBox(
              height:
                  MachineDashboardSizes.machineDashboardPageCancelButtonHeight,
              width: 50,
              child: CommonCloseButton(
                onPress: () {},
              ),
            ),
          ],
        );
    }
  }
}
