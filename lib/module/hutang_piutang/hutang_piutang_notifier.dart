import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/inquery_gl_model.dart';
import 'adjusted_rounding.dart';

import '../../models/customer_supplier_model.dart';
import '../../models/setup_pajak_model.dart';
import '../../network/network.dart';
import '../../repository/SetupRepository.dart';

class HutangPiutangNotifier extends ChangeNotifier {
  final BuildContext context;
  final int tipe;

  HutangPiutangNotifier({
    required this.context,
    required this.tipe,
  }) {
    getProfile();
  }
  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getCustomers();
      getSetupPajak();
      getSetupkaskecil();
      // getHutangPiutang();
      notifyListeners();
    });
  }

  List<SetupHutangPiutangModel> listData = [];
  SetupHutangPiutangModel? setupHutangPiutangModel;
  Future getSetupkaskecil() async {
    isLoading = true;
    listData.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(
            token, NetworkURL.getSetupHutangPiutang(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listData.add(SetupHutangPiutangModel.fromJson(i));
        }
        if (list.isNotEmpty) {
          setupHutangPiutangModel = listData[0];
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future getHutangPiutang() async {
    var data = {"kode_pt": users!.kodePt};
    Setuprepository.setup(
        token, NetworkURL.getHutangPiutang(), jsonEncode(data));
  }

  List<Map<String, dynamic>> extractJnsAccB(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];

    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          if (item['jns_acc'] == 'C' && item['type_posting'] == "Y") {
            result.add(item);
          }

          if (item.containsKey('items') && item['items'] is List) {
            traverse(item['items']);
          }
        }
      }
    }

    traverse(rawData);
    return result;
  }

  InqueryGlModel? inqueryGlModelTransaksi;
  pilihAkunTransaksi(InqueryGlModel value) {
    inqueryGlModelTransaksi = value;
    namaakuntransaksi.text = value.namaSbb;
    notifyListeners();
  }

  InqueryGlModel? inqueryGlModelPajak;
  pilihAkunPajak(InqueryGlModel value) {
    inqueryGlModelPajak = value;
    namaakunpajak.text = value.namaSbb;
    notifyListeners();
  }

  InqueryGlModel? inqueryGlModelPph;
  pilihAkunPph(InqueryGlModel value) {
    inqueryGlModelPph = value;
    namaakunpph.text = value.namaSbb;
    notifyListeners();
  }

  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
  TextEditingController namaakuntransaksi = TextEditingController();
  TextEditingController namaakunpajak = TextEditingController();
  TextEditingController namaakunpph = TextEditingController();
  Future<List<InqueryGlModel>> getInquery(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listGl.clear();
      notifyListeners();

      var data = {"kode_pt": "001"};

      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getInqueryGL(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          final List<Map<String, dynamic>> jnsAccBItems =
              extractJnsAccB(response['data']);
          listGl = jnsAccBItems
              .map((item) => InqueryGlModel.fromJson(item))
              .where((model) =>
                  model.nosbb.toLowerCase().contains(query.toLowerCase()) ||
                  model.namaSbb.toLowerCase().contains(query.toLowerCase()) &&
                      model.typePosting == "Y")
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        isLoadingInquery = false;
        notifyListeners();
      }
    } else {
      listGl.clear(); // clear on short query
    }

    return listGl;
  }

  String? tipePiutang = "Jasa";
  List<String> listTipePiutang = [
    "Jasa",
    "Barang",
  ];

  bool ppn = true; // atau false
  bool pph = true; // atau false

  pilihTipePiutang(String value) {
    tipePiutang = value;
    notifyListeners();
  }

  final keyForm = GlobalKey<FormState>();
  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      List<Map<String, dynamic>> listTmp = [];

      for (var i = 0; i < listTglJthTempo.length; i++) {
        var tglJatuhTempo = listTglJthTempo[i].text;
        var nilaiTransaksi = listNilaiTransaksi[i].text.replaceAll(",", "");
        var nilaippn = listNilaiPPN[i].text.replaceAll(",", "");
        var nilaipph = listNilaiPPH[i].text.replaceAll(",", "");
        var outstanding = listOutstanding[i].text.replaceAll(",", "");
        var format = DateFormat('dd-MMM-y');
        DateTime parseDate = format.parse(tglJatuhTempo);
        listTmp.add({
          "custsupp": "${customerSupplierModel!.noSif}",
          "nokontrak": "${nokontrak.text}",
          "tgl_kontrak": "${DateFormat('y-MM-dd').format(tglKontrak!)}",
          "ke": "${i + 1}",
          "thn": "${DateFormat('y').format(parseDate)}",
          "bln": "${DateFormat('MM').format(parseDate)}",
          "tgl": "${DateFormat('dd').format(parseDate)}",
          "os": "$outstanding",
          "tag_pokok": "$nilaiTransaksi",
          "tag_ppn": "$nilaippn",
          "tag_pph": "$nilaipph",
          "byr_pokok": "0",
          "byr_ppn": "0",
          "byr_pph": "0",
          "ststgh": "0",
          "tglbyr_pokok": "",
          "tglbyr_ppn": "",
          "tglbyr_pph": "",
          "noinv": "${carabayar ? noinvoice.text : ""}",
          "tgltagihan": "${DateFormat('y-MM-dd').format(parseDate)}",
          "tglppn": "${DateFormat('y-MM-dd').format(parseDate)}",
          "tglpph": "${DateFormat('y-MM-dd').format(parseDate)}",
          "stspokok": "0",
          "stsppn": "0",
          "stspph": "0",
          "kdmkt": "",
          "stsrec": "A",
          "inpuser": "${users!.namauser}",
          "inptgljam": "${DateFormat('y-MM-dd HH:mm:ss').format(parseDate)}",
          "inpterm": "",
          "chguser": "",
          "chgtgljam": "",
          "chgterm": "",
          "autuser": "",
          "auttgljam": "",
          "autterm": "",
          "stsacru": "",
          "tglbyrlambat": "",
          "userinput": "${users!.namauser}",
          "userterm": "",
          "kode_pt": "${users!.kodePt}",
          "kode_kantor": "${users!.kodeKantor}",
          "kode_induk": "${users!.kodeInduk}",
          "no_ref": "${noreferensi.text}",
          "keterangan": "${keterangan.text}",
          "jenis_transaksi": "$tipePiutang",
          "nama_sif": "${customerSupplierModel!.nmSif}",
          "alamat": "${alamat.text}",
        });
      }
      notifyListeners();

      Setuprepository.setup(
              token, NetworkURL.addHutangPiutang(), jsonEncode(listTmp))
          .then((value) {
        Navigator.pop(context);
        if (value['status'].toString().toLowerCase().contains("success")) {
          //transaksi hutang piutang
          if (double.parse(users!.maksimalTransaksi) <
              double.parse(nilaitransaksi.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", "")
                  .replaceAll(",", "."))) {
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi":
                  "${DateFormat('y-MM-dd').format(DateTime.now())}",
              "tgl_valuta": "${DateFormat('y-MM-dd').format(tglKontrak!)}",
              "batch": "${users!.batch}",
              "trx_type": "TRX",
              "trx_code":
                  "${tglKontrak!.isBefore(DateTime.now()) ? "110" : "100"}",
              "otor": "0",
              "kode_trn": "",
              "nama_dr": jenis == 1
                  ? setupHutangPiutangModel!.namasbblawanpiutang
                  : setupHutangPiutangModel!.namasbbtransaksihutang,
              "dracc": jenis == 1
                  ? setupHutangPiutangModel!.sbblawanpiutang
                  : setupHutangPiutangModel!.sbbtransaksihutang,
              "nama_cr": jenis == 1
                  ? setupHutangPiutangModel!.namasbbtransaksipiutang
                  : setupHutangPiutangModel!.namasbblawanhutang,
              "cracc": jenis == 1
                  ? setupHutangPiutangModel!.sbbtransaksipiutang
                  : setupHutangPiutangModel!.sbblawanhutang,
              "rrn": "$invoice",
              "no_dokumen": "${nokontrak.text}",
              "no_ref": "${noreferensi.text}",
              "nominal": double.parse(nilaitransaksi.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", "")
                  .replaceAll(",", ".")),
              "keterangan": "${keterangan.text}",
              "kode_pt": "${users!.kodePt}",
              "kode_kantor": "${users!.kodeKantor}",
              "kode_induk": "${users!.kodeInduk}",
              "sts_validasi": "N",
              "kode_ao_dr": "",
              "kode_coll": "",
              "kode_ao_cr": "",
              "userinput": "${users!.namauser}",
              "userterm": "114.80.90.54",
              "keterangan_otorisasi": "Melebihi Maksimal Limit Transaksi",
              "inputtgljam":
                  "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
              "otoruser": "",
              "otorterm": "",
              "otortgljam": "",
              "flag_trn": "0",
              "merchant": "",
              "source_trx": "",
              "status": "PENDING",
              "modul": "HUTANG PIUTANG",
            };
            Setuprepository.setup(
                token, NetworkURL.transaksi(), jsonEncode(data));
          } else {
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi":
                  "${DateFormat('y-MM-dd').format(DateTime.now())}",
              "tgl_valuta": "${DateFormat('y-MM-dd').format(tglKontrak!)}",
              "batch": "${users!.batch}",
              "trx_type": "TRX",
              "trx_code":
                  "${tglKontrak!.isBefore(DateTime.now()) ? "110" : "100"}",
              "otor": "0",
              "kode_trn": "",
              "nama_dr": jenis == 1
                  ? setupHutangPiutangModel!.namasbblawanpiutang
                  : setupHutangPiutangModel!.namasbbtransaksihutang,
              "dracc": jenis == 1
                  ? setupHutangPiutangModel!.sbblawanpiutang
                  : setupHutangPiutangModel!.sbbtransaksihutang,
              "nama_cr": jenis == 1
                  ? setupHutangPiutangModel!.namasbbtransaksipiutang
                  : setupHutangPiutangModel!.namasbblawanhutang,
              "cracc": jenis == 1
                  ? setupHutangPiutangModel!.sbbtransaksipiutang
                  : setupHutangPiutangModel!.sbblawanhutang,
              "rrn": "$invoice",
              "no_dokumen": "${nokontrak.text}",
              "no_ref": "${noreferensi.text}",
              "nominal": double.parse(nilaitransaksi.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", "")
                  .replaceAll(",", ".")),
              "keterangan": "${keterangan.text}",
              "kode_pt": "${users!.kodePt}",
              "kode_kantor": "${users!.kodeKantor}",
              "kode_induk": "${users!.kodeInduk}",
              "sts_validasi": "N",
              "kode_ao_dr": "",
              "kode_coll": "",
              "kode_ao_cr": "",
              "userinput": "${users!.namauser}",
              "userterm": "114.80.90.54",
              "keterangan_otorisasi": "Melebihi Maksimal Limit Transaksi",
              "inputtgljam":
                  "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
              "otoruser": "",
              "otorterm": "",
              "otortgljam": "",
              "flag_trn": "0",
              "merchant": "",
              "source_trx": "",
              "status": "COMPLETED",
              "modul": "HUTANG PIUTANG",
            };
            Setuprepository.setup(
                token, NetworkURL.transaksi(), jsonEncode(data));
          }

          //transaksi PPN
          if (ppn) {
            if (double.parse(users!.maksimalTransaksi) <
                double.parse(nilaitransaksi.text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", "."))) {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta": "${DateFormat('y-MM-dd').format(tglKontrak!)}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code":
                    "${tglKontrak!.isBefore(DateTime.now()) ? "110" : "100"}",
                "otor": "0",
                "kode_trn": "",
                "nama_dr": jenis == 1
                    ? setupHutangPiutangModel!.namasbblawanpiutang
                    : setupHutangPiutangModel!.namasbbppnhutang,
                "dracc": jenis == 1
                    ? setupHutangPiutangModel!.sbblawanpiutang
                    : setupHutangPiutangModel!.sbbppnhutang,
                "nama_cr": jenis == 1
                    ? setupHutangPiutangModel!.namasbbppnpiutang
                    : setupHutangPiutangModel!.namasbblawanhutang,
                "cracc": jenis == 1
                    ? setupHutangPiutangModel!.sbbppnpiutang
                    : setupHutangPiutangModel!.sbblawanhutang,
                "rrn": "$invoice",
                "no_dokumen": "${nokontrak.text}",
                "no_ref": "${noreferensi.text}",
                "nominal": double.parse(nilaippn.text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")),
                "keterangan": "${keterangan.text}",
                "kode_pt": "${users!.kodePt}",
                "kode_kantor": "${users!.kodeKantor}",
                "kode_induk": "${users!.kodeInduk}",
                "sts_validasi": "N",
                "kode_ao_dr": "",
                "kode_coll": "",
                "kode_ao_cr": "",
                "userinput": "${users!.namauser}",
                "userterm": "114.80.90.54",
                "keterangan_otorisasi": "Melebihi Maksimal Limit Transaksi",
                "inputtgljam":
                    "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
                "otoruser": "",
                "otorterm": "",
                "otortgljam": "",
                "flag_trn": "0",
                "merchant": "",
                "source_trx": "",
                "status": "PENDING",
                "modul": "PPN HUTANG PIUTANG",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            } else {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta": "${DateFormat('y-MM-dd').format(tglKontrak!)}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code":
                    "${tglKontrak!.isBefore(DateTime.now()) ? "110" : "100"}",
                "otor": "0",
                "kode_trn": "",
                "nama_dr": jenis == 1
                    ? setupHutangPiutangModel!.namasbblawanpiutang
                    : setupHutangPiutangModel!.namasbbppnhutang,
                "dracc": jenis == 1
                    ? setupHutangPiutangModel!.sbblawanpiutang
                    : setupHutangPiutangModel!.sbbppnhutang,
                "nama_cr": jenis == 1
                    ? setupHutangPiutangModel!.namasbbppnpiutang
                    : setupHutangPiutangModel!.namasbblawanhutang,
                "cracc": jenis == 1
                    ? setupHutangPiutangModel!.sbbppnpiutang
                    : setupHutangPiutangModel!.sbblawanhutang,
                "rrn": "$invoice",
                "no_dokumen": "${nokontrak.text}",
                "no_ref": "${noreferensi.text}",
                "nominal": double.parse(nilaippn.text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")),
                "keterangan": "${keterangan.text}",
                "kode_pt": "${users!.kodePt}",
                "kode_kantor": "${users!.kodeKantor}",
                "kode_induk": "${users!.kodeInduk}",
                "sts_validasi": "N",
                "kode_ao_dr": "",
                "kode_coll": "",
                "kode_ao_cr": "",
                "userinput": "${users!.namauser}",
                "userterm": "114.80.90.54",
                "keterangan_otorisasi": "Melebihi Maksimal Limit Transaksi",
                "inputtgljam":
                    "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
                "otoruser": "",
                "otorterm": "",
                "otortgljam": "",
                "flag_trn": "0",
                "merchant": "",
                "source_trx": "",
                "status": "COMPLETED",
                "modul": "PPN HUTANG PIUTANG",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            }
          }

          //transaksi PPH
          if (pph) {
            if (double.parse(users!.maksimalTransaksi) <
                double.parse(nilaitransaksi.text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", "."))) {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta": "${DateFormat('y-MM-dd').format(tglKontrak!)}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code":
                    "${tglKontrak!.isBefore(DateTime.now()) ? "110" : "100"}",
                "otor": "0",
                "kode_trn": "",
                "nama_dr": jenis == 1
                    ? setupHutangPiutangModel!.namasbbpphpiutang
                    : setupHutangPiutangModel!.namasbblawanhutang,
                "dracc": jenis == 1
                    ? setupHutangPiutangModel!.sbbpphpiutang
                    : setupHutangPiutangModel!.sbblawanhutang,
                "nama_cr": jenis == 1
                    ? setupHutangPiutangModel!.namasbblawanpiutang
                    : setupHutangPiutangModel!.namasbbpphhutang,
                "cracc": jenis == 1
                    ? setupHutangPiutangModel!.sbblawanpiutang
                    : setupHutangPiutangModel!.sbbpphhutang,
                "rrn": "$invoice",
                "no_dokumen": "${nokontrak.text}",
                "no_ref": "${noreferensi.text}",
                "nominal": double.parse(nilaipph.text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")),
                "keterangan": "${keterangan.text}",
                "kode_pt": "${users!.kodePt}",
                "kode_kantor": "${users!.kodeKantor}",
                "kode_induk": "${users!.kodeInduk}",
                "sts_validasi": "N",
                "kode_ao_dr": "",
                "kode_coll": "",
                "kode_ao_cr": "",
                "userinput": "${users!.namauser}",
                "userterm": "114.80.90.54",
                "keterangan_otorisasi": "Melebihi Maksimal Limit Transaksi",
                "inputtgljam":
                    "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
                "otoruser": "",
                "otorterm": "",
                "otortgljam": "",
                "flag_trn": "0",
                "merchant": "",
                "source_trx": "",
                "status": "PENDING",
                "modul": "PPH HUTANG PIUTANG",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            } else {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta": "${DateFormat('y-MM-dd').format(tglKontrak!)}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code":
                    "${tglKontrak!.isBefore(DateTime.now()) ? "110" : "100"}",
                "otor": "0",
                "kode_trn": "",
                "nama_dr": jenis == 1
                    ? setupHutangPiutangModel!.namasbbpphpiutang
                    : setupHutangPiutangModel!.namasbblawanhutang,
                "dracc": jenis == 1
                    ? setupHutangPiutangModel!.sbbpphpiutang
                    : setupHutangPiutangModel!.sbblawanhutang,
                "nama_cr": jenis == 1
                    ? setupHutangPiutangModel!.namasbblawanpiutang
                    : setupHutangPiutangModel!.namasbbpphhutang,
                "cracc": jenis == 1
                    ? setupHutangPiutangModel!.sbblawanpiutang
                    : setupHutangPiutangModel!.sbbpphhutang,
                "rrn": "$invoice",
                "no_dokumen": "${nokontrak.text}",
                "no_ref": "${noreferensi.text}",
                "nominal": double.parse(nilaipph.text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")),
                "keterangan": "${keterangan.text}",
                "kode_pt": "${users!.kodePt}",
                "kode_kantor": "${users!.kodeKantor}",
                "kode_induk": "${users!.kodeInduk}",
                "sts_validasi": "N",
                "kode_ao_dr": "",
                "kode_coll": "",
                "kode_ao_cr": "",
                "userinput": "${users!.namauser}",
                "userterm": "114.80.90.54",
                "keterangan_otorisasi": "Melebihi Maksimal Limit Transaksi",
                "inputtgljam":
                    "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
                "otoruser": "",
                "otorterm": "",
                "otortgljam": "",
                "flag_trn": "0",
                "merchant": "",
                "source_trx": "",
                "status": "COMPLETED",
                "modul": "PPH HUTANG PIUTANG",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            }
          }

          //transaski barang
          if (jenis == 1) {
            if (tipePiutang == "Barang") {
              if (double.parse(users!.maksimalTransaksi) <
                  double.parse(nilaitransaksi.text
                      .replaceAll("Rp ", "")
                      .replaceAll(".", "")
                      .replaceAll(",", "."))) {
                var invoice = DateTime.now().millisecondsSinceEpoch.toString();
                var data = {
                  "tgl_transaksi":
                      "${DateFormat('y-MM-dd').format(DateTime.now())}",
                  "tgl_valuta": "${DateFormat('y-MM-dd').format(tglKontrak!)}",
                  "batch": "${users!.batch}",
                  "trx_type": "TRX",
                  "trx_code":
                      "${tglKontrak!.isBefore(DateTime.now()) ? "110" : "100"}",
                  "otor": "0",
                  "kode_trn": "",
                  "nama_dr": setupHutangPiutangModel!.namasbbhpppiutang,
                  "dracc": setupHutangPiutangModel!.sbbhpppiutang,
                  "nama_cr": setupHutangPiutangModel!.namasbbpersedianpiutang,
                  "cracc": setupHutangPiutangModel!.sbbpersedianpiutang,
                  "rrn": "$invoice",
                  "no_dokumen": "${nokontrak.text}",
                  "no_ref": "${noreferensi.text}",
                  "nominal": double.parse(nilaihpp.text
                      .replaceAll("Rp ", "")
                      .replaceAll(".", "")
                      .replaceAll(",", ".")),
                  "keterangan": "${keterangan.text}",
                  "kode_pt": "${users!.kodePt}",
                  "kode_kantor": "${users!.kodeKantor}",
                  "kode_induk": "${users!.kodeInduk}",
                  "sts_validasi": "N",
                  "kode_ao_dr": "",
                  "kode_coll": "",
                  "kode_ao_cr": "",
                  "userinput": "${users!.namauser}",
                  "userterm": "114.80.90.54",
                  "keterangan_otorisasi": "Melebihi Maksimal Limit Transaksi",
                  "inputtgljam":
                      "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
                  "otoruser": "",
                  "otorterm": "",
                  "otortgljam": "",
                  "flag_trn": "0",
                  "merchant": "",
                  "source_trx": "",
                  "status": "PENDING",
                  "modul": "HPP PERSEDIAN HUTANG PIUTANG",
                };
                Setuprepository.setup(
                    token, NetworkURL.transaksi(), jsonEncode(data));
              } else {
                var invoice = DateTime.now().millisecondsSinceEpoch.toString();
                var data = {
                  "tgl_transaksi":
                      "${DateFormat('y-MM-dd').format(DateTime.now())}",
                  "tgl_valuta": "${DateFormat('y-MM-dd').format(tglKontrak!)}",
                  "batch": "${users!.batch}",
                  "trx_type": "TRX",
                  "trx_code":
                      "${tglKontrak!.isBefore(DateTime.now()) ? "110" : "100"}",
                  "otor": "0",
                  "kode_trn": "",
                  "nama_dr": setupHutangPiutangModel!.namasbbhpppiutang,
                  "dracc": setupHutangPiutangModel!.sbbhpppiutang,
                  "nama_cr": setupHutangPiutangModel!.namasbbpersedianpiutang,
                  "cracc": setupHutangPiutangModel!.sbbpersedianpiutang,
                  "rrn": "$invoice",
                  "no_dokumen": "${nokontrak.text}",
                  "no_ref": "${noreferensi.text}",
                  "nominal": double.parse(nilaihpp.text
                      .replaceAll("Rp ", "")
                      .replaceAll(".", "")
                      .replaceAll(",", ".")),
                  "keterangan": "${keterangan.text}",
                  "kode_pt": "${users!.kodePt}",
                  "kode_kantor": "${users!.kodeKantor}",
                  "kode_induk": "${users!.kodeInduk}",
                  "sts_validasi": "N",
                  "kode_ao_dr": "",
                  "kode_coll": "",
                  "kode_ao_cr": "",
                  "userinput": "${users!.namauser}",
                  "userterm": "114.80.90.54",
                  "keterangan_otorisasi": "Melebihi Maksimal Limit Transaksi",
                  "inputtgljam":
                      "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
                  "otoruser": "",
                  "otorterm": "",
                  "otortgljam": "",
                  "flag_trn": "0",
                  "merchant": "",
                  "source_trx": "",
                  "status": "COMPLETED",
                  "modul": "HPP PERSEDIAN HUTANG PIUTANG",
                };
                Setuprepository.setup(
                    token, NetworkURL.transaksi(), jsonEncode(data));
              }
            }
          }

          dialog = false;
          listTmp.clear();

          informationDialog(context, "Information", value['message']);
        } else {
          informationDialog(context, "Warning", value['message']);
        }
      });
    }
  }

  Future getSetupPajak() async {
    isLoading = true;
    listPajak.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getSetupPajak(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listPajak.add(SetupPajakModel.fromJson(i));
        }
        setupPajakModel = listPajak[0];
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  int jenis = 1;

  gantijenis(int value) {
    jenis = value;
    notifyListeners();
  }

  void changeTotal() {
    double ppn = (double.parse(nilaitransaksi.text
            .replaceAll("Rp ", "")
            .replaceAll(".", "")
            .replaceAll(",", ".")) *
        double.parse(setupPajakModel!.ppn) /
        100);
    double pph = (double.parse(nilaitransaksi.text
            .replaceAll("Rp ", "")
            .replaceAll(".", "")
            .replaceAll(",", ".")) *
        double.parse(setupPajakModel!.pph23) /
        100);
    nilaippn.text = "Rp ${FormatCurrency.oCcyDecimal.format(ppn)}";
    nilaipph.text = "Rp ${FormatCurrency.oCcyDecimal.format(pph)}";
    notifyListeners();
  }

  List<SetupPajakModel> listPajak = [];
  SetupPajakModel? setupPajakModel;

  CustomerSupplierModel? customerSupplierModel;
  void pilihCustomerSupplier(CustomerSupplierModel value) async {
    customerSupplierModel = value;
    customersupplier.text = customerSupplierModel!.nmSif;
    ao.text = customerSupplierModel!.kodeAoCustomer;
    alamat.text = customerSupplierModel!.alamat;
    notifyListeners();
  }

  List<CustomerSupplierModel> listCs = [];
  Future<List<CustomerSupplierModel>> getCustomerSupplierQuery(
      String query) async {
    if (query.isNotEmpty && query.length > 2) {
      listCs.clear();
      notifyListeners();

      var data = {"kode_pt": "001"};

      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getCustomer(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          // final List<Map<String, dynamic>> jnsAccBItems = response['data'];
          for (Map<String, dynamic> i in response['data']) {
            listCs.add(CustomerSupplierModel.fromJson(i));
          }
          return listCs
              .where((model) => jenis == 1
                  ? (model.nmSif.toLowerCase().contains(query.toLowerCase()) &&
                      (model.golCust == "1" || model.golCust == "3"))
                  : (model.nmSif.toLowerCase().contains(query.toLowerCase()) &&
                          model.golCust == "2" ||
                      model.golCust == "3"))
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        notifyListeners();
      }
    } else {
      listCs.clear(); // clear on short query
    }

    return listCs;
  }

  DateTime? tglKontrak = DateTime.now();
  DateTime? tglJthTempoPertama = DateTime.now();

  Future pilihTanggalKontrak() async {
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
      tglKontrak = pickedendDate;
      tanggalKontrak.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  DateTime? tglJatuhTempo;
  TextEditingController tanggalJatuhTempoText = TextEditingController();
  Future pilihJatuhTempo() async {
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
      tglJatuhTempo = pickedendDate;
      tanggalJatuhTempoText.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  Future pilihTanggalJatuhTempoPertama() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(tglKontrak!)),
          int.parse(DateFormat('MM').format(tglKontrak!)),
          int.parse(DateFormat('dd').format(tglKontrak!)) + 1),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(tglKontrak!)),
          int.parse(DateFormat('MM').format(tglKontrak!)),
          int.parse(DateFormat('dd').format(tglKontrak!)) + 1),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(tglKontrak!)) + 1,
          int.parse(DateFormat('MM').format(tglKontrak!)),
          int.parse(DateFormat('dd').format(tglKontrak!))),
    ));
    if (pickedendDate != null) {
      tglJthTempoPertama = pickedendDate;
      tglJatuhTempoPertama.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  List<CustomerSupplierModel> list = [];
  getCustomers() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getCustomer(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(CustomerSupplierModel.fromJson(i));
        }
        jenis == 1
            ? list.where((e) => e.golCust == "1" || e.golCust == "3").toList()
            : list.where((e) => e.golCust == "2" || e.golCust == "3").toList();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  var isLoading = true;

  gantippn() {
    ppn = !ppn;
    notifyListeners();
  }

  gantipph() {
    pph = !pph;
    notifyListeners();
  }

  var dialog = false;
  var editData = false;
  tambah() {
    dialog = true;
    editData = false;
    notifyListeners();
  }

  List<TextEditingController> listTglJthTempo = [];
  List<TextEditingController> listOutstanding = [];
  List<TextEditingController> listNilaiTransaksi = [];
  List<TextEditingController> listNilaiPPN = [];
  List<TextEditingController> listNilaiPPH = [];

  List<int> pembulatanDenganPenyesuaian(
      List<double> nilaiAsli, double totalTarget) {
    List<int> nilaiBulatan = nilaiAsli.map((e) => e.round()).toList();
    int totalBulatan = nilaiBulatan.fold(0, (a, b) => a + b);
    int selisih = totalTarget.round() - totalBulatan;

    // Penyesuaian nilai berdasarkan selisih
    while (selisih != 0) {
      for (int i = 0; i < nilaiBulatan.length && selisih != 0; i++) {
        if (selisih > 0) {
          nilaiBulatan[i]++;
          selisih--;
        } else if (selisih < 0 && nilaiBulatan[i] > 0) {
          nilaiBulatan[i]--;
          selisih++;
        }
      }
    }

    return nilaiBulatan;
  }

  var buttonSimpan = false;

  hitungPembayaran() {
    if (nilaitransaksi.text.isEmpty) {
      informationDialog(context, "Warning", "Input Nilai Transaksi");
    } else if (jangkawaktu.text.isEmpty && caraPembayaran == "BERTAHAP") {
      informationDialog(context, "Warning", "Input Jangka Waktu");
    } else {
      listTglJthTempo.clear();
      listNilaiTransaksi.clear();
      listOutstanding.clear();
      listNilaiPPN.clear();
      listNilaiPPH.clear();
      notifyListeners();
      DateTime firstDate = tglJthTempoPertama!;
      int initialDay = firstDate.day;
      bool isAkhirBulan =
          firstDate.day == DateTime(firstDate.year, firstDate.month + 1, 0).day;

      int periode = 0;
      if (caraPembayaran == "BERTAHAP") {
        periode = int.parse(jangkawaktu.text);
      } else {
        periode = 1;
      }

      double totalNilai = double.parse(nilaitransaksi.text
          .replaceAll("Rp ", "")
          .replaceAll(".", "")
          .replaceAll(",", "."));
      double totalPPN = double.parse(nilaippn.text
          .replaceAll("Rp ", "")
          .replaceAll(".", "")
          .replaceAll(",", "."));
      double totalPPH = double.parse(nilaipph.text
          .replaceAll("Rp ", "")
          .replaceAll(".", "")
          .replaceAll(",", "."));

      List<int> nilaiList =
          List.generate(periode - 1, (i) => (totalNilai / periode).floor());
      List<int> ppnList =
          List.generate(periode - 1, (i) => (totalPPN / periode).floor());
      List<int> pphList =
          List.generate(periode - 1, (i) => (totalPPH / periode).floor());

      // Elemen terakhir adalah sisa
      int nilaiLast = totalNilai.round() - nilaiList.reduce((a, b) => a + b);
      int ppnLast = totalPPN.round() - ppnList.reduce((a, b) => a + b);
      int pphLast = totalPPH.round() - pphList.reduce((a, b) => a + b);
      int outstanding = totalNilai.round();

      for (var i = 0; i < periode; i++) {
        // listTglJthTempo.add(TextEditingController(
        //     text:
        //         "${DateFormat('dd-MMM-y').format(DateTime(int.parse(DateFormat('y').format(tglJthTempoPertama!)), int.parse(DateFormat('MM').format(tglJthTempoPertama!)) + i, int.parse(DateFormat('dd').format(tglJthTempoPertama!))))}"));

        int year = firstDate.year;
        int month = firstDate.month + i;

        DateTime targetEndOfMonth = DateTime(year, month + 1, 0);
        int maxDay = targetEndOfMonth.day;
        int targetDay;

        if (initialDay == 31) {
          targetDay = maxDay;
        } else if (initialDay == 30) {
          targetDay = (maxDay >= 30) ? 30 : maxDay;
        } else {
          targetDay = (initialDay > maxDay) ? maxDay : initialDay;
        }

        DateTime jthTempo = DateTime(year, month, targetDay);

        listTglJthTempo.add(TextEditingController(
            text: DateFormat('dd-MMM-y').format(jthTempo)));

        int nilai = (i == periode - 1) ? nilaiLast : nilaiList[i];
        listNilaiTransaksi.add(TextEditingController(
            text: FormatCurrency.oCcyDecimal.format(nilai)));
        if (ppn) {
          int nilaiPPN = (pphppn)
              ? (i == periode - 1 ? ppnLast : ppnList[i])
              : (i == periode - 1 ? totalPPN.round() : 0);
          listNilaiPPN.add(TextEditingController(
              text: FormatCurrency.oCcyDecimal.format(nilaiPPN)));
        } else {
          listNilaiPPN.add(TextEditingController(
              text: FormatCurrency.oCcyDecimal.format(0)));
        }

        if (pph) {
          int nilaiPPH = (pphppn)
              ? (i == periode - 1 ? pphLast : pphList[i])
              : (i == periode - 1 ? totalPPH.round() : 0);
          listNilaiPPH.add(TextEditingController(
              text: FormatCurrency.oCcyDecimal.format(nilaiPPH)));
        } else {
          listNilaiPPH.add(TextEditingController(
              text: FormatCurrency.oCcyDecimal.format(0)));
        }

        // if (pphppn) {
        //   int ppn = (i == periode - 1) ? ppnLast : ppnList[i];
        //   int pph = (i == periode - 1) ? pphLast : pphList[i];
        //   listNilaiPPN.add(TextEditingController(
        //       text: FormatCurrency.oCcyDecimal.format(ppn)));
        //   listNilaiPPH.add(TextEditingController(
        //       text: FormatCurrency.oCcyDecimal.format(pph)));
        // } else {
        //   if (i == periode - 1) {
        //     listNilaiPPN.add(TextEditingController(
        //         text: FormatCurrency.oCcyDecimal.format(totalPPN.round())));
        //     listNilaiPPH.add(TextEditingController(
        //         text: FormatCurrency.oCcyDecimal.format(totalPPH.round())));
        //   } else {
        //     listNilaiPPN.add(TextEditingController(
        //         text: FormatCurrency.oCcyDecimal.format(0)));
        //     listNilaiPPH.add(TextEditingController(
        //         text: FormatCurrency.oCcyDecimal.format(0)));
        //   }
        // }

        // // listOutstanding.add(TextEditingController(
        // //     text: FormatCurrency.oCcyDecimal.format(outstanding)));

        // // outstanding -= nilai;
        outstanding -= nilai;
        listOutstanding.add(TextEditingController(
            text: FormatCurrency.oCcyDecimal.format(outstanding)));
      }
      buttonSimpan = true;
      notifyListeners();
    }
  }

  removeItem(int index) {
    if (tagihanbulanan) {
      informationDialog(
          context, "Warning", "Komponen tagihan tidak bisa dihapus");
    } else {
      listTglJthTempo.removeAt(index);
      listNilaiTransaksi.removeAt(index);
      listNilaiPPN.removeAt(index);
      listNilaiPPH.removeAt(index);
    }
    notifyListeners();
  }

  TextEditingController jangkawaktu = TextEditingController();
  TextEditingController ao = TextEditingController();
  TextEditingController noinvoice = TextEditingController();
  TextEditingController noreferensi = TextEditingController();
  TextEditingController customersupplier = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController nokontrak = TextEditingController();
  TextEditingController tglkontrak = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController nilaitransaksi = TextEditingController();
  TextEditingController nilaihpp = TextEditingController();
  TextEditingController nilaippn = TextEditingController();
  TextEditingController nilaipph = TextEditingController();
  TextEditingController tglJatuhTempoPertama = TextEditingController();
  TextEditingController tanggalKontrak = TextEditingController();

  bool jenisTrans = false;
  pilihJenisTransaksi(bool value) {
    jenisTrans = value;
    notifyListeners();
  }

  var tagihanbulanan = true;
  gantitagitahnbulanan() {
    tagihanbulanan = !tagihanbulanan;
    notifyListeners();
  }

  var pphppn = true;
  gantipphppn() {
    pphppn = !pphppn;
    notifyListeners();
  }

  var carabayar = false;
  ganticarabayar() {
    carabayar = !carabayar;
    notifyListeners();
  }

  var caraPembayaran = "";
  ganticaraPembayaran(String value) {
    caraPembayaran = value;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    editData = false;
    notifyListeners();
  }
}
