import 'dart:async';

import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_peripheral_zone_provider.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_utility_step_provider.dart';
import 'package:burnout_mobile/utility/form_key.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_edit_program_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';

void main() {
  void findCommon() {
    expect(find.byKey(FormKey.formStepTempAndDurEditStep), findsOneWidget);
    expect(find.byKey(const Key('editStepListView')), findsOneWidget);
    expect(find.byKey(const Key('addMoreStepButton')), findsOneWidget);

    for (int i = 0;
        i <
            MachineDashboardUtilityStepProvider()
                .machineDashboardUtilityStepList
                .length;
        i++) {
      expect(
          find.byKey(Key(
              '${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[i].machineUtilityStepTitle}leading')),
          findsOneWidget);
      expect(
          find.byKey(
            Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[i].machineUtilityStepTitle}title'),
          ),
          findsOneWidget);
      expect(
          find.byKey(
            Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[i].machineUtilityStepTitle}tempTextField'),
          ),
          findsOneWidget);
      expect(
          find.byKey(
            Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[i].machineUtilityStepTitle}durTextField'),
          ),
          findsOneWidget);
      expect(
          find.byKey(
            Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[i].machineUtilityStepTitle}trailing'),
          ),
          findsOneWidget);
    }
    expect(find.byKey(const Key('dividerListTile')), findsNWidgets(5));
    expect(
        find.byKey(
          const Key('coolingStepIcon'),
        ),
        findsNWidgets(2));
    expect(
        find.byKey(
          const Key('heatingStepIcon'),
        ),
        findsNWidgets(2));
    expect(
        find.byKey(
          const Key('maintainStepIcon'),
        ),
        findsNWidgets(2));
  }

  int listLenght = MachineDashboardUtilityStepProvider().count;

  testWidgets('Edit Step ListView Should Render correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) {
            MachineDashboardUtilityStepProvider();
          },
          child: const Scaffold(
            body: Center(
              child: MachineDashboardEditProgramStep(),
            ),
          ),
        ),
      ),
    );
    findCommon();
  });

  testWidgets('Edit Step Should be able to add more step', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) {
            MachineDashboardUtilityStepProvider();
          },
          child: const Scaffold(
            body: Center(
              child: MachineDashboardEditProgramStep(),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byKey(const Key('addMoreStepButton')));
    await tester.pumpAndSettle();
  });

  testWidgets('Edit Step button should be able to callback', (tester) async {
    final Completer _completer = Completer();
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) {
            MachineDashboardUtilityStepProvider();
          },
          child: Scaffold(
            body: Center(
              child: MachineDashboardEditProgramStep(
                leadingCallback: _completer.complete,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(
      Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[0].machineUtilityStepTitle}leading'),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(
      Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[0].machineUtilityStepTitle}trailing'),
    ));
    await tester.pumpAndSettle();
  });

  testWidgets('Edit Step Textfiled should be able to input text',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) {
            MachineDashboardUtilityStepProvider();
          },
          child: const Scaffold(
            body: Center(
              child: MachineDashboardEditProgramStep(),
            ),
          ),
        ),
      ),
    );
    for (int i = 0;
        i <
            MachineDashboardUtilityStepProvider()
                .machineDashboardUtilityStepList
                .length;
        i++) {
      expect(
          find.byKey(
            Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[i].machineUtilityStepTitle}tempTextField'),
          ),
          findsOneWidget);
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(
          Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[i].machineUtilityStepTitle}tempTextField'),
        ),
        'test',
      );
      await tester.pumpAndSettle();

      expect(
          find.byKey(
            Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[i].machineUtilityStepTitle}durTextField'),
          ),
          findsOneWidget);
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(
          Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[i].machineUtilityStepTitle}durTextField'),
        ),
        'test',
      );
      await tester.pumpAndSettle();
    }
  });

  testGoldens('should have the right screenshot', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) {
            MachineDashboardUtilityStepProvider();
          },
          child: const Scaffold(
            body: Center(
              child: MachineDashboardEditProgramStep(),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byKey(const Key('addMoreStepButton')));
    await tester.pumpAndSettle();
    await multiScreenGolden(
        tester, 'machine_dashboard_edit_program_step_add_more',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(400, 650),
          )
        ]);
  });

  testGoldens('Add more step should have the right screenshot', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) {
            MachineDashboardUtilityStepProvider();
          },
          child: const Scaffold(
            body: Center(
              child: MachineDashboardEditProgramStep(),
            ),
          ),
        ),
      ),
    );
    await multiScreenGolden(tester, 'machine_dashboard_edit_program_step',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(400, 650),
          )
        ]);
  });
}
