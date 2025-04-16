import 'dart:io';

import 'package:accounting/models/index.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BayarDimukaNotifier extends ChangeNotifier {
  final BuildContext context;

  BayarDimukaNotifier({required this.context}) {
    for (Map<String, dynamic> i in json) {
      listTransaksi.add(TransaksiModel.fromJson(i));
    }
    for (Map<String, dynamic> i in data) {
      listData.add(TransaksiBayarPendapatanDimukaModel.fromJson(i));
    }

    notifyListeners();
  }

  confirmPrint() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog();
        });
  }

  DateTime? tglTransaksi;
  Future pilihTanggalBuka() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) + 10,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
    ));
    if (pickedendDate != null) {
      tglTransaksi = pickedendDate;
      tglTransaksiText.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController nomorRef = TextEditingController();

  bool dialog = false;
  tambah() {
    dialog = true;
    referensi = false;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    referensi = false;
    notifyListeners();
  }

  kembali() {
    dialog = true;
    referensi = false;
    notifyListeners();
  }

  List<TransaksiBayarPendapatanDimukaModel> listData = [];
  List<Map<String, dynamic>> data = [
    {
      "no_transaksi": "TR0000001",
      "keterangan": "Sewa Gedung ",
      "berapa": "12",
      "tanggal_transaksi": "2024-04-16",
      "dimuka": "N",
      "no_referensi": "RFFF000001",
      "nominal": "120000000",
      "status": "A",
    }
  ];

  TextEditingController keterangan = TextEditingController();
  TextEditingController berapakali = TextEditingController();
  TextEditingController nomiinal = TextEditingController();
  TextEditingController noakun = TextEditingController();
  TextEditingController namaakun = TextEditingController();
  TextEditingController tanggaltransaksi = TextEditingController();

  List<String> listJenis = [
    "BAYAR DIMUKA",
    "PENDAPATAN DIMUKA",
  ];
  String? jenis = "BAYAR DIMUKA";
  pilihjenis(String value) {
    jenis = value;
    notifyListeners();
  }

  bool dimuka = false;
  bool referensi = false;
  pilihReferensi() {
    referensi = true;
    dialog = false;
    notifyListeners();
  }

  gantidimuka() {
    dimuka = !dimuka;
    notifyListeners();
  }

  List<TransaksiModel> listTransaksi = [];

  TransaksiModel? transaksiModel;
  pilihTransaksi(TransaksiModel value) {
    transaksiModel = value;
    dialog = true;
    referensi = false;
    noakun.text = value.creditAcc;
    keterangan.text = value.keterangan;
    namaakun.text = value.namaCredit;
    nominal.text = FormatCurrency.oCcy
        .format(int.parse(value.nominal))
        .replaceAll(".", ",");
    notifyListeners();
  }

  clear() {
    transaksiModel = null;
    noakun.clear();
    namaakun.clear();
    nominal.clear();
    notifyListeners();
  }

  List<Map<String, dynamic>> json = [
    {
      "tgl_trans": "2025-03-26",
      "trans_user": "Edi Kurniawan",
      "kode_trans": "89029898449491",
      "credit_acc": "0190301",
      "nama_credit": "Biaya Dibayar dimuka - Sewa Gedung",
      "debet_acc": "0130103",
      "nama_debet": "Giro Bank Mandiri",
      "nomor_dok": "",
      "nomor_ref": "89029898449491",
      "nominal": "1000000",
      "keterangan": "Gdng, Graha Muncul Mekar",
      "kode_pt": "001",
      "kode_kantor": "10001",
      "kode_induk": "",
      "kode_ao_debet": "",
      "kode_ao_credit": ""
    }
  ];
}
