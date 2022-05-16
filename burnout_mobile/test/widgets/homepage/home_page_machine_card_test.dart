import 'dart:async';
import 'package:burnout_mobile/constants/homepage/home_page_constants.dart';
import 'package:burnout_mobile/data_models/home_page_mock_machine_card.dart';
import 'package:burnout_mobile/widgets/home_page_machine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testWidgets('Machine card should render correctly', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
          body: HomePageMachineCard(
        homePageMockMachineCard: HomePageMockMachineCard(
            machineStatus: true,
            machineName: 'machineName1',
            machineModel: 'machineModel1',
            machinePic: HomePageConstants.homePageMachineCardMachinePic,
            onTap: () {}),
      )),
    ));
    expect(find.byKey(const Key('machineName')), findsOneWidget);
    expect(find.byKey(const Key('machineModel')), findsOneWidget);
    expect(find.byKey(const Key('machineStatus')), findsOneWidget);
  });

  testWidgets('Should call callback function when tap card', (tester) async {
    final completer = Completer<void>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomePageMachineCard(
            homePageMockMachineCard: HomePageMockMachineCard(
                machineStatus: true,
                machineName: 'machineName1',
                machineModel: 'machineModel1',
                machinePic: HomePageConstants.homePageMachineCardMachinePic,
                onTap: completer.complete),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(HomePageMachineCard));
    expect(completer.isCompleted, true);
  });

  testWidgets('Machine On should have right screenshot ', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: HomePageMachineCard(
          homePageMockMachineCard: HomePageMockMachineCard(
              machineStatus: true,
              machineName: 'machineName1',
              machineModel: 'machineModel1',
              machinePic: HomePageConstants.homePageMachineCardMachinePic,
              onTap: () {}),
        ),
      ),
    ));

    expect(find.byType(HomePageMachineCard),
        matchesGoldenFile('Machine_card_status_on.png'));
  });

  testWidgets('Machine Off should have right screenshot ', (tester) async {
    await loadAppFonts();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: HomePageMachineCard(
          homePageMockMachineCard: HomePageMockMachineCard(
              machineStatus: false,
              machineName: 'machineName3',
              machineModel: 'machineModel3',
              machinePic: HomePageConstants.homePageMachineCardMachinePic,
              onTap: () {}),
        ),
      ),
    ));

    expect(find.byType(HomePageMachineCard),
        matchesGoldenFile('Machine_card_status_off.png'));
  });
}
