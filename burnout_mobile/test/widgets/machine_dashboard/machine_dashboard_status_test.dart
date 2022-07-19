import 'dart:async';
import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_ui_strings.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/provider/machine_data_provider.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_status.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_status_idle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';

void main() {
  void findCommon() {
    expect(find.byKey(const Key('machineDashboardTitle')), findsOneWidget);
  }

  testWidgets('Machine Dashboard Status (Idle)', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (BuildContext context) => MachineDataProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: ((context) => MachineDashboardStatus(
                    mockMachinePayload: context
                        .watch<MachineDataProvider>()
                        .mockMachinePayloadIdle,
                  )),
            ),
          ),
        ),
      ),
    );
    expect(find.byKey(const Key('machineDashboardStatusIdleButton')),
        findsOneWidget);
    findCommon();
  });

  testWidgets('Machine Dashboard Status (Waiting)', (tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (BuildContext context) => MachineDataProvider(),
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: ((context) => MachineDashboardStatus(
                  mockMachinePayload: context
                      .watch<MachineDataProvider>()
                      .mockMachinePayloadWaiting,
                )),
          ),
        ),
      ),
    ));
    expect(find.byKey(const Key('MachineDashboardStatusWaitingStatus')),
        findsOneWidget);
    findCommon();
  });

  testWidgets('Machine Dashboard Status (On Program)', (tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (BuildContext context) => MachineDataProvider(),
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: ((context) => MachineDashboardStatus(
                  mockMachinePayload: context
                      .watch<MachineDataProvider>()
                      .mockMachinePayloadOnProgram,
                )),
          ),
        ),
      ),
    ));
    expect(find.byKey(const Key('machineDashboardStatusOnProgramPercentage')),
        findsOneWidget);
    expect(find.byKey(const Key('machineDashboardStatusOnProgramTimeRemaing')),
        findsOneWidget);
    findCommon();
  });

  testWidgets(
      'Should call callback function when tap Machine Dashboard Idle (New Program)',
      (tester) async {
    final completer = Completer<void>();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MachineDashboardStatusIdleButton(
          key: const Key(''),
          buttonText: MachineDashboardUiStrings.machineDashboardNewProgram,
          icon: Icons.add_circle_outline,
          onTap: completer.complete,
        ),
      ),
    ));

    await tester
        .tap(find.text(MachineDashboardUiStrings.machineDashboardNewProgram));
    await tester.pump();
    expect(completer.isCompleted, true);
  });

  testWidgets(
      'Should call callback function when tap Machine Dashboard Idle (Load Program)',
      (tester) async {
    final completer = Completer<void>();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MachineDashboardStatusIdleButton(
          key: const Key('loadProgramButton'),
          buttonText: MachineDashboardUiStrings.machineDashboardLoadProgram,
          icon: Icons.drive_folder_upload_outlined,
          onTap: completer.complete,
        ),
      ),
    ));

    await tester
        .tap(find.text(MachineDashboardUiStrings.machineDashboardLoadProgram));
    await tester.pump();
    expect(completer.isCompleted, true);
  });

  testGoldens('should have the right screenshot Idle', (tester) async {
    await loadAppFonts();
    await tester.pumpWidgetBuilder(
      ChangeNotifierProvider(
        create: (BuildContext context) => MachineDataProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: MachineDashboardStatus(
                  mockMachinePayload: context
                      .watch<MachineDataProvider>()
                      .mockMachinePayloadIdle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await multiScreenGolden(tester, 'machine_dashboard_status_idle', devices: [
      const Device(
        name: 'Phone',
        size: Size(1080, 2020),
      )
    ]);
  });

  testGoldens('should have the right screenshot Waiting', (tester) async {
    await loadAppFonts();
    await tester.pumpWidgetBuilder(
      ChangeNotifierProvider(
        create: (BuildContext context) => MachineDataProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: MachineDashboardStatus(
                  mockMachinePayload: context
                      .watch<MachineDataProvider>()
                      .mockMachinePayloadWaiting,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await multiScreenGolden(tester, 'machine_dashboard_status_waiting',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(1080, 2020),
          )
        ]);
  });

  testGoldens('should have the right screenshot On Program', (tester) async {
    await loadAppFonts();
    await tester.pumpWidgetBuilder(
      ChangeNotifierProvider(
        create: (BuildContext context) => MachineDataProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: MachineDashboardStatus(
                  mockMachinePayload: context
                      .watch<MachineDataProvider>()
                      .mockMachinePayloadOnProgram,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await multiScreenGolden(tester, 'machine_dashboard_status_on_program',
        devices: [
          const Device(
            name: 'Phone',
            size: Size(1080, 2020),
          )
        ]);
  });
}
