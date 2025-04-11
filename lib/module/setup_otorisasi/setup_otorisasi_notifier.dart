import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class SetupOtorisasiNotifier extends ChangeNotifier {
  final BuildContext context;

  SetupOtorisasiNotifier({required this.context}) {
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
      "modul": "Input - Data Kantor",
      "user": "Edi Kurniawan",
      "tanggal": "6 April 2025, 11:00",
      "data": "Kantor 2",
      "status": "PENDING"
    },
    {
      "modul": "Perubahan - Data Kantor",
      "user": "Edi Kurniawan",
      "tanggal": "6 April 2025, 11:15",
      "data":
          "Kode Kantor : 100011 >< 100001,\nNama Kantor : PT TEGUH AMAN LESTARI >< TEGUH AMAN LESTARI",
      "status": "PENDING"
    },
  ];
  List<OtorisasiModel> list = [];
}
