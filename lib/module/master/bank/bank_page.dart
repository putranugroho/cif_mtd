import 'package:accounting/module/master/bank/bank_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankPage extends StatelessWidget {
  const BankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BankNotifier(context: context),
      child: Consumer<BankNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        )),
      ),
    );
  }
}
