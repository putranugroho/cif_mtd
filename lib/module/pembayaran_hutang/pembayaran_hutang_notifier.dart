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
        if (listPembayaran.isNotEmpty) {
          for (var i = 0; i < listPembayaran.length; i++) {
            listInvoice.add(TextEditingController(
                text: listPembayaran[i].noinv == null
                    ? ""
                    : listPembayaran[i].noinv));
            listTagihanNilai = listPembayaran
                .map((e) => double.parse(e.tagPokok).toInt())
                .toList();
            listPPNNilai = listPembayaran
                .map((e) => double.parse(e.tagPpn).toInt())
                .toList();
            listPPHNilai = listPembayaran
                .map((e) => double.parse(e.tagPph).toInt())
                .toList();
            listTagihan.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal
                    .format(double.parse(listPembayaran[i].tagPokok).toInt())));
            listPPH.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal
                    .format(double.parse(listPembayaran[i].tagPph).toInt())));
            listPPN.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal
                    .format(double.parse(listPembayaran[i].tagPpn).toInt())));
          }
          int totalTransaksi = double.parse(nilaipembayaran.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", '')
                  .replaceAll(",", "."))
              .toInt();

          var hasil = distribusiPembayaran(
            totalTransaksi: totalTransaksi,
            listTagihan: listTagihanNilai,
            listPPN: listPPNNilai,
            listPPH: listPPHNilai,
          );
          if (listTagihanNilai.isNotEmpty) {
            for (var i = 0; i < listTagihanNilai.length; i++) {
              listBayarTagihan.add(TextEditingController(
                  text: FormatCurrency.oCcy
                      .format(hasil['listBayarTagihan']![i])));
              listBayarPPN.add(TextEditingController(
                  text: FormatCurrency.oCcy.format(hasil['listBayarPPN']![i])));
              listBayarPPH.add(TextEditingController(
                  text: FormatCurrency.oCcy.format(hasil['listBayarPPH']![i])));
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
