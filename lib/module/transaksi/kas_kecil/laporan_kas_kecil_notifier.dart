import 'dart:convert';
import 'dart:io';

import 'package:accounting/models/index.dart';
import 'package:accounting/pref/pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';
import '../../../utils/dialog_loading.dart';
import '../../../utils/informationdialog.dart';

class LaporanKasKecilNotifier extends ChangeNotifier {
  final BuildContext context;

  LaporanKasKecilNotifier({required this.context}) {
    // for (Map<String, dynamic> i in coa) {
    //   listCoa.add(CoaModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in data) {
    //   listData.add(TransaksiModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in ao) {
    //   listAo.add(AoModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in json) {
    //   listKodeTransaksi.add(SetupTransModel.fromJson(i));
    // }
    getProfile();
    notifyListeners();
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

  List<KasKecilModel> listkas = [];
  KasKecilModel? kasKecilModel;
  Future getSetupkaskecil() async {
    isLoading = true;
    listkas.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001"
    };
    Setuprepository.setup(token, NetworkURL.getSetupKasKecil(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listkas.add(KasKecilModel.fromJson(i));
        }
        if (listkas.isNotEmpty) {
          kasKecilModel = listkas[0];
          nossbcre.text = kasKecilModel!.namasbbKaskecil;
          namaSbbCre.text = kasKecilModel!.nosbbKasKecil;
          nosbbdeb.clear();
          namaSbbDeb.clear();
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

  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nosbbdeb.text = value.namaSbb;
    namaSbbDeb.text = value.nosbb;
    notifyListeners();
  }

  TextEditingController namaSbbCre = TextEditingController();
  TextEditingController namaSbbDeb = TextEditingController();
  pilihAkunCre(InqueryGlModel value) {
    inqueryGlModelcre = value;
    nossbcre.text = value.namaSbb;
    namaSbbCre.text = value.nosbb;
    notifyListeners();
  }

  Future getInqueryAll() async {
    list.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001"
    };
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems = extractJnsAccB(value['data']);
        list = jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();

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

  var isLoading = true;
  Future getSetupTrans() async {
    isLoading = true;
    listData.clear();
    listDataTrans.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001"
    };
    Setuprepository.setup(token, NetworkURL.getSetupTrans(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listDataTrans.add(SetupTransModel.fromJson(i));
        }
        if (listDataTrans.isNotEmpty) {
          listData = listDataTrans.where((e) => e.modul == "KAS KECIL").toList();
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
    if (metode == "Pemasukan") {
      nosbbdeb.text = kasKecilModel!.namasbbKaskecil;
      namaSbbDeb.text = kasKecilModel!.nosbbKasKecil;
      nossbcre.clear();
      namaSbbCre.clear();
    } else {
      nossbcre.text = kasKecilModel!.namasbbKaskecil;
      namaSbbCre.text = kasKecilModel!.nosbbKasKecil;
      nosbbdeb.clear();
      namaSbbDeb.clear();
    }
    notifyListeners();
  }

  confirmPrint() {
    showDialog(
        context: context,
        builder: (context) {
          return const Dialog();
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
      tglBackDatetext.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
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
      tglTransaksiText.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  final keyForm = GlobalKey<FormState>();

  bool cancel = true;
  cancelKode() async {
    cancel = true;
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

  var isLoadingData = true;
  List<TransaksiPendModel> listTransaksi = [];
  List<TransaksiPendModel> listTransaksiAdd = [];
  Future getTransaksi() async {
    isLoadingData = true;
    listTransaksi.clear();
    notifyListeners();
    var data = {
      "kode_pt": users!.kodePt,
    };
    Setuprepository.setup(token, NetworkURL.view(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksi.add(TransaksiPendModel.fromJson(i));
        }
        if (listTransaksi.isNotEmpty) {
          listTransaksiAdd = listTransaksi.where((e) => e.cracc == kasKecilModel!.nosbbKasKecil || e.dracc == kasKecilModel!.nosbbKasKecil).toList();
        }
        isLoadingData = false;
        notifyListeners();
      } else {
        isLoadingData = false;
        notifyListeners();
      }
    });
  }

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController tglBackDatetext = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController nomorRef = TextEditingController();

  bool dialog = false;
  bool editData = false;
  tambah() {
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

  TextEditingController keterangan = TextEditingController();
  cek() {
    if (keyForm.currentState!.validate()) {
      if (users!.limitAkses == "Y") {
        if (double.parse(users!.maksimalTransaksi) < double.parse(nominal.text.replaceAll("Rp ", "").replaceAll(".", "").replaceAll(",", "."))) {
          DialogCustom().showLoading(context);
          var invoice = DateTime.now().millisecondsSinceEpoch.toString();
          var data = {
            "tgl_transaksi": DateFormat('y-MM-dd').format(DateTime.now()),
            "tgl_valuta": backDate ? DateFormat('y-MM-dd').format(tglBackDate!) : DateFormat('y-MM-dd').format(DateTime.now()),
            "batch": users!.batch,
            "trx_type": "TRX",
            "trx_code": backDate ? "110" : "100",
            "otor": "0",
            "kode_trn": setupTransModel == null ? "" : setupTransModel!.kdTrans,
            "nama_dr": nosbbdeb.text,
            "dracc": namaSbbDeb.text,
            "nama_cr": nossbcre.text,
            "cracc": namaSbbCre.text,
            "rrn": invoice,
            "no_dokumen": nomorDok.text,
            "no_ref": nomorRef.text,
            "nominal": double.parse(nominal.text.replaceAll("Rp ", "").replaceAll(".", "").replaceAll(",", ".")),
            "keterangan": keterangan.text,
            "kode_pt": users!.kodePt,
            "kode_kantor": users!.kodeKantor,
            "kode_induk": users!.kodeInduk,
            "sts_validasi": "N",
            "kode_ao_dr": "",
            "kode_coll": "",
            "kode_ao_cr": "",
            "userinput": users!.namauser,
            "userterm": "114.80.90.54",
            "keterangan_otorisasi": "Melebihi Maksimal Limit Transaksi",
            "inputtgljam": DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now()),
            "otoruser": "",
            "otorterm": "",
            "otortgljam": "",
            "flag_trn": "0",
            "merchant": "",
            "source_trx": "",
            "status": "PENDING",
            "modul": "KAS KECIL",
          };
          Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data)).then((value) {
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
            "tgl_transaksi": DateFormat('y-MM-dd').format(DateTime.now()),
            "tgl_valuta": backDate ? DateFormat('y-MM-dd').format(tglBackDate!) : DateFormat('y-MM-dd').format(DateTime.now()),
            "batch": users!.batch,
            "trx_type": "TRX",
            "trx_code": backDate ? "110" : "100",
            "otor": "0",
            "kode_trn": setupTransModel == null ? "" : setupTransModel!.kdTrans,
            "nama_dr": nosbbdeb.text,
            "dracc": namaSbbDeb.text,
            "nama_cr": nossbcre.text,
            "cracc": namaSbbCre.text,
            "rrn": invoice,
            "no_dokumen": nomorDok.text,
            "no_ref": nomorRef.text,
            "nominal": double.parse(nominal.text.replaceAll("Rp ", "").replaceAll(".", "").replaceAll(",", ".")),
            "keterangan": keterangan.text,
            "kode_pt": users!.kodePt,
            "kode_kantor": users!.kodeKantor,
            "kode_induk": users!.kodeInduk,
            "sts_validasi": "N",
            "kode_ao_dr": "",
            "kode_coll": "",
            "kode_ao_cr": "",
            "userinput": users!.namauser,
            "userterm": "114.80.90.54",
            "inputtgljam": DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now()),
            "otoruser": "",
            "otorterm": "",
            "otortgljam": "",
            "flag_trn": "0",
            "merchant": "",
            "source_trx": "",
            "status": "COMPLETED",
            "modul": "KAS KECIL",
          };
          Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data)).then((value) {
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

    notifyListeners();
  }

  List<SetupTransModel> listDataTrans = [];
  List<SetupTransModel> listData = [];
  SetupTransModel? setupTransModel;
  pilihTransModel(SetupTransModel value) {
    setupTransModel = value;
    namaTransaksi.text = setupTransModel!.kdTrans;
    inqueryGlModeldeb = listGl.where((e) => e.nosbb == setupTransModel!.glDeb).isEmpty ? null : listGl.where((e) => e.nosbb == setupTransModel!.glDeb).first;
    inqueryGlModelcre = listGl.where((e) => e.nosbb == setupTransModel!.glKre).isEmpty ? null : listGl.where((e) => e.nosbb == setupTransModel!.glKre).first;
    nosbbdeb.text = setupTransModel!.namaDeb;
    namaSbbDeb.text = setupTransModel!.glDeb;
    nossbcre.text = setupTransModel!.namaKre;
    namaSbbCre.text = setupTransModel!.glKre;
    cancel = false;
    notifyListeners();
  }

  List<KaryawanModel> listKaryawan = [];
  TextEditingController namaKaryawan = TextEditingController();
  TextEditingController nikKaryawan = TextEditingController();
  KaryawanModel? karyawanModel;
  piliAkunKaryawan(KaryawanModel value) {
    karyawanModel = value;
    namaKaryawan.text = karyawanModel!.namaLengkap;
    nikKaryawan.text = karyawanModel!.nik;
    notifyListeners();
  }

  Future<List<KaryawanModel>> getInqKaryawan(String query) async {
    if (query.isNotEmpty && query.length > 2 && editData == false) {
      listKaryawan.clear();
      notifyListeners();
      var data = {
        "nama": query
      };
      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.cariKaryawan(),
          jsonEncode(data),
        );

        for (Map<String, dynamic> i in response) {
          listKaryawan.add(KaryawanModel.fromJson(i));
        }
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print("Error: $e");
        }
      } finally {
        notifyListeners();
      }
    } else {
      listKaryawan.clear(); // clear on short query
    }

    return listKaryawan;
  }

  TextEditingController tglText = TextEditingController();

  DateTime? tgl;
  Future pilihTanggal() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(int.parse(DateFormat('y').format(DateTime.now())), int.parse(DateFormat('MM').format(DateTime.now())), int.parse(DateFormat('dd').format(DateTime.now()))),
      firstDate: DateTime(int.parse(DateFormat('y').format(DateTime.now())), int.parse(DateFormat('MM').format(DateTime.now())), int.parse(DateFormat('dd').format(DateTime.now()))),
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
      tgl = pickedendDate;
      tglText.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }
}
