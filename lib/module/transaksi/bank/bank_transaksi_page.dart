import 'package:accounting/module/transaksi/bank/bank_transaksi_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankTransaksiPage extends StatelessWidget {
  const BankTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BankTransaksiNotifier(context: context),
      child: Consumer<BankTransaksiNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
