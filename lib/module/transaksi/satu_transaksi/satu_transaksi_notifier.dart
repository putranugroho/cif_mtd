import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SatuTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  SatuTransaksiNotifier({required this.context}) {
    getUsers();

    notifyListeners();
  }
  UserModel? users;
  getUsers() async {
    Pref().getUsers().then((value) {
      users = value;
      getSetupTrans();
      getAoMarketing();
      getInqueryAll();
      getTransaksi();
      notifyListeners();
    });
  }

  var isLoadingData = true;
  List<TransaksiModel> listTransaksi = [];
  Future getTransaksi() async {
    isLoadingData = true;
    listTransaksi.clear();
    notifyListeners();
    var data = {
      "filter": {
        "general": {
          "batch": null,
          "status_transaksi": "all",
          "kode_pt": "${users!.kodePt}",
          "kode_kantor": "${users!.kodeKantor}",
          "kode_induk": "${users!.kodeInduk}",
          "rrn": null,
          "no_dokumen": null,
          "no_reff": null,
          "flag_trn": "0"
        },
        "range_tanggal": {
          "from": "${DateFormat('y-MM-dd').format(DateTime.now())}",
          "to": "${DateFormat('y-MM-dd').format(DateTime.now())}"
        },
        "akun": {"dracc": null, "cracc": null},
        "range_nominal": {"min": null, "max": null}
      },
      "pagination": {"page": 1},
      "sort": {"by": "tgl_transaksi", "order": "desc"}
    };
    Setuprepository.setup(token, NetworkURL.search(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksi.add(TransaksiModel.fromJson(i));
        }
        isLoadingData = false;
        notifyListeners();
      } else {
        isLoadingData = false;
        notifyListeners();
      }
    });
  }

  List<InqueryGlModel> list = [];
  List<AoModel> listAo = [];
  getAoMarketing() async {
    isLoading = true;
    listAo.clear();
    notifyListeners();
    var data = {"kode_pt": "${users!.kodePt}"};
    Setuprepository.setup(token, NetworkURL.getAoMarketing(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listAo.add(AoModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  InqueryGlModel? inqueryGlModeldeb;
  InqueryGlModel? inqueryGlModelcre;
  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
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

  SetupTransModel? setupTransModel;
  pilihTransModel(SetupTransModel value) {
    setupTransModel = value;
    namaTransaksi.text = setupTransModel!.kdTrans;
    inqueryGlModeldeb =
        listGl.where((e) => e.nosbb == setupTransModel!.glDeb).isEmpty
            ? null
            : listGl.where((e) => e.nosbb == setupTransModel!.glDeb).first;
    inqueryGlModelcre =
        listGl.where((e) => e.nosbb == setupTransModel!.glKre).isEmpty
            ? null
            : listGl.where((e) => e.nosbb == setupTransModel!.glKre).first;
    nosbbdeb.text = setupTransModel!.namaDeb;
    namaSbbDeb.text = setupTransModel!.glDeb;
    nossbcre.text = setupTransModel!.namaKre;
    namaSbbCre.text = setupTransModel!.glKre;
    notifyListeners();
  }

  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nosbbdeb.text = value.namaSbb;
    namaSbbDeb.text = value.nosbb;
    notifyListeners();
  }

  pilihAkunCre(InqueryGlModel value) {
    inqueryGlModelcre = value;
    nossbcre.text = value.namaSbb;
    namaSbbCre.text = value.nosbb;
    notifyListeners();
  }

  Future getInqueryAll() async {
    listGl.clear();
    notifyListeners();
    var data = {"kode_pt": "${users!.kodePt}"};
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

  var isLoading = true;
  Future getSetupTrans() async {
    isLoading = true;
    listData.clear();
    notifyListeners();
    var data = {"kode_pt": "${users!.kodePt}"};
    Setuprepository.setup(token, NetworkURL.getSetupTrans(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listData.add(SetupTransModel.fromJson(i));
        }
        isLoading = false;
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

  confirmPrint() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog();
        });
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

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController tglBackDatetext = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController nomorRef = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  bool dialog = false;
  tambah() {
    clear();
    dialog = true;
    notifyListeners();
  }

  bool backDate = false;
  gantibackDate() {
    backDate = !backDate;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  clear() {
    setupTransModel = null;
    namaTransaksi.clear();
    nomorDok.clear();
    nomorRef.clear();
    sbbAset = null;
    namaSbbCre.clear();
    nossbcre.clear();
    nosbbdeb.clear();
    namaSbbDeb.clear();
    sbbpenyusutan = null;
    nominal.clear();
    keterangan.clear();
    aoModel = null;
    aoModelKRedit = null;
    dialog = false;

    notifyListeners();
  }

  List<SetupTransModel> listData = [];

  TextEditingController namaSbbAset = TextEditingController();
  TextEditingController namaTransaksi = TextEditingController();
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

  // List<AoModel> listAo = [];
  AoModel? aoModel;
  AoModel? aoModelKRedit;
  pilihAoModelDebet(AoModel value) {
    aoModel = value;
    notifyListeners();
  }

  final keyForm = GlobalKey<FormState>();

  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      var invoice = DateTime.now().millisecondsSinceEpoch.toString();
      var data = [
        {
          "tgl_transaksi": "${DateFormat('y-MM-dd').format(DateTime.now())}",
          "tgl_valuta":
              "${backDate ? DateFormat('y-MM-dd').format(tglBackDate!) : DateFormat('y-MM-dd').format(DateTime.now())}",
          "batch": "${users!.batch}",
          "trx_type": "TRX",
          "trx_code": "${backDate ? "110" : "100"}",
          "otor": "0",
          "kode_trn":
              "${setupTransModel == null ? "" : setupTransModel!.kdTrans}",
          "nama_dr": "${nosbbdeb.text}",
          "dracc": "${namaSbbDeb.text}",
          "nama_cr": "${nossbcre.text}",
          "cracc": "${namaSbbCre.text}",
          "rrn": "$invoice",
          "no_dokumen": "${nomorDok.text}",
          "no_ref": "${nomorRef.text}",
          "nominal": double.parse(nominal.text
              .replaceAll("Rp ", "")
              .replaceAll(".", "")
              .replaceAll(",", ".")),
          "keterangan": "${keterangan.text}",
          "kode_pt": "${users!.kodePt}",
          "kode_kantor": "${users!.kodeKantor}",
          "kode_induk": "${users!.kodeInduk}",
          "sts_validasi": "N",
          "kode_ao_dr": "${aoModel == null ? "" : aoModel!.kode}",
          "kode_coll": "",
          "kode_ao_cr": "${aoModelKRedit == null ? "" : aoModelKRedit!.kode}",
          "userinput": "${users!.namauser}",
          "userterm": "114.80.90.54",
          "inputtgljam":
              "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
          "otoruser": "",
          "otorterm": "",
          "otortgljam": "",
          "flag_trn": "0",
          "merchant": "",
          "source_trx": ""
        }
      ];
      print(jsonEncode(data));
      Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data))
          .then((value) {
        Navigator.pop(context);
        if (value['code'] == "000") {
          getTransaksi();
          clear();
          informationDialog(context, "Information", value['message']);
        } else {
          informationDialog(context, "Warning", value['message']);
        }
      });
    }
  }

  cancelKode() async {
    inqueryGlModelcre = null;
    inqueryGlModelcre = null;
    setupTransModel = null;
    namaTransaksi.clear();
    namaSbbCre.clear();
    nossbcre.clear();
    nosbbdeb.clear();
    namaSbbDeb.clear();
    notifyListeners();
  }

  pilihAoModelKredit(AoModel value) {
    aoModelKRedit = value;
    notifyListeners();
  }
}
