import 'package:accounting/module/inventaris/laporan/laporan_inventaris_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaporanMasterPage extends StatelessWidget {
  const LaporanMasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LaporanInventarisNotifier(context: context),
      child: Consumer<LaporanInventarisNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
