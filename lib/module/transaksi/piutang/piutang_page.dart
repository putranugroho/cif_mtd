import 'package:accounting/module/transaksi/piutang/piutang_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PiutangPage extends StatelessWidget {
  const PiutangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PiutangNotifier(context: context),
      child: Consumer<PiutangNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
