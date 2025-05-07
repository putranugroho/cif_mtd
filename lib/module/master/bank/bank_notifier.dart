import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../network/network.dart';
import '../../../utils/button_custom.dart';

class BankNotifier extends ChangeNotifier {
  final BuildContext context;

  BankNotifier({required this.context}) {
    getBank();
    getInqueryAll();
    getSandiBankAll();
    notifyListeners();
  }

  List<InqueryGlModel> listGl = [];
  Future getInqueryAll() async {
    listGl.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccB(value['data']);
        listGl =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        notifyListeners();
      }
    });
  }

  Future getSandiBankAll() async {
    isLoadingInquery = true;
    listSandi.clear();
    notifyListeners();

    var data = {"kode_pt": "001"};

    try {
      final response = await Setuprepository.setup(
        token,
        NetworkURL.getSandiBank(),
        jsonEncode(data),
      );

      if (response['status'].toString().toLowerCase().contains("success")) {
        final jnsAccBItems =
            (response['data'] as List).cast<Map<String, dynamic>>();

        List<SandiBankModel> allItems =
            jnsAccBItems.map((e) => SandiBankModel.fromJson(e)).toList();

        listSandi = allItems.toList();
      }
      notifyListeners();
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoadingInquery = false;
      notifyListeners();
    }
  }

  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nosbbdeb.text = value.namaSbb;
    namaSbbDeb.text = value.nosbb;
    notifyListeners();
  }

  TextEditingController namaSbbDeb = TextEditingController();
  InqueryGlModel? inqueryGlModeldeb;
  TextEditingController nosbbdeb = TextEditingController();
  TextEditingController nossbcre = TextEditingController();

  var isLoadingInquery = false;
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

  List<SandiBankModel> listSandi = [];

  Future<List<SandiBankModel>> getSandiBank(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listSandi.clear();
      notifyListeners();

      var data = {"kode_pt": "001"};

      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getSandiBank(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          final jnsAccBItems =
              (response['data'] as List).cast<Map<String, dynamic>>();

          List<SandiBankModel> allItems =
              jnsAccBItems.map((e) => SandiBankModel.fromJson(e)).toList();

          listSandi = allItems
              .where((item) =>
                  item.namaLjk.toLowerCase().contains(query.toLowerCase()))
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
      listSandi.clear(); // clear on short query
    }

    return listSandi;
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

  List<BankModel> list = [];
  var isLoading = true;
  Future getBank() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getBank(), jsonEncode(data))
        .then((value) {
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

  bool dialog = false;
  tambah() {
    clear();
    dialog = true;
    notifyListeners();
  }

  bool aro = false;
  pilihAro(bool value) {
    aro = value;
    notifyListeners();
  }

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
      tglBuka = pickedendDate;
      tglBukaRekening.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  Future pilihTanggalJatuhTempo() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(tglBuka!)),
          int.parse(DateFormat('MM').format(tglBuka!)),
          int.parse(DateFormat('dd').format(tglBuka!)) + 10),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(tglBuka!)),
          int.parse(DateFormat('MM').format(tglBuka!)),
          int.parse(DateFormat('dd').format(tglBuka!)) + 10),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(tglBuka!)) + 10,
          int.parse(DateFormat('MM').format(tglBuka!)),
          int.parse(DateFormat('dd').format(tglBuka!))),
    ));
    if (pickedendDate != null) {
      tglJatuhTempo = pickedendDate;
      tglJatuhTempoRekening.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController nilai = TextEditingController();
  TextEditingController saldoEOM = TextEditingController();
  TextEditingController jangkaWaktu = TextEditingController();
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

  var search = false;
  cariRekening() async {
    search = true;
    namaRek.text = "PT TEGUH AMAN LESTARI";
    notifyListeners();
  }

  confirm() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Anda yakin menghapus ${bankModel!.nmBank} - ${bankModel!.nmRek}?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ButtonSecondary(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        name: "Tidak",
                      )),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: ButtonPrimary(
                        onTap: () {
                          Navigator.pop(context);
                          remove();
                        },
                        name: "Ya",
                      )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  remove() {
    DialogCustom().showLoading(context);
    var data = {
      "id": bankModel!.id,
    };
    Setuprepository.setup(token, NetworkURL.deleteBank(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getBank();
        clear();

        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message'][0]);
      }
    });
  }

  TextEditingController kodeBank = TextEditingController();
  TextEditingController namaRek = TextEditingController();
  TextEditingController namaBank = TextEditingController();
  TextEditingController noBilyet = TextEditingController();
  List<SandiBankModel> listBank = [];
  SandiBankModel? sandiBankModel;
  pilihSandi(SandiBankModel value) {
    sandiBankModel = value;
    namaBank.text = value.namaLjk;
    kodeBank.text = sandiBankModel!.sandi;
    notifyListeners();
  }

  final keyForm = GlobalKey<FormState>();
  var editData = false;
  TextEditingController cabang = TextEditingController();
  BankModel? bankModel;
  edit(String id) {
    dialog = true;
    editData = true;
    bankModel = list.where((e) => e.id == int.parse(id)).first;
    sandiBankModel =
        listSandi.where((e) => e.sandi == bankModel!.kodeBank).first;
    kodeBank.text = bankModel!.kodeBank;
    cabang.text = bankModel!.cabang;
    noBilyet.text = bankModel!.noBilyet;
    namaRek.text = bankModel!.nmRek;
    namaBank.text = bankModel!.nmBank;
    noRek.text = bankModel!.noRek;
    rekening = bankModel!.kdRek == "10"
        ? "Tabungan"
        : bankModel!.kdRek == "20"
            ? "Giro"
            : "Deposito";
    nosbbdeb.text = bankModel!.nosbb;
    namaSbbDeb.text = bankModel!.namaSbb;
    nilai.text = FormatCurrency.oCcy
        .format(int.parse(bankModel!.nominal))
        .replaceAll(".", ",");
    jangkaWaktu.text = bankModel!.jw;
    tglBukaRekening.text = bankModel!.tglbuka;
    tglJatuhTempoRekening.text = bankModel!.tgljtempo;
    saldoEOM.text = bankModel!.saldoeom;
    notifyListeners();
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": "${bankModel!.id}",
          "kode_bank": "${kodeBank.text.trim()}",
          "nm_bank": "${sandiBankModel!.namaLjk}",
          "nm_rek": "${namaRek.text.trim()}",
          "cabang": "${cabang.text.trim()}",
          "no_bilyet": "${noBilyet.text.trim()}",
          "no_rek": "${noRek.text}",
          "kd_rek":
              "${rekening == "Tabungan" ? "10" : rekening == "Giro" ? "20" : "30"}",
          "nosbb": "${nosbbdeb.text.trim()}",
          "nama_sbb": "${namaSbbDeb.text.trim()}",
          "nominal": "${nilai.text.trim().replaceAll(",", '')}",
          "jw": "${jangkaWaktu.text}",
          "tglbuka":
              "${tglBuka == null ? "" : DateFormat('y-MM-dd').format(tglBuka!)}",
          "tgljtempo":
              "${tglJatuhTempo == null ? "" : DateFormat('y-MM-dd').format(tglJatuhTempo!)}",
          "saldoeom": "${saldoEOM.text.replaceAll(",", "")}",
          "kode_pt": "001",
          "kode_kantor": "",
          "kode_induk": ""
        };
        // print(jsonEncode(data));
        Setuprepository.setup(token, NetworkURL.editBank(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getBank();
            clear();
            informationDialog(context, "Information", value['message']);
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_bank": "${kodeBank.text.trim()}",
          "nm_bank": "${sandiBankModel!.namaLjk}",
          "nm_rek": "${namaRek.text.trim()}",
          "no_rek": "${noRek.text}",
          "no_bilyet": "${noBilyet.text.trim()}",
          "cabang": "${cabang.text}",
          "kd_rek":
              "${rekening == "Tabungan" ? "10" : rekening == "Giro" ? "20" : "30"}",
          "nosbb": "${inqueryGlModeldeb!.nosbb}",
          "nama_sbb": "${inqueryGlModeldeb!.namaSbb}",
          "nominal": "${nilai.text.trim().replaceAll(",", '')}",
          "jw": "${jangkaWaktu.text}",
          "tglbuka":
              "${tglBuka == null ? "" : DateFormat('y-MM-dd').format(tglBuka!)}",
          "tgljtempo":
              "${tglJatuhTempo == null ? "" : DateFormat('y-MM-dd').format(tglJatuhTempo!)}",
          "saldoeom": "${saldoEOM.text.replaceAll(",", "")}",
          "kode_pt": "001",
          "kode_kantor": "",
          "kode_induk": ""
        };
        Setuprepository.setup(token, NetworkURL.addBank(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getBank();
            clear();
            informationDialog(context, "Information", value['message']);
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      }
    }
  }

  clear() async {
    dialog = false;
    editData = false;
    kodeBank.clear();
    namaBank.clear();
    noRek.clear();
    rekening = "Tabungan";
    nosbbdeb.clear();
    namaSbbDeb.clear();
    nilai.clear();
    saldoEOM.clear();
    tglBukaRekening.clear();
    tglJatuhTempoRekening.clear();
    saldoEOM.clear();
    notifyListeners();
  }
}
