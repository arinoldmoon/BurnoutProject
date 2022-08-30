import 'package:burnout_mobile/constants/machine_setting/machine_setting_sizes.dart';
import 'package:burnout_mobile/constants/machine_setting/machine_setting_ui_strings.dart';
import 'package:burnout_mobile/styles/app_theme.dart';
import 'package:burnout_mobile/widgets/machine_setting/machine_setting_expand_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class MachineSettingPage extends StatefulWidget {
  const MachineSettingPage({Key? key}) : super(key: key);

  @override
  State<MachineSettingPage> createState() => _MachineSettingPageState();
}

class _MachineSettingPageState extends State<MachineSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          PhosphorIcons.list,
          color: AppTheme.greyPrimary,
        ),
        title: Text(
          MachineSettingUiStrings.machineSettingPageMockMachineName,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding:
                MachineSettingSizes.machineSettingExpansionAppbarActionPadding,
            child: Icon(
              PhosphorIcons.bell_simple,
              color: AppTheme.greyPrimary,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: MachineSettingSizes.machineSettingExpansionPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MachineSettingSizes.machineSettingHeaderPadding,
                child: Text(
                  MachineSettingUiStrings.machineSettingPageHeader,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height:
                    MachineSettingSizes.machineSettingHeaderExpansionSpacing,
              ),
              const MachineSettingExpandPanel(),
            ],
          ),
        ),
      ),
    );
  }
}
