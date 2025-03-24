import 'package:accounting/module/inventaris/penempatan/penempatan_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PenempatanPage extends StatelessWidget {
  const PenempatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PenempatanNotifier(context: context),
      child: Consumer(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
