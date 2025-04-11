import 'package:flutter/material.dart';

class SetupClosingEomNotifier extends ChangeNotifier {
  final BuildContext context;

  SetupClosingEomNotifier({required this.context}) {}

  TextEditingController closing = TextEditingController(text: "3");
}
