import 'package:accounting/module/inventaris/jual_beli/jual_beli_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JualBeliPage extends StatelessWidget {
  const JualBeliPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JualBeliNotifier(context: context),
      child: Consumer<JualBeliNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
