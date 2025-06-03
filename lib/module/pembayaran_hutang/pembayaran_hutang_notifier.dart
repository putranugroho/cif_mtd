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

class PembayaranHutangNotifier extends ChangeNotifier {
  final BuildContext context;

  PembayaranHutangNotifier({required this.context}) {
    getProfile();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getInqueryAll();
      getHutangPiutang();
      getTransaksi();
      notifyListeners();
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
          listTransaksiPendingAdd = listTransaksiPending
              .where((e) => e.status == "COMPLETED")
              .toList();
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

  Future getInqueryAll() async {
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
  TextEditingController ppn = TextEditingController();
  TextEditingController maksPpn = TextEditingController();
  TextEditingController pph23 = TextEditingController();
  TextEditingController customersupplier = TextEditingController();
  TextEditingController alamat = TextEditingController();

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

  TextEditingController tglValuta = TextEditingController();

  TransaksiPendModel? transaksiPendModel;
  pilihTransaksi(String value) {
    transaksiPendModel =
        listTransaksiPendingAdd.where((e) => e.rrn == value).first;
    nilaipembayaran.text = FormatCurrency.oCcyDecimal
        .format(double.parse(transaksiPendModel!.nominal).toInt());
    tglValuta.text = transaksiPendModel!.tglValuta;
    nodokumen.text = transaksiPendModel!.noDokumen;
    dialog = false;
    notifyListeners();
  }

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
    notifyListeners();
  }

  var isLoading = false;
  final keyForm = GlobalKey<FormState>();

  int transaksi = 1;

  List<TextEditingController> listAmount = [];
  List<HutangPiutangItemModel> listPembayaran = [];
  tambahTransaksi() {
    listTagihan.clear();
    listPPH.clear();
    listPPN.clear();
    listBayarTagihan.clear();
    listBayarPPN.clear();
    listBayarPPH.clear();
    listPembayaran.clear();

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
        if (listPembayaran.isNotEmpty) {
          for (var i = 0; i < listPembayaran.length; i++) {
            listTagihan.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal
                    .format(double.parse(listPembayaran[i].tagPokok).toInt())));
            listPPH.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal
                    .format(double.parse(listPembayaran[i].tagPph).toInt())));
            listPPN.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal
                    .format(double.parse(listPembayaran[i].tagPpn).toInt())));
            listBayarTagihan.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal
                    .format(double.parse(listPembayaran[i].byrPokok).toInt())));
            listBayarPPN.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal
                    .format(double.parse(listPembayaran[i].byrPpn).toInt())));
            listBayarPPH.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal
                    .format(double.parse(listPembayaran[i].byrPph).toInt())));
          }
        }

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
    getHutangPiutang();
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
