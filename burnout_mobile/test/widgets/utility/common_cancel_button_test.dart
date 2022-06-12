import 'dart:async';

import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/widgets/utility/common_cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testWidgets('Checkbox should work correctly test onpress', (tester) async {
    final Completer _completer = new Completer();
    const buttonTitle = "";

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: CommonCancelButton(
                buttonTitle: buttonTitle,
                onPress: _completer.complete,
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.byType(CommonCancelButton));
  });

  testGoldens('Common cancel should render correctly', (tester) async {
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
                  child: CommonCancelButton(
                    buttonTitle: buttonTitle,
                    onPress: () {},
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    await multiScreenGolden(tester, 'common_cancel_button', devices: [
      const Device(
        name: 'Phone',
        size: Size(120, 60),
      )
    ]);
  });
}
