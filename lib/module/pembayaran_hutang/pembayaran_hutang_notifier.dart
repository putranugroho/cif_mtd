import 'dart:convert';

import 'package:accounting/models/hutang_piutang_item_model.dart';
import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class PembayaranHutangNotifier extends ChangeNotifier {
  final BuildContext context;

  PembayaranHutangNotifier({required this.context}) {
    getProfile();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getInqueryA();
      getInqueryAll();
      getSetupkaskecil();
      getHutangPiutang();

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

  List<Map<String, dynamic>> extractJnsAccBb(List<dynamic> rawData) {
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

  List<InqueryGlModel> listGlAll = [];
  Future getInqueryAll() async {
    listGlAll.clear();
    notifyListeners();
    var data = {"kode_pt": users!.kodePt};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccBb(value['data']);
        listGlAll =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        getTransaksi();
        notifyListeners();
      }
    });
  }

  var isLoadingData = true;
  List<TransaksiPendModel> listTransaksiPending = [];
  List<TransaksiPendModel> listTransaksiPendingAdd = [];
  Future getTransaksi() async {
    isLoadingData = true;
    listTransaksiPending.clear();
    listTransaksiPendingAdd.clear();
    notifyListeners();
    var data = {
      "kode_pt": users!.kodePt,
    };
    Setuprepository.setup(token, NetworkURL.view(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksiPending.add(TransaksiPendModel.fromJson(i));
        }
        if (listTransaksiPending.isNotEmpty) {
          if (jenis == 1) {
            listTransaksiPendingAdd = listTransaksiPending
                .where((e) =>
                    e.cracc == inqueryGlModeldeb!.nosbb &&
                    e.status == "COMPLETED")
                .toList();
          } else {
            listTransaksiPendingAdd = listTransaksiPending
                .where((e) =>
                    e.dracc == inqueryGlModeldeb!.nosbb &&
                    e.status == "COMPLETED")
                .toList();
          }
        }
        isLoadingData = false;
        notifyListeners();
      } else {
        isLoadingData = false;
        notifyListeners();
      }
    });
  }

  TextEditingController tglKontrak = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController keteranganSelisih = TextEditingController();
  TextEditingController noref = TextEditingController();

  pilihTagihan(String value) {
    hutangPiutangTransaksiModel =
        listTransaksiAdd.where((e) => e.nokontrak == value).first;
    nilaitagihan.text = FormatCurrency.oCcyDecimal
        .format(double.parse(hutangPiutangTransaksiModel!.totalTagPokok));
    tglKontrak.text = hutangPiutangTransaksiModel!.tglKontrak;
    noref.text = hutangPiutangTransaksiModel!.noRef;
    keterangan.text = hutangPiutangTransaksiModel!.keterangan;
    caritransaksi.text = hutangPiutangTransaksiModel!.nokontrak;
    dialog = false;
    notifyListeners();
  }

  HutangPiutangTransaksiModel? hutangPiutangTransaksiModel;

  List<HutangPiutangTransaksiModel> listTransaksi = [];
  List<HutangPiutangTransaksiModel> listTransaksiAdd = [];
  Future getHutangPiutang() async {
    listTransaksi.clear();
    listTransaksiAdd.clear();
    notifyListeners();
    var data = {"kode_pt": users!.kodePt};
    Setuprepository.setup(
            token, NetworkURL.getHutangPiutang(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksi.add(HutangPiutangTransaksiModel.fromJson(i));
        }
        if (listTransaksi.isNotEmpty) {
          listTransaksiAdd = jenis == 2
              ? listTransaksi
                  .where((e) =>
                      e.tipeTransaksi == "2" &&
                      e.custsupp == customerSupplierModel!.noSif)
                  .toList()
              : listTransaksi
                  .where((e) =>
                      e.tipeTransaksi == "1" &&
                      e.custsupp == customerSupplierModel!.noSif)
                  .toList();
        }

        notifyListeners();
      } else {
        notifyListeners();
      }
    });
  }

  CustomerSupplierModel? customerSupplierModel;
  void pilihCustomerSupplier(CustomerSupplierModel value) async {
    customerSupplierModel = value;
    customersupplier.text = customerSupplierModel!.nmSif;
    alamat.text = customerSupplierModel!.alamat;
    getHutangPiutang();
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

  Future getInqueryA() async {
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccB(value['data']);
        list =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
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

  List<InqueryGlModel> list = [];

  TextEditingController nmSbb = TextEditingController();
  TextEditingController noSbb = TextEditingController();
  TextEditingController caritransaksi = TextEditingController();
  TextEditingController caritransaksis = TextEditingController();
  TextEditingController nilaipembayaran = TextEditingController();
  TextEditingController nilaitagihan = TextEditingController();
  TextEditingController nodokumen = TextEditingController();
  TextEditingController nodokumenselisih = TextEditingController();
  TextEditingController noinv = TextEditingController();
  TextEditingController ppn = TextEditingController();
  TextEditingController maksPpn = TextEditingController();
  TextEditingController pph23 = TextEditingController();
  TextEditingController customersupplier = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController noRefTRansaksi = TextEditingController();

  InqueryGlModel? inqueryGlModeldeb;
  InqueryGlModel? inqueryGlModelcre;
  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
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

  List<InqueryGlModel> listGlPembayaran = [];
  Future<List<InqueryGlModel>> getInqueryKelebihan(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listGlPembayaran.clear();
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
          listGlPembayaran = jnsAccBItems
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
      listGlPembayaran.clear(); // clear on short query
    }

    return listGlPembayaran;
  }

  TextEditingController nosbbkelebihan = TextEditingController();
  TextEditingController tglValuta = TextEditingController();

  InqueryGlModel? inqueryGlModelKelebihan;
  pilihSbbKelebihan(InqueryGlModel value) {
    inqueryGlModelKelebihan = value;
    nosbbkelebihan.text = value.namaSbb;
    notifyListeners();
  }

  bayar() {}

  onchange(int value) {
    print(double.parse(listBayarTagihan[value]
        .text
        .replaceAll("Rp ", "")
        .replaceAll(".", "")
        .replaceAll(",", ".")));
    notifyListeners();
    if (double.parse(listTagihan[value]
            .text
            .replaceAll("Rp ", "")
            .replaceAll(".", "")
            .replaceAll(",", ".")) <
        double.parse(listBayarTagihan[value]
            .text
            .replaceAll("Rp ", "")
            .replaceAll(".", "")
            .replaceAll(",", "."))) {
      informationDialog(context, "Warning",
          "Nominal tagihan tidak boleh lebih besar dari tagihan pokok");
    } else {
      var sel = double.parse(nilaipembayaran.text
              .replaceAll("Rp ", "")
              .replaceAll(".", "")
              .replaceAll(",", ".")) -
          (listBayarTagihan
                  .map((e) => double.parse(e.text
                      .replaceAll("Rp ", "")
                      .replaceAll(".", "")
                      .replaceAll(",", ".")))
                  .reduce((a, b) => a + b) +
              listBayarPPN.map((e) => double.parse(e.text.replaceAll("Rp ", "").replaceAll(".", "").replaceAll(",", "."))).reduce(
                  (a, b) => a + b) +
              listBayarPPH
                  .map((e) => double.parse(e.text.replaceAll("Rp ", "").replaceAll(".", "").replaceAll(",", ".")))
                  .reduce((a, b) => a + b));
      if (sel < 0) {
        informationDialog(context, "Warning", "Nominal pembayaran kurang");
      } else {
        selisih.text = "Rp ${FormatCurrency.oCcyDecimal.format(sel)}";
      }
    }

    notifyListeners();
  }

  TransaksiPendModel? transaksiPendModel;
  pilihTransaksi(String value) {
    transaksiPendModel =
        listTransaksiPendingAdd.where((e) => e.rrn == value).first;
    nilaipembayaran.text =
        "Rp ${FormatCurrency.oCcyDecimal.format(double.parse(transaksiPendModel!.nominal).toInt())}";
    tglValuta.text = transaksiPendModel!.tglValuta;
    nodokumen.text = transaksiPendModel!.noDokumen;
    keteranganTrans.text = transaksiPendModel!.keterangan;
    noRefTRansaksi.text  = transaksiPendModel!.noRef;
    dialog = false;
    notifyListeners();
  }

  List<TextEditingController> listInvoice = [];
  List<TextEditingController> listTagihan = [];
  List<TextEditingController> listPPH = [];
  List<TextEditingController> listPPN = [];
  List<TextEditingController> listBayarTagihan = [];
  List<TextEditingController> listBayarPPN = [];
  List<TextEditingController> listBayarPPH = [];
  pilihTransHutang(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nmSbb.text = value.namaSbb;
    noSbb.text = value.nosbb;
    getTransaksi();
    notifyListeners();
  }

  var isLoading = false;
  final keyForm = GlobalKey<FormState>();

  int transaksi = 1;

  List<TextEditingController> listAmount = [];
  List<HutangPiutangItemModel> listPembayaran = [];
  List<int> listTagihanNilai = [];
  List<int> listPPNNilai = [];
  List<int> listPPHNilai = [];

  loadData() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      List<Map<String, dynamic>> listtmp = [];
      listtmp.clear();
      for (var i = 0; i < listPembayaran.length; i++) {
        listtmp.add({
          "id": listPembayaran[i].id,
          "nokontrak": listPembayaran[i].nokontrak,
          "bayarpokok": hasil!['listBayarTagihan']![i],
          "bayarppn": hasil!['listBayarPPN']![i],
          "bayarpph": hasil!['listBayarPPH']![i],
        });
      }
      var data = {
        "noinv": noinv.text,
        "nodokumen": nodokumen.text,
        "noref": noref.text,
        "nokontrak": hutangPiutangTransaksiModel!.nokontrak,
        "kode_pt": users!.kodePt,
        "kode_kantor": users!.kodeKantor,
        "kode_induk": users!.kodeInduk,
        "data": listtmp,
      };

      Setuprepository.setup(
              token, NetworkURL.bayarHutangPiutang(), jsonEncode(data))
          .then((value) {
        Navigator.pop(context);
        if (value['status'].toString().toLowerCase().contains("success")) {
          if (double.parse(selisih.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", "")
                  .replaceAll(",", ".")) >
              0) {
            if (double.parse(users!.maksimalTransaksi) <
                double.parse(nilaipembayaran.text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", "."))) {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta":
                    "${DateFormat('y-MM-dd').format(DateTime.parse(transaksiPendModel!.tglValuta))}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code":
                    "${DateTime.parse(transaksiPendModel!.tglValuta).isBefore(DateTime.now()) ? "110" : "100"}",
                "otor": "0",
                "kode_trn": "",
                "nama_dr": transaksiPendModel!.namaCr,
                "dracc": transaksiPendModel!.cracc,
                "nama_cr": inqueryGlModelKelebihan!.namaSbb,
                "cracc": inqueryGlModelKelebihan!.nobb,
                "rrn": "$invoice",
                "no_dokumen": "${nodokumenselisih.text.trim()}",
                "no_ref": "${transaksiPendModel!.noRef}",
                "no_kontrak": "${hutangPiutangTransaksiModel!.nokontrak}",
                "no_invoice": "${noinv.text}",
                "nominal": double.parse(selisih.text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")),
                "keterangan": "${keteranganSelisih.text}",
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
                "modul": "SELISIH HUTANG PIUTANG",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            } else {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta":
                    "${DateFormat('y-MM-dd').format(DateTime.parse(transaksiPendModel!.tglValuta))}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code":
                    "${DateTime.parse(transaksiPendModel!.tglValuta).isBefore(DateTime.now()) ? "110" : "100"}",
                "otor": "0",
                "kode_trn": "",
                "nama_dr": transaksiPendModel!.namaCr,
                "dracc": transaksiPendModel!.cracc,
                "nama_cr": inqueryGlModelKelebihan!.namaSbb,
                "cracc": inqueryGlModelKelebihan!.nobb,
                "rrn": "$invoice",
                "no_kontrak": "${hutangPiutangTransaksiModel!.nokontrak}",
                "no_invoice": "${noinv.text}",
                "no_dokumen": "${nodokumenselisih.text.trim()}",
                "no_ref": "${transaksiPendModel!.noRef}",
                "nominal": double.parse(selisih.text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")),
                "keterangan": "${keteranganSelisih.text}",
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
                "modul": "SELISIH HUTANG PIUTANG",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            }
          }
          for (var i = 0; i < hasil!['listBayarTagihan']!.length; i++) {
            if (hasil!['listBayarTagihan']![i] > 0) {
              if (double.parse(users!.maksimalTransaksi) <
                  double.parse(nilaipembayaran.text
                      .replaceAll("Rp ", "")
                      .replaceAll(".", "")
                      .replaceAll(",", "."))) {
                var invoice = DateTime.now().millisecondsSinceEpoch.toString();
                var data = {
                  "tgl_transaksi":
                      "${DateFormat('y-MM-dd').format(DateTime.now())}",
                  "tgl_valuta":
                      "${DateFormat('y-MM-dd').format(DateTime.parse(transaksiPendModel!.tglValuta))}",
                  "batch": "${users!.batch}",
                  "trx_type": "TRX",
                  "trx_code":
                      "${DateTime.parse(transaksiPendModel!.tglValuta).isBefore(DateTime.now()) ? "110" : "100"}",
                  "otor": "0",
                  "kode_trn": "",
                  "nama_dr": transaksiPendModel!.namaCr,
                  "dracc": transaksiPendModel!.cracc,
                  "nama_cr": setupHutangPiutangModel!.namasbbtransaksipiutang,
                  "cracc": setupHutangPiutangModel!.sbbtransaksipiutang,
                  "rrn": "$invoice",
                  "no_dokumen": "${nodokumen.text.trim()}",
                  "no_ref": "${noref.text}",
                  "no_kontrak": "${hutangPiutangTransaksiModel!.nokontrak}",
                  "no_invoice": "${noinv.text}",
                  "nominal": hasil!['listBayarTagihan']![i],
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
                  "modul": "BAYAR HUTANG PIUTANG",
                };
                Setuprepository.setup(
                    token, NetworkURL.transaksi(), jsonEncode(data));
              } else {
                var invoice = DateTime.now().millisecondsSinceEpoch.toString();
                var data = {
                  "tgl_transaksi":
                      "${DateFormat('y-MM-dd').format(DateTime.now())}",
                  "tgl_valuta":
                      "${DateFormat('y-MM-dd').format(DateTime.parse(transaksiPendModel!.tglValuta))}",
                  "batch": "${users!.batch}",
                  "trx_type": "TRX",
                  "trx_code":
                      "${DateTime.parse(transaksiPendModel!.tglValuta).isBefore(DateTime.now()) ? "110" : "100"}",
                  "otor": "0",
                  "kode_trn": "",
                  "nama_dr": transaksiPendModel!.namaCr,
                  "dracc": transaksiPendModel!.cracc,
                  "nama_cr": setupHutangPiutangModel!.namasbbtransaksipiutang,
                  "cracc": setupHutangPiutangModel!.sbbtransaksipiutang,
                  "rrn": "$invoice",
                  "no_kontrak": "${hutangPiutangTransaksiModel!.nokontrak}",
                  "no_invoice": "${noinv.text}",
                  "no_dokumen": "${nodokumen.text.trim()}",
                  "no_ref": "${noref.text}",
                  "nominal": hasil!['listBayarTagihan']![i],
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
                  "modul": "BAYAR HUTANG PIUTANG",
                };
                Setuprepository.setup(
                    token, NetworkURL.transaksi(), jsonEncode(data));
              }
            }
          }

          clear();

          getHutangPiutang();
          informationDialog(context, "Information", value['message']);
          notifyListeners();
        } else {
          informationDialog(context, "Warning", value['message']);
          notifyListeners();
        }
      });
    }
  }

  TextEditingController keteranganTrans = TextEditingController();

  clear() {
    rincianData = false;
    inqueryGlModelKelebihan = null;
    inqueryGlModeldeb = null;
    transaksiPendModel = null;
    hutangPiutangTransaksiModel = null;
    customerSupplierModel = null;
    nmSbb.clear();
    listPembayaran.clear();
    tglKontrak.clear();
    customersupplier.clear();
    alamat.clear();
    nilaitagihan.clear();
    nilaipembayaran.clear();
    noref.clear();
    nodokumen.clear();
    noinv.clear();
    noSbb.clear();
    keterangan.clear();
    keteranganTrans.clear();
    tglValuta.clear();
    tglValuta.clear();
    notifyListeners();
  }

  int totalTransaksi = 0;
  Map<String, List<int>>? hasil;

  tambahTransaksi() {
    listTagihan.clear();
    listPPH.clear();
    listPPN.clear();
    listBayarTagihan.clear();
    listBayarPPN.clear();
    listBayarPPH.clear();
    listPembayaran.clear();
    listTagihanNilai.clear();
    listPPNNilai.clear();
    listPPHNilai.clear();

    notifyListeners();
    DialogCustom().showLoading(context);
    var ddata = {
      "kode_pt": users!.kodePt,
      "no_kontrak": hutangPiutangTransaksiModel!.nokontrak,
    };
    Setuprepository.setup(
            token, NetworkURL.searchHutangPiutang(), jsonEncode(ddata))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listPembayaran.add(HutangPiutangItemModel.fromJson(i));
        }
        listPembayaran.sort((a, b) => a.ke.compareTo(b.ke));
        if (listPembayaran.isNotEmpty) {
          for (var i = 0; i < listPembayaran.length; i++) {
            listInvoice.add(TextEditingController(
                text: listPembayaran[i].noinv == null
                    ? ""
                    : listPembayaran[i].noinv));
            listTagihanNilai = listPembayaran
                .map((e) =>
                    double.parse(e.tagPokok).toInt() -
                    double.parse(e.byrPokok).toInt())
                .toList();
            listPPNNilai = listPembayaran
                .map((e) =>
                    double.parse(e.tagPpn).toInt() -
                    double.parse(e.byrPpn).toInt())
                .toList();
            listPPHNilai = listPembayaran
                .map((e) =>
                    double.parse(e.tagPph).toInt() -
                    double.parse(e.byrPph).toInt())
                .toList();
            listTagihan.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal.format(
                    double.parse(listPembayaran[i].tagPokok).toInt() -
                        double.parse(listPembayaran[i].byrPokok).toInt())));
            listPPH.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal.format(
                    double.parse(listPembayaran[i].tagPph).toInt() -
                        double.parse(listPembayaran[i].byrPph).toInt())));
            listPPN.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal.format(
                    double.parse(listPembayaran[i].tagPpn).toInt() -
                        double.parse(listPembayaran[i].byrPpn).toInt())));
          }
          totalTransaksi = double.parse(nilaipembayaran.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", '')
                  .replaceAll(",", "."))
              .toInt();

          hasil = distribusiPembayaran(
            totalTransaksi: totalTransaksi,
            listTagihan: listTagihanNilai,
            listPPN: listPPNNilai,
            listPPH: listPPHNilai,
          );
          if (listTagihanNilai.isNotEmpty) {
            for (var i = 0; i < listTagihanNilai.length; i++) {
              listBayarTagihan.add(TextEditingController(
                  text: FormatCurrency.oCcy
                      .format(hasil!['listBayarTagihan']![i])));
              listBayarPPN.add(TextEditingController(
                  text:
                      FormatCurrency.oCcy.format(hasil!['listBayarPPN']![i])));
              listBayarPPH.add(TextEditingController(
                  text:
                      FormatCurrency.oCcy.format(hasil!['listBayarPPH']![i])));
            }
          }
          var sel = double.parse(nilaipembayaran.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", "")
                  .replaceAll(",", ".")) -
              (listBayarTagihan
                      .map((e) => double.parse(e.text
                          .replaceAll("Rp ", "")
                          .replaceAll(".", "")
                          .replaceAll(",", ".")))
                      .reduce((a, b) => a + b) +
                  listBayarPPN.map((e) => double.parse(e.text.replaceAll("Rp ", "").replaceAll(".", "").replaceAll(",", "."))).reduce(
                      (a, b) => a + b) +
                  listBayarPPH
                      .map((e) => double.parse(e.text.replaceAll("Rp ", "").replaceAll(".", "").replaceAll(",", ".")))
                      .reduce((a, b) => a + b));
          selisih.text = "Rp ${FormatCurrency.oCcyDecimal.format(sel)}";
          if (sel > 0) {
            kelebihan = true;
          }
        }

        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  TextEditingController selisih = TextEditingController();

  int jenis = 1;

  gantijenis(int value) {
    jenis = value;
    getHutangPiutang();
    getTransaksi();
    notifyListeners();
  }

  bool akun = false;
  gantiakun(bool value) {
    akun = value;
    notifyListeners();
  }

  bool kelebihan = false;
  gantikelebihan() {
    kelebihan = !kelebihan;
    notifyListeners();
  }

  var dialog = false;
  tambah() {
    dialog = true;
    editData = "";
    notifyListeners();
  }

  var editData = "";
  cariTrans() {
    dialog = true;
    editData = "caritransaksi";
    notifyListeners();
  }

  cariTagihan() {
    dialog = true;
    editData = "caritagihan";
    notifyListeners();
  }

  tutup() {
    dialog = false;
    editData = "";
    notifyListeners();
  }

  var rincianData = false;
  rincian() {
    rincianData = !rincianData;
    notifyListeners();
  }

  cek() {}
}

