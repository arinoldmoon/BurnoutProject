import 'package:burnout_mobile/constants/machine_dashboard/machine_dashboard_sizes.dart';
import 'package:burnout_mobile/constants/machine_dashboard/machine_enum.dart';
import 'package:burnout_mobile/constants/ui_strings.dart';
import 'package:burnout_mobile/data_models/mock_machine_payload.dart';
import 'package:burnout_mobile/grpc/google/protobuf/empty.pb.dart';
import 'package:burnout_mobile/grpc/oven.pbgrpc.dart';
import 'package:burnout_mobile/pages/machine_dashboard/machine_dashboard_page_operating.dart';
import 'package:burnout_mobile/provider/machine_dashboard/machine_dashboard_peripheral_zone_provider.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/utility/common_button.dart';
import 'package:burnout_mobile/widgets/utility/common_close_button.dart';
import 'package:burnout_mobile/widgets/utility/common_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import 'machine_dashboard_page_waiting.dart';

class MachineDashboardPage extends StatefulWidget {
  const MachineDashboardPage({Key? key, required this.machinePayload})
      : super(key: key);

  final MockMachinePayload machinePayload;

  @override
  State<MachineDashboardPage> createState() => _MachineDashboardPageState();
}

class _MachineDashboardPageState extends State<MachineDashboardPage> {
  late MockMachinePayload machineData = widget.machinePayload;
  late ProtoServiceConnection ovenInfo;
  late List<MachineTemperature> machineTemperature =
      widget.machinePayload.machineTemperature!;
  late List<MachinePeripheral> machinePeripheral =
      widget.machinePayload.machinePeripheral!;

  static final channel = ClientChannel(
    '192.168.15.134', // Use your IP address where the server is running
    port: 5000,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  final OvenProtoServiceClient ovenStub = OvenProtoServiceClient(channel);
  final PatternProtoServiceClient patternStub =
      PatternProtoServiceClient(channel);

  void callGrpc() async {
    ovenInfo = await ovenStub.deviceConnect(Empty());
    var patternListCount = await patternStub.getPatternList(Empty());
    callMonitor();
  }

  void callMonitor() async {
    var response = ovenStub.monitorDevice(Empty());
    response.listen((value) {
      machineTemperature = [
        MachineTemperature(
          machineTemp: value.temp.tempOven.toDouble(),
          machineHeaterStatus: value.coil.coilOven
              ? MachineOnOffStatus.ON
              : MachineOnOffStatus.OFF,
          machineTempName: MachineHeater.OVEN,
        ),
        MachineTemperature(
          machineTemp: value.temp.tempAFB.toDouble(),
          machineHeaterStatus: value.coil.coilAFB
              ? MachineOnOffStatus.ON
              : MachineOnOffStatus.OFF,
          machineTempName: MachineHeater.AFB,
        ),
        MachineTemperature(
          machineTemp: value.temp.tempTube.toDouble(),
          machineHeaterStatus: value.coil.coilTube
              ? MachineOnOffStatus.ON
              : MachineOnOffStatus.OFF,
          machineTempName: MachineHeater.TUBE,
        ),
        MachineTemperature(
          machineTemp: value.temp.tempFloor.toDouble(),
          machineHeaterStatus: value.coil.coilFloor
              ? MachineOnOffStatus.ON
              : MachineOnOffStatus.OFF,
          machineTempName: MachineHeater.FLOOR,
        )
      ];

      machinePeripheral = [
        MachinePeripheral(
            machinePeripheralType: MachinePeripheralType.AIRFLOW,
            machineOnOffStatus: value.coil.coilPump
                ? MachineOnOffStatus.ON
                : MachineOnOffStatus.OFF),
        MachinePeripheral(
            machinePeripheralType: MachinePeripheralType.DOOR,
            machineOnOffStatus: value.status.door
                ? MachineOnOffStatus.ON
                : MachineOnOffStatus.OFF),
      ];
      _buildValue();
    });
  }

  void _buildValue() {
    if (mounted) {
      setState(() {
        machineData = MockMachinePayload(
          machineName: ovenInfo.ovenInfo.machineName,
          machineStatus: widget.machinePayload.machineStatus,
          machineModel: widget.machinePayload.machineModel,
          machineProgram: 'Operating Program1',
          machineOnProgramPercent: 0.65,
          machineTimeRemaing: 225,
          machineTemperature: machineTemperature,
          machinePeripheral: machinePeripheral,
        );
      });
    }
  }

  @override
  void initState() {
    callGrpc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return MachineDashboardPeripheralZoneProvider();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
            color: AppTheme.titleAppbarIconColor,
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                machineData.machineName,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: MachineDashboardSizes.machineDashboardPageTitleSpacing,
              ),
              Text(machineData.machineModel,
                  style: Theme.of(context).textTheme.headline5),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded),
              onPressed: () {},
              color: AppTheme.titleAppbarIconColor,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: MachineDashboardSizes.machineDashboardPagePadding,
                child: _buildPage(),
              ),
            ),
            Padding(
              padding: MachineDashboardSizes.machineDashboardPagePadding,
              child: _buildBottom(context),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.yellowPrimary,
          unselectedItemColor: AppTheme.yellowPrimary.withOpacity(.50),
          onTap: (value) {},
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                PhosphorIcons.activity,
                size: MachineDashboardSizes
                    .machineDashboardPageBottomNavItemIconSize,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                PhosphorIcons.chartLine,
                size: MachineDashboardSizes
                    .machineDashboardPageBottomNavItemIconSize,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                PhosphorIcons.gearSix,
                size: MachineDashboardSizes
                    .machineDashboardPageBottomNavItemIconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage() {
    switch (machineData.machineStatus) {
      case MachineStatusRun.ONPROGRAM:
        return MachineDashboardPageOperating(
          machinePayload: machineData,
        );
      case MachineStatusRun.IDLE:
        return Container();
      case MachineStatusRun.WAITING:
        return MachineDashboardPageWaiting(
          machinePayload: machineData,
        );
    }
  }

  Widget _buildBottom(BuildContext context) {
    switch (machineData.machineStatus) {
      case MachineStatusRun.ONPROGRAM:
        return SizedBox(
          height: MachineDashboardSizes.machineDashboardPageCancelButtonHeight,
          width: double.infinity,
          child: CommonButton(
            buttonTitle: UiStrings.common_cancel,
            fontSize: Theme.of(context).textTheme.headline6,
            onPress: () {},
            buttonColor: AppTheme.redPrimary100,
          ),
        );

      case MachineStatusRun.IDLE:
        return Container();

      case MachineStatusRun.WAITING:
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: MachineDashboardSizes
                    .machineDashboardPageCancelButtonHeight,
                child: CommonSubmitButton(
                  buttonTitle: UiStrings.common_start,
                  onPress: () {},
                ),
              ),
            ),
            const SizedBox(
              width: MachineDashboardSizes
                  .machineDashboardUitlityStartCloseButtonSpacing,
            ),
            SizedBox(
              height:
                  MachineDashboardSizes.machineDashboardPageCancelButtonHeight,
              width: 50,
              child: CommonCloseButton(
                onPress: () {},
              ),
            ),
          ],
        );
    }
  }
}
