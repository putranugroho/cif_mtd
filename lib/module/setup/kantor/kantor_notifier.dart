import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class KantorNotifier extends ChangeNotifier {
  final BuildContext context;

  KantorNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(KantorModel.fromJson(i));
    }
    kantorModel = list.where((e) => e.statusKantor == "P").first;
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

  KantorModel? kantorModel;

  pilihKantor(KantorModel value) {
    kantorModel = value;
    notifyListeners();
  }

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController provinsi = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController kecamatan = TextEditingController();
  TextEditingController kelurahan = TextEditingController();
  TextEditingController kodepos = TextEditingController();
  TextEditingController notelp = TextEditingController();
  TextEditingController fax = TextEditingController();

  List<String> listStatus = [
    "Pusat",
    "Cabang",
    "Anak Cabang",
    "Outlet/Gudang",
  ];

  String? status;
  pilihStatus(String value) {
    status = value;
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
