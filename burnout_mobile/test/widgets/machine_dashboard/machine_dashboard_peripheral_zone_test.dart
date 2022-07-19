import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/provider/machine_data_provider.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_peripheral_zone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';

void main() {
  void findCommon() {
    expect(find.byKey(const Key('machinePeripheralStatus')), findsOneWidget);
    expect(find.byKey(const Key('machinePeripheralName')), findsOneWidget);
  }

  testWidgets('Machine Dashboard Peripheral On Should Render Correctly',
      (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => MachineDataProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => SingleChildScrollView(
                child: SizedBox(
                  height:
                      MachineDashboardSizes.machineDashboardTemperatureHeight,
                  child: ListView(
                    children: [
                      MachineDashboardPeripheralZone(
                        machinePeripheral: context
                            .read<MachineDataProvider>()
                            .machinePeripheralZoneList
                            .first,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    expect(
        find.text(MachineDashboardUiStrings.machineDashboardPeripheralAirFlow),
        findsOneWidget);
    findCommon();
  });

  testWidgets('Machine Dashboard Peripheral Off Should Render Correctly',
      (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => MachineDataProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => SingleChildScrollView(
                child: SizedBox(
                  height:
                      MachineDashboardSizes.machineDashboardTemperatureHeight,
                  child: ListView(
                    children: [
                      MachineDashboardPeripheralZone(
                        machinePeripheral: context
                            .read<MachineDataProvider>()
                            .machinePeripheralZoneList
                            .last,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    expect(find.text(MachineDashboardUiStrings.machineDashboardPeripheralDoor),
        findsOneWidget);
    findCommon();
  });

  testGoldens('should have the right screenshot On', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => MachineDataProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => SingleChildScrollView(
                child: SizedBox(
                  height:
                      MachineDashboardSizes.machineDashboardTemperatureHeight,
                  child: ListView(
                    children: [
                      MachineDashboardPeripheralZone(
                        machinePeripheral: context
                            .read<MachineDataProvider>()
                            .machinePeripheralZoneList
                            .first,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await multiScreenGolden(tester, 'machine_dashboard_peripheral_on',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(200, 100),
          )
        ]);
  });

  testGoldens('should have the right screenshot Off', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => MachineDataProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => SingleChildScrollView(
                child: SizedBox(
                  height:
                      MachineDashboardSizes.machineDashboardTemperatureHeight,
                  child: ListView(
                    children: [
                      MachineDashboardPeripheralZone(
                        machinePeripheral: context
                            .read<MachineDataProvider>()
                            .machinePeripheralZoneList
                            .last,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await multiScreenGolden(tester, 'machine_dashboard_peripheral_off',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(200, 100),
          )
        ]);
  });
}
