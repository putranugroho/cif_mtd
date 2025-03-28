import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class AktivasiNotifier extends ChangeNotifier {
  final BuildContext context;

  AktivasiNotifier({required this.context}) {
    for (Map<String, dynamic> i in json) {
      list.add(AktivasiModel.fromJson(i));
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
  TextEditingController jamMulai = TextEditingController();
  TextEditingController jamSelesai = TextEditingController();
  List<String> listHari = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];

  List<String> listHariAdd = [];

  pilihHari(String value) async {
    if (listHariAdd.isEmpty) {
      listHariAdd.add(value);
    } else {
      if (listHariAdd.where((e) => e == value).isNotEmpty) {
        listHariAdd.remove(value);
      } else {
        listHariAdd.add(value);
      }
    }
    notifyListeners();
  }

  List<AktivasiModel> list = [];
  List<Map<String, dynamic>> json = [
    {
      "kd_aktivasi": "100001",
      "nm_aktivasi": "Regu 1",
      "hari": "['Senin','Selasa','Rabu']",
      "jam_mulai": "10:00:00",
      "jam_selesai": "17:00:00"
    },
    {
      "kd_aktivasi": "100002",
      "nm_aktivasi": "Regu 2",
      "hari": "['Kamis','Jumat','Sabtu']",
      "jam_mulai": "08:00:00",
      "jam_selesai": "17:00:00"
    },
  ];
}
