import 'package:accounting/module/transaksi/otorisasi/otorisasi_transaksi_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtorisasiTransaksiPage extends StatelessWidget {
  const OtorisasiTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtorisasiTransaksiNotifier(context: context),
      child: Consumer<OtorisasiTransaksiNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
