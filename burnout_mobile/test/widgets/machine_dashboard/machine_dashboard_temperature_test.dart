import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_temperature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  void findCommon() {
    expect(find.byKey(const Key('machineTempText')), findsOneWidget);
    expect(find.byKey(const Key('machineTempWidget')), findsOneWidget);
  }

  testWidgets('Machine Dashboard Temp On', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MachineDashboardSizes.machineDashboardTemperatureHeight,
              child: ListView(
                children: [
                  MachineDashboardTemperature(
                      machineTemperature:
                          MachineTemperature.mockMachineTemp.first),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    expect(find.byKey(const Key('machineTempIconOn')), findsOneWidget);
    findCommon();
  });

  testWidgets('Machine Dashboard Temp Off', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MachineDashboardSizes.machineDashboardTemperatureHeight,
              child: ListView(
                children: [
                  MachineDashboardTemperature(
                      machineTemperature:
                          MachineTemperature.mockMachineTemp.last),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    expect(find.byKey(const Key('machineTempIconOff')), findsOneWidget);
    findCommon();
  });

  testGoldens('should have the right screenshot On', (tester) async {
    await loadAppFonts();
    await tester.pumpWidgetBuilder(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MachineDashboardSizes.machineDashboardTemperatureHeight,
              child: ListView(
                children: [
                  MachineDashboardTemperature(
                      machineTemperature:
                          MachineTemperature.mockMachineTemp.first),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
    await multiScreenGolden(tester, 'machine_dashboard_temperature_on',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(200, 100),
          )
        ]);
  });

  testGoldens('should have the right screenshot Off', (tester) async {
    await loadAppFonts();

    await tester.pumpWidgetBuilder(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MachineDashboardSizes.machineDashboardTemperatureHeight,
              child: ListView(
                children: [
                  MachineDashboardTemperature(
                      machineTemperature:
                          MachineTemperature.mockMachineTemp.last),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
    await multiScreenGolden(tester, 'machine_dashboard_temperature_off',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(200, 100),
          )
        ]);
  });
}
