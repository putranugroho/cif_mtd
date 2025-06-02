import 'dart:convert';

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
      notifyListeners();
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
    isLoading = true;
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
              ? listTransaksi.where((e) => e.tipeTransaksi == "2").toList()
              : listTransaksi.where((e) => e.tipeTransaksi == "1").toList();
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  CustomerSupplierModel? customerSupplierModel;
  void pilihCustomerSupplier(CustomerSupplierModel value) async {
    customerSupplierModel = value;
    customersupplier.text = customerSupplierModel!.nmSif;
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

  tambahTransaksi() {
    // if (noSbb.text.isEmpty && nmSbb.text.isEmpty) {
    //   informationDialog(context, "Warning", "Pilih SBB Transaksi");
    // } else if (nilaipembayaran.text.isEmpty) {
    //   informationDialog(context, "Warning", "Pilih Transaksi");
    // } else if (nilaitagihan.text.isEmpty) {
    //   informationDialog(context, "Warning", "Pilih Tagihan");
    // } else if (nodokumen.text.isEmpty) {
    //   informationDialog(context, "Warning", "Masukan Nomor Dokumen");
    // } else {

    //   // transaksi++;
    //   // listAmount.add(TextEditingController(text: "0"));
    //   // notifyListeners();
    // }
    DialogCustom().showLoading(context);
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
