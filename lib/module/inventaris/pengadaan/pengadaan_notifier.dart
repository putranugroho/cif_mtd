import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/utils/colors.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';
import '../../../utils/format_currency.dart';
import '../../../utils/informationdialog.dart';

class PengadaanNotifier extends ChangeNotifier {
  final BuildContext context;

  PengadaanNotifier({required this.context}) {
    getProfile();
    notifyListeners();
  }
  SetupPajakModel? setupPajakModel;
  List<SetupPajakModel> listPajak = [];

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getKelompokAset();
      getMetodePenyusutan();
      getGolonganAset();
      getKantor();
      getSetupPajak();
      getInventaris();

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
    var data = {"kode_pt": "${users!.kodePt}"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccBb(value['data']);
        listGlAll =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        print("GL : ${jsonEncode(listGlAll)}");
        getTransaksi();
        notifyListeners();
      }
    });
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

  List<KantorModel> listKantor = [];
  Future getKantor() async {
    listKantor.clear();

    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.getKantor(token, NetworkURL.getKantor(), jsonEncode(data))
        .then((value) {
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

  KantorModel? kantor;

  List<GolonganAsetModel> listGolongan = [];
  Future getGolonganAset() async {
    isLoading = true;
    listGolongan.clear();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getGolonganAset(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listGolongan.add(GolonganAsetModel.fromJson(i));
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
  List<KelompokAsetModel> listKelompok = [];
  Future getKelompokAset() async {
    isLoading = true;
    listKelompok.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getKelompokAset(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listKelompok.add(KelompokAsetModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        // informationDialog(context, "Warning", value['message'][0]);

        isLoading = false;
        notifyListeners();
      }
    });
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
      "kode_pt": "${users!.kodePt}",
    };
    Setuprepository.setup(token, NetworkURL.view(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksi.add(TransaksiPendModel.fromJson(i));
        }
        if (listTransaksi.isNotEmpty) {
          for (var i = 0; i < listGlAll.length; i++) {
            if (noDokTrans.text.isNotEmpty) {
              listTransaksiAdd.addAll(listTransaksi
                  .where((e) =>
                      (e.dracc == listGlAll[i].nosbb) &&
                      e.status == "COMPLETED" &&
                      e.noDokumen == noDokTrans.text.trim() &&
                      e.tglValuta == DateFormat('y-MM-dd').format(tglValuta))
                  .toList());
            } else {
              listTransaksiAdd.addAll(listTransaksi
                  .where((e) =>
                      (e.dracc == listGlAll[i].nosbb) &&
                      e.status == "COMPLETED" &&
                      e.tglValuta == DateFormat('y-MM-dd').format(tglValuta))
                  .toList());
            }
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

  TransaksiPendModel? transaksiPendModel;
  pilihTransaksi(TransaksiPendModel value) async {
    transaksiPendModel = value;
    noDok.text = transaksiPendModel!.noDokumen;
    noRef.text = transaksiPendModel!.noRef;
    nilaiTrans.text =
        FormatCurrency.oCcy.format(int.parse(transaksiPendModel!.nominal));
    keteranganTrans.text = transaksiPendModel!.keterangan;
    dialog = true;
    dialogTransaksi = false;
    notifyListeners();
  }

  int metode = 0;

  List<MetodePenyusutanModel> listPenyusutan = [];
  MetodePenyusutanModel? metodePenyusutanModel;
  Future getMetodePenyusutan() async {
    isLoading = true;
    listPenyusutan.clear();
    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.setup(
            token, NetworkURL.getMetodePenyusutan(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listPenyusutan.add(MetodePenyusutanModel.fromJson(i));
        }
        metodePenyusutanModel = listPenyusutan[0];
        metode = int.parse(metodePenyusutanModel!.metodePenyusutan);
        nilaiPenyusutan.text = metodePenyusutanModel!.nilaiAkhir.toString();

        // nilai.text = metodePenyusutanModel!.declining.toString();
        print(metode);
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

  int currentStep = 0;
  void onStepContinue() {
    if ((currentStep + 1) <= formStep.length) {
      if (formStep[currentStep].currentState!.validate()) {
        goToNextStep();
      }
    }
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

  Future<List<KaryawanModel>> getInquery(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      listKaryawan.clear();
      notifyListeners();
      var data = {"nama": query};
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

  final List<GlobalKey<FormState>> formStep = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  bool dialog = false;
  tambah() {
    clear();
    currentStep = 0;
    dialog = true;
    editData = false;
    penempatanModel = "Kantor";
    kelompokAsetModel = null;
    golonganAsetModel = null;
    nodok.clear();
    noaset.clear();
    namaaset.clear();
    keterangan.clear();
    noDok.clear();
    tglbeli.clear();
    tglterima.clear();
    hargaBeli.text = "0";
    discount.text = "0";
    biaya.text = "0";
    nilaiPenyusutan.text = metodePenyusutanModel!.nilaiAkhir.toString();
    ppn.text = "0";
    pph.text = "0";
    subtotal = 0;
    total = 0;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  var dialogTransaksi = false;

  bukaTransaksi() {
    getTransaksi().then((value) {
      dialogTransaksi = true;
      dialog = false;
      notifyListeners();
    });
  }

  tutupDialogTransaksi() {
    dialogTransaksi = false;
    dialog = true;
    notifyListeners();
  }

  TextEditingController nodok = TextEditingController();
  TextEditingController tglbeli = TextEditingController();
  TextEditingController tglterima = TextEditingController();
  TextEditingController hargaBeli = TextEditingController(text: "0");
  TextEditingController discount = TextEditingController(text: "0");
  TextEditingController biaya = TextEditingController(text: "0");
  TextEditingController nilaiPenyusutan = TextEditingController();
  TextEditingController ppn = TextEditingController(text: "0");
  TextEditingController pph = TextEditingController(text: "0");
  int total = 0;
  onChange() {
    if (pajak) {
      subtotal = int.parse(hargaBeli.text.replaceAll(",", "")) -
          int.parse(discount.text.replaceAll(",", "")) +
          int.parse(biaya.text.replaceAll(",", ""));
      total = (subtotal + int.parse(ppn.text.replaceAll(",", ""))) -
          int.parse(pph.text.replaceAll(",", ""));
    } else {
      subtotal = int.parse(hargaBeli.text.replaceAll(",", "")) -
          int.parse(discount.text.replaceAll(",", "")) +
          int.parse(biaya.text.replaceAll(",", ""));
      total = int.parse(hargaBeli.text.replaceAll(",", "")) -
          int.parse(discount.text.replaceAll(",", "")) +
          int.parse(biaya.text.replaceAll(",", ""));
    }

    notifyListeners();
  }

  bool pajak = false;
  int subtotal = 0;
  gantipajak(bool value) {
    pajak = value;
    if (pajak) {
      ppn.text = (((int.parse(hargaBeli.text.replaceAll(",", "")) -
                      int.parse(discount.text.replaceAll(",", "")) +
                      int.parse(biaya.text.replaceAll(",", ""))) *
                  double.parse(setupPajakModel!.ppn)) /
              100)
          .toInt()
          .toString();
      pph.text = (((int.parse(hargaBeli.text.replaceAll(",", "")) -
                      int.parse(discount.text.replaceAll(",", "")) +
                      int.parse(biaya.text.replaceAll(",", ""))) *
                  double.parse(setupPajakModel!.pph23)) /
              100)
          .toInt()
          .toString();
      subtotal = int.parse(hargaBeli.text.replaceAll(",", "")) -
          int.parse(discount.text.replaceAll(",", "")) +
          int.parse(biaya.text.replaceAll(",", ""));
      total = (int.parse(hargaBeli.text.replaceAll(",", "")) -
              int.parse(discount.text.replaceAll(",", "")) +
              int.parse(biaya.text.replaceAll(",", "")) +
              (int.parse(ppn.text.replaceAll(",", "")))) -
          int.parse(pph.text.replaceAll(",", ""));
      notifyListeners();
    } else {
      ppn.text = "0";
      pph.text = "0";
      total = int.parse(hargaBeli.text.replaceAll(",", "")) -
          int.parse(discount.text.replaceAll(",", "")) +
          int.parse(biaya.text.replaceAll(",", ""));
    }
    notifyListeners();
  }

  String? satuan = "Unit";

  gantiSatuan(String value) {
    satuan = value;
    notifyListeners();
  }

  // List<KelompokAsetModel> listKelompok = [];
  KelompokAsetModel? kelompokAsetModel;
  pilihKelompok(KelompokAsetModel value) {
    kelompokAsetModel = value;
    notifyListeners();
  }

  List<String> listPenempatan = ["Kantor", "Karyawan"];
  String? penempatanModel = "Kantor";
  pilihPenempatan(String value) {
    penempatanModel = value;
    notifyListeners();
  }

  List<String> listSatuan = ["Pcs", "Unit", "Set"];
  String? satuanModel = "Pcs";
  pilihSatuan(String value) {
    satuanModel = value;
    notifyListeners();
  }

  // List<GolonganAsetModel> listGolongan = [];
  GolonganAsetModel? golonganAsetModel;
  pilihGolongan(GolonganAsetModel value) {
    golonganAsetModel = value;

    notifyListeners();
  }

  DateTime? tglBuka = DateTime.now();

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
      tglTransaksi = pickedendDate;
      tglbeli.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  DateTime tglValuta = DateTime.now();
  Future pilihTanggalValuta() async {
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
      tglValuta = pickedendDate;
      tglTrans.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  DateTime? tglTransaksi;
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
              )) -
              1),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
                DateTime.now(),
              )) -
              1),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) - 10,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
    ));
    if (pickedendDate != null) {
      tglTransaksi = pickedendDate;
      tglbeli.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController masasusut = TextEditingController();
  cek() {
    if (editData) {
      DialogCustom().showLoading(context);

      var data = {
        "id": inventarisModel!.id,
        "kdaset": noaset.text,
        "namaaset": namaaset.text,
        "ket": keterangan.text,
        "kode_kelompok": kelompokAsetModel!.kodeKelompok,
        "nama_kelompok": kelompokAsetModel!.namaKelompokn,
        "kode_golongan": golonganAsetModel!.kodeGolongan,
        "nama_golongan": golonganAsetModel!.namaGolongan,
        "nodok_beli": noDok.text,
        "tgl_beli": DateFormat('y-MM-dd').format(tglTransaksi!),
        "tgl_terima": DateFormat('y-MM-dd').format(tglTransaksis!),
        "habeli": hargaBeli.text.replaceAll(",", ""),
        "disc": discount.text.replaceAll(",", ""),
        "biaya": biaya.text.replaceAll(",", ""),
        "haper": subtotal,
        "nilai_residu": nilaiPenyusutan.text.replaceAll(",", ""),
        "ppn_beli": ppn.text.replaceAll(",", ""),
        "pph": pph.text.replaceAll(",", ""),
        "tgl_jual": "",
        "nodok_jual": "",
        "hajual": "",
        "ppn_jual": "",
        "margin": "",
        "tgl_revaluasi": "",
        "pic_revaluasi": "",
        "nilai_buku": "0",
        "total_susut": "0",
        "susut_ke": "0",
        "kode_pt": kantor!.kodePt,
        "kode_kantor": kantor!.kodeKantor,
        "kode_induk": kantor!.kodeInduk,
        "lokasi": lokasi.text.trim(),
        "kota": kota.text,
        "masasusut": masasusut.text,
        "bln_mulai_susut": blnPenyusutan.text,
        "kdkondisi": "",
        "kondisi": "",
        "satuan_aset": satuan!,
        "nilai_declining": nilaiPenyusutan.text.replaceAll(",", ""),
        "perbaikan": "",
        "stsasr": 'N',
        "nopolis": "",
        "nilai_revaluasi": "",
        "nik": "${karyawanModel == null ? "" : karyawanModel!.nik}",
        "nama_pejabat":
            "${karyawanModel == null ? "" : karyawanModel!.namaLengkap}",
        "sbb_aset": golonganAsetModel!.sbbAset,
        "sbb_penyusutan": golonganAsetModel!.sbbPenyusutan,
        "sbb_biaya_penyusutan": golonganAsetModel!.sbbBiayaPenyusutan,
        "sbb_rugi_revaluasi": golonganAsetModel!.sbbRugiRevaluasi,
        "sbb_laba_revaluasi": golonganAsetModel!.sbbLabaRevaluasi,
        "sbb_rugi_jual": golonganAsetModel!.sbbRugiJual,
        "sbb_laba_jual": golonganAsetModel!.sbbLabaJual,
        "sbb_ppn": golonganAsetModel!.sbbPpn,
        "sbb_pph": golonganAsetModel!.sbbPph,
        "sbb_biaya_perbaikan": golonganAsetModel!.sbbBiayaPerbaikan,
      };
      Setuprepository.setup(
              token, NetworkURL.editInventaris(), jsonEncode(data))
          .then((value) {
        Navigator.pop(context);
        if (value['status'].toString().toLowerCase().contains("success")) {
          clear();
          dialog = false;
          informationDialog(context, "Information", value['message']);
          notifyListeners();
        } else {
          informationDialog(context, "Warning", value['message']);
        }
      });
    } else {
      DialogCustom().showLoading(context);

      var data = {
        "kdaset": noaset.text,
        "kode_pt": kantor!.kodePt,
        "kode_kantor": kantor!.kodeKantor,
        "kode_induk": kantor!.kodeInduk,
        "userinput": users!.namauser,
        "userterm": "114.80.90.54",
        "ket": keterangan.text,
        "namaaset": namaaset.text,
        "kode_kelompok": kelompokAsetModel!.kodeKelompok,
        "nama_kelompok": kelompokAsetModel!.namaKelompokn,
        "kode_golongan": golonganAsetModel!.kodeGolongan,
        "nama_golongan": golonganAsetModel!.namaGolongan,
        "nodok_beli": noDok.text,
        "nodok_transaksi": noDok.text,
        "tgl_beli": DateFormat('y-MM-dd').format(tglTransaksi!),
        "tgl_terima": DateFormat('y-MM-dd').format(tglTransaksis!),
        "habeli": hargaBeli.text.replaceAll(",", ""),
        "disc": discount.text.replaceAll(",", ""),
        "biaya": biaya.text.replaceAll(",", ""),
        "haper": subtotal,
        "nilai_residu": nilaiPenyusutan.text.replaceAll(",", ""),
        "ppn_beli": ppn.text.replaceAll(",", ""),
        "pph": pph.text.replaceAll(",", ""),
        "tgl_jual": "",
        "pajak": pajak ? "Y" : "N",
        "nodok_jual": "",
        "hajual": "",
        "ppn_jual": "",
        "margin": "",
        "tgl_revaluasi": "",
        "pic_revaluasi": "",
        "tgl_valuta": "${transaksiPendModel!.tglValuta}",
        "nilai_buku": "0",
        "total_susut": "0",
        "susut_ke": "0",
        "nama_kantor": kantor!.namaKantor,
        "lokasi": lokasi.text.trim(),
        "kota": kota.text,
        "masasusut": masasusut.text,
        "keterangan_transaksi": keteranganTrans.text,
        "jenis_penempatan": penempatanModel,
        "metode_penyusutan": metodePenyusutanModel!.metodePenyusutan,
        "bln_mulai_susut": blnPenyusutan.text,
        "persentase_penyusutan": metodePenyusutanModel!.declining,
        "bln_susut": DateFormat("y-MM").format(now),
        "kdkondisi": "",
        "kondisi": "",
        "satuan_aset": satuan!,
        "nilai_declining": nilaiPenyusutan.text.replaceAll(",", ""),
        "perbaikan": "",
        "stsasr": 'N',
        "nopolis": "",
        "nilai_revaluasi": "",
        "nik": "${karyawanModel == null ? "" : karyawanModel!.nik}",
        "nama_pejabat":
            "${karyawanModel == null ? "" : karyawanModel!.namaLengkap}",
        "sbb_aset": golonganAsetModel!.sbbAset,
        "sbb_penyusutan": golonganAsetModel!.sbbPenyusutan,
        "sbb_biaya_penyusutan": golonganAsetModel!.sbbBiayaPenyusutan,
        "sbb_rugi_revaluasi": golonganAsetModel!.sbbRugiRevaluasi,
        "sbb_laba_revaluasi": golonganAsetModel!.sbbLabaRevaluasi,
        "sbb_rugi_jual": golonganAsetModel!.sbbRugiJual,
        "sbb_laba_jual": golonganAsetModel!.sbbLabaJual,
        "sbb_biaya_perbaikan": golonganAsetModel!.sbbBiayaPerbaikan,
        "sbb_ppn": golonganAsetModel!.sbbPpn,
        "sbb_pph": golonganAsetModel!.sbbPph,
        "sbb_aset_data": golonganAsetModel!.sbbAset.toString().substring(1, 13),
        "sbb_penyusutan_data":
            golonganAsetModel!.sbbPenyusutan.toString().substring(1, 13),
      };
      Setuprepository.setup(token, NetworkURL.addInventaris(), jsonEncode(data))
          .then((value) {
        Navigator.pop(context);
        if (value['status'].toString().toLowerCase().contains("success")) {
          if (pajak) {
            if (double.parse(ppn.text.replaceAll(",", "")) < total) {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta": "${transaksiPendModel!.tglValuta}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code": "${transaksiPendModel!.trxCode}",
                "otor": "0",
                "kode_trn": "",
                "nama_dr":
                    "${golonganAsetModel!.sbbPpn.toString().substring(14, golonganAsetModel!.sbbPpn.toString().length)}",
                "dracc":
                    "${golonganAsetModel!.sbbPpn.toString().substring(1, 13)}",
                "nama_cr": "${transaksiPendModel!.namaDr}",
                "cracc": "${transaksiPendModel!.dracc}",
                "rrn": "$invoice",
                "no_dokumen": "${transaksiPendModel!.noDokumen}",
                "no_ref": "${transaksiPendModel!.noRef}",
                "nominal": double.parse(ppn.text.replaceAll(",", "")),
                "keterangan": "${keteranganTrans.text}",
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
                "modul": "PAJAK PENGADAAN INVENTARIS",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            } else {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta": "${transaksiPendModel!.tglValuta}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code": "${transaksiPendModel!.trxCode}",
                "otor": "0",
                "kode_trn": "",
                "nama_dr":
                    "${golonganAsetModel!.sbbPpn.toString().substring(14, golonganAsetModel!.sbbPpn.toString().length)}",
                "dracc":
                    "${golonganAsetModel!.sbbPpn.toString().substring(1, 13)}",
                "nama_cr": "${transaksiPendModel!.namaDr}",
                "cracc": "${transaksiPendModel!.dracc}",
                "rrn": "$invoice",
                "no_dokumen": "${transaksiPendModel!.noDokumen}",
                "no_ref": "${transaksiPendModel!.noRef}",
                "nominal": subtotal,
                "keterangan": "${keteranganTrans.text}",
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
                "status": "COMPLETED",
                "modul": "PAJAK PENGADAAN INVENTARIS",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            }

            if (double.parse(pph.text.replaceAll(",", "")) < total) {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta": "${transaksiPendModel!.tglValuta}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code": "${transaksiPendModel!.trxCode}",
                "otor": "0",
                "kode_trn": "",
                "nama_cr":
                    "${golonganAsetModel!.sbbPph.toString().substring(14, golonganAsetModel!.sbbPph.toString().length)}",
                "cracc":
                    "${golonganAsetModel!.sbbPph.toString().substring(1, 13)}",
                "nama_dr": "${transaksiPendModel!.namaDr}",
                "dracc": "${transaksiPendModel!.dracc}",
                "rrn": "$invoice",
                "no_dokumen": "${transaksiPendModel!.noDokumen}",
                "no_ref": "${transaksiPendModel!.noRef}",
                "nominal": double.parse(pph.text.replaceAll(",", "")),
                "keterangan": "${keteranganTrans.text}",
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
                "modul": "PAJAK PPH PENGADAAN INVENTARIS",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            } else {
              var invoice = DateTime.now().millisecondsSinceEpoch.toString();
              var data = {
                "tgl_transaksi":
                    "${DateFormat('y-MM-dd').format(DateTime.now())}",
                "tgl_valuta": "${transaksiPendModel!.tglValuta}",
                "batch": "${users!.batch}",
                "trx_type": "TRX",
                "trx_code": "${transaksiPendModel!.trxCode}",
                "otor": "0",
                "kode_trn": "",
                "nama_cr":
                    "${golonganAsetModel!.sbbPph.toString().substring(14, golonganAsetModel!.sbbPph.toString().length)}",
                "cracc":
                    "${golonganAsetModel!.sbbPph.toString().substring(1, 13)}",
                "nama_dr": "${transaksiPendModel!.namaDr}",
                "dracc": "${transaksiPendModel!.dracc}",
                "rrn": "$invoice",
                "no_dokumen": "${transaksiPendModel!.noDokumen}",
                "no_ref": "${transaksiPendModel!.noRef}",
                "nominal": double.parse(pph.text.replaceAll(",", "")),
                "keterangan": "${keteranganTrans.text}",
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
                "status": "COMPLETED",
                "modul": "PAJAK PENGADAAN INVENTARIS",
              };
              Setuprepository.setup(
                  token, NetworkURL.transaksi(), jsonEncode(data));
            }
          }
          if (double.parse(users!.maksimalTransaksi) < total) {
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi":
                  "${DateFormat('y-MM-dd').format(DateTime.now())}",
              "tgl_valuta": "${transaksiPendModel!.tglValuta}",
              "batch": "${users!.batch}",
              "trx_type": "TRX",
              "trx_code": "${transaksiPendModel!.trxCode}",
              "otor": "0",
              "kode_trn": "",
              "nama_dr":
                  "${golonganAsetModel!.sbbAset.toString().substring(14, golonganAsetModel!.sbbAset.toString().length)}",
              "dracc":
                  "${golonganAsetModel!.sbbAset.toString().substring(1, 13)}",
              "nama_cr": "${transaksiPendModel!.namaDr}",
              "cracc": "${transaksiPendModel!.dracc}",
              "rrn": "$invoice",
              "no_dokumen": "${transaksiPendModel!.noDokumen}",
              "no_ref": "${transaksiPendModel!.noRef}",
              "nominal": subtotal,
              "keterangan": "${keteranganTrans.text}",
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
              "modul": "PENGADAAN INVENTARIS",
            };
            Setuprepository.setup(
                token, NetworkURL.transaksi(), jsonEncode(data));
          } else {
            var invoice = DateTime.now().millisecondsSinceEpoch.toString();
            var data = {
              "tgl_transaksi":
                  "${DateFormat('y-MM-dd').format(DateTime.now())}",
              "tgl_valuta": "${transaksiPendModel!.tglValuta}",
              "batch": "${users!.batch}",
              "trx_type": "TRX",
              "trx_code": "${transaksiPendModel!.trxCode}",
              "otor": "0",
              "kode_trn": "",
              "nama_dr":
                  "${golonganAsetModel!.sbbAset.toString().substring(14, golonganAsetModel!.sbbAset.toString().length)}",
              "dracc":
                  "${golonganAsetModel!.sbbAset.toString().substring(1, 13)}",
              "nama_cr": "${transaksiPendModel!.namaDr}",
              "cracc": "${transaksiPendModel!.dracc}",
              "rrn": "$invoice",
              "no_dokumen": "${transaksiPendModel!.noDokumen}",
              "no_ref": "${transaksiPendModel!.noRef}",
              "nominal": subtotal,
              "keterangan": "${keteranganTrans.text}",
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
              "status": "COMPLETED",
              "modul": "PENGADAAN INVENTARIS",
            };
            Setuprepository.setup(
                token, NetworkURL.transaksi(), jsonEncode(data));
          }
          clear();
          dialog = false;
          informationDialog(context, "Information", value['message']);
          notifyListeners();
        } else {
          informationDialog(context, "Warning", value['message']);
        }
      });
    }
  }

  List<InventarisModel> list = [];

//contoh decimal sparator currency
  final currencyFormatter =
      NumberFormat.currency(symbol: 'Rp ', decimalDigits: 2);
  getInventaris() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getInventaris(), jsonEncode(data))
        .then((value) {
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

  InventarisModel? inventarisModel;
  var editData = false;
  edit(String id) async {
    inventarisModel = list.where((e) => e.id == int.parse(id)).first;
    currentStep = 0;
    dialog = true;
    editData = true;
    noaset.text = inventarisModel!.kdaset;
    namaaset.text = inventarisModel!.namaaset;
    keterangan.text = inventarisModel!.ket;
    pajak = inventarisModel!.ppnBeli != "0" ? true : false;

    satuan = listSatuan.where((e) => e == inventarisModel!.satuanAset).first;
    kantor = listKantor
        .where((e) =>
            e.kodePt == inventarisModel!.kodePt &&
            e.kodeKantor == inventarisModel!.kodeKantor)
        .first;
    kelompokAsetModel = listKelompok
        .where((e) => e.kodeKelompok == inventarisModel!.kodeKelompok)
        .first;
    golonganAsetModel = listGolongan
        .where((e) => e.kodeGolongan == inventarisModel!.kodeGolongan)
        .first;
    lokasi.text = inventarisModel!.lokasi;
    kota.text = inventarisModel!.kota;
    noDok.text = inventarisModel!.nodokBeli;
    tglbeli.text = inventarisModel!.tglBeli;
    tglterima.text = inventarisModel!.tglTerima;
    masasusut.text = inventarisModel!.masasusut;
    blnPenyusutan.text = inventarisModel!.blnMulaiSusut;
    tglTransaksi = DateTime.parse(inventarisModel!.tglBeli);
    tglTransaksis = DateTime.parse(inventarisModel!.tglTerima);
    hargaBeli.text = FormatCurrency.oCcy
        .format(int.parse(inventarisModel!.habeli))
        .replaceAll(".", ",");
    discount.text = FormatCurrency.oCcy
        .format(int.parse(inventarisModel!.disc))
        .replaceAll(".", ",");
    biaya.text = FormatCurrency.oCcy
        .format(int.parse(inventarisModel!.biaya))
        .replaceAll(".", ",");
    subtotal = int.parse(inventarisModel!.haper);
    nilaiPenyusutan.text = FormatCurrency.oCcy
        .format(int.parse(inventarisModel!.nilaiResidu))
        .replaceAll(".", ",");
    ppn.text = FormatCurrency.oCcy
        .format(int.parse(inventarisModel!.ppnBeli))
        .replaceAll(".", ",");
    pph.text = FormatCurrency.oCcy
        .format(int.parse(inventarisModel!.pph))
        .replaceAll(".", ",");
    total = (subtotal + int.parse(ppn.text.replaceAll(",", ""))) -
        int.parse(pph.text.replaceAll(",", ""));
    notifyListeners();
  }

  clear() {
    dialog = false;
    editData = false;
    kelompokAsetModel = null;
    golonganAsetModel = null;
    kantor = null;
    noDok.clear();
    noaset.clear();
    namaaset.clear();
    keterangan.clear();
    blnPenyusutan.clear();
    tglbeli.clear();
    tglterima.clear();
    lokasi.clear();
    kota.clear();
    nilaiPenyusutan.clear();
    hargaBeli.text = "0";
    discount.text = "0";
    biaya.text = "0";
    ppn.text = "0";
    pph.text = "0";
    subtotal = 0;
    total = 0;
    notifyListeners();
  }

  TextEditingController cariTrans = TextEditingController();
  TextEditingController tglTrans = TextEditingController();
  TextEditingController noDokTrans = TextEditingController();
  TextEditingController nilaiTrans = TextEditingController();
  TextEditingController keteranganTrans = TextEditingController();
  TextEditingController noDok = TextEditingController();
  TextEditingController noRef = TextEditingController();
  TextEditingController noaset = TextEditingController();
  TextEditingController namaaset = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController blnPenyusutan = TextEditingController();
  DateTime now = DateTime.now();
  void showDate() async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              width: 500,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Pilih Periode",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 100,
                    child: ScrollDatePicker(
                      minimumDate: DateTime(
                        tglTransaksi!.year,
                        tglTransaksi!.month,
                      ),
                      maximumDate: DateTime(DateTime.now().year + 50),
                      options: DatePickerOptions(backgroundColor: Colors.white),
                      viewType: [
                        DatePickerViewType.month,
                        DatePickerViewType.year,
                      ],
                      selectedDate: now,
                      onDateTimeChanged: (e) {
                        setStateDialog(() {
                          now = e;
                          blnPenyusutan.text = DateFormat('MMMM y').format(now);
                        });
                        notifyListeners(); // if ChangeNotifier is needed
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      blnPenyusutan.text = DateFormat('MMMM y').format(now);
                      notifyListeners(); // if ChangeNotifier is needed
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.blue, // replace with your colorPrimary
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
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
      },
    );
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
      firstDate: DateTime(
          int.parse(DateFormat('y').format(tglTransaksi!)),
          int.parse(DateFormat('MM').format(tglTransaksi!)),
          int.parse(DateFormat('dd').format(tglTransaksi!))),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) + 10,
          int.parse(DateFormat('MM').format(tglTransaksi!)),
          int.parse(DateFormat('dd').format(tglTransaksi!))),
    ));
    if (pickedendDate != null) {
      tglTransaksis = pickedendDate;
      tglterima.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  List<KantorModel> listkantor = [];
  KantorModel? kantorModel;
  pilihKantor(KantorModel value) {
    kantor = value;

    notifyListeners();
  }

  TextEditingController lokasi = TextEditingController();
  TextEditingController kota = TextEditingController();
}
