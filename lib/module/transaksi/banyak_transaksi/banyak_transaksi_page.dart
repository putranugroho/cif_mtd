import 'package:accounting/module/transaksi/banyak_transaksi/banyak_transaksi_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BanyakTransaksiPage extends StatelessWidget {
  const BanyakTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BanyakTransaksiNotifier(context: context),
      child: Consumer<BanyakTransaksiNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
