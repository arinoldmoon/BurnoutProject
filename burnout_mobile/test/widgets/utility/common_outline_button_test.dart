import 'dart:async';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/utility/common_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testWidgets('Outline button should work correctly test onpress',
      (tester) async {
    final Completer _completer = Completer();

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: CommonOutlineButton(
                titlieButton: Text(
                  MachineDashboardUiStrings
                      .machineDashboardUtilityEditProgramButton,
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: AppTheme.yellowPrimary,
                      ),
                ),
                appthemeColor: AppTheme.yellowPrimary,
                onPress: _completer.complete,
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.byType(CommonOutlineButton));
    expect(_completer.isCompleted, isTrue);
  });

  testGoldens('Common outline button should render correctly', (tester) async {
    await loadAppFonts();

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: Center(
                child: CommonOutlineButton(
                  titlieButton: Text(
                    MachineDashboardUiStrings
                        .machineDashboardUtilityEditProgramButton,
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: AppTheme.yellowPrimary,
                        ),
                  ),
                  appthemeColor: AppTheme.yellowPrimary,
                  onPress: () {},
                ),
              ),
            );
          },
        ),
      ),
    );

    await multiScreenGolden(tester, 'common_outline_button', devices: [
      const Device(
        name: 'Phone',
        size: Size(120, 60),
      )
    ]);
  });
}
