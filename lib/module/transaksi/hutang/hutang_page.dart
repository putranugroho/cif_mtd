import 'package:accounting/module/transaksi/hutang/hutang_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HutangPage extends StatelessWidget {
  const HutangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HutangNotifier(context: context),
      child: Consumer<HutangNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
