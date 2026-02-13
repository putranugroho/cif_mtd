import 'package:cif/models/index.dart';
import 'package:flutter/material.dart';

class RekonsiliasiHutangNotifier extends ChangeNotifier {
  final BuildContext context;

  RekonsiliasiHutangNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(RekonsiliasiPiutangHutangModel.fromJson(i));
    }
    for (Map<String, dynamic> i in dataPiutang) {
      listPiutang.add(RekonsiliasiPiutangHutangModel.fromJson(i));
    }
    if (list.isNotEmpty) {
      totalActive = list.where((f) => f.statusInvoice == "A").map((e) => int.parse(e.nilaiInvoice)).reduce((a, b) => a + b);
      totalMacet = list.where((f) => f.statusInvoice == "M").map((e) => int.parse(e.nilaiInvoice)).reduce((a, b) => a + b);
    }
    notifyListeners();
  }

  List<String> listHutang = [
    "HUTANG",
    "PIUTANG",
  ];
  String? jenis = "HUTANG";
  pilihJenis(String value) {
    jenis = value;
    notifyListeners();
  }

  int totalActive = 0;
  int totalMacet = 0;
  List<RekonsiliasiPiutangHutangModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "no_invoice": "INV10000001",
      "jns_invoice": "1",
      "no_sif": "100011",
      "nm_sif": "PT GLOBAL TEKNOLOGI INDONESIA",
      "tgl_invoice": "2025-04-07",
      "nilai_invoice": "120000000",
      "ppn": "0",
      "pph": "0",
      "tgl_jt_tempo": "2025-04-30",
      "bertahap": "N",
      "jumlah_tahap": "",
      "tgl_bayar": "",
      "nilai_bayar": "",
      "status_invoice": "A",
      "kode_pt": "001",
      "kode_kantor": "10011",
      "kode_induk": "",
      "kode_ao": "",
      "no_referensi": "INV10000001",
      "saldo": "120000000",
    },
    {
      "no_invoice": "INV10000002",
      "jns_invoice": "2",
      "no_sif": "100011",
      "nm_sif": "PT GLOBAL TEKNOLOGI INDONESIA",
      "tgl_invoice": "2025-04-07",
      "nilai_invoice": "60000000",
      "ppn": "0",
      "pph": "0",
      "tgl_jt_tempo": "2025-04-30",
      "bertahap": "N",
      "jumlah_tahap": "",
      "tgl_bayar": "",
      "nilai_bayar": "",
      "status_invoice": "A",
      "kode_pt": "001",
      "kode_kantor": "10011",
      "kode_induk": "",
      "kode_ao": "",
      "no_referensi": "",
      "saldo": "0",
    },
    {
      "no_invoice": "INV10000003",
      "jns_invoice": "2",
      "no_sif": "100011",
      "nm_sif": "PT GLOBAL TEKNOLOGI INDONESIA",
      "tgl_invoice": "2025-04-07",
      "nilai_invoice": "50000000",
      "ppn": "0",
      "pph": "0",
      "tgl_jt_tempo": "2025-04-30",
      "bertahap": "N",
      "jumlah_tahap": "",
      "tgl_bayar": "",
      "nilai_bayar": "",
      "status_invoice": "M",
      "kode_pt": "001",
      "kode_kantor": "10011",
      "kode_induk": "",
      "kode_ao": "",
      "no_referensi": "INV10000003",
      "saldo": "40000000",
    }
  ];

  List<RekonsiliasiPiutangHutangModel> listPiutang = [];
  List<Map<String, dynamic>> dataPiutang = [
    {
      "no_invoice": "INV10000001",
      "jns_invoice": "1",
      "no_sif": "100011",
      "nm_sif": "PT GLOBAL TEKNOLOGI INDONESIA",
      "tgl_invoice": "2025-04-07",
      "nilai_invoice": "120000000",
      "ppn": "0",
      "pph": "0",
      "tgl_jt_tempo": "2025-04-30",
      "bertahap": "N",
      "jumlah_tahap": "",
      "tgl_bayar": "",
      "nilai_bayar": "",
      "status_invoice": "A",
      "kode_pt": "001",
      "kode_kantor": "10011",
      "kode_induk": "",
      "kode_ao": "",
      "no_referensi": "INV10000001",
      "saldo": "120000000",
    },
    {
      "no_invoice": "INV10000002",
      "jns_invoice": "2",
      "no_sif": "100011",
      "nm_sif": "PT GLOBAL TEKNOLOGI INDONESIA",
      "tgl_invoice": "2025-04-07",
      "nilai_invoice": "60000000",
      "ppn": "0",
      "pph": "0",
      "tgl_jt_tempo": "2025-04-30",
      "bertahap": "N",
      "jumlah_tahap": "",
      "tgl_bayar": "",
      "nilai_bayar": "",
      "status_invoice": "A",
      "kode_pt": "001",
      "kode_kantor": "10011",
      "kode_induk": "",
      "kode_ao": "",
      "no_referensi": "",
      "saldo": "0",
    },
    {
      "no_invoice": "INV10000003",
      "jns_invoice": "2",
      "no_sif": "100011",
      "nm_sif": "PT GLOBAL TEKNOLOGI INDONESIA",
      "tgl_invoice": "2025-04-07",
      "nilai_invoice": "50000000",
      "ppn": "0",
      "pph": "0",
      "tgl_jt_tempo": "2025-04-30",
      "bertahap": "N",
      "jumlah_tahap": "",
      "tgl_bayar": "",
      "nilai_bayar": "",
      "status_invoice": "M",
      "kode_pt": "001",
      "kode_kantor": "10011",
      "kode_induk": "",
      "kode_ao": "",
      "no_referensi": "INV10000003",
      "saldo": "40000000",
    }
  ];
}
