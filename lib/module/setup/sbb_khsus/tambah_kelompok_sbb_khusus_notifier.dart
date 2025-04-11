import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class TambahKelompokSbbKhususNotifier extends ChangeNotifier {
  final BuildContext context;

  TambahKelompokSbbKhususNotifier({required this.context}) {
    for (Map<String, dynamic> i in json) {
      list.add(GolonganSbbKhususModel.fromJson(i));
    }
    notifyListeners();
  }

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();

  bool satu = false;
  gantisatuan() {
    satu = !satu;
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

  List<GolonganSbbKhususModel> list = [];
  List<Map<String, dynamic>> json = [
    {
      "kode_sbb_khusus": "AK",
      "nama_sbb_khusus": "Arus Kas",
      "coa_satu": "N",
    },
    {
      "kode_sbb_khusus": "LB",
      "nama_sbb_khusus": "LR Berjalan",
      "coa_satu": "Y",
    },
    {
      "kode_sbb_khusus": "LB",
      "nama_sbb_khusus": "LR Tahun Lalu",
      "coa_satu": "Y",
    },
  ];
}
