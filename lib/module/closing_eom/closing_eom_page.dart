import 'package:accounting/module/closing_eom/closing_eom_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClosingEomPage extends StatelessWidget {
  const ClosingEomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClosingEomNotifier(context: context),
      child: Consumer<ClosingEomNotifier>(
        builder: (context, value, child) => SafeArea(child: Scaffold()),
      ),
    );
  }
}
