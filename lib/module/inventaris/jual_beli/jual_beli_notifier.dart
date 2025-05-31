import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/utils/colors.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';
import '../../../utils/format_currency.dart';

class JualBeliNotifier extends ChangeNotifier {
  final BuildContext context;

  JualBeliNotifier({required this.context}) {
    getProfile();
    notifyListeners();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getKantor();
      getInventaris();
      getInqueryAll();
      getMetodePenyusutan();
      notifyListeners();
    });
  }

  List<MetodePenyusutanModel> listPenyusutan = [];
  MetodePenyusutanModel? metodePenyusutanModel;
  int metode = 0;
  Future getMetodePenyusutan() async {
    isLoading = true;
    listPenyusutan.clear();
    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.setup(token, NetworkURL.getMetodePenyusutan(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listPenyusutan.add(MetodePenyusutanModel.fromJson(i));
        }
        metodePenyusutanModel = listPenyusutan[0];
        metode = int.parse(metodePenyusutanModel!.metodePenyusutan);
        nilaiPenyusutan.text = metodePenyusutanModel!.nilaiAkhir.toString();

        print("Declining ${metodePenyusutanModel!.declining}");
        isLoading = false;
        notifyListeners();
      } else {
        // informationDialog(context, "Warning", value['message'][0]);
        notifyListeners();
      }
    });
    notifyListeners();
  }

  var isLoadingData = true;
  List<TransaksiPendModel> listTransaksi = [];
  List<TransaksiPendModel> listTransaksiAdd = [];
  Future getTransaksi() async {
    isLoadingData = true;
    listTransaksi.clear();
    listTransaksiAdd.clear();
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
          for (var i = 0; i < listGlAll.length; i++) {
            listTransaksiAdd.addAll(listTransaksi.where((e) => (e.cracc == listGlAll[i].nosbb || e.dracc == listGlAll[i].nosbb) && e.status == "COMPLETED" && e.tglValuta == DateFormat('y-MM-dd').format(tglTransaksi!)).toList());
          }
        }
        isLoadingData = false;
        notifyListeners();
      } else {
        isLoadingData = false;
        notifyListeners();
      }
    });
  }

  List<Map<String, dynamic>> extractJnsAccBb(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];

    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          if (item['jns_acc'] == 'C' && item['type_posting'] == "Y" && item['akun_perantara'] == "Y") {
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

  List<InqueryGlModel> listGlAll = [];
  Future getInqueryAll() async {
    listGlAll.clear();
    notifyListeners();
    var data = {
      "kode_pt": users!.kodePt
    };
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems = extractJnsAccBb(value['data']);
        listGlAll = jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        print("GL : ${jsonEncode(listGlAll)}");
        getTransaksi();
        notifyListeners();
      }
    });
  }

  List<KantorModel> listKantor = [];
  Future getKantor() async {
    listKantor.clear();

    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.getKantor(token, NetworkURL.getKantor(), jsonEncode(data)).then((value) {
      if (value['status'] == "Success") {
        for (Map<String, dynamic> i in value['data']) {
          listKantor.add(KantorModel.fromJson(i));
        }

        notifyListeners();
      } else {
        notifyListeners();
      }
    });
  }

  List<KantorModel> listkantor = [];
  KantorModel? kantorModel;
  pilihKantor(KantorModel value) {
    kantor = value;

    notifyListeners();
  }

  KantorModel? kantor;
  List<InventarisModel> list = [];

