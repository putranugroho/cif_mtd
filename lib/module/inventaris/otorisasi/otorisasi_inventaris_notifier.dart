import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class OtorisasiInventarisNotifier extends ChangeNotifier {
  final BuildContext context;

  OtorisasiInventarisNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(OtorisasiModel.fromJson(i));
    }
    notifyListeners();
  }

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  OtorisasiModel? otorisasiModel;
  var dialog = false;
  edit(String data) {
    otorisasiModel = list.where((e) => e.data == data).first;
    dialog = true;
    notifyListeners();
  }

  close() {
    dialog = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> data = [
    {
      "modul": "Input - Pengadaan",
      "user": "Edi Kurniawan",
      "tanggal": "6 April 2025, 12:04",
      "data":
          "No Aset : 100002\nNama Aset : Avanza\nKelompok : TRANSPORTASI\nGolongan : Kendaraan\nHarga : 140.000.000\nTotal : 140.000.000",
      "status": "PENDING"
    },
  ];
  List<OtorisasiModel> list = [];
}
