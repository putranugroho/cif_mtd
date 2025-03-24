import 'package:accounting/module/transaksi/satu_transaksi/satu_transaksi_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SatuTransaksiPage extends StatelessWidget {
  const SatuTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SatuTransaksiNotifier(context: context),
      child: Consumer<SatuTransaksiNotifier>(
        builder: (context, value, child) => SafeArea(
          child: Scaffold(),
        ),
      ),
    );
  }
}