//contoh decimal sparator currency
  var isLoading = true;
  final currencyFormatter = NumberFormat.currency(symbol: 'Rp ', decimalDigits: 2);
  getInventaris() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001"
    };
    Setuprepository.setup(token, NetworkURL.getInventaris(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(InventarisModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  int currentStep = 0;
  void onStepContinue() {
    if ((currentStep + 1) <= formStep.length) {
      if (formStep[currentStep].currentState!.validate()) {
        goToNextStep();
      }
    }
  }

  void onStepBack() {
    if (currentStep > 0) {
      currentStep--;
    } else {
      Navigator.pop(context);
    }
    notifyListeners();
  }

  void goToNextStep() {
    currentStep++;
    notifyListeners();
  }

  List<Map<String, dynamic>> extractJnsAccB(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];

    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          if (item['jns_acc'] == 'C' && item['type_posting'] == "Y" && item['gol_acc'] == "3") {
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

  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nosbbdeb.text = value.namaSbb;
    namaSbbDeb.text = value.nosbb;
    notifyListeners();
  }

  InqueryGlModel? inqueryGlModeldeb;
  InqueryGlModel? inqueryGlModelcre;
  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
  TextEditingController nosbbdeb = TextEditingController();
  TextEditingController namaSbbDeb = TextEditingController();
  TextEditingController nossbcre = TextEditingController();
  Future<List<InqueryGlModel>> getInqueryTransaksi(String query) async {
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
          listGl = jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).where((model) => model.nosbb.toLowerCase().contains(query.toLowerCase()) || model.namaSbb.toLowerCase().contains(query.toLowerCase()) && model.typePosting == "Y").toList();
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

  final List<GlobalKey<FormState>> formStep = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  cek() {
    if (pilihModel == "Jual") {
      var rrn = DateTime.now().millisecondsSinceEpoch.toString();
      DialogCustom().showLoading(context);
      var jenisPenempatan = inventarisModel!.nik != '' ? "Karyawan" : "Kantor";
      var format = DateFormat('MMMM y');
      DateTime parseDate = format.parse(inventarisModel!.blnMulaiSusut);
      var data = {
        "kode_pt": users!.kodePt,
        "kdaset": inventarisModel!.kdaset,
        "kode_induk": users!.kodeInduk,
        "jenis_penempatan": jenisPenempatan,
        "nama_kantor": kantor!.namaKantor,
        "kode_kantor": users!.kodeKantor,
        "userinput": users!.namauser,
        "userterm": "114.80.90.54",
        "nilai_jual": nilaijual.text.replaceAll(",", ""),
        "tgl_jual": DateFormat('y-MM-dd').format(tanggalJual!),
        "alasan_jual": "$rrn ${alasanjualhapus.text.trim()}",
        "bln_susut": DateFormat('y-MM-dd').format(parseDate),
        "tgl_valuta": transaksiPendModel!.tglValuta,
        "nomor_dok": transaksiPendModel!.noDokumen,
        "keterangan_transaksi": transaksiPendModel!.keterangan,
        "habeli": nilaiTrans.text.replaceAll(",", ""),
        "persentase_penyusutan": nilaiPenyusutan.text.replaceAll(",", ""),
        "metode_penyusutan": metode.toString(),
      };
      print("Data Payload ${jsonEncode(data)}");
      Setuprepository.setup(token, NetworkURL.jual(), jsonEncode(data)).then((value) {
        Navigator.pop(context);
        if (value['status'].toString().toLowerCase().contains("success")) {
          if (double.parse(users!.maksimalTransaksi) < double.parse(inventarisModel!.habeli)) {
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi": DateFormat('y-MM-dd').format(DateTime.now()),
              "tgl_valuta": transaksiPendModel!.tglValuta,
              "batch": users!.batch,
              "trx_type": "TRX",
              "trx_code": transaksiPendModel!.trxCode,
              "otor": "0",
              "kode_trn": "",
              "nama_dr": inventarisModel!.sbbAset.toString().substring(14, inventarisModel!.sbbAset.toString().length),
              "dracc": inventarisModel!.sbbAset.toString().substring(1, 13),
              "nama_cr": inventarisModel!.sbbPenyusutan.toString().substring(14, inventarisModel!.sbbPenyusutan.toString().length),
              "cracc": inventarisModel!.sbbPenyusutan.toString().substring(1, 13),
              "rrn": invoice,
              "no_dokumen": transaksiPendModel!.noDokumen,
              "no_ref": transaksiPendModel!.noRef,
              "nominal": inventarisModel!.habeli,
              "keterangan": keteranganTrans.text,
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
              "modul": "JUAL INVENTARIS",
            };
            Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data));
          } else {
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi": DateFormat('y-MM-dd').format(DateTime.now()),
              "tgl_valuta": transaksiPendModel!.tglValuta,
              "batch": users!.batch,
              "trx_type": "TRX",
              "trx_code": transaksiPendModel!.trxCode,
              "otor": "0",
              "kode_trn": "",
              "nama_dr": inventarisModel!.sbbAset.toString().substring(14, inventarisModel!.sbbAset.toString().length),
              "dracc": inventarisModel!.sbbAset.toString().substring(1, 13),
              "nama_cr": inventarisModel!.sbbPenyusutan.toString().substring(14, inventarisModel!.sbbPenyusutan.toString().length),
              "cracc": inventarisModel!.sbbPenyusutan.toString().substring(1, 13),
              "rrn": invoice,
              "no_dokumen": transaksiPendModel!.noDokumen,
              "no_ref": transaksiPendModel!.noRef,
              "nominal": inventarisModel!.habeli,
              "keterangan": keteranganTrans.text,
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
              "status": "COMPLETED",
              "modul": "JUAL INVENTARIS",
            };
            Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data));
          }

          if (double.parse(users!.maksimalTransaksi) < double.parse(inventarisModel!.habeli)) {
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi": DateFormat('y-MM-dd').format(DateTime.now()),
              "tgl_valuta": transaksiPendModel!.tglValuta,
              "batch": users!.batch,
              "trx_type": "TRX",
              "trx_code": transaksiPendModel!.trxCode,
              "otor": "0",
              "kode_trn": "",
              "nama_dr": transaksiPendModel!.namaCr,
              "dracc": transaksiPendModel!.cracc,
              "nama_cr": inqueryGlModeldeb!.namaSbb,
              "cracc": inqueryGlModeldeb!.nosbb,
              "rrn": invoice,
              "no_dokumen": transaksiPendModel!.noDokumen,
              "no_ref": transaksiPendModel!.noRef,
              "nominal": nilaijual.text.replaceAll(",", ""),
              "keterangan": keteranganTrans.text,
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
              "modul": "JUAL PENDAPATAN INVENTARIS",
            };
            Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data));
          } else {
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi": DateFormat('y-MM-dd').format(DateTime.now()),
              "tgl_valuta": transaksiPendModel!.tglValuta,
              "batch": users!.batch,
              "trx_type": "TRX",
              "trx_code": transaksiPendModel!.trxCode,
              "otor": "0",
              "kode_trn": "",
              "nama_dr": transaksiPendModel!.namaCr,
              "dracc": transaksiPendModel!.cracc,
              "nama_cr": inqueryGlModeldeb!.namaSbb,
              "cracc": inqueryGlModeldeb!.nosbb,
              "rrn": invoice,
              "no_dokumen": transaksiPendModel!.noDokumen,
              "no_ref": transaksiPendModel!.noRef,
              "nominal": nilaijual.text.replaceAll(",", ""),
              "keterangan": keteranganTrans.text,
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
              "status": "COMPLETED",
              "modul": "JUAL PENDAPATAN INVENTARIS",
            };
            Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data));
          }

          getInventaris();
          dialog = false;
          currentStep = 0;
          clear();
          informationDialog(context, "Information", value['message']);
          notifyListeners();
        } else {
          informationDialog(context, "Warning", value['message']);
        }
      });
    } else {
      DialogCustom().showLoading(context);
      var jenisPenempatan = inventarisModel!.nik != '' ? "Karyawan" : "Kantor";
      var format = DateFormat('MMMM y');
      var rrn = DateTime.now().millisecondsSinceEpoch.toString();
      DateTime parseDate = format.parse(inventarisModel!.blnMulaiSusut);
      var data = {
        "kode_pt": users!.kodePt,
        "kdaset": inventarisModel!.kdaset,
        "kode_induk": users!.kodeInduk,
        "jenis_penempatan": jenisPenempatan,
        "nama_kantor": kantor!.namaKantor,
        "kode_kantor": users!.kodeKantor,
        "userinput": users!.namauser,
        "userterm": "114.80.90.54",
        "nilai_jual": nilaijual.text.replaceAll(",", ""),
        "tgl_jual": DateFormat('y-MM-dd').format(tanggalJual!),
        "alasan_jual": "$rrn ${alasanjualhapus.text.trim()}",
        "bln_susut": DateFormat('y-MM-dd').format(parseDate),
        "tgl_valuta": inventarisTransaksiModel!.tanggalValuta,
        "nomor_dok": inventarisTransaksiModel!.noDokumenPembelian,
        "keterangan_transaksi": inventarisTransaksiModel!.keteranganTransaksi,
        "habeli": inventarisTransaksiModel!.nilaiBuku,
        "persentase_penyusutan": nilaiPenyusutan.text.replaceAll(",", ""),
        "metode_penyusutan": metode.toString(),
      };
      print("Data Payload ${jsonEncode(data)}");
      Setuprepository.setup(token, NetworkURL.hapusaset(), jsonEncode(data)).then((value) {
        Navigator.pop(context);
        if (value['status'].toString().toLowerCase().contains("success")) {
          if (double.parse(users!.maksimalTransaksi) < double.parse(inventarisModel!.habeli)) {
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi": DateFormat('y-MM-dd').format(DateTime.now()),
              "tgl_valuta": inventarisTransaksiModel!.tanggalValuta,
              "batch": users!.batch,
              "trx_type": "TRX",
              "trx_code": "100",
              "otor": "0",
              "kode_trn": "",
              "nama_dr": inventarisModel!.sbbAset.toString().substring(14, inventarisModel!.sbbAset.toString().length),
              "dracc": inventarisModel!.sbbAset.toString().substring(1, 13),
              "nama_cr": inventarisModel!.sbbPenyusutan.toString().substring(14, inventarisModel!.sbbPenyusutan.toString().length),
              "cracc": inventarisModel!.sbbPenyusutan.toString().substring(1, 13),
              "rrn": invoice,
              "no_dokumen": inventarisTransaksiModel!.noDokumenPembelian,
              "no_ref": rrn,
              "nominal": inventarisModel!.habeli,
              "keterangan": inventarisTransaksiModel!.keteranganTransaksi,
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
              "modul": "HAPUS INVENTARIS",
            };
            Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data));
          } else {
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi": DateFormat('y-MM-dd').format(DateTime.now()),
              "tgl_valuta": transaksiPendModel!.tglValuta,
              "batch": users!.batch,
              "trx_type": "TRX",
              "trx_code": transaksiPendModel!.trxCode,
              "otor": "0",
              "kode_trn": "",
              "nama_dr": inventarisModel!.sbbAset.toString().substring(14, inventarisModel!.sbbAset.toString().length),
              "dracc": inventarisModel!.sbbAset.toString().substring(1, 13),
              "nama_cr": inventarisModel!.sbbPenyusutan.toString().substring(14, inventarisModel!.sbbPenyusutan.toString().length),
              "cracc": inventarisModel!.sbbPenyusutan.toString().substring(1, 13),
              "rrn": invoice,
              "no_dokumen": transaksiPendModel!.noDokumen,
              "no_ref": transaksiPendModel!.noRef,
              "nominal": inventarisModel!.habeli,
              "keterangan": keteranganTrans.text,
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
              "status": "COMPLETED",
              "modul": "HAPUS INVENTARIS",
            };
            Setuprepository.setup(token, NetworkURL.transaksi(), jsonEncode(data));
          }

          getInventaris();
          dialog = false;
          currentStep = 0;
          clear();
          informationDialog(context, "Information", value['message']);
          notifyListeners();
        } else {
          informationDialog(context, "Warning", value['message']);
        }
      });
    }
  }

  clear() {
    inventarisModel = null;
    karyawanModel = null;
    transaksiPendModel = null;
    namaKaryawan.clear();
    nikKaryawan.clear();
    kdAset.clear();
    noaset.clear();
    nmAset.clear();
    lokasi.clear();
    kota.clear();
    nik.clear();
    noDok.clear();
    kelompok.clear();
    keterangan.clear();
    golongan.clear();
    satuans.clear();
    tglbeli.clear();
    tglterima.clear();
    notifyListeners();
  }

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  TransaksiPendModel? transaksiPendModel;
  pilihTransaksi(TransaksiPendModel value) {
    dialog = false;
    transaksiPendModel = value;
    nilaijual.text = FormatCurrency.oCcy.format(int.parse(transaksiPendModel!.nominal)).replaceAll(".", ",");
    notifyListeners();
  }

  TextEditingController nodok = TextEditingController();
  TextEditingController tglbeli = TextEditingController();
  TextEditingController tgljualhapus = TextEditingController();
  TextEditingController nilaijual = TextEditingController();
  TextEditingController alasanjualhapus = TextEditingController();
  TextEditingController tglterima = TextEditingController();
  TextEditingController hargaBeli = TextEditingController(text: "0");
  TextEditingController hargaBuku = TextEditingController(text: "0");
  TextEditingController discount = TextEditingController(text: "0");
  TextEditingController biaya = TextEditingController(text: "0");
  TextEditingController nilaiPenyusutan = TextEditingController();
  TextEditingController ppn = TextEditingController(text: "0");
  TextEditingController pph = TextEditingController(text: "0");
  int total = 0;
  onChange() {
    total = int.parse(hargaBeli.text.replaceAll(",", "")) - int.parse(discount.text.replaceAll(",", "")) + int.parse(biaya.text.replaceAll(",", ""));
    notifyListeners();
  }

  bool pajak = false;
  gantipajak(bool value) {
    pajak = value;
    notifyListeners();
  }

  List<String> listPilih = [
    "Jual",
    "Hapus"
  ];
  String? pilihModel = "Jual";
  pilihPilih(String value) {
    pilihModel = value;
    notifyListeners();
  }

  List<String> listPenempatan = [
    "Kantor",
    "Karyawan"
  ];
  String? penempatanModel = "Kantor";
  pilihPenempatan(String value) {
    penempatanModel = value;
    notifyListeners();
  }

  String? satuan = "Unit";

  gantiSatuan(String value) {
    satuan = value;
    notifyListeners();
  }

  DateTime? tglTransaksi = DateTime.now();
  Future piihTanggalBeli() async {
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
          int.parse(DateFormat('y').format(DateTime.now())) - 2,
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
      tglTrans.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
      getTransaksi();
      notifyListeners();
    }
  }

  DateTime? tanggalJual;
  Future piihTanggalJualHapus() async {
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
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
                DateTime.now(),
              )) -
              1,
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
      tanggalJual = pickedendDate;
      tgljualhapus.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController blnPenyusutan = TextEditingController();
  DateTime now = DateTime.now();
  showDate() async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Container(
                width: 500,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Pilih Periode",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 100,
                      child: ScrollDatePicker(
                          maximumDate: DateTime(int.parse(DateFormat('y').format(DateTime.now())) + 50),
                          options: const DatePickerOptions(backgroundColor: Colors.white),
                          viewType: const [
                            DatePickerViewType.month,
                            DatePickerViewType.year,
                          ],
                          selectedDate: now,
                          onDateTimeChanged: (e) {
                            setState(() {
                              now = e;
                              blnPenyusutan.text = DateFormat('MMMM y').format(now);
                              notifyListeners();
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        notifyListeners();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          "Simpan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  DateTime? tglTransaksis;
  Future pilihTanggalTerima() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(tglTransaksi!)),
          int.parse(DateFormat('MM').format(
            tglTransaksi!,
          )),
          int.parse(DateFormat('dd').format(
            tglTransaksi!,
          ))),
      firstDate: DateTime(int.parse(DateFormat('y').format(tglTransaksi!)), int.parse(DateFormat('MM').format(tglTransaksi!)), int.parse(DateFormat('dd').format(tglTransaksi!))),
      lastDate: DateTime(int.parse(DateFormat('y').format(DateTime.now())) + 10, int.parse(DateFormat('MM').format(tglTransaksi!)), int.parse(DateFormat('dd').format(tglTransaksi!))),
    ));
    if (pickedendDate != null) {
      tglTransaksis = pickedendDate;
      tglterima.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  List<KaryawanModel> listKaryawan = [];

  Future<List<KaryawanModel>> getInquery(String query) async {
    if (query.isNotEmpty && query.length > 2) {
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

  TextEditingController namaKaryawan = TextEditingController();
  TextEditingController nikKaryawan = TextEditingController();
  KaryawanModel? karyawanModel;
  piliAkunKaryawan(KaryawanModel value) {
    karyawanModel = value;
    namaKaryawan.text = karyawanModel!.namaLengkap;
    nikKaryawan.text = karyawanModel!.nik;
    notifyListeners();
  }

  TextEditingController cariTrans = TextEditingController();
  TextEditingController tglTrans = TextEditingController();
  TextEditingController noDokTrans = TextEditingController();
  TextEditingController nilaiTrans = TextEditingController();
  TextEditingController keteranganTrans = TextEditingController();

  TextEditingController noDok = TextEditingController();
  TextEditingController noaset = TextEditingController();
  TextEditingController namaaset = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  TextEditingController kdAset = TextEditingController();
  TextEditingController nmAset = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController golongan = TextEditingController();
  TextEditingController kelompok = TextEditingController();
  TextEditingController satuans = TextEditingController();

  // List<InventarisModel> list = [];
  InventarisModel? inventarisModel;
  List<InventarisTransaksiModel> listInventarisTranskasi = [];
  InventarisTransaksiModel? inventarisTransaksiModel;
  pilihInventory(InventarisModel value) {
    inventarisModel = value;
    DialogCustom().showLoading(context);
    var data = {
      "kode_pt": inventarisModel!.kodePt,
      "kode_kantor": inventarisModel!.kodeKantor,
      "kode_induk": inventarisModel!.kodeInduk,
      "kode_kelompok": inventarisModel!.kodeKelompok,
      "kode_golongan": inventarisModel!.kodeGolongan,
      "kdaset": inventarisModel!.kdaset,
    };
    Setuprepository.setup(token, NetworkURL.cariInventaris(), jsonEncode(data)).then((values) {
      Navigator.pop(context);
      if (values['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in values['data']) {
          listInventarisTranskasi.add(InventarisTransaksiModel.fromJson(i));
        }
        if (listInventarisTranskasi.isNotEmpty) {
          inventarisTransaksiModel = listInventarisTranskasi[0];
          print("HABELI : ${inventarisModel!.habeli}");
          kdAset.text = inventarisModel!.kdaset;
          noaset.text = inventarisModel!.kdaset;
          nmAset.text = inventarisModel!.namaaset;
          kantor = listKantor.where((e) => e.kodePt == inventarisModel!.kodePt && e.kodeKantor == inventarisModel!.kodeKantor).first;
          lokasi.text = inventarisModel!.lokasi;
          kota.text = inventarisModel!.kota;
          nik.text = inventarisModel!.nik;
          noDok.text = inventarisModel!.nodokBeli;
          kelompok.text = inventarisModel!.namaKelompok;
          // keteranganTrans.text = inventarisModel!.ket;
          keterangan.text = inventarisModel!.ket;
          golongan.text = inventarisModel!.namaGolongan;
          satuans.text = inventarisModel!.satuanAset;
          tglbeli.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(inventarisModel!.tglBeli.toString()));
          tgljualhapus.text = DateFormat("dd-MMM-yyyy").format(DateTime.now());
          tglterima.text = inventarisModel!.tglTerima;
          nilaiTrans.text = FormatCurrency.oCcy.format(int.parse(inventarisModel!.habeli)).replaceAll(".", ",");
          hargaBuku.text = FormatCurrency.oCcy.format(int.parse(inventarisTransaksiModel!.nilaiBuku)).replaceAll(".", ",");
          getTransaksi();
          notifyListeners();
        } else {
          informationDialog(context, "Warning", "Inventaris tidak ditemukan di transaksi");
        }
      }
    });
  }

  bukaTransaksi() {
    dialog = true;
    notifyListeners();
  }
}
