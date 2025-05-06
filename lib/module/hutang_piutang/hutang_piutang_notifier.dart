import 'dart:convert';

import 'package:accounting/utils/format_currency.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/customer_supplier_model.dart';
import '../../models/setup_pajak_model.dart';
import '../../network/network.dart';
import '../../repository/SetupRepository.dart';

class HutangPiutangNotifier extends ChangeNotifier {
  final BuildContext context;
  final int tipe;
  final int jenis;

  HutangPiutangNotifier(
      {required this.context, required this.tipe, required this.jenis}) {
    getCustomers();
    getSetupPajak();
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
          listCs
              .where((model) =>
                  model.nmSif.toLowerCase().contains(query.toLowerCase()))
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

  DateTime? tglJthTempoPertama = DateTime.now();

  Future pilihTanggalJatuhTempoPertama() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(tglJthTempoPertama!)),
          int.parse(DateFormat('MM').format(tglJthTempoPertama!)),
          int.parse(DateFormat('dd').format(tglJthTempoPertama!))),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(tglJthTempoPertama!)) - 10,
          int.parse(DateFormat('MM').format(tglJthTempoPertama!)),
          int.parse(DateFormat('dd').format(tglJthTempoPertama!))),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(tglJthTempoPertama!)) + 10,
          int.parse(DateFormat('MM').format(tglJthTempoPertama!)),
          int.parse(DateFormat('dd').format(tglJthTempoPertama!))),
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
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  var isLoading = true;
  getProfile() async {}
  var dialog = false;
  var editData = false;
  tambah() {
    dialog = true;
    editData = false;
    notifyListeners();
  }

  List<TextEditingController> listTglJthTempo = [];
  List<TextEditingController> listNilaiTransaksi = [];
  List<TextEditingController> listNilaiPPN = [];
  List<TextEditingController> listNilaiPPH = [];

  hitungPembayaran() {
    if (nilaitransaksi.text.isEmpty) {
      informationDialog(context, "Warning", "Input nilai transaksi");
    } else {
      listTglJthTempo.clear();
      listNilaiTransaksi.clear();
      listNilaiPPN.clear();
      listNilaiPPH.clear();
      notifyListeners();
      double nilai = double.parse(nilaitransaksi.text
              .replaceAll("Rp ", "")
              .replaceAll(".", "")
              .replaceAll(",", ".")) /
          double.parse(jangkawaktu.text);
      double ppn = double.parse(nilaippn.text
              .replaceAll("Rp ", "")
              .replaceAll(".", "")
              .replaceAll(",", ".")) /
          double.parse(jangkawaktu.text);
      double pph = double.parse(nilaipph.text
              .replaceAll("Rp ", "")
              .replaceAll(".", "")
              .replaceAll(",", ".")) /
          double.parse(jangkawaktu.text);
      for (var i = 0; i < int.parse(jangkawaktu.text); i++) {
        listTglJthTempo.add(TextEditingController(
            text:
                "${DateFormat('dd-MMM-y').format(DateTime(int.parse(DateFormat('y').format(tglJthTempoPertama!)), int.parse(DateFormat('MM').format(tglJthTempoPertama!)) + i, int.parse(DateFormat('dd').format(tglJthTempoPertama!))))}"));

        listNilaiTransaksi.add(TextEditingController(
            text: FormatCurrency.oCcyDecimal.format(nilai)));
        if (pphppn) {
          listNilaiPPN.add(TextEditingController(
              text: FormatCurrency.oCcyDecimal.format(ppn)));
          listNilaiPPH.add(TextEditingController(
              text: FormatCurrency.oCcyDecimal.format(pph)));
        } else {
          if ((i + 1) == int.parse(jangkawaktu.text)) {
            listNilaiPPN.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal.format(double.parse(nilaippn
                    .text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")))));
            listNilaiPPH.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal.format(double.parse(nilaipph
                    .text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")))));
          } else {
            listNilaiPPN.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal.format(0)));
            listNilaiPPH.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal.format(0)));
          }
        }
      }
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
  TextEditingController nilaippn = TextEditingController();
  TextEditingController nilaipph = TextEditingController();
  TextEditingController tglJatuhTempoPertama = TextEditingController();

  var tagihanbulanan = false;
  gantitagitahnbulanan() {
    tagihanbulanan = !tagihanbulanan;
    notifyListeners();
  }

  var pphppn = false;
  gantipphppn() {
    pphppn = !pphppn;
    notifyListeners();
  }

  var carabayar = false;
  ganticarabayar() {
    carabayar = !carabayar;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    editData = false;
    notifyListeners();
  }
}
