import 'package:flutter/material.dart';

class PenyusutanNotifier extends ChangeNotifier {
  final BuildContext context;

  PenyusutanNotifier({required this.context});

  int metode = 0;

  gantimetode(int value) {
    metode = value;
    notifyListeners();
  }
}
