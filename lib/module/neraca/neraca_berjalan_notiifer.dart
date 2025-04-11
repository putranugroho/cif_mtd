import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class NeracaBerjalanNotiifer extends ChangeNotifier {
  final BuildContext context;

  NeracaBerjalanNotiifer({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(NeracaModel.fromJson(i));
    }
    notifyListeners();
  }

  List<NeracaModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "nobb": "100000000001",
      "nama_bb": "Kas",
      "type_posting": "AKTIVA",
      "sbb_item": [
        {
          "nosbb": "100100000001",
          "nama_sbb": "Kas Besar",
          "type_posting": "",
          "saldo": "100000000",
        },
        {
          "nosbb": "100200000001",
          "nama_sbb": "Kas Kecil",
          "type_posting": "",
          "saldo": "5000000",
        },
        {
          "nosbb": "100300000001",
          "nama_sbb": "Kas Transaksi",
          "type_posting": "",
          "saldo": "10200000",
        },
      ],
    },
    {
      "nobb": "200000000001",
      "nama_bb": "Bank",
      "type_posting": "AKTIVA",
      "sbb_item": [
        {
          "nosbb": "200100000001",
          "nama_sbb": "Bank Mandiri",
          "type_posting": "",
          "saldo": "160000000",
        },
        {
          "nosbb": "200200000001",
          "nama_sbb": "Bank BCA",
          "type_posting": "",
          "saldo": "50000000",
        },
      ],
    },
    {
      "nobb": "400000000001",
      "nama_bb": "Tabungan",
      "type_posting": "PASIVA",
      "sbb_item": [
        {
          "nosbb": "400100000001",
          "nama_sbb": "Tabungan Karyawan",
          "type_posting": "",
          "saldo": "170000000",
        },
        {
          "nosbb": "400200000001",
          "nama_sbb": "Tabungan Pinjaman",
          "type_posting": "",
          "saldo": "60000000",
        },
      ],
    },
    {
      "nobb": "600000000001",
      "nama_bb": "Laba/Rugi",
      "type_posting": "PASIVA",
      "sbb_item": [
        {
          "nosbb": "600100000001",
          "nama_sbb": "Pendapatan",
          "type_posting": "",
          "saldo": "170000000",
        },
        {
          "nosbb": "600200000001",
          "nama_sbb": "Tabungan Pinjaman",
          "type_posting": "",
          "saldo": "60000000",
        },
      ],
    },
  ];
}
