import 'dart:async';
import 'dart:core';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_cancel_operation_dialog.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_delete_program_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group(MachineDashboardDeleteProgramDialog, () {
    testWidgets(
        'Machine Dashboard Cancel Operation Dialog should render correctly',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => MachineDashboardCancelOperationDialog(
                      cancelCallBack: () {},
                      submitCallBack: () {},
                    ),
                  );
                },
              ),
            );
          }),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key('titleDialog')), findsOneWidget);
      expect(find.byKey(const Key('contentText')), findsOneWidget);
      expect(find.byKey(const Key('cancelButtonDialog')), findsOneWidget);
      expect(find.byKey(const Key('submitButtonDialog')), findsOneWidget);
    });

    testWidgets(
        'Machine Dashboard Cancel Operation Dialog Cancel Call Back Should work correctly',
        (tester) async {
      final Completer completer = Completer();
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => MachineDashboardCancelOperationDialog(
                      cancelCallBack: completer.complete,
                      submitCallBack: () {},
                    ),
                  );
                },
              ),
            );
          }),
        ),
      );
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key('cancelButtonDialog')));
      expect(completer.isCompleted, isTrue);
    });

    testWidgets(
        'Machine Dashboard Cancel Operation Dialog Submit Call Back Should work correctly',
        (tester) async {
      final Completer completer = Completer();
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => MachineDashboardCancelOperationDialog(
                      cancelCallBack: () {},
                      submitCallBack: completer.complete,
                    ),
                  );
                },
              ),
            );
          }),
        ),
      );
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key('submitButtonDialog')));
      expect(completer.isCompleted, isTrue);
    });

    testGoldens('Dialog should render correctly', (tester) async {
      await loadAppFonts();
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => MachineDashboardCancelOperationDialog(
                      cancelCallBack: () {},
                      submitCallBack: () {},
                    ),
                  );
                },
              ),
            );
          }),
        ),
      );
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await multiScreenGolden(
          tester, 'machine_dashboard_cancel_operation_dialog',
          devices: [
            const Device(
              name: 'Phone',
              size: Size(450, 300),
            )
          ]);
    });
  });
}
