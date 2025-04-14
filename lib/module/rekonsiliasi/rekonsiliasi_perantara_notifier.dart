import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class RekonsiliasiPerantaraNotifier extends ChangeNotifier {
  final BuildContext context;

  RekonsiliasiPerantaraNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(RekonPerantaraModel.fromJson(i));
    }

    for (var bb in data) {
      for (var sbb in bb['sbb_item']) {
        double saldoAwal = sbb['saldo'] ?? 0.0;
        List transaksi = sbb['item_transaksi'];

        for (var trx in transaksi) {
          double nominal = trx['nominal'] ?? 0.0;
          saldoAwal -= nominal;

          // Tambahkan nilai sisaSaldo ke transaksi
          trx['sisaSaldo'] = saldoAwal;
        }
      }
    }

    // for (var item in data) {
    //   String typePosting = item['kode_kelompok'];
    //   List<Map<String, dynamic>> sbbItems =
    //       List<Map<String, dynamic>>.from(item['item']);

    //   double subtotal = sbbItems.fold(
    //       0, (sum, sbb) => sum + double.parse((sbb['haper'] ?? 0)));

    //   // if (typePosting == 'AKTIVA') {
    //   //   totalAktiva += subtotal;
    //   // } else if (typePosting == 'PASIVA') {
    //   //   totalPasiva += subtotal;
    //   // }
    // }

    notifyListeners();
  }

  int totalActive = 0;
  int totalMacet = 0;
  List<RekonPerantaraModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "nobb": "400000000001",
      "nama_bb": "RRA - BEBAN DIBAYAR DIMUKA",
      "type_posting": "AKTIVA",
      "sbb_item": [
        {
          "nosbb": "0190301",
          "nama_sbb": "Biaya Dibayar dimuka - Sewa Gedung",
          "type_posting": "",
          "saldo": 640000.00,
          "item_transaksi": [
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449491",
              "debet_acc": "0190301",
              "nama_debet": "Biaya Dibayar dimuka - Sewa Gedung",
              "credit_acc": "0130109",
              "nama_credit": "Giro Bank BNI",
              "nomor_dok": "",
              "nomor_ref": "89029898449491",
              "nominal": 320000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449492",
              "debet_acc": "0190301",
              "nama_debet": "Biaya Dibayar dimuka - Sewa Gedung",
              "credit_acc": "0130109",
              "nama_credit": "Giro Bank BNI",
              "nomor_dok": "",
              "nomor_ref": "89029898449492",
              "nominal": 150000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            }
          ],
        },
        {
          "nosbb": "0190304",
          "nama_sbb": "Biaya Dibayar dimuka - Lainnya",
          "type_posting": "",
          "saldo": 850000.00,
          "item_transaksi": [
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449492",
              "debet_acc": "0190304",
              "nama_debet": "Biaya Dibayar dimuka - Lainnya",
              "credit_acc": "0130109",
              "nama_credit": "Giro Bank BNI",
              "nomor_dok": "",
              "nomor_ref": "89029898449492",
              "nominal": 150000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
          ],
        },
        // {
        //   "nosbb": "0190315",
        //   "nama_sbb": "Uang Muka Pajak",
        //   "type_posting": "",
        //   "saldo": 215449.36,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190319",
        //   "nama_sbb": "Biaya Dibayar Dimuka - OJK",
        //   "type_posting": "",
        //   "saldo": 40027.64,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190321",
        //   "nama_sbb": "BDD LAINNYA 3",
        //   "type_posting": "",
        //   "saldo": 94540.00,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190322",
        //   "nama_sbb": "DEPOSIT INVELLI",
        //   "type_posting": "",
        //   "saldo": 264.63,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190323",
        //   "nama_sbb": "DEPOSIT MTD",
        //   "type_posting": "",
        //   "saldo": 10000.00,
        //   "item_transaksi": [],
        // }
      ]
    },
  ];
}
