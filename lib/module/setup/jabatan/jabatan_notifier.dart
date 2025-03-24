import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class JabatanNotifier extends ChangeNotifier {
  final BuildContext context;

  JabatanNotifier({required this.context}) {
    for (Map<String, dynamic> i in jabatan) {
      listJabatan.add(JabatanModel.fromJson(i));
    }
    for (Map<String, dynamic> i in json) {
      list.add(LevelModel.fromJson(i));
    }
    notifyListeners();
  }

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();

  List<JabatanModel> listJabatan = [];

  List<Map<String, dynamic>> jabatan = [
    {
      "kode_jabatan": "0001",
      "nama_jabatan": "Direktur Utama",
      "lvl_jabatan": "2",
    },
    {
      "kode_jabatan": "0002",
      "nama_jabatan": "Komisaris",
      "lvl_jabatan": "1",
    },
    {
      "kode_jabatan": "0003",
      "nama_jabatan": "Direktur",
      "lvl_jabatan": "2",
    }
  ];
  List<LevelModel> list = [];
  LevelModel? levelModel;
  pilihLevel(LevelModel value) {
    levelModel = value;
    notifyListeners();
  }

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
