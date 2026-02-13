import 'dart:convert';

import 'package:cif/models/index.dart';
import 'package:cif/utils/colors.dart';
import 'package:cif/utils/dialog_loading.dart';
import 'package:cif/utils/informationdialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';
import '../../../utils/format_currency.dart';

class PenempatanNotifier extends ChangeNotifier {
  final BuildContext context;

  PenempatanNotifier({required this.context}) {
    getKantor();
    getInventaris();
    notifyListeners();
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
    var data = {"kode_pt": "001"};
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

  final List<GlobalKey<FormState>> formStep = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  final keyForm = GlobalKey<FormState>();
  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      var data = {
        "jenis_penempatan": penempatanModel,
        "kode_kelompok": inventarisModel!.kodeKelompok,
        "kdaset": inventarisModel!.kdaset,
        "kode_golongan": inventarisModel!.kodeGolongan,
        "lokasi": lokasi.text,
        "kota": kota.text,
        "kode_pt": kantor!.kodePt,
        "kode_kantor": kantor!.kodeKantor,
        "kode_induk": kantor!.kodeInduk,
        "nama_kantor": kantor!.namaKantor,
        "nama_pejabat": karyawanModel == null ? "" : karyawanModel!.namaLengkap,
        "nik": karyawanModel == null ? "" : karyawanModel!.nik,
      };
      Setuprepository.setup(token, NetworkURL.penempatan(), jsonEncode(data)).then((value) {
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
  }

  clear() {
    inventarisModel = null;
    karyawanModel = null;
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
    total = int.parse(hargaBeli.text.replaceAll(",", "")) - int.parse(discount.text.replaceAll(",", "")) + int.parse(biaya.text.replaceAll(",", ""));
    notifyListeners();
  }

  bool pajak = false;
  gantipajak(bool value) {
    pajak = value;
    notifyListeners();
  }

  List<String> listPenempatan = ["Kantor", "Karyawan"];
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
      tglbeli.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
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
      tglbeli.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
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
      firstDate: DateTime(int.parse(DateFormat('y').format(tglTransaksi!)), int.parse(DateFormat('MM').format(tglTransaksi!)),
          int.parse(DateFormat('dd').format(tglTransaksi!))),
      lastDate: DateTime(int.parse(DateFormat('y').format(DateTime.now())) + 10, int.parse(DateFormat('MM').format(tglTransaksi!)),
          int.parse(DateFormat('dd').format(tglTransaksi!))),
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

  TextEditingController namaKaryawan = TextEditingController();
  TextEditingController nikKaryawan = TextEditingController();
  KaryawanModel? karyawanModel;
  piliAkunKaryawan(KaryawanModel value) {
    karyawanModel = value;
    namaKaryawan.text = karyawanModel!.namaLengkap;
    nikKaryawan.text = karyawanModel!.nik;
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

  // List<InventarisModel> list = [];
  InventarisModel? inventarisModel;
  pilihInventory(InventarisModel value) {
    inventarisModel = value;
    kdAset.text = inventarisModel!.kdaset;
    noaset.text = inventarisModel!.kdaset;
    nmAset.text = inventarisModel!.namaaset;
    inventarisModel!.nik != "" ? penempatanModel = "Karyawan" : penempatanModel = "Kantor";
    kantor = listKantor.where((e) => e.kodePt == inventarisModel!.kodePt && e.kodeKantor == inventarisModel!.kodeKantor).first;
    lokasi.text = inventarisModel!.lokasi;
    kota.text = inventarisModel!.kota;
    nikKaryawan.text = inventarisModel!.nik;
    noDok.text = inventarisModel!.nodokBeli;
    kelompok.text = inventarisModel!.namaKelompok;
    keterangan.text = inventarisModel!.ket;
    namaKaryawan.text = inventarisModel!.namaPejabat;
    nikKaryawan.text = inventarisModel!.nik;
    golongan.text = inventarisModel!.namaGolongan;
    satuans.text = inventarisModel!.satuanAset;
    tglbeli.text = inventarisModel!.tglBeli;
    tglterima.text = inventarisModel!.tglTerima;
    notifyListeners();
  }
}
