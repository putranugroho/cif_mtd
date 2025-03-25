import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class KelompokAsetNotifier extends ChangeNotifier {
  final BuildContext context;

  KelompokAsetNotifier({required this.context}) {
    for (Map<String, dynamic> i in json) {
      list.add(KelompokAsetModel.fromJson(i));
    }
    notifyListeners();
  }

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<KelompokAsetModel> list = [];
  List<Map<String, dynamic>> json = [
    {
      "kode_kelompok": "1",
      "nama_kelompok": "TRANSPORTASI",
    },
    {
      "kode_kelompok": "2",
      "nama_kelompok": "BERGERAK",
    },
  ];
}
