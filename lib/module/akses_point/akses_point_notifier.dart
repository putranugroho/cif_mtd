import 'package:flutter/material.dart';

class AksesPointNotifier extends ChangeNotifier {
  final BuildContext context;

  AksesPointNotifier({required this.context}) {
    getAksesPoint();
  }

  getAksesPoint() async {}
}
