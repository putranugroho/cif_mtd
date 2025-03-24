import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class KantorNotifier extends ChangeNotifier {
  final BuildContext context;

  KantorNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(KantorModel.fromJson(i));
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> data = [
    {
      "kode_pt": "10001",
      "kode_kantor": "100011",
      "kode_induk": "",
      "nama_kantor": "PT TEGUH AMAN LESTARI ",
      "status_kantor": "P",
      "alamat": "Trasa Coworking Space",
      "kelurahan": "PROCOT",
      "kecamatan": "SLAWI",
      "kota": "KABUPATEN TEGAL",
      "provinsi": "JAWA TENGAH",
      "kode_pos": "52419",
      "telp": null,
      "fax": null
    }
  ];
  List<KantorModel> list = [];
}
