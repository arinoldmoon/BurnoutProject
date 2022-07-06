import 'dart:async';
import 'package:burnout_mobile/data_models/home_page_mock_machine_card.dart';
import 'package:burnout_mobile/pages/Homepage/home_page_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  final BuildContext context;
  testWidgets('Home page All should render correctly', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: HomePageAll()),
    ));
    expect(find.byKey(const Key('machineCard')), findsNWidgets(3));
  });

  testWidgets('Home page All should have right screenshot ', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: HomePageAll()),
    ));

    expect(find.byType(HomePageAll), matchesGoldenFile('Home_page_all.png'));
  });
}
