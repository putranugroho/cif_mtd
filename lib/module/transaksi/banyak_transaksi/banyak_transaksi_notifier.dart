import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../repository/SetupRepository.dart';

class BanyakTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  BanyakTransaksiNotifier({required this.context}) {
    // for (Map<String, dynamic> i in coa) {
    //   listCoa.add(CoaModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in data) {
    //   listData.add(TransaksiModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in ao) {
    //   listAo.add(AoModel.fromJson(i));
    // }
    getPRofile();

    notifyListeners();
  }
  UserModel? users;
  getPRofile() {
    Pref().getUsers().then((value) {
      users = value;
      getAoMarketing();
      getTransaksi();
      notifyListeners();
    });
  }

  var isLoadingData = true;
  List<TransaksiPendModel> listTransaksi = [];
  List<TransaksiPendModel> listTransaksiAdd = [];
  Future getTransaksi() async {
    isLoadingData = true;
    listTransaksi.clear();
    listTransaksiAdd.clear();
    notifyListeners();
    var data = {
      "kode_pt": users!.kodePt,
    };
    Setuprepository.setup(token, NetworkURL.view(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksi.add(TransaksiPendModel.fromJson(i));
        }
        if (listTransaksi.isNotEmpty) {
          listTransaksiAdd = listTransaksi
              .where((e) =>
                  e.userinput == users!.namauser &&
                  e.modul.contains("BANYAK"))
              .toList();

          listTransaksiAdd.sort((a, b) => DateTime.parse(b.createddate)
              .compareTo(DateTime.parse(a.createddate)));
        }
        isLoadingData = false;
        notifyListeners();
      } else {
        isLoadingData = false;
        notifyListeners();
      }
    });
  }

  getAoMarketing() async {
    isLoading = true;
    listAo.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getAoMarketing(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listAo.add(AoModel.fromJson(i));
        }
        getInqueryAll();
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<Map<String, dynamic>> extractJnsAccB(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];

    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          if (item['jns_acc'] == 'C') {
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

  InqueryGlModel? inqueryGlModeldeb;
  InqueryGlModel? inqueryGlModelcre;
  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
  List<InqueryGlModel> list = [];
  TextEditingController nosbbdeb = TextEditingController();
  TextEditingController nossbcre = TextEditingController();
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
                  model.namaSbb.toLowerCase().contains(query.toLowerCase()))
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

  TextEditingController namaSbbDeb = TextEditingController();
  TextEditingController namaSbbCre = TextEditingController();
  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nosbbdeb.text = value.namaSbb;
    namaSbbDeb.text = value.nosbb;
    notifyListeners();
  }

  pilihAkunItem(InqueryGlModel value, int index) {
    listGlItems[index] = value;
    listNamaSbbItems[index].text = value.namaSbb;
    notifyListeners();
  }

  Future getInqueryAll() async {
    list.clear();
    isLoading = true;
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccB(value['data']);
        list =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        // inqueryGlModeldeb = listGl[0];
        tambahTransaksi();
        isLoading = false;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  var isLoading = true;

  int transaksi = 0;

  List<TextEditingController> listAmount = [];
  List<TextEditingController> listNamaSbbItems = [];
  List<TextEditingController> listKeterangan = [];
  List<TextEditingController> listNoDok = [];
  List<InqueryGlModel> listGlItems = [];
  List<AoModel?> listAoitems = [];

  remove(int index) {
    transaksi--;
    print(transaksi);
    notifyListeners();
    listNamaSbbItems.removeAt(index);
    listAmount.removeAt(index);
    listKeterangan.removeAt(index);
    listNoDok.removeAt(index);
    listGlItems.removeAt(index);
    listAoitems.removeAt(index);
    changeTotal();
    notifyListeners();
  }

  tambahTransaksi() {
    transaksi++;
    print(transaksi);
    notifyListeners();
    listNamaSbbItems.add(TextEditingController(text: ""));
    listAmount.add(TextEditingController(text: "0"));
    listKeterangan.add(TextEditingController(text: ""));
    listNoDok.add(TextEditingController(text: ""));
    listGlItems.add(list[0]);
    listAoitems.add(null);
    notifyListeners();
  }

  changeMaster() {
    total = double.parse(nominal.text
        .replaceAll(".", '')
        .replaceAll("Rp ", '')
        .replaceAll(",", "."));
    notifyListeners();
  }

  double total = 0;
  changeTotal() {
    total = double.parse(nominal.text
            .replaceAll(".", '')
            .replaceAll("Rp ", '')
            .replaceAll(",", ".")) -
        listAmount
            .map((e) => double.parse(e.text
                .replaceAll(".", "")
                .replaceAll("Rp ", '')
                .replaceAll(",", ".")))
            .reduce((a, b) => a + b);
    notifyListeners();
  }

  confirmPrint() {
    showDialog(
        context: context,
        builder: (context) {
          return const Dialog();
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

  DateTime? tglBackDate = DateTime.now();
  Future tanggalBackDate() async {
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
      tglBackDate = pickedendDate;
      tglBackDatetext.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController tglBackDatetext = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController nomorRef = TextEditingController();

  bool backDate = false;
  gantibackDate() {
    backDate = !backDate;
    notifyListeners();
  }

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  final keyForm = GlobalKey<FormState>();

  cek() {
    if (keyForm.currentState!.validate()) {
      if (users!.limitAkses == "Y") {
        if (total > 0 || total < 0) {
          informationDialog(context, "Warning", "Selisih harus 0");
        } else {
          DialogCustom().showLoading(context);
          if (double.parse(users!.maksimalTransaksi) <
              double.parse(nominal.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", "")
                  .replaceAll(",", "."))) {
            for (var i = 0; i < listGlItems.length; i++) {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta": "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code":
                    "${tglBackDate!.isBefore(DateTime.now()) ? "110" : "100"}",
                "otor": "0",
                "kode_trn": "",
                "nama_dr":
                    !akun ? inqueryGlModeldeb!.namaSbb : listGlItems[i].namaSbb,
                "dracc":
                    !akun ? inqueryGlModeldeb!.nosbb : listGlItems[i].nosbb,
                "nama_cr":
                    !akun ? listGlItems[i].namaSbb : inqueryGlModeldeb!.namaSbb,
                "cracc":
                    !akun ? listGlItems[i].nosbb : inqueryGlModeldeb!.nosbb,
                "rrn": "$invoice",
                "no_kontrak": "",
                "no_invoice": "",
                "no_dokumen": "${listNoDok[i].text.trim()}",
                "no_ref": "${nomorRef.text}",
                "nominal": double.parse(listAmount[i]
                    .text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")),
                "keterangan": "${listKeterangan[i].text}",
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
                "flag_trn": "1",
                "merchant": "",
                "source_trx": "",
                "status": "PENDING",
                "modul": "BANYAK TRANSAKSI",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            }
          } else {
            for (var i = 0; i < listGlItems.length; i++) {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta": "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code":
                    "${tglBackDate!.isBefore(DateTime.now()) ? "110" : "100"}",
                "otor": "0",
                "kode_trn": "",
                "nama_dr":
                    !akun ? inqueryGlModeldeb!.namaSbb : listGlItems[i].namaSbb,
                "dracc":
                    !akun ? inqueryGlModeldeb!.nosbb : listGlItems[i].nosbb,
                "nama_cr":
                    !akun ? listGlItems[i].namaSbb : inqueryGlModeldeb!.namaSbb,
                "cracc":
                    !akun ? listGlItems[i].nosbb : inqueryGlModeldeb!.nosbb,
                "rrn": "$invoice",
                "no_kontrak": "",
                "no_invoice": "",
                "no_dokumen": "${listNoDok[i].text.trim()}",
                "no_ref": "${nomorRef.text}",
                "nominal": double.parse(listAmount[i]
                    .text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")),
                "keterangan": "${listKeterangan[i].text}",
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
                "flag_trn": "1",
                "merchant": "",
                "source_trx": "",
                "status": "COMPLETED",
                "modul": "BANYAK TRANSAKSI˝",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            }
          }
        }
        Navigator.pop(context);
        inqueryGlModeldeb = null;
        nosbbdeb.clear();
        namaSbbDeb.clear();
        nominal.clear();
        listNoDok.clear();
        listGlItems.clear();
        listAmount.clear();
        listAoitems.clear();
        listKeterangan.clear();
        nomorRef.clear();
        informationDialog(context, "Information", "Berhasil");
      } else {
        informationDialog(context, "Warning", "Tidak memiliki akses");
      }
    }
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<TransaksiModel> listData = [];
  List<Map<String, dynamic>> data = [
    {
      "tgl_trans": "2025-03-26",
      "trans_user": "Edi Kurniawan",
      "kode_trans": "8902989844i9491",
      "debet_acc": "100010001",
      "nama_debet": "Kas Besar",
      "credit_acc": "100010002",
      "nama_credit": "Kas Kecil",
      "nomor_dok": "",
      "nomor_ref": "8902989844i9491",
      "nominal": "1000000",
      "keterangan": "",
      "kode_pt": "001",
      "kode_kantor": "10001",
      "kode_induk": "",
      "kode_ao_debet": "",
      "kode_ao_credit": ""
    }
  ];

  List<CoaModel> listCoa = [];

  TextEditingController namaSbbAset = TextEditingController();
  CoaModel? sbbAset;
  pilihSbbAset(CoaModel value) {
    sbbAset = value;
    namaSbbAset.text = value.nosbb;
    notifyListeners();
  }

  TextEditingController masasusut = TextEditingController();
  TextEditingController namaSbbpenyusutan = TextEditingController();
  CoaModel? sbbpenyusutan;
  pilihSbbpenyusutan(CoaModel value) {
    sbbpenyusutan = value;
    namaSbbpenyusutan.text = value.nosbb;
    notifyListeners();
  }

  bool akun = false;
  gantiakun(bool value) {
    akun = value;
    notifyListeners();
  }

  List<AoModel> listAo = [];
  AoModel? aoModel;

  pilihAoModelDebet(AoModel value, int index) {
    // aoModel = value;
    listAoitems[index] = value;
    notifyListeners();
  }
}
