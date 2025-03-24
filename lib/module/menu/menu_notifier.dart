import 'package:flutter/material.dart';

class MenuNotifier extends ChangeNotifier {
  final BuildContext context;

  MenuNotifier({required this.context}) {
    getProfile();
  }

  getProfile() async {}

  int page = 0;
  gantimenu(int value) {
    page = value;
    notifyListeners();
  }
}
