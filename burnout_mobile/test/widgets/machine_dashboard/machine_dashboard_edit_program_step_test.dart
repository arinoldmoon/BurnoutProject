import 'dart:async';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_utility_step_provider.dart';
import 'package:burnout_mobile/utility/form_key.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_edit_program_step.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';

void main() {
  List<MachineUtilityStep> originalListItems =
      MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList;
  late List<MachineUtilityStep> listItems;
  const double itemHeight = 48.0;

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final MachineUtilityStep element = listItems.removeAt(oldIndex);
    listItems.insert(newIndex, element);
  }

  Widget listItemToWidget(MachineUtilityStep listItem) {
    return SizedBox(
      key: Key(listItem.machineUtilityStepTitle),
      height: itemHeight,
      width: itemHeight,
      child: Text(listItem.machineUtilityStepTitle),
    );
  }

  setUp(() {
    listItems = originalListItems.toList();
  });

  Widget build({
    Widget? header,
    Widget? footer,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    EdgeInsets padding = EdgeInsets.zero,
    TargetPlatform? platform,
  }) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => MachineDashboardUtilityStepProvider(),
        child: Consumer<MachineDashboardUtilityStepProvider>(
          builder: (context, value, child) {
            return SizedBox(
              height: itemHeight * 10,
              width: itemHeight * 10,
              child: ReorderableListView(
                header: header,
                scrollDirection: scrollDirection,
                onReorder: onReorder,
                reverse: reverse,
                padding: padding,
                children: listItems.map<Widget>(listItemToWidget).toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> longPressDrag(
      WidgetTester tester, Offset start, Offset end) async {
    final TestGesture drag = await tester.startGesture(start);
    await tester.pump(kLongPressTimeout + kPressTimeout);
    await drag.moveTo(end);
    await tester.pump(kPressTimeout);
    await drag.up();
  }

  void findCommon() {
    expect(find.byKey(FormKey.formStepTempAndDurEditStep), findsOneWidget);
    expect(find.byKey(const Key('editStepListView')), findsOneWidget);
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
    expect(find.byKey(const Key('dividerListTile')), findsNWidgets(6));
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
            body: MachineDashboardEditProgramStep(),
          ),
        ),
      ),
    );

    await tester.drag(
        find.byKey(const Key('editStepListView')), const Offset(0.0, -300));
    await tester.pump();
  });

  testWidgets('allows reordering from the very bottom to the very top',
      (WidgetTester tester) async {
    await tester.pumpWidget(build());
    expect(listItems, orderedEquals(originalListItems));
    await longPressDrag(
      tester,
      tester.getCenter(find.text('Step 6')),
      tester.getCenter(find.text('Step 1')),
    );
    await tester.pumpAndSettle();

    List<String> expectList = [
      'Step 6',
      'Step 1',
      'Step 2',
      'Step 3',
      'Step 4',
      'Step 5',
    ];
    for (int i = 0; i < listItems.length; i++) {
      expect(listItems[i].machineUtilityStepTitle, expectList[i]);
    }
  });

  testWidgets('allows reordering from the very top to the very bottom',
      (WidgetTester tester) async {
    await tester.pumpWidget(build());
    expect(listItems, orderedEquals(originalListItems));
    await longPressDrag(
      tester,
      tester.getCenter(find.text('Step 1')),
      tester.getCenter(find.text('Step 6')) + const Offset(0.0, itemHeight * 2),
    );
    await tester.pumpAndSettle();
    List<String> expectList = [
      'Step 2',
      'Step 3',
      'Step 4',
      'Step 5',
      'Step 6',
      'Step 1',
    ];
    for (int i = 0; i < listItems.length; i++) {
      expect(listItems[i].machineUtilityStepTitle, expectList[i]);
    }
  });

  testWidgets('allows reordering inside the middle of the widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(build());
    expect(listItems, orderedEquals(originalListItems));
    await longPressDrag(
      tester,
      tester.getCenter(find.text('Step 3')),
      tester.getCenter(find.text('Step 2')),
    );
    await tester.pumpAndSettle();

    List<String> expectList = [
      'Step 1',
      'Step 3',
      'Step 2',
      'Step 4',
      'Step 5',
      'Step 6',
    ];
    for (int i = 0; i < listItems.length; i++) {
      expect(listItems[i].machineUtilityStepTitle, expectList[i]);
    }
  });

  testWidgets('Edit Step Should Render Dialog When Tap Trailing Button',
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
    await tester.tap(
      find.byKey(
        Key('${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[2].machineUtilityStepTitle}trailing'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(Key('startApStepDialog')), findsOneWidget);
  });

  testWidgets('Edit Step Should Render Dialog When Tap Trailing Button',
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
    await tester.tap(find.byKey(Key(
        '${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[2].machineUtilityStepTitle}trailing')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('startApStepDialog')), findsOneWidget);
  });

  testWidgets('Edit Step Should Render Dialog And Start At This Step Correctly',
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
    await tester.tap(find.byKey(Key(
        '${MachineDashboardUtilityStepProvider().machineDashboardUtilityStepList[2].machineUtilityStepTitle}trailing')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('startApStepDialog')), findsOneWidget);
    await tester.tap(find.byKey(const Key('submitButtonDialog')));
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
