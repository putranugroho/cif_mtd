import 'package:accounting/module/setup/otorisasi/otorisasi_setup_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtorisasiSetupPage extends StatelessWidget {
  const OtorisasiSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtorisasiSetupNotifier(context: context),
      child: Consumer<OtorisasiSetupNotifier>(
        builder: (context, value, child) => const SafeArea(child: Scaffold()),
      ),
    );
  }
}
