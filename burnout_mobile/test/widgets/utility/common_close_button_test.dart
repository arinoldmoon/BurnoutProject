import 'dart:async';

import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/widgets/utility/common_close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testWidgets('Checkbox should work correctly test onpress', (tester) async {
    final Completer _completer = new Completer();

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: CommonCloseButton(
                onPress: _completer.complete,
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.byType(CommonCloseButton));
  });

  testGoldens('Common close button should render correctly', (tester) async {
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
                  width: double.infinity,
                  child: CommonCloseButton(
                    onPress: () {},
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    await multiScreenGolden(tester, 'common_close_button', devices: [
      const Device(
        name: 'Phone',
        size: Size(60, 60),
      )
    ]);
  });
}
