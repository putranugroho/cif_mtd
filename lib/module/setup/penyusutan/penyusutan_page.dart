import 'package:accounting/module/setup/penyusutan/penyusutan_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PenyusutanPage extends StatelessWidget {
  const PenyusutanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PenyusutanNotifier(context: context),
      child: Consumer<PenyusutanNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
