import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility.dart';
import 'package:burnout_mobile/widgets/utility/common_outline_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  Widget _buildPage(MachineStatusRun machineStatus) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
            child: MachineDashboardUtility(machineStatus: machineStatus)),
      ),
    );
  }

  void _findTabbarMenu() {
    expect(find.byType(TabBar), findsOneWidget);
    expect(find.text("Step"), findsOneWidget);
    expect(find.text("Setting"), findsOneWidget);
    expect(find.text("Graph"), findsOneWidget);
  }

  testWidgets(
      'Machine Dashboard Utility Should Render Correctly On Program / Idle (Temp)',
      (tester) async {
    await tester.pumpWidget(_buildPage(MachineStatusRun.ONPROGRAM));
    _findTabbarMenu();
  });

  testWidgets('Machine Dashboard Utility Should Render Correctly Waiting',
      (tester) async {
    await tester.pumpWidget(_buildPage(MachineStatusRun.WAITING));
    _findTabbarMenu();
    expect(find.byType(CommonOutlineButton), findsOneWidget);
  });

  testWidgets('Machine Dashboard Utility Tabbar Tab Test', (tester) async {
    await tester.pumpWidget(_buildPage(MachineStatusRun.WAITING));
    final TabController controller =
        DefaultTabController.of(tester.element(find.text('Graph')))!;
    expect(controller, isNotNull);
    expect(controller.index, 0);
    expect(controller.previousIndex, 0);

    await tester.tap(find.text('Step'));
    expect(controller.index, 1);
    expect(controller.previousIndex, 0);

    await tester.tap(find.text('Setting'));
    expect(controller.index, 2);
    expect(controller.previousIndex, 1);
  });

  testGoldens('Machine Dashboard Uitlity On Program Golden test',
      (tester) async {
    await loadAppFonts();
    const widget =
        MachineDashboardUtility(machineStatus: MachineStatusRun.ONPROGRAM);
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [Device.iphone11])
      ..addScenario(widget: widget)
      ..addScenario(
        widget: widget,
        name: 'tap step',
        onCreate: (scenarioWidgetKey) async {
          final finder = find.descendant(
            of: find.byKey(scenarioWidgetKey),
            matching: find.text('Step'),
          );
          expect(finder, findsOneWidget);
          await tester.tap(finder);
        },
      )
      ..addScenario(
        widget: widget,
        name: 'tap setting',
        onCreate: (scenarioWidgetKey) async {
          final finder = find.descendant(
            of: find.byKey(scenarioWidgetKey),
            matching: find.text('Setting'),
          );
          expect(finder, findsOneWidget);
          await tester.tap(finder);
        },
      );
    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(
        tester, 'machine_dashboard_utility_on_program.iphone11');
  });
}
