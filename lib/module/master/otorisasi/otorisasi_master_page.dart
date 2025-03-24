import 'package:accounting/module/master/otorisasi/otorisasi_master_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtorisasiMasterPage extends StatelessWidget {
  const OtorisasiMasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtorisasiMasterNotifier(context: context),
      child: Consumer<OtorisasiMasterNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
