import 'package:flutter/material.dart';

class MachineDashboardEditProgramSteptile extends StatefulWidget {
  const MachineDashboardEditProgramSteptile({Key? key}) : super(key: key);

  @override
  State<MachineDashboardEditProgramSteptile> createState() =>
      _MachineDashboardEditProgramSteptileState();
}

class _MachineDashboardEditProgramSteptileState
    extends State<MachineDashboardEditProgramSteptile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.more_vert),
        onPressed: () {},
      ),
    );
  }
}
