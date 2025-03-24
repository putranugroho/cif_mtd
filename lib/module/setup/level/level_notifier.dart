import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class LevelNotifier extends ChangeNotifier {
  final BuildContext context;

  LevelNotifier({required this.context}) {
    for (Map<String, dynamic> i in json) {
      list.add(LevelModel.fromJson(i));
    }
    notifyListeners();
  }

  TextEditingController level = TextEditingController();
  TextEditingController jabatan = TextEditingController();

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<LevelModel> list = [];
  List<Map<String, dynamic>> json = [
    {"lvl_jabatan": "1", "kel_jabatan": "Komisaris"},
    {"lvl_jabatan": "2", "kel_jabatan": "Direksi"},
    {"lvl_jabatan": "3", "kel_jabatan": "GM"},
    {"lvl_jabatan": "4", "kel_jabatan": "Kep. Cabang"},
    {"lvl_jabatan": "5", "kel_jabatan": "Manager"},
    {"lvl_jabatan": "6", "kel_jabatan": "Kep. Ranting"},
    {"lvl_jabatan": "7", "kel_jabatan": "Kabag"},
    {"lvl_jabatan": "8", "kel_jabatan": "Supervisor"},
  ];
}
