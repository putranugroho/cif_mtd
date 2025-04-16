import 'package:flutter/material.dart';

class RekonsiliasiTransaksiPendingNotifier extends ChangeNotifier {
  final BuildContext context;

  RekonsiliasiTransaksiPendingNotifier({required this.context}) {
    notifyListeners();
  }
}
