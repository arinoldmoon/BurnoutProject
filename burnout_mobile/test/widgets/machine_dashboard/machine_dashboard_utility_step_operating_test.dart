import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_utility_step_provider.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility_step_operating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  void findCommon() {
    expect(find.byKey(const Key('stepTitle')), findsNWidgets(6));
    expect(find.byKey(const Key('stepTimeRemaining')), findsNWidgets(6));
    expect(find.byKey(const Key('stepTemp')), findsNWidgets(6));
    expect(find.byKey(const Key('ListTileStepOperating')), findsNWidgets(6));
    expect(find.byKey(const Key('ListViewStepOperating')), findsOneWidget);
    expect(find.byKey(const Key('coolingStepIcon')), findsNWidgets(2));
    expect(find.byKey(const Key('heatingStepIcon')), findsNWidgets(2));
    expect(find.byKey(const Key('maintainStepIcon')), findsNWidgets(2));
  }

  testWidgets(
      'Machine Dashboard Utility Step Operating Should Render Correctly',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                MachineDashboardUtilityStepProvider();
              },
            ),
          ],
          child: const Scaffold(body: MachineDashboardUtilityStepOperating()),
        ),
      ),
    );
    findCommon();
  });

  testWidgets('Machine Dashboard Utility Step Test Scroll', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                MachineDashboardUtilityStepProvider();
              },
            ),
          ],
          child: const Scaffold(
            body: MachineDashboardUtilityStepOperating(),
          ),
        ),
      ),
    );

    await tester.drag(find.byKey(const Key('ListViewStepOperating')),
        const Offset(0.0, -300));
    await tester.pump();
  });

  testGoldens('should have the right screenshot', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                MachineDashboardUtilityStepProvider();
              },
            ),
          ],
          child: Scaffold(
            body: Padding(
              padding: MachineDashboardSizes.machineDashboardPagePadding,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MachineDashboardSizes
                        .machineDashboardUtilityContainerRadius),
                    color: Colors.white,
                  ),
                  height: MachineDashboardSizes
                      .machineDashboardUtilityContainerHeight,
                  child: const MachineDashboardUtilityStepOperating()),
            ),
          ),
        ),
      ),
    );
    await multiScreenGolden(tester, 'machine_dashboard_utility_step_operating',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(400, 700),
          )
        ]);
  });
}
