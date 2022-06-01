import 'package:burnout_mobile/widgets/utility/common_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testWidgets('Checkbox should work correctly', (tester) async {
    bool _isChecked = true;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: CommonCheckbox(
                  isCheck: _isChecked,
                  onCheck: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  }),
            );
          },
        ),
      ),
    );

    await tester.tap(find.byType(CommonCheckbox));
    await tester.pumpAndSettle();
    expect(_isChecked, false);

    await tester.tap(find.byType(CommonCheckbox));
    await tester.pumpAndSettle();
    expect(_isChecked, true);

    _isChecked = false;
    await tester.pumpAndSettle();
    expect(_isChecked, false);

    _isChecked = true;
    await tester.pumpAndSettle();
    expect(_isChecked, true);
  });

  testGoldens('Checkbox should render correctly', (tester) async {
    bool _isChecked = true;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: Center(
                child: CommonCheckbox(
                    isCheck: _isChecked,
                    onCheck: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    }),
              ),
            );
          },
        ),
      ),
    );

    await multiScreenGolden(tester, 'common_checkbox_check', devices: [
      const Device(
        name: 'Phone',
        size: Size(20, 20),
      )
    ]);
  });

  testGoldens('Checkbox should render correctly', (tester) async {
    bool _isChecked = false;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: Center(
                child: CommonCheckbox(
                    isCheck: _isChecked,
                    onCheck: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    }),
              ),
            );
          },
        ),
      ),
    );

    await multiScreenGolden(tester, 'common_checkbox_uncheck', devices: [
      const Device(
        name: 'Phone',
        size: Size(20, 20),
      )
    ]);
  });
}
