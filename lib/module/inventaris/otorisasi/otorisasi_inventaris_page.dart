import 'package:accounting/module/inventaris/otorisasi/otorisasi_inventaris_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtorisasiInventarisPage extends StatelessWidget {
  const OtorisasiInventarisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtorisasiInventarisNotifier(context: context),
      child: Consumer<OtorisasiInventarisNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
