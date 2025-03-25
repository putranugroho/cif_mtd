import 'package:flutter/material.dart';

class SetupPajakNotifier extends ChangeNotifier {
  final BuildContext context;

  SetupPajakNotifier({required this.context});

  TextEditingController ppn = TextEditingController();
  TextEditingController maksPpn = TextEditingController();
  TextEditingController pph23 = TextEditingController();
}
