import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_data_provider.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility_step_operating.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_utility_step_waiting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

void main() {
  List<MachineUtilityStep> originalListItems =
      MachineDataProvider().machineDashboardUtilityStepList;

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

  Widget build({
    Widget? header,
    Widget? footer,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    EdgeInsets padding = EdgeInsets.zero,
    TargetPlatform? platform,
  }) {
    return ChangeNotifierProvider(
      create: (context) => MachineDataProvider(),
      child: MaterialApp(
        home: SizedBox(
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
        ),
      ),
    );
  }

  void findCommon() {
    expect(find.byKey(const Key('stepTitle')), findsNWidgets(6));
    expect(find.byKey(const Key('stepTimeRemaining')), findsNWidgets(6));
    expect(find.byKey(const Key('stepTemp')), findsNWidgets(6));
    expect(find.byKey(const Key('listTileStepWaiting')), findsNWidgets(6));
    expect(find.byKey(const Key('ListViewStepWaiting')), findsOneWidget);
    expect(find.byKey(const Key('coolingStepIcon')), findsNWidgets(2));
    expect(find.byKey(const Key('heatingStepIcon')), findsNWidgets(2));
    expect(find.byKey(const Key('maintainStepIcon')), findsNWidgets(2));
  }

  setUp(() {
    listItems = originalListItems.toList();
  });

  Future<void> longPressDrag(
      WidgetTester tester, Offset start, Offset end) async {
    final TestGesture drag = await tester.startGesture(start);
    await tester.pump(kLongPressTimeout + kPressTimeout);
    await drag.moveTo(end);
    await tester.pump(kPressTimeout);
    await drag.up();
  }

  testWidgets(
      'Machine Dashboard Utility Step Operating Should Render Correctly',
      (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => MachineDataProvider(),
        child: const MaterialApp(
          home: Scaffold(body: MachineDashboardUtilityStepWaiting()),
        ),
      ),
    );
    findCommon();
  });

  testWidgets('Machine Dashboard Utility Step Test Scroll', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => MachineDataProvider(),
        child: const MaterialApp(
          home: Scaffold(body: MachineDashboardUtilityStepWaiting()),
        ),
      ),
    );
    await tester.drag(
        find.byKey(const Key('ListViewStepWaiting')), const Offset(0.0, -300));
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

  testGoldens('should have the right screenshot', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => MachineDataProvider(),
        child: const MaterialApp(
          home: Scaffold(body: MachineDashboardUtilityStepWaiting()),
        ),
      ),
    );
    await multiScreenGolden(tester, 'machine_dashboard_utility_step_waiting',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(800, 700),
          )
        ]);
  });
}
