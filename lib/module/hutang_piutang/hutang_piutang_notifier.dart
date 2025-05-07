import 'dart:convert';

import 'package:accounting/utils/format_currency.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adjusted_rounding.dart';

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

  hitungPembayaran() {
    if (nilaitransaksi.text.isEmpty) {
      informationDialog(context, "Warning", "Input Nilai Transaksi");
    } else if (jangkawaktu.text.isEmpty) {
      informationDialog(context, "Warning", "Input Jangka Waktu");
    } else {
      listTglJthTempo.clear();
      listNilaiTransaksi.clear();
      listNilaiPPN.clear();
      listNilaiPPH.clear();
      notifyListeners();

      int periode = int.parse(jangkawaktu.text);

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

      for (var i = 0; i < periode; i++) {
        listTglJthTempo.add(TextEditingController(
            text:
                "${DateFormat('dd-MMM-y').format(DateTime(int.parse(DateFormat('y').format(tglJthTempoPertama!)), int.parse(DateFormat('MM').format(tglJthTempoPertama!)) + i, int.parse(DateFormat('dd').format(tglJthTempoPertama!))))}"));

        int nilai = (i == periode - 1) ? nilaiLast : nilaiList[i];
        listNilaiTransaksi.add(TextEditingController(
            text: FormatCurrency.oCcyDecimal.format(nilai)));

        if (pphppn) {
          int ppn = (i == periode - 1) ? ppnLast : ppnList[i];
          int pph = (i == periode - 1) ? pphLast : pphList[i];
          listNilaiPPN.add(TextEditingController(
              text: FormatCurrency.oCcyDecimal.format(ppn)));
          listNilaiPPH.add(TextEditingController(
              text: FormatCurrency.oCcyDecimal.format(pph)));
        } else {
          if (i == periode - 1) {
            listNilaiPPN.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal.format(totalPPN.round())));
            listNilaiPPH.add(TextEditingController(
                text: FormatCurrency.oCcyDecimal.format(totalPPH.round())));
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
