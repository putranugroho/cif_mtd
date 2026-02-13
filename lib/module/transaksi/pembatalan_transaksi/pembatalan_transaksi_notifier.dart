import 'dart:convert';

import 'package:cif/models/index.dart';
import 'package:cif/pref/pref.dart';
import 'package:cif/utils/dialog_loading.dart';
import 'package:cif/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/transaksi_model.dart';
import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';
import '../../../utils/informationdialog.dart';

class PembatalanTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  PembatalanTransaksiNotifier({required this.context}) {
    getProfile();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      notifyListeners();
    });
  }

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

  DateTime? tglVal = DateTime.now();
  Future tanggalValuta() async {
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
      tglVal = pickedendDate;
      tglValuta.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
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
      tglPenjualan.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController noRef = TextEditingController();
  TextEditingController noDok = TextEditingController();
  TextEditingController tglTransaksi = TextEditingController();
  TextEditingController tglValuta = TextEditingController();
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
    if (keyForm.currentState!.validate()) {
      if (users!.namauser != transaksiModel!.inpuser) {
        informationDialog(context, "Warning", "User tidak sesuai");
      } else {
        DialogCustom().showLoading(context);
        // print(transaksiModel!.inptgljam);

        var data = {
          "rrn": transaksiModel!.rrn,
          "otoruser": users!.namauser,
          "keterangan_otorisasi": "Pembatalan transaksi ${transaksiModel!.rrn}",
          "alasan": alasan.text,
          "otorinput": DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now()),
          "kode_pt": transaksiModel!.kodePt,
        };
        print(jsonEncode(data));
        Setuprepository.setup(token, NetworkURL.batal(), jsonEncode(data)).then((value) {
          Navigator.pop(context);
          if (value['code'] == "000") {
            dialog = false;
            editData = false;
            transaksiModel = null;
            notifyListeners();
            informationDialog(context, "Information", value['message']);
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      }
    }
  }

  bool dialog = false;
  tambah(String rrn) {
    // clear();
    transaksiModel = listTransaksi.where((e) => e.rrn == rrn).first;
    noDok.text = transaksiModel!.nomorDok;
    noRef.text = transaksiModel!.nomorRef;
    tglTransaksi.text = transaksiModel!.tglVal;
    nominal.text = "Rp ${FormatCurrency.oCcyDecimal.format(double.parse(transaksiModel!.nominal))}";
    akunDebit.text = transaksiModel!.namaDebet;
    sbbDebit.text = transaksiModel!.debetAcc;
    sbbKredit.text = transaksiModel!.creditAcc;
    akunKredit.text = transaksiModel!.namaCredit;
    keterangan.text = transaksiModel!.keterangan;
    aoDebit.text = transaksiModel!.kodeAoDebet;
    aoKredit.text = transaksiModel!.kodeAoCredit;
    tglPenjualan.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    editData = false;
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  TransaksiModel? transaksiModel;

  var isLoadingData = true;
  List<TransaksiModel> listTransaksi = [];
  Future cariSekarang() async {
    isLoadingData = true;
    listTransaksi.clear();
    notifyListeners();
    var data = cariTrans
        ? {
            "filter": {
              "general": {
                "batch": null,
                "status_transaksi": "trx_success",
                "kode_pt": users!.kodePt,
                "kode_kantor": users!.kodeKantor,
                "kode_induk": users!.kodeInduk,
                "rrn": null,
                "no_dokumen": null,
                "no_reff": null,
                "flag_trn": "0"
              },
              "range_tanggal": {"from": DateFormat('y-MM-dd').format(DateTime.now()), "to": DateFormat('y-MM-dd').format(DateTime.now())},
              "akun": {"dracc": null, "cracc": null},
              "range_nominal": {"min": null, "max": null}
            },
            "pagination": {"page": 1},
            "sort": {"by": "tgl_val", "order": "desc"}
          }
        : {
            "filter": {
              "general": {
                "batch": null,
                "status_transaksi": "trx_success",
                "kode_pt": users!.kodePt,
                "kode_kantor": users!.kodeKantor,
                "kode_induk": users!.kodeInduk,
                "rrn": null,
                "no_dokumen": null,
                "no_reff": null,
                "flag_trn": "0"
              },
              "range_tanggal_valuta": {"from": DateFormat('y-MM-dd').format(tglVal!), "to": DateFormat('y-MM-dd').format(tglVal!)},
              "akun": {"dracc": null, "cracc": null},
              "range_nominal": {"min": null, "max": null}
            },
            "pagination": {"page": 1},
            "sort": {"by": "tgl_val", "order": "desc"}
          };
    Setuprepository.setup(token, NetworkURL.search(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksi.add(TransaksiModel.fromJson(i));
        }
        isLoadingData = false;
        notifyListeners();
      } else {
        isLoadingData = false;
        notifyListeners();
      }
    });
  }
}
