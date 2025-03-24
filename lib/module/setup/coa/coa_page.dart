import 'package:accounting/module/setup/coa/coa_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoaPage extends StatelessWidget {
  const CoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoaNotifier(context: context),
      child: Consumer<CoaNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Chart of Account",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(child: ListView())
            ],
          ),
        )),
      ),
    );
  }
}
