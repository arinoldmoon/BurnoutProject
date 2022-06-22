import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility_setting_operating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  void findCommon() {
    expect(find.byKey(const Key('TubeHeater')), findsOneWidget);
    expect(find.byKey(const Key('FloorHeater')), findsOneWidget);
    expect(find.byKey(const Key('AfterBurner')), findsOneWidget);
    expect(find.byKey(const Key('HeatAlarm')), findsOneWidget);
    expect(find.byKey(const Key('AirflowSetting')), findsOneWidget);
    expect(find.byKey(const Key('AdditionalSetting')), findsOneWidget);
    expect(find.byKey(const Key('HoldLastStepCheckbox')), findsOneWidget);
    expect(find.byKey(const Key('ScheduleCheckbox')), findsOneWidget);
  }

  testWidgets(
      'Machine Dashboard Utility Setting Operating Should Render Correctly',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: MachineDashboardUtilitySettingOperating()),
      ),
    );
    findCommon();
  });

  testGoldens('Machine Dashboard Utility Setting Operating Should Match Golden',
      (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
            body: Center(child: MachineDashboardUtilitySettingOperating())),
      ),
    );
    await multiScreenGolden(
        tester, 'machine_dashboard_utility_setting_operating',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(320, 714),
          )
        ]);
  });
}
