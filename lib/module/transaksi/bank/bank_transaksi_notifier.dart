import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../network/network.dart';

class BankTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  BankTransaksiNotifier({required this.context}) {
    getBank();
    // getInqueryAll();
    notifyListeners();
  }

  List<InqueryGlModel> listGl = [];
  Future getInqueryAll() async {
    listGl.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001"
    };
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems = extractJnsAccB(value['data']);
        listGl = jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        notifyListeners();
      }
    });
  }

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  onChangeTotal(int index) {
    int total = int.parse(listAmount[index].text.replaceAll(',', '')) - int.parse(listSaldo[index].text.replaceAll(',', ''));
    listSelisih[index].text = FormatCurrency.oCcy.format(total).replaceAll(".", ',');
    notifyListeners();
  }

  List<TextEditingController> listBankController = [];
  List<TextEditingController> listNoSBB = [];
  List<TextEditingController> listSaldo = [];
  List<TextEditingController> listAmount = [];
  List<TextEditingController> listSelisih = [];
  DateTime? tglBuka = DateTime.now();
  DateTime? tglJatuhTempo = DateTime.now();

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
      firstDate: DateTime(1950),
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
      tglBuka = pickedendDate;
      tglBukaRekening.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  Future pilihTanggalJatuhTempo() async {
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
      firstDate: DateTime(1950),
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
      tglJatuhTempoRekening.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController nilai = TextEditingController();
  TextEditingController saldoEOM = TextEditingController();
  TextEditingController noRek = TextEditingController();
  TextEditingController tglBukaRekening = TextEditingController();
  TextEditingController tglJatuhTempoRekening = TextEditingController();
  List<String> jnsRekening = [
    "Tabungan",
    "Giro",
    "Deposito",
  ];
  String? rekening;
  pilihRekening(String value) {
    rekening = value;
    notifyListeners();
  }

  List<CoaModel> listCoa = [];

  TextEditingController namaSbbAset = TextEditingController();
  CoaModel? sbbAset;
  pilihSbbAset(CoaModel value) {
    sbbAset = value;
    namaSbbAset.text = value.nosbb;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> coa = [
    {
      "gol_acc": "1",
      "jns_acc": "A",
      "nobb": "10000000",
      "nosbb": "10000000",
      "nama_sbb": "Kas",
      "type_posting": "N",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "B",
      "nobb": "10000000",
      "nosbb": "10001000",
      "nama_sbb": "Kas",
      "type_posting": "N",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "10001001",
      "nama_sbb": "Kas Besar",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "10001002",
      "nama_sbb": "Kas Kecil",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "10001003",
      "nama_sbb": "Kas Transaksi",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
  ];

  var isLoadingInquery = false;
  Future<List<InqueryGlModel>> getInquery(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listGl.clear();
      notifyListeners();

      var data = {
        "kode_pt": "001"
      };

      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getInqueryGL(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          final List<Map<String, dynamic>> jnsAccBItems = extractJnsAccB(response['data']);
          listGl = jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).where((model) => model.nosbb.toLowerCase().contains(query.toLowerCase()) || model.namaSbb.toLowerCase().contains(query.toLowerCase())).toList();
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

  var isLoading = true;
  Future getBank() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001"
    };
    Setuprepository.setup(token, NetworkURL.getBank(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(BankModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<BankModel> list = [];
  BankModel? bankModel;
  pilihBank(BankModel value) {
    bankModel = value;
    notifyListeners();
  }

  TextEditingController nilaiTransaksi = TextEditingController();

  List<Map<String, dynamic>> json = [
    {
      "kode_bank": "008",
      "nm_bank": "BANK MANDIRI",
      "no_rek": "30000112333",
      "kd_rek": "10",
      "nosbb": "100100000006",
      "nama_sbb": "BANK MANDIRI",
      "nominal": "10000000",
      "jw": "",
      "tglbuka": "",
      "tgljtempo": "",
      "saldoeom": "",
      "kode_pt": "001",
      "kode_kantor": "10001",
      "kode_induk": ""
    },
    {
      "kode_bank": "008",
      "nm_bank": "BANK MANDIRI",
      "no_rek": "30000112331",
      "kd_rek": "10",
      "nosbb": "100100000007",
      "nama_sbb": "BANK MANDIRI",
      "nominal": "100000000",
      "jw": "",
      "tglbuka": "",
      "tgljtempo": "",
      "saldoeom": "",
      "kode_pt": "001",
      "kode_kantor": "10001",
      "kode_induk": ""
    }
  ];

  var search = false;
  cariRekening() async {
    search = true;
    namaRek.text = "PT TEGUH AMAN LESTARI";
    notifyListeners();
  }

  TextEditingController kodeBank = TextEditingController();
  TextEditingController namaRek = TextEditingController();
  // List<SandiBankModel> listBank = [];
  SandiBankModel? sandiBankModel;
  pilihSandi(SandiBankModel value) {
    sandiBankModel = value;
    // kodeBank.text = sandiBankModel!.kodeBank;
    // if (list.where((e) => e.kodeBank == sandiBankModel!.kodeBank).isNotEmpty) {
    //   for (var i = 0;
    //       i < list.where((e) => e.kodeBank == sandiBankModel!.kodeBank).length;
    //       i++) {
    //     final data = list
    //         .where((e) => e.kodeBank == sandiBankModel!.kodeBank)
    //         .toList()[i];
    //     int selisih =
    //         (int.parse(data.nominal) - - (i == 0 ? 900000 : 700000)) - int.parse(data.nominal);
    //     listBankController.add(TextEditingController(text: data.nmBank));
    //     listNoSBB.add(TextEditingController(text: data.nosbb));
    //     listSaldo.add(TextEditingController(
    //       text: FormatCurrency.oCcy
    //           .format(int.parse(data.nominal))
    //           .replaceAll(".", ","),
    //     ));
    //     listAmount.add(TextEditingController(
    //       text: FormatCurrency.oCcy
    //           .format(int.parse(data.nominal) - (i == 0 ? 900000 : 700000))
    //           .replaceAll(".", ","),
    //     ));
    //     listSelisih.add(TextEditingController(
    //         text: FormatCurrency.oCcy.format(selisih).replaceAll(".", ",")));
    //   }
    //   notifyListeners();
    // } else {
    //   informationDialog(context, "Warning",
    //       "Belum memiliki akun bank ${sandiBankModel!.namaBank}");
    // }
    notifyListeners();
  }

  List<Map<String, dynamic>> bankJson = [
    {
      "id": 1,
      "sandi_bic": "AGTBIDJA",
      "nama_bank": "PT. BANK RAYA INDONESIA, TBK",
      "nama_bank_singkat": "BANK RAYA",
      "kode_bank": "494",
      "kode_kantor": "0014"
    },
    {
      "id": 83,
      "sandi_bic": "CENAIDJA",
      "nama_bank": "PT. BANK CENTRAL ASIA Tbk.",
      "nama_bank_singkat": "BCA",
      "kode_bank": "014",
      "kode_kantor": "0397"
    },
    {
      "id": 43,
      "sandi_bic": "BMRIIDJA",
      "nama_bank": "PT. BANK MANDIRI (PERSERO) TBK",
      "nama_bank_singkat": "BANK MANDIRI",
      "kode_bank": "008",
      "kode_kantor": "0017"
    },
  ];
}
