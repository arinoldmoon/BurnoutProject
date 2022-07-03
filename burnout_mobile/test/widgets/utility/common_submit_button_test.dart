import 'dart:async';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/widgets/utility/common_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testWidgets('Submit button should work correctly test onpress',
      (tester) async {
    final Completer _completer = Completer();

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: CommonSubmitButton(
                buttonTitle: '',
                onPress: _completer.complete,
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.byType(CommonSubmitButton));
      expect(_completer.isCompleted, isTrue);
  });

  testGoldens('Common submit button should render correctly', (tester) async {
    await loadAppFonts();

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: Center(
                child: SizedBox(
                  height: MachineDashboardSizes
                      .machineDashboardPageCancelButtonHeight,
                  child: CommonSubmitButton(
                    buttonTitle: UiStrings.common_start,
                    onPress: () {},
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    await multiScreenGolden(tester, 'common_submit_button', devices: [
      const Device(
        name: 'Phone',
        size: Size(120, 60),
      )
    ]);
  });
}
