import 'dart:async';

import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/utility/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testWidgets('Common Button should work correctly test onpress',
      (tester) async {
    final Completer _completer = Completer();
    const buttonTitle = "";

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: CommonButton(
                buttonTitle: buttonTitle,
                fontSize: Theme.of(context).textTheme.headline6,
                onPress: _completer.complete,
                buttonColor: AppTheme.redPrimary100,
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.byType(CommonButton));
    expect(_completer.isCompleted, isTrue);
  });

  testGoldens('Common button should render correctly', (tester) async {
    await loadAppFonts();
    const buttonTitle = UiStrings.common_cancel;
    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: Center(
                child: SizedBox(
                  height: MachineDashboardSizes
                      .machineDashboardPageCancelButtonHeight,
                  width: double.infinity,
                  child: CommonButton(
                    buttonTitle: buttonTitle,
                    fontSize: Theme.of(context).textTheme.headline6,
                    onPress: () {},
                    buttonColor: AppTheme.redPrimary100,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    await multiScreenGolden(tester, 'common_button', devices: [
      const Device(
        name: 'Phone',
        size: Size(120, 60),
      )
    ]);
  });
}
