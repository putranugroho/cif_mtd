import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/models/perantara_model.dart';
import 'package:accounting/models_manual/rekon_perantara_item_model.dart';
import 'package:accounting/models_manual/rekon_perantara_model.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../network/network.dart';
import '../../repository/SetupRepository.dart';

class PerantaraAktivaNotifier extends ChangeNotifier {
  final BuildContext context;

  PerantaraAktivaNotifier({required this.context}) {
    getProfile();

    notifyListeners();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getInqueryAll();
      notifyListeners();
    });
  }

  List<Map<String, dynamic>> extractJnsAccBb(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];

    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          if (item['jns_acc'] == 'C' &&
              item['type_posting'] == "Y" &&
              item['akun_perantara'] == "Y") {
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
    var data = {"kode_pt": users!.kodePt};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccBb(value['data']);
        listGlAll =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        print("AKUN PERANTARA ${listGlAll.length}");
        print("AKUN PERANTARA ${jsonEncode(listGlAll)}");
        if (listGlAll.isNotEmpty) {
          getTransaksiAll();
        }
        notifyListeners();
      }
    });
  }

  var isLoadingData = true;
  List<PerantaraModel> listTransaksi = [];
  List<PerantaraModel> listTransaksiAdd = [];
  Future getTransaksi() async {
    isLoadingData = true;
    listTransaksi.clear();
    listTransaksiAdd.clear();
    notifyListeners();
    var data = {
      "kode_pt": users!.kodePt,
      "jenis": jenis,
    };
    Setuprepository.setup(token, NetworkURL.perantara(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksi.add(PerantaraModel.fromJson(i));
        }
        if (listTransaksi.isNotEmpty) {
          listTransaksiAdd = jenis == "AKTIVA"
              ? listTransaksi
                  .where((e) =>
                      e.status == "COMPLETED" &&
                      e.dracc == inqueryGlModelcre!.nosbb)
                  .toList()
              : listTransaksi
                  .where((e) =>
                      e.status == "COMPLETED" &&
                      e.cracc == inqueryGlModelcre!.nosbb)
                  .toList();
          listTransaksiAdd.sort((a, b) => DateTime.parse(b.createddate)
              .compareTo(DateTime.parse(a.createddate)));
        }
        isLoadingData = false;
        notifyListeners();
      } else {
        isLoadingData = false;
        notifyListeners();
      }
    });
  }

  var isLoading = true;
  List<PerantaraModel> listTransaksiAll = [];
  List<PerantaraModel> listTransaksiAllAdd = [];
  Future getTransaksiAll() async {
    isLoadingData = true;
    listTransaksiAll.clear();
    listTransaksiAllAdd.clear();
    notifyListeners();
    var data = {
      "kode_pt": users!.kodePt,
      "jenis": jenis,
    };
    Setuprepository.setup(token, NetworkURL.perantara(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksiAll.add(PerantaraModel.fromJson(i));
        }
        if (listTransaksiAll.isNotEmpty) {
          if (jenis == "AKTIVA") {
            for (var i = 0; i < listGlAll.length; i++) {
              var matched = listTransaksiAll
                  .where(
                    (e) =>
                        e.status == "COMPLETED" &&
                        e.dracc == listGlAll[i].nosbb,
                  )
                  .toList();
              if (matched.isNotEmpty) {
                listTransaksiAllAdd.addAll(matched);
                print("RESULT : ${listTransaksiAllAdd.length}");
                print("RESULT JSON : ${jsonEncode(listTransaksiAllAdd)}");
              }
            }
          } else {
            for (var i = 0; i < listGlAll.length; i++) {
              var matched = listTransaksiAll
                  .where(
                    (e) =>
                        e.status == "COMPLETED" &&
                        e.cracc == listGlAll[i].nosbb,
                  )
                  .toList();
              if (matched.isNotEmpty) {
                listTransaksiAllAdd.addAll(matched);
                print("RESULT : ${listTransaksiAllAdd.length}");
                print("RESULT JSON : ${jsonEncode(listTransaksiAllAdd)}");
              }
            }
          }
          // for (var bb in value['data']) {
          //   for (var sbb in bb['sbb_item']) {
          //     double saldoAwal = sbb['saldo'] ?? 0.0;
          //     List transaksi = sbb['item_transaksi'];

          //     for (var trx in transaksi) {
          //       double nominal = trx['nominal'] ?? 0.0;
          //       saldoAwal -= nominal;

          //       trx['sisaSaldo'] = saldoAwal;
          //     }
          //   }
          // }

          // listTransaksiAllAdd.sort((a, b) => DateTime.parse(b.createddate)
          //     .compareTo(DateTime.parse(a.createddate)));
          listTransaksiAllAdd.sort((a, b) {
            final craccCompare = b.cracc.compareTo(a.cracc); // descending
            if (craccCompare != 0) return craccCompare;

            // Jika cracc sama, bandingkan createddate secara descending
            return DateTime.parse(b.createddate)
                .compareTo(DateTime.parse(a.createddate));
          });
        }
        isLoadingData = false;
        notifyListeners();
      } else {
        isLoadingData = false;
        notifyListeners();
      }
    });
  }

  cari() {
    dialogtrans = true;
    getTransaksi();
    notifyListeners();
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

  PerantaraModel? transaksiPendModel;
  pilihTransaksi(String value) {
    transaksiPendModel = listTransaksiAdd.where((e) => e.rrn == value).first;
    dialogtrans = false;
    dialog = true;
    // nomorRef.text = transaksiPendModel!.noRef;
    nomorDok.text = transaksiPendModel!.noDokumen;
    keterangan.text = transaksiPendModel!.keterangan;
    namaSbbAset.text = transaksiPendModel!.cracc;
    sisaSaldo.text =
        "Rp ${FormatCurrency.oCcyDecimal.format(transaksiPendModel!.sisaSaldo)}";
    namaSbbDebit.text = transaksiPendModel!.namaCr;
    tglBackDatetext.text = transaksiPendModel!.tglValuta;
    notifyListeners();
  }

  tutupTransaksi() {
    dialogtrans = false;
    notifyListeners();
  }

  InqueryGlModel? inqueryGlModelcre;
  InqueryGlModel? inqueryGlModelcreTrans;
  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
  TextEditingController nosbbdeb = TextEditingController();
  TextEditingController nossbcre = TextEditingController();
  TextEditingController nossbcretrans = TextEditingController();
  TextEditingController namaSbbCreTrans = TextEditingController();
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

  pilihAkunCre(InqueryGlModel value) {
    inqueryGlModelcre = value;
    nossbcre.text = value.namaSbb;
    namaSbbCre.text = value.nosbb;
    getTransaksi();
    notifyListeners();
  }

  pilihAkunCreTrans(InqueryGlModel value) {
    inqueryGlModelcreTrans = value;
    nossbcretrans.text = value.namaSbb;
    namaSbbCreTrans.text = value.nosbb;

    notifyListeners();
  }

  List<String> listJenis = [];
  String? jenis = "AKTIVA";
  gantijenis(String value) {
    jenis = value;

    getTransaksiAll();
    notifyListeners();
  }

  var dialog = false;

  tambah(PerantaraModel value) {
    transaksiPendModel = value;
    dialogtrans = false;
    dialog = true;
    // nomorRef.text = transaksiPendModel!.noRef;
    nomorDok.text = transaksiPendModel!.noDokumen;
    keterangan.text = transaksiPendModel!.keterangan;
    namaSbbAset.text = transaksiPendModel!.cracc;
    sisaSaldo.text =
        "Rp ${FormatCurrency.oCcyDecimal.format(transaksiPendModel!.sisaSaldo)}";
    namaSbbDebit.text = transaksiPendModel!.namaCr;
    tglBackDatetext.text = transaksiPendModel!.tglValuta;

    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController namaSbbDebit = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController keteranganTrans = TextEditingController();
  TextEditingController namaSbbKredit = TextEditingController();
  TextEditingController nomorRef = TextEditingController();
  TextEditingController namaSbbAset = TextEditingController();
  TextEditingController namaTransaksi = TextEditingController();
  TextEditingController sisaSaldo = TextEditingController();
  TextEditingController sisaPembayaran = TextEditingController();
  CoaModel? sbbAset;
  pilihSbbAset(CoaModel value) {
    sbbAset = value;
    namaSbbAset.text = value.nosbb;
    notifyListeners();
  }

  bool backDate = false;
  gantibackDate() {
    backDate = !backDate;
    notifyListeners();
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

  TextEditingController tglBackDatetext = TextEditingController();

  final keyForm = GlobalKey<FormState>();
  cek() async {
    if (keyForm.currentState!.validate()) {
      if (users!.limitAkses == "Y") {
        if (transaksiPendModel!.sisaSaldo <
            double.parse(nominal.text
                .replaceAll("Rp ", "")
                .replaceAll(".", "")
                .replaceAll(",", "."))) {
          informationDialog(context, "Warning",
              "Sisa saldo hanya Rp. ${FormatCurrency.oCcyDecimal.format(transaksiPendModel!.sisaSaldo)}");
        } else {
          if (double.parse(users!.maksimalTransaksi) <
              double.parse(nominal.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", "")
                  .replaceAll(",", "."))) {
            DialogCustom().showLoading(context);
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi": DateFormat('y-MM-dd').format(DateTime.now()),
              "tgl_valuta": tglBackDatetext.text,
              "batch": users!.batch,
              "trx_type": "TRX",
              "trx_code":
                  DateTime.parse(tglBackDatetext.text).isBefore(DateTime.now())
                      ? "110"
                      : "100",
              "otor": "0",
              "kode_trn": "",
              "nama_dr": namaSbbDebit.text,
              "dracc": namaSbbAset.text,
              "nama_cr": nossbcretrans.text,
              "cracc": namaSbbCreTrans.text,
              "rrn": invoice,
              "no_dokumen": nomorDok.text,
              "no_ref": nomorRef.text,
              "nominal": double.parse(nominal.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", "")
                  .replaceAll(",", ".")),
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
              "inputtgljam":
                  DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now()),
              "otoruser": "",
              "otorterm": "",
              "otortgljam": "",
              "flag_trn": "1",
              "merchant": "",
              "source_trx": "",
              "status": "PENDING",
              "modul": "PERANTARA",
            };
            Setuprepository.setup(
                    token, NetworkURL.transaksi(), jsonEncode(data))
                .then((value) {
              Navigator.pop(context);
              if (value['status'] == "success") {
                getTransaksiAll();
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
              "tgl_valuta": tglBackDatetext.text,
              "batch": users!.batch,
              "trx_type": "TRX",
              "trx_code":
                  DateTime.parse(tglBackDatetext.text).isBefore(DateTime.now())
                      ? "110"
                      : "100",
              "otor": "0",
              "kode_trn": "",
              "nama_dr": namaSbbDebit.text,
              "dracc": namaSbbAset.text,
              "nama_cr": nossbcretrans.text,
              "cracc": namaSbbCreTrans.text,
              "rrn": invoice,
              "no_dokumen": nomorDok.text,
              "no_ref": nomorRef.text,
              "nominal": double.parse(nominal.text
                  .replaceAll("Rp ", "")
                  .replaceAll(".", "")
                  .replaceAll(",", ".")),
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
              "inputtgljam":
                  DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now()),
              "otoruser": "",
              "otorterm": "",
              "otortgljam": "",
              "flag_trn": "1",
              "merchant": "",
              "source_trx": "",
              "status": "COMPLETED",
              "modul": "PERANTARA",
            };
            Setuprepository.setup(
                    token, NetworkURL.transaksi(), jsonEncode(data))
                .then((value) {
              Navigator.pop(context);
              if (value['status'] == "success") {
                getTransaksiAll();
                clear();
                informationDialog(context, "Information", value['message']);
              } else {
                informationDialog(context, "Warning", value['message']);
              }
            });
          }
        }
      } else {
        informationDialog(context, "Warning", "Tidak bisa melakukan transaksi");
      }
    }
  }

  clear() {
    dialogtrans = false;
    dialog = false;
    nomorRef.clear();
    nominal.clear();
    keteranganTrans.clear();
    namaSbbDebit.clear();
    namaSbbAset.clear();
    nossbcretrans.clear();
    namaSbbCreTrans.clear();
    notifyListeners();
  }

  var dialogtrans = false;

  TextEditingController masasusut = TextEditingController();
  TextEditingController namaSbbpenyusutan = TextEditingController();
  CoaModel? sbbpenyusutan;
  pilihSbbpenyusutan(CoaModel value) {
    sbbpenyusutan = value;
    namaSbbpenyusutan.text = value.nosbb;
    notifyListeners();
  }

  List<CoaModel> listCoa = [];
  List<Map<String, dynamic>> coa = [
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "0190301",
      "nama_sbb": "Biaya Dibayar dimuka - Sewa Gedung",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "0190304",
      "nama_sbb": "Biaya Dibayar dimuka - Lainnya",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
  ];

  List<CoaModel> listCoaDebet = [];
  List<Map<String, dynamic>> coaDebet = [
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "0110101",
      "nama_sbb": "Kas Kantor",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "0130103",
      "nama_sbb": "Giro Bank Mandiri",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "0130109",
      "nama_sbb": "Giro Bank BNI",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "0130111",
      "nama_sbb": "Giro Bank BSI",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "0130231",
      "nama_sbb": "DEP. Bank BNI",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
  ];

  int totalActive = 0;
  int totalMacet = 0;
  List<RekonPerantaraModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "nobb": "400000000001",
      "nama_bb": "RRA - BEBAN DIBAYAR DIMUKA",
      "type_posting": "AKTIVA",
      "sbb_item": [
        {
          "nosbb": "0190301",
          "nama_sbb": "Biaya Dibayar dimuka - Sewa Gedung",
          "type_posting": "Gdng. Graha Muncul Mekar",
          "saldo": 640000.00,
          "item_transaksi": [
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449491",
              "debet_acc": "0190301",
              "nama_debet": "Biaya Dibayar dimuka - Sewa Gedung",
              "credit_acc": "0130109",
              "nama_credit": "Giro Bank BNI",
              "nomor_dok": "",
              "nomor_ref": "89029898449491",
              "nominal": 320000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449492",
              "debet_acc": "0190301",
              "nama_debet": "Biaya Dibayar dimuka - Sewa Gedung",
              "credit_acc": "0130109",
              "nama_credit": "Giro Bank BNI",
              "nomor_dok": "",
              "nomor_ref": "89029898449492",
              "nominal": 150000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            }
          ],
        },
        {
          "nosbb": "0190304",
          "nama_sbb": "Biaya Dibayar dimuka - Lainnya",
          "type_posting": "",
          "saldo": 850000.00,
          "item_transaksi": [
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449492",
              "debet_acc": "0190304",
              "nama_debet": "Biaya Dibayar dimuka - Lainnya",
              "credit_acc": "0130109",
              "nama_credit": "Giro Bank BNI",
              "nomor_dok": "",
              "nomor_ref": "89029898449492",
              "nominal": 150000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
          ],
        },
        // {
        //   "nosbb": "0190315",
        //   "nama_sbb": "Uang Muka Pajak",
        //   "type_posting": "",
        //   "saldo": 215449.36,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190319",
        //   "nama_sbb": "Biaya Dibayar Dimuka - OJK",
        //   "type_posting": "",
        //   "saldo": 40027.64,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190321",
        //   "nama_sbb": "BDD LAINNYA 3",
        //   "type_posting": "",
        //   "saldo": 94540.00,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190322",
        //   "nama_sbb": "DEPOSIT INVELLI",
        //   "type_posting": "",
        //   "saldo": 264.63,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190323",
        //   "nama_sbb": "DEPOSIT MTD",
        //   "type_posting": "",
        //   "saldo": 10000.00,
        //   "item_transaksi": [],
        // }
      ]
    },
  ];

  List<RekonPerantaraModel> listPasive = [];
  List<Map<String, dynamic>> dataPasiva = [
    {
      "nobb": "100000000001",
      "nama_bb": "RRP - LAINNYA",
      "type_posting": "PASIVA",
      "sbb_item": [
        {
          "nosbb": "0290901",
          "nama_sbb": "Cadangan Dana Pendidikan",
          "type_posting": "Training CCNA",
          "saldo": 750000.00,
          "item_transaksi": [
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449491",
              "debet_acc": "0290901",
              "nama_debet": "Cadangan Dana Pendidikan",
              "credit_acc": "0110101",
              "nama_credit": "Kas Kantor",
              "nomor_dok": "",
              "nomor_ref": "89029898449491",
              "nominal": 320000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449491",
              "debet_acc": "0290901",
              "nama_debet": "Cadangan Dana Pendidikan",
              "credit_acc": "0110101",
              "nama_credit": "Kas Kantor",
              "nomor_dok": "",
              "nomor_ref": "89029898449491",
              "nominal": 230000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
          ],
        },
      ]
    },
  ];
}
