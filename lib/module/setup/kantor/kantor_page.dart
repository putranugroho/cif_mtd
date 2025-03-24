import 'package:accounting/module/setup/kantor/kantor_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KantorPage extends StatelessWidget {
  const KantorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KantorNotifier(context: context),
      child: Consumer<KantorNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Kantor",
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
