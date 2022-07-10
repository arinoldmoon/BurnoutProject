import 'dart:async';
import 'dart:core';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_delete_program_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  int mockDeleteProgram = 0;
  group(MachineDashboardDeleteProgramDialog, () {
    testWidgets(
        'Machine Dashboard Delete Program Dialog should render correctly',
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
                    builder: (_) => MachineDashboardDeleteProgramDialog(
                      programIndex: mockDeleteProgram,
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
      expect(find.text('Delete Program 1'), findsOneWidget);
      expect(find.byKey(const Key('titleDialog')), findsOneWidget);
      expect(find.byKey(const Key('contentDialog')), findsOneWidget);
      expect(find.byKey(const Key('cancelButtonDialog')), findsOneWidget);
      expect(find.byKey(const Key('submitButtonDialog')), findsOneWidget);
    });

    testWidgets(
        'Machine Dashboard Delete Program Dialog Cancel Call Back Should work correctly',
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
                    builder: (_) => MachineDashboardDeleteProgramDialog(
                      programIndex: mockDeleteProgram,
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
        'Machine Dashboard Delete Program Dialog Submit Call Back Should work correctly',
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
                    builder: (_) => MachineDashboardDeleteProgramDialog(
                      programIndex: mockDeleteProgram,
                      cancelCallBack: (){},
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
                    builder: (_) => MachineDashboardDeleteProgramDialog(
                      programIndex: mockDeleteProgram,
                      cancelCallBack: (){},
                      submitCallBack: (){},
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
        await multiScreenGolden(tester, 'machine_dashboard_delete_program_dialog', devices: [
          const Device(
            name: 'Phone',
            size: Size(450, 300),
          )
        ]);
      });
  });
}
