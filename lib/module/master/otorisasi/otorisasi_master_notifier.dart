import 'package:cif/models/index.dart';
import 'package:flutter/material.dart';

class OtorisasiMasterNotifier extends ChangeNotifier {
  final BuildContext context;

  OtorisasiMasterNotifier({required this.context}) {
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
      "modul": "Input - Customer",
      "user": "Edi Kurniawan",
      "tanggal": "6 April 2025, 11:22",
      "data": "No Sif : 100000021\nNama Sif : Rio Abdi Perkasa\nGolongan Customer : Customer\nBidang Usaha : Logistik",
      "status": "PENDING"
    },
  ];
  List<OtorisasiModel> list = [];
}
