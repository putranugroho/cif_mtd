import 'dart:convert';
import 'dart:io';

import 'package:accounting/models/index.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';
import '../../../utils/button_custom.dart';
import '../../../utils/dialog_loading.dart';
import '../../../utils/format_currency.dart';

class KasbonNotifier extends ChangeNotifier {
  final BuildContext context;

  KasbonNotifier({required this.context}) {
    getProfile();
    notifyListeners();
  }

  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nosbbdeb.text = value.nosbb;
    namaSbbDeb.text = value.namaSbb;
    notifyListeners();
  }

  InqueryGlModel? inqueryGlModelPenyelesaian;
  pilihAkunKreditPenyelesaian(InqueryGlModel value) {
    inqueryGlModelPenyelesaian = value;
    namaSbbDebPenyelesaian.text = value.namaSbb;
    notifyListeners();
  }

  TextEditingController namaSbbCre = TextEditingController();
  TextEditingController namaSbbDeb = TextEditingController();
  TextEditingController keteranganBaru = TextEditingController();
  TextEditingController nomorDokBaru = TextEditingController();
  TextEditingController namaSbbDebPenyelesaian = TextEditingController();
  pilihAkunCre(InqueryGlModel value) {
    inqueryGlModelcre = value;
    nossbcre.text = value.nosbb;
    namaSbbCre.text = value.namaSbb;
    notifyListeners();
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

  TextEditingController namaTransaksi = TextEditingController();
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

  var isLoading = true;
  Future getSetupTrans() async {
    isLoading = true;
    listData.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
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

  List<InqueryGlModel> list = [];

  List<String> listMetodeKas = [
    "Pengeluaran",
    "Pemasukan",
  ];
  String? metode = "Pengeluaran";
  pilihMetode(String value) {
    metode = value;
    notifyListeners();
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

  DateTime? tglPenyelesaian;
  Future pilihTanggalPenyelesaian() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(DateTime.now())),
          int.parse(DateFormat('dd').format(DateTime.now()))),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) - 2,
          int.parse(DateFormat('MM').format(DateTime.now())),
          int.parse(DateFormat('dd').format(DateTime.now()))),
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
      tglPenyelesaian = pickedendDate;
      tglPenyelesaianText.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController nilaiTrans = TextEditingController();
  TextEditingController selisih = TextEditingController();
  double nilaiselisih = 0;

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

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController tglPenyelesaianText = TextEditingController();
  TextEditingController tglBackDatetext = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController nomorRef = TextEditingController();

  bool dialog = false;
  bool editData = false;

  tambah() {
    dialog = true;
    editData = false;
    notifyListeners();
  }

  final keyForm = GlobalKey<FormState>();

  simpan() async {
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
                    "Apakah data sudah benar ?",
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
                          cek();
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

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getSetupTrans();
      getInqueryAll();
      getSetupkaskecil();
      notifyListeners();
    });
  }

  var isLoadingData = true;
  List<TransaksiPendModel> listTransaksi = [];
  List<TransaksiPendModel> listTransaksiAdd = [];
  Future getTransaksi() async {
    isLoadingData = true;
    listTransaksi.clear();
    notifyListeners();
    var data = {
      "kode_pt": "${users!.kodePt}",
    };
    Setuprepository.setup(token, NetworkURL.view(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksi.add(TransaksiPendModel.fromJson(i));
        }
        if (listTransaksi.isNotEmpty) {
          listTransaksiAdd = listTransaksi
              .where((e) => e.dracc == kasKecilModel!.nosbbKasBon)
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

  TextEditingController keterangan = TextEditingController();
  List<KasKecilModel> listkas = [];
  KasKecilModel? kasKecilModel;
  Future getSetupkaskecil() async {
    isLoading = true;
    listkas.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(
            token, NetworkURL.getSetupKasKecil(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listkas.add(KasKecilModel.fromJson(i));
        }
        if (listkas.isNotEmpty) {
          kasKecilModel = listkas[0];
          nosbbdeb.text = kasKecilModel!.namasbbKasbon;
          namaSbbDeb.text = kasKecilModel!.nosbbKasBon;
          nossbcre.text = kasKecilModel!.namasbbKaskecil;
          namaSbbCre.text = kasKecilModel!.nosbbKasKecil;
        }
        getTransaksi();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  penyelesaian() {
    if (keyForm.currentState!.validate()) {
      if (users!.limitAkses == "Y") {
        if (double.parse(users!.maksimalTransaksi) <
            double.parse(nominal.text
                .replaceAll("Rp ", "")
                .replaceAll(".", "")
                .replaceAll(",", "."))) {
          DialogCustom().showLoading(context);
          var invoice = DateTime.now().millisecondsSinceEpoch.toString();
          var data = {
            "tgl_transaksi": "${DateFormat('y-MM-dd').format(DateTime.now())}",
            "tgl_valuta":
                "${backDate ? DateFormat('y-MM-dd').format(tglBackDate!) : DateFormat('y-MM-dd').format(DateTime.now())}",
            "batch": "${users!.batch}",
            "trx_type": "TRX",
            "trx_code": "${backDate ? "110" : "100"}",
            "otor": "0",
            "kode_trn":
                "${setupTransModel == null ? "" : setupTransModel!.kdTrans}",
            "nama_dr": "${inqueryGlModelPenyelesaian!.namaSbb}",
            "dracc": "${inqueryGlModelPenyelesaian!.nosbb}",
            "nama_cr": "${nosbbdeb.text}",
            "cracc": "${namaSbbDeb.text}",
            "rrn": "$invoice",
            "no_dokumen": "${nomorDokBaru.text}",
            "no_ref": "${transaksiPendModel!.noRef}",
            "nominal": double.parse(nilaiTrans.text
                .replaceAll("Rp ", "")
                .replaceAll(".", "")
                .replaceAll(",", ".")),
            "keterangan": "${keteranganBaru.text}",
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
            "modul": "PENYELESAIAN KASBON",
          };
          Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data))
              .then((value) {
            Navigator.pop(context);
            if (value['status'] == "success") {
              getTransaksi();
              clear();
              informationDialog(context, "Information", value['message']);
            } else {
              informationDialog(context, "Warning", value['message']);
            }
          });
        } else {
          if (tglPenyelesaian!.isBefore(DateTime.now())) {
            backDate = true;
          } else {
            backDate = false;
          }
          DialogCustom().showLoading(context);
          var invoice = DateTime.now().millisecondsSinceEpoch.toString();
          var data = {
            "tgl_transaksi": "${DateFormat('y-MM-dd').format(DateTime.now())}",
            "tgl_valuta":
                "${backDate ? DateFormat('y-MM-dd').format(tglPenyelesaian!) : DateFormat('y-MM-dd').format(DateTime.now())}",
            "batch": "${users!.batch}",
            "trx_type": "TRX",
            "trx_code": "${backDate ? "110" : "100"}",
            "otor": "0",
            "kode_trn":
                "${setupTransModel == null ? "" : setupTransModel!.kdTrans}",
            "nama_dr": "${inqueryGlModelPenyelesaian!.namaSbb}",
            "dracc": "${inqueryGlModelPenyelesaian!.nosbb}",
            "nama_cr": "${nosbbdeb.text}",
            "cracc": "${namaSbbDeb.text}",
            "rrn": "$invoice",
            "no_dokumen": "${nomorDokBaru.text}",
            "no_ref": "${transaksiPendModel!.noRef}",
            "nominal": (nilaiselisih < 0)
                ? double.parse(transaksiPendModel!.nominal)
                : double.parse(nilaiTrans.text
                    .replaceAll("Rp ", "")
                    .replaceAll(".", "")
                    .replaceAll(",", ".")),
            "keterangan": "${keteranganBaru.text}",
            "kode_pt": "${users!.kodePt}",
            "kode_kantor": "${users!.kodeKantor}",
            "kode_induk": "${users!.kodeInduk}",
            "sts_validasi": "N",
            "kode_ao_dr": "",
            "kode_coll": "",
            "kode_ao_cr": "",
            "userinput": "${users!.namauser}",
            "userterm": "114.80.90.54",
            "inputtgljam":
                "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
            "otoruser": "",
            "otorterm": "",
            "otortgljam": "",
            "flag_trn": "0",
            "merchant": "",
            "source_trx": "",
            "status": "COMPLETED",
            "modul": "PENYELESAIAN KASBON",
          };
          Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data))
              .then((value) {
            if (nilaiselisih < 0) {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta":
                    "${backDate ? DateFormat('y-MM-dd').format(tglPenyelesaian!) : DateFormat('y-MM-dd').format(DateTime.now())}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code": "${backDate ? "110" : "100"}",
                "otor": "0",
                "kode_trn":
                    "${setupTransModel == null ? "" : setupTransModel!.kdTrans}",
                "nama_dr": "${inqueryGlModelPenyelesaian!.namaSbb}",
                "dracc": "${inqueryGlModelPenyelesaian!.nosbb}",
                "nama_cr": "${nossbcre.text}",
                "cracc": "${namaSbbCre.text}",
                "rrn": "$invoice",
                "no_dokumen": "${nomorDokBaru.text}",
                "no_ref": "${transaksiPendModel!.noRef}",
                "nominal":
                    double.parse(nilaiselisih.toString().replaceAll("-", "")),
                "keterangan": "${keteranganBaru.text}",
                "kode_pt": "${users!.kodePt}",
                "kode_kantor": "${users!.kodeKantor}",
                "kode_induk": "${users!.kodeInduk}",
                "sts_validasi": "N",
                "kode_ao_dr": "",
                "kode_coll": "",
                "kode_ao_cr": "",
                "userinput": "${users!.namauser}",
                "userterm": "114.80.90.54",
                "inputtgljam":
                    "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
                "otoruser": "",
                "otorterm": "",
                "otortgljam": "",
                "flag_trn": "0",
                "merchant": "",
                "source_trx": "",
                "status": "COMPLETED",
                "modul": "SISA KASBON",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            } else if (nilaiselisih > 0) {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta":
                    "${backDate ? DateFormat('y-MM-dd').format(tglPenyelesaian!) : DateFormat('y-MM-dd').format(DateTime.now())}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code": "${backDate ? "110" : "100"}",
                "otor": "0",
                "kode_trn":
                    "${setupTransModel == null ? "" : setupTransModel!.kdTrans}",
                "nama_dr": "${nossbcre.text}",
                "dracc": "${namaSbbCre.text}",
                "nama_cr": "${nosbbdeb.text}",
                "cracc": "${namaSbbDeb.text}",
                "rrn": "$invoice",
                "no_dokumen": "${nomorDokBaru.text}",
                "no_ref": "${transaksiPendModel!.noRef}",
                "nominal":
                    double.parse(nilaiselisih.toString().replaceAll("-", "")),
                "keterangan": "${keteranganBaru.text}",
                "kode_pt": "${users!.kodePt}",
                "kode_kantor": "${users!.kodeKantor}",
                "kode_induk": "${users!.kodeInduk}",
                "sts_validasi": "N",
                "kode_ao_dr": "",
                "kode_coll": "",
                "kode_ao_cr": "",
                "userinput": "${users!.namauser}",
                "userterm": "114.80.90.54",
                "inputtgljam":
                    "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
                "otoruser": "",
                "otorterm": "",
                "otortgljam": "",
                "flag_trn": "0",
                "merchant": "",
                "source_trx": "",
                "status": "COMPLETED",
                "modul": "SISA KASBON",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            }
            Navigator.pop(context);
            if (value['status'] == "success") {
              getTransaksi();
              clear();
              informationDialog(context, "Information", value['message']);
            } else {
              informationDialog(context, "Warning", value['message']);
            }
          });
        }
      } else {
        informationDialog(context, "Warning", "Tidak bisa melakukan transaksi");
      }
    }
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      if (users!.limitAkses == "Y") {
        if (double.parse(users!.maksimalTransaksi) <
            double.parse(nominal.text
                .replaceAll("Rp ", "")
                .replaceAll(".", "")
                .replaceAll(",", "."))) {
          DialogCustom().showLoading(context);
          var invoice = DateTime.now().millisecondsSinceEpoch.toString();
          var data = {
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
            "modul": "KASBON",
          };
          Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data))
              .then((value) {
            Navigator.pop(context);
            if (value['status'] == "success") {
              getTransaksi();
              clear();
              informationDialog(context, "Information", value['message']);
            } else {
              informationDialog(context, "Warning", value['message']);
            }
          });
        } else {
          DialogCustom().showLoading(context);
          var invoice = DateTime.now().millisecondsSinceEpoch.toString();
          var data = {
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
            "kode_ao_dr": "",
            "kode_coll": "",
            "kode_ao_cr": "",
            "userinput": "${users!.namauser}",
            "userterm": "114.80.90.54",
            "inputtgljam":
                "${DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now())}",
            "otoruser": "",
            "otorterm": "",
            "otortgljam": "",
            "flag_trn": "0",
            "merchant": "",
            "source_trx": "",
            "status": "CREATED",
            "modul": "KASBON",
          };
          Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data))
              .then((value) {
            Navigator.pop(context);
            if (value['status'] == "success") {
              getTransaksi();
              clear();
              informationDialog(context, "Information", value['message']);
            } else {
              informationDialog(context, "Warning", value['message']);
            }
          });
        }
      } else {
        informationDialog(context, "Warning", "Tidak bisa melakukan transaksi");
      }
    }
  }

  updateSelisih() {
    // FormatCurrency.oCcy.format(int.parse(nominal.text)).replaceAll(".", ",");
    nilaiselisih = double.parse(nominal.text.replaceAll(",", "")) -
        double.parse(nilaiTrans.text
            .replaceAll(".", "")
            .replaceAll("Rp ", "")
            .replaceAll(",", "."));
    selisih.text = FormatCurrency.oCcy.format(nilaiselisih);
    notifyListeners();
  }

  DateTime? tglTransaksi;
  TransaksiPendModel? transaksiPendModel;
  edit(String rrn) {
    transaksiPendModel = listTransaksi.where((e) => e.rrn == rrn).first;
    if (transaksiPendModel!.status == "COMPLETED") {
      informationDialog(
          context, "Warning", "Kas Bon tidak bisa ditransaksikan");
    } else {
      nomorDok.text = transaksiPendModel!.noDokumen;
      nomorRef.text = transaksiPendModel!.noRef;
      keterangan.text = transaksiPendModel!.keterangan;
      dialog = true;
      editData = true;
      tglTransaksiText.text = transaksiPendModel!.tglTransaksi;
      nominal.text = transaksiPendModel!.nominal;
      nilaiTrans.text = "0";
      updateSelisih();
      notifyListeners();
    }
  }

  bool backDate = false;
  gantibackDate() {
    backDate = !backDate;
    notifyListeners();
  }

  clear() {
    nomorDok.clear();
    nomorRef.clear();
    namaSbbCre.clear();
    nossbcre.clear();
    nosbbdeb.clear();
    namaSbbDeb.clear();
    nominal.clear();
    keterangan.clear();
    dialog = false;
    getSetupkaskecil();
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<SetupTransModel> listData = [];
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
    nosbbdeb.text = setupTransModel!.glDeb;
    namaSbbDeb.text = setupTransModel!.namaDeb;
    nossbcre.text = setupTransModel!.glKre;
    namaSbbCre.text = setupTransModel!.namaKre;
    notifyListeners();
  }
}
