import 'package:burnout_mobile/provider/machine_data_provider.dart';
import 'package:burnout_mobile/widgets/machine_dashboard/machine_dashboard_expansional_setting.dart';
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';

class MachineDashboardSettingPage extends StatelessWidget {
  const MachineDashboardSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return MachineDataProvider();
      },
      child: Scaffold(
        body: Consumer<MachineDataProvider>(
          builder: (context, value, child) {
            return const Nil();
          },
        ),
      ),
    );
  }
}
