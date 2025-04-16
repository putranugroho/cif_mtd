import 'package:flutter/material.dart';

import '../../models/users_model.dart';

class AktivasiUsersNotifier extends ChangeNotifier {
  final BuildContext context;

  AktivasiUsersNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      listData.add(UsersModel.fromJson(i));
    }
    notifyListeners();
  }

  List<UsersModel> listData = [];
  List<Map<String, dynamic>> data = [
    {
      "userid": "edicybereye",
      "pass": "123123",
      "namauser": "Edi Kurniawan",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": "",
      "tglexp": "2025-12-30",
      "lvluser": "A",
      "terminal_id": "",
      "akses_kasir": "N",
      "sbb_kasir": "",
      "nama_sbb": "",
      "fhoto_1": "",
      "fhoto_2": "",
      "fhoto_3": "",
      "level_otor": "1",
      "beda_kantor": "Y",
      "min_otor": "10000000",
      "max_otor": "20000000"
    },
    {
      "userid": "fadli",
      "pass": "123123",
      "namauser": "Fadli",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": "",
      "tglexp": "2025-12-30",
      "lvluser": "A",
      "terminal_id": "",
      "akses_kasir": "N",
      "sbb_kasir": "",
      "nama_sbb": "",
      "fhoto_1": "",
      "fhoto_2": "",
      "fhoto_3": "",
      "level_otor": "1",
      "beda_kantor": "Y",
      "min_otor": "10000000",
      "max_otor": "20000000"
    },
  ];
}
