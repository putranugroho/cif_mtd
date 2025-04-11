import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class OtorisasiTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  OtorisasiTransaksiNotifier({required this.context}) {
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
      "modul": "Input - Satu Transaksi",
      "user": "Edi Kurniawan",
      "tanggal": "6 April 2025, 12:04",
      "data":
          "Melebih Hak Akses Transaksi\n\nStatus : CREATED\nKeterangan Transaksi : \nNilai : 1.000.000\nAkun Debet : Kas Kecil\nAkun Kredit : Kas Transaksi\nNomor Dokumen : \nNomor Referensi : \nKeterangan : ",
      "status": "PENDING"
    },
  ];
  List<OtorisasiModel> list = [];
}
