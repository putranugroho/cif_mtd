import 'package:cif/module/setup/laporan/laporan_setup_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaporanSetupPage extends StatelessWidget {
  const LaporanSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LaporanSetupNotifier(context: context),
      child: Consumer<LaporanSetupNotifier>(
        builder: (context, value, child) => const SafeArea(child: Scaffold()),
      ),
    );
  }
}
