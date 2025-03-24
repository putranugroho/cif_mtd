import 'package:accounting/module/transaksi/laporan/laporan_transaksi_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaporanTransaksiPage extends StatelessWidget {
  const LaporanTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LaporanTransaksiNotifier(context: context),
      child: Consumer<LaporanTransaksiNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
