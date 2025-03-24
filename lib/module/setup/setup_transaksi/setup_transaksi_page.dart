import 'package:accounting/module/setup/setup_transaksi/setup_transaksi_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetupTransaksiPage extends StatelessWidget {
  const SetupTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetupTransaksiNotifier(context: context),
      child: Consumer<SetupTransaksiNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