Map<String, List<int>> distribusiPembayaran({
  required int totalTransaksi,
  required List<int> listTagihan,
  required List<int> listPPN,
  required List<int> listPPH,
}) {
  List<int> bayarTagihan = List.filled(listTagihan.length, 0);
  List<int> bayarPPN = List.filled(listPPN.length, 0);
  List<int> bayarPPH = List.filled(listPPH.length, 0);

  int sisa = totalTransaksi;

  for (int i = 0; i < listTagihan.length; i++) {
    // Bayar Tagihan
    int bayar = listTagihan[i] <= sisa ? listTagihan[i] : sisa;
    bayarTagihan[i] = bayar;
    sisa -= bayar;

    // Bayar PPN (jika ada)
    if (sisa > 0 && listPPN[i] > 0) {
      int bayar = listPPN[i] <= sisa ? listPPN[i] : sisa;
      bayarPPN[i] = bayar;
      sisa -= bayar;
    }

    // Bayar PPH
    if (sisa > 0 && listPPH[i] > 0) {
      int bayar = listPPH[i] <= sisa ? listPPH[i] : sisa;
      bayarPPH[i] = bayar;
      sisa -= bayar;
    }
  }

  return {
    "listBayarTagihan": bayarTagihan,
    "listBayarPPN": bayarPPN,
    "listBayarPPH": bayarPPH,
  };
}
