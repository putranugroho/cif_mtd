import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserAksesNotifier extends ChangeNotifier {
  final BuildContext context;

  UserAksesNotifier({required this.context}) {}

  bool cariTrans = false;
  pilihCariTransaksi(bool value) {
    cariTrans = value;
    notifyListeners();
  }

  bool cariDok = false;
  gantiCariDok() {
    cariDok = !cariDok;
    notifyListeners();
  }

  DateTime? tglTrans = DateTime.now();
  Future tanggalTransaksi() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
                DateTime.now(),
              )) -
              1),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) - 10,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
                DateTime.now(),
              )) -
              1),
    ));
    if (pickedendDate != null) {
      tglTrans = pickedendDate;
      tglTransaksi.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController noRef = TextEditingController();
  TextEditingController noDok = TextEditingController();
  TextEditingController tglTransaksi = TextEditingController();
  TextEditingController nominal = TextEditingController();
  TextEditingController akunDebit = TextEditingController();
  TextEditingController akunKredit = TextEditingController();
  TextEditingController sbbDebit = TextEditingController();
  TextEditingController sbbKredit = TextEditingController();
  TextEditingController aoDebit = TextEditingController();
  TextEditingController aoKredit = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController alasan = TextEditingController();

  var editData = false;
  final keyForm = GlobalKey<FormState>();
  cek() {}

  confirm() {}

  bool dialog = false;
  tambah() {
    // clear();
    editData = false;
    dialog = true;
    notifyListeners();
  }

  edit(String id) async {}

  tutup() {
    dialog = false;
    notifyListeners();
  }
}
