import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/utility/validator.dart';
import 'package:burnout_mobile/widgets/utility/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testWidgets('TextFormField Should render correctly', (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommonTextFormField(
            borderFocusColorBorder: AppTheme.primaryBackGroungColor,
            controller: controller,
            fillColor: AppTheme.primaryBackGroungColor,
          ),
        ),
      ),
    );
    expect(find.byType(CommonTextFormField), findsOneWidget);
  });

  testWidgets('TextFormField Should be able to input', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommonTextFormField(
            borderFocusColorBorder: AppTheme.primaryBackGroungColor,
            controller: controller,
            fillColor: AppTheme.primaryBackGroungColor,
          ),
        ),
      ),
    );

    expect(find.byType(CommonTextFormField), findsOneWidget);
    await tester.pump();
    await tester.enterText(find.byType(CommonTextFormField), "test");
  });

  testWidgets('TextFormField Should be able to validate', (tester) async {
    final controller = TextEditingController();
    final formGlobal = GlobalKey<FormState>();
    int x = 23;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formGlobal,
            child: CommonTextFormField(
              borderFocusColorBorder: AppTheme.primaryBackGroungColor,
              controller: controller,
              fillColor: AppTheme.primaryBackGroungColor,
              validator: Validators.isDigit(UiStrings.digitOnly),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(CommonTextFormField), findsOneWidget);
    await tester.pump();
    await tester.enterText(find.byType(CommonTextFormField), "test");
    await tester.pumpAndSettle();
    expect(formGlobal.currentState!.validate(), false);

    expect(find.byType(CommonTextFormField), findsOneWidget);
    await tester.pump();
    await tester.enterText(find.byType(CommonTextFormField), x.toString());
    await tester.pumpAndSettle();
    expect(formGlobal.currentState!.validate(), true);
  });

  testGoldens('Common submit button should render correctly', (tester) async {
    final controller = TextEditingController();
    await loadAppFonts();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CommonTextFormField(
              labelText: 'Placeholder',
              borderFocusColorBorder: Colors.white,
              controller: controller,
              fillColor: AppTheme.yellowPrimary,
            ),
          ),
        ),
      ),
    );

    await multiScreenGolden(tester, 'common_text_form_field', devices: [
      const Device(
        name: 'Phone',
        size: Size(120, 60),
      )
    ]);
  });
}
