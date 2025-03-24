import 'package:accounting/module/transaksi/back_date/back_date_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackDatePage extends StatelessWidget {
  const BackDatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BackDateNotifier(context: context),
      child: Consumer<BackDateNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
