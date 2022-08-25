import 'dart:async';
import 'package:burnout_mobile/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  late int _currentPage;

  void setCurrentPage(int index) {
    _currentPage = index;
  }

  setUp() {
    _currentPage = 0;
  }

  testWidgets('Drawer menu should render correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return const Scaffold(body: DrawerMenu());
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('leadingIcon')), findsNWidgets(3));
    for (int i = 0; i < 2; i++) {
      expect(find.byKey(Key('titleMenuText$i')), findsNWidgets(1));
    }
    expect(find.byKey(const Key('closeButton')), findsOneWidget);
  });

  testWidgets('Drawer test onselect should work correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return const Scaffold(body: DrawerMenu());
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('titleMenuText0')));
    setCurrentPage(0);
    expect(_currentPage, 0);
  });

  testGoldens('Drawer menu button should render correctly', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return const Scaffold(body: DrawerMenu());
          },
        ),
      ),
    );

    await multiScreenGolden(tester, 'drawer_menu', devices: [Device.iphone11]);

    await screenMatchesGolden(tester, 'goldens/drawer_menu.Phone');
  });
}
