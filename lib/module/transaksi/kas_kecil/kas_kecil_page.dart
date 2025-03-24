import 'package:accounting/module/transaksi/kas_kecil/kas_kecil_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KasKecilPage extends StatelessWidget {
  const KasKecilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KasKecilNotifier(context: context),
      child: Consumer<KasKecilNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
