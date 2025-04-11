import 'package:flutter/material.dart';

import '../../models/transaksi_model.dart';

class JurnalNotifier extends ChangeNotifier {
  final BuildContext context;

  JurnalNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      listData.add(TransaksiModel.fromJson(i));
    }
    firstDayCurrentMonth = DateTime.utc(now.year, now.month, 1);

    lastDayCurrentMonth =
        DateTime.utc(now.year, now.month + 1).subtract(Duration(days: 1));
    notifyListeners();
  }

  DateTime now = DateTime.now();

  DateTime? firstDayCurrentMonth;
  DateTime? lastDayCurrentMonth;

  Future changeStartDate() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2040),
    ));
    now = pickedendDate!;

    notifyListeners();
  }

  Future changeEndDate() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2040),
    ));
    lastDayCurrentMonth = pickedendDate!;

    notifyListeners();
  }

  List<TransaksiModel> listData = [];
  List<Map<String, dynamic>> data = [
    {
      "tgl_trans": "2025-03-26",
      "trans_user": "Edi Kurniawan",
      "kode_trans": "",
      "debet_acc": "100010001",
      "nama_debet": "Kas Besar",
      "credit_acc": "100010002",
      "nama_credit": "Kas Kecil",
      "nomor_dok": "",
      "nomor_ref": "8902989844i9491",
      "nominal": "1000000",
      "keterangan": "Persedian ATK",
      "kode_pt": "001",
      "kode_kantor": "10001",
      "kode_induk": "",
      "kode_ao_debet": "",
      "kode_ao_credit": ""
    },
    {
      "tgl_trans": "2025-03-26",
      "trans_user": "Edi Kurniawan",
      "kode_trans": "",
      "debet_acc": "100010001",
      "nama_debet": "Kas Besar",
      "credit_acc": "100010002",
      "nama_credit": "Kas Kecil",
      "nomor_dok": "",
      "nomor_ref": "89029898449492",
      "nominal": "1500000",
      "keterangan": "Isi Petty Cash April",
      "kode_pt": "001",
      "kode_kantor": "10001",
      "kode_induk": "",
      "kode_ao_debet": "",
      "kode_ao_credit": "",
    },
  ];
}
