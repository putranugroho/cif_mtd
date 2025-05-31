import 'package:flutter/material.dart';

import '../../models_manual/rekon_perantara_model.dart';

class RekonsiliasiPerantaraPasivaNotifier extends ChangeNotifier {
  final BuildContext context;

  RekonsiliasiPerantaraPasivaNotifier({required this.context}) {
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
      "nobb": "100000000001",
      "nama_bb": "RRP - LAINNYA",
      "type_posting": "PASIVA",
      "sbb_item": [
        {
          "nosbb": "0290901",
          "nama_sbb": "Cadangan Dana Pendidikan",
          "type_posting": "",
          "saldo": 750000.00,
          "item_transaksi": [
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449491",
              "debet_acc": "0290901",
              "nama_debet": "Cadangan Dana Pendidikan",
              "credit_acc": "0110101",
              "nama_credit": "Kas Kantor",
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
              "kode_trans": "89029898449491",
              "debet_acc": "0290901",
              "nama_debet": "Cadangan Dana Pendidikan",
              "credit_acc": "0110101",
              "nama_credit": "Kas Kantor",
              "nomor_dok": "",
              "nomor_ref": "89029898449491",
              "nominal": 230000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
          ],
        },
      ]
    },
  ];
}
