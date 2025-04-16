import 'package:accounting/module/rekonsiliasi/rekonsiliasi_transaksi_pending_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RekonsiliasiTransaksiPendingPage extends StatelessWidget {
  const RekonsiliasiTransaksiPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RekonsiliasiTransaksiPendingNotifier(context: context),
      child: Consumer(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [],
          ),
        )),
      ),
    );
  }
}
