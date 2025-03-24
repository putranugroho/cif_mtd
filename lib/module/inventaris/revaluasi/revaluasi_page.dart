import 'package:accounting/module/inventaris/revaluasi/revaluasi_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RevaluasiPage extends StatelessWidget {
  const RevaluasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RevaluasiNotifier(context: context),
      child: Consumer<RevaluasiNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
