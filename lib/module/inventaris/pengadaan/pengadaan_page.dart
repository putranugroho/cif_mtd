import 'package:accounting/module/inventaris/pengadaan/pengadaan_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PengadaanPage extends StatelessWidget {
  const PengadaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PengadaanNotifier(context: context),
      child: Consumer<PengadaanNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
