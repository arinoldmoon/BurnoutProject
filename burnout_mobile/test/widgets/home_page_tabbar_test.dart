import 'package:burnout_mobile/constants/home_page_ui_strings.dart';
import 'package:burnout_mobile/widgets/home_page_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testWidgets('Tabbar should render correctly', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: HomePageTabbar()),
    ));
    expect(find.text(HomePageUiStrings.homePageAllTabbarTitle), findsOneWidget);
    expect(find.text(HomePageUiStrings.homePageBurnoutTabbarTitle),
        findsOneWidget);
    expect(find.text(HomePageUiStrings.homePageCastingTabbarTitle),
        findsOneWidget);
    expect(find.text(HomePageUiStrings.homePageWaxInjectionTabbarTitle),
        findsOneWidget);
  });

  testWidgets('Tabbar tap select tab', (WidgetTester tester) async {
    await loadAppFonts();
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: HomePageTabbar()),
    ));

    final TabController controller = DefaultTabController.of(
        tester.element(find.text(HomePageUiStrings.homePageAllTabbarTitle)))!;
    expect(controller, isNotNull);
    expect(controller.index, 0);
    expect(controller.previousIndex, 0);

    await tester.tap(find.text(HomePageUiStrings.homePageBurnoutTabbarTitle));
    expect(controller.indexIsChanging, true);
    expect(controller.index, 1);
    expect(controller.previousIndex, 0);

    await tester.tap(find.text(HomePageUiStrings.homePageCastingTabbarTitle));
    expect(controller.indexIsChanging, true);
    expect(controller.index, 2);
    expect(controller.previousIndex, 1);

    await tester
        .tap(find.text(HomePageUiStrings.homePageWaxInjectionTabbarTitle));
    expect(controller.indexIsChanging, true);
    expect(controller.index, 3);
    expect(controller.previousIndex, 2);
  });

  testWidgets('should have the right screenshot A Page', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: HomePageTabbar()),
    ));
    expect(
        find.byType(HomePageTabbar), matchesGoldenFile('Home_Page_Tabbar_A.png'));
  });

    testWidgets('should have the right screenshot B Page', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: HomePageTabbar()),
    ));
    await tester.tap(find.text(HomePageUiStrings.homePageBurnoutTabbarTitle));
    await tester.pumpAndSettle();
    expect(
        find.byType(HomePageTabbar), matchesGoldenFile('Home_Page_Tabbar_B.png'));
  });

   testWidgets('should have the right screenshot C Page', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: HomePageTabbar()),
    ));
    await tester.tap(find.text(HomePageUiStrings.homePageCastingTabbarTitle));
    await tester.pumpAndSettle();
    expect(
        find.byType(HomePageTabbar), matchesGoldenFile('Home_Page_Tabbar_C.png'));
  });

   testWidgets('should have the right screenshot D Page', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: HomePageTabbar()),
    ));
    await tester.tap(find.text(HomePageUiStrings.homePageWaxInjectionTabbarTitle));
    await tester.pumpAndSettle();
    expect(
        find.byType(HomePageTabbar), matchesGoldenFile('Home_Page_Tabbar_D.png'));
  });
}
