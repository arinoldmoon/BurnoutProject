import 'package:burnout_mobile/constants/machine_setting/machine_setting_sizes.dart';
import 'package:burnout_mobile/widgets/machine_setting/machine_setting_expand_panel.dart';
import 'package:flutter/material.dart';

class MachineSettingPage extends StatefulWidget {
  const MachineSettingPage({Key? key}) : super(key: key);

  @override
  State<MachineSettingPage> createState() => _MachineSettingPageState();
}

class _MachineSettingPageState extends State<MachineSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: MachineSettingSizes.machineSettingExpansionPagePadding,
          child: MachineSettingExpandPanel(),
        ),
      ),
    );
  }
}
