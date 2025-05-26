import 'package:accounting/models/index.dart';
import 'package:accounting/pref/pref.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LaporanTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  LaporanTransaksiNotifier({required this.context}) {
    getProfile();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      tglTransaksi.text = DateFormat("dd-MMM-yyyy").format(DateTime.now());
      notifyListeners();
    });
  }

  String cariTrans = "SUCCESS";
  pilihCariTransaksi(String value) {
    cariTrans = value;
    notifyListeners();
  }

  bool cariTglTrans = true;
  pilihTglTransaksi(bool value) {
    cariTglTrans = value;
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
          ))),
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
          ))),
    ));
    if (pickedendDate != null) {
      tglTrans = pickedendDate;
      tglTransaksi.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  DateTime? tglJual = DateTime.now();
  Future tanggalPenjualan() async {
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
          int.parse(DateFormat('y').format(DateTime.now())) - 1,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) + 1,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
                DateTime.now(),
              )) -
              1),
    ));
    if (pickedendDate != null) {
      tglJual = pickedendDate;
      tglPenjualan.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController cariUser = TextEditingController();
  TextEditingController noRef = TextEditingController();
  TextEditingController noDok = TextEditingController();
  TextEditingController tglTransaksi = TextEditingController();
  TextEditingController tglPenjualan = TextEditingController();
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
  final searchForm = GlobalKey<FormState>();
  final keyForm = GlobalKey<FormState>();
  final keyForm2 = GlobalKey<FormState>();
  cek() {}

  confirm() {
    if (keyForm.currentState!.validate()) {}
  }

  bool pilihSemuaMenu = false;

  void togglePilihSemua() {}

  bool dialog = false;
  tambah() {
    // clear();
    editData = false;
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }
}
