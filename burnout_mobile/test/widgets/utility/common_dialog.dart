import 'dart:async';
import 'dart:core';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/utility/common_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(CommonDialog, () {
    testWidgets('Dialog should render correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => CommonDialog(
                        titleText: 'titleText',
                        contentText: 'contentText',
                        submitButtonTile: 'submit',
                        cancelButtonTile: 'cancel',
                        submitButtonColor: AppTheme.greenPrimary100,
                        cancelButtonColor: AppTheme.greyPrimary400,
                        cancelButtonCallBack: () {},
                        submitButtonCallBack: () {}),
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
      expect(find.byKey(const Key('contentDialog')), findsOneWidget);
      expect(find.byKey(const Key('cancelButtonDialog')), findsOneWidget);
      expect(find.byKey(const Key('submitButtonDialog')), findsOneWidget);
    });

    testWidgets('Cancel callback should work on complete', (tester) async {
      final Completer _completer = Completer();

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => CommonDialog(
                        titleText: 'titleText',
                        contentText: 'contentText',
                        submitButtonTile: 'submit',
                        cancelButtonTile: 'cancel',
                        submitButtonColor: AppTheme.greenPrimary100,
                        cancelButtonColor: AppTheme.greyPrimary400,
                        cancelButtonCallBack: _completer.complete,
                        submitButtonCallBack: () {}),
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
      expect(_completer.isCompleted, isTrue);
    });
  });

  testWidgets('Dialog should render correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
            body: GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (_) => CommonDialog(
                      titleText: 'titleText',
                      contentText: 'contentText',
                      submitButtonTile: 'submit',
                      cancelButtonTile: 'cancel',
                      submitButtonColor: AppTheme.greenPrimary100,
                      cancelButtonColor: AppTheme.greyPrimary400,
                      cancelButtonCallBack: () {},
                      submitButtonCallBack: () {}),
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
    expect(find.byKey(const Key('contentDialog')), findsOneWidget);
    expect(find.byKey(const Key('cancelButtonDialog')), findsOneWidget);
    expect(find.byKey(const Key('submitButtonDialog')), findsOneWidget);
  });
}



