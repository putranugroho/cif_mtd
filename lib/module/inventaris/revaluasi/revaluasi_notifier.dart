import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/utils/colors.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';
import '../../../utils/format_currency.dart';

class RevaluasiNotifier extends ChangeNotifier {
  final BuildContext context;

  RevaluasiNotifier({required this.context}) {
    getProfile();
    notifyListeners();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getInventaris();
      notifyListeners();
    });
  }

  TextEditingController nominal = TextEditingController();
  var isLoading = true;
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

  final List<GlobalKey<FormState>> formStep = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  TextEditingController nodok = TextEditingController();
  TextEditingController tglbeli = TextEditingController();
  TextEditingController tglterima = TextEditingController();
  TextEditingController hargaBeli = TextEditingController(text: "0");
  TextEditingController hargaBuku = TextEditingController(text: "0");
  TextEditingController haper = TextEditingController(text: "0");
  TextEditingController nilaiBuku = TextEditingController(text: "0");
  TextEditingController discount = TextEditingController(text: "0");
  TextEditingController biaya = TextEditingController(text: "0");
  TextEditingController nilaiPenyusutan = TextEditingController();
  TextEditingController ppn = TextEditingController(text: "0");
  TextEditingController pph = TextEditingController(text: "0");
  int total = 0;
  onChange() {
    total = int.parse(hargaBeli.text.replaceAll(",", "")) -
        int.parse(discount.text.replaceAll(",", "")) +
        int.parse(biaya.text.replaceAll(",", ""));
    notifyListeners();
  }

  bool pajak = false;
  gantipajak(bool value) {
    pajak = value;
    notifyListeners();
  }

  String? satuan = "Unit";

  gantiSatuan(String value) {
    satuan = value;
    notifyListeners();
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
          int.parse(DateFormat('y').format(DateTime.now())) + 2,
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

  cek() async {
    DialogCustom().showLoading(context);
    var data = {
      "kode_kelompok": inventarisModel!.kodeKelompok,
      "kdaset": inventarisModel!.kdaset,
      "kode_golongan": inventarisModel!.kodeGolongan,
      "pic_revaluasi": picReval.text.trim(),
      "nilai_revaluasi": nominal.text.replaceAll(",", ""),
      "tgl_revaluasi": DateFormat('y-MM-dd').format(tglTransaksi!),
      "kode_pt": users!.kodePt,
      "kode_kantor": users!.kodeKantor,
      "kode_induk": users!.kodeInduk,
      "userinput": users!.namauser,
      "userterm": "114.80.90.54",
    };
    Setuprepository.setup(token, NetworkURL.revaluasi(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
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

  clear() {
    inventarisModel = null;
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

  TextEditingController blnPenyusutan = TextEditingController();
  DateTime now = DateTime.now();
  showDate() async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                width: 500,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Pilih Periode",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 100,
                      child: ScrollDatePicker(
                          maximumDate: DateTime(int.parse(
                                  DateFormat('y').format(DateTime.now())) +
                              50),
                          options:
                              DatePickerOptions(backgroundColor: Colors.white),
                          viewType: [
                            DatePickerViewType.month,
                            DatePickerViewType.year,
                          ],
                          selectedDate: now,
                          onDateTimeChanged: (e) {
                            setState(() {
                              now = e;
                              blnPenyusutan.text =
                                  DateFormat('MMMM y').format(now);
                              notifyListeners();
                            });
                          }),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        notifyListeners();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(8)),
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
        });
  }

  List<Map<String, dynamic>> kantor = [
    {
      "kode_pt": "10001",
      "kode_kantor": "100011",
      "kode_induk": "",
      "nama_kantor": "PT TEGUH AMAN LESTARI ",
      "status_kantor": "P",
      "alamat": "Trasa Coworking Space",
      "kelurahan": "PROCOT",
      "kecamatan": "SLAWI",
      "kota": "KABUPATEN TEGAL",
      "provinsi": "JAWA TENGAH",
      "kode_pos": "52419",
      "telp": null,
      "fax": null
    }
  ];

  List<KantorModel> listkantor = [];
  KantorModel? kantorModel;
  pilihKantor(KantorModel value) {
    kantorModel = value;
    notifyListeners();
  }

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
  TextEditingController picReval = TextEditingController();

  int subtotal = 0;
  List<InventarisModel> list = [];
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
    Setuprepository.setup(token, NetworkURL.cariInventaris(), jsonEncode(data))
        .then((values) {
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
          noDok.text = inventarisModel!.nodokBeli;
          kelompok.text = inventarisModel!.namaKelompok;
          keterangan.text = inventarisModel!.ket;
          golongan.text = inventarisModel!.namaGolongan;
          satuans.text = inventarisModel!.satuanAset;
          tglbeli.text = inventarisModel!.tglRevaluasi;
          nominal.text = FormatCurrency.oCcy
              .format(int.parse(inventarisModel!.nilaiRevaluasi))
              .replaceAll(".", ",");
          picReval.text = inventarisModel!.picRevaluasi;
          tglterima.text = inventarisModel!.tglTerima;
          biaya.text = FormatCurrency.oCcy
              .format(int.parse(inventarisModel!.biaya))
              .replaceAll(".", ",");
          hargaBeli.text = FormatCurrency.oCcy
              .format(int.parse(inventarisModel!.habeli))
              .replaceAll(".", ",");
          hargaBuku.text = FormatCurrency.oCcy
              .format(int.parse(inventarisTransaksiModel!.nilaiBuku))
              .replaceAll(".", ",");
          haper.text = FormatCurrency.oCcy
              .format(int.parse(inventarisModel!.haper))
              .replaceAll(".", ",");
          nilaiPenyusutan.text = FormatCurrency.oCcy
              .format(int.parse(inventarisTransaksiModel!.persentasePenyusutan))
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
        } else {
          informationDialog(
              context, "Warning", "Inventaris tidak ditemukan di transaksi");
        }
      }
    });

    notifyListeners();
  }
}
