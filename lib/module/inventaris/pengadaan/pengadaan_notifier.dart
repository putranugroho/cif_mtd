import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/utils/colors.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';
import '../../../utils/format_currency.dart';

class PengadaanNotifier extends ChangeNotifier {
  final BuildContext context;

  PengadaanNotifier({required this.context}) {
    getKelompokAset();
    getMetodePenyusutan();
    getGolonganAset();
    getKantor();
    getSetupPajak();
    notifyListeners();
  }
  SetupPajakModel? setupPajakModel;
  List<SetupPajakModel> listPajak = [];

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
  TextEditingController discount = TextEditingController(text: "0");
  TextEditingController biaya = TextEditingController(text: "0");
  TextEditingController nilaiPenyusutan = TextEditingController();
  TextEditingController ppn = TextEditingController(text: "0");
  TextEditingController pph = TextEditingController(text: "0");
  int total = 0;
  onChange() {
    subtotal = int.parse(hargaBeli.text.replaceAll(",", "")) -
        int.parse(discount.text.replaceAll(",", "")) +
        int.parse(biaya.text.replaceAll(",", ""));
    total = int.parse(hargaBeli.text.replaceAll(",", "")) -
        int.parse(discount.text.replaceAll(",", "")) +
        int.parse(biaya.text.replaceAll(",", ""));
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
    DialogCustom().showLoading(context);

    var data = {
      "kdaset": noaset.text,
      "ket": keterangan.text,
      "kode_kelompok": kelompokAsetModel!.kodeKelompok,
      "nama_kelompok": kelompokAsetModel!.namaKelompokn,
      "kode_golongan": golonganAsetModel!.kodeGolongan,
      "nama_golongan": golonganAsetModel!.namaGolongan,
      "nodok_beli": noDok.text,
      "tgl_beli": tglbeli.text,
      "tgl_terima": tglterima.text,
      "habeli": hargaBeli.text,
      "disc": discount.text,
      "biaya": biaya.text,
      "haper": subtotal,
      "nilai_residu": nilaiPenyusutan.text,
      "ppn_beli": ppn.text,
      "pph": pph.text,
      "tgl_jual": "",
      "nodok_jual": "",
      "hajual": "",
      "ppn_jual": "",
      "margin": "",
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
      "nilai_declining": nilaiPenyusutan.text,
      "perbaikan": "",
      "stsasr": 'N',
      "nopolis": "",
      "nilai_revaluasi": "",
      "nik": "",
      "nama_pejabat": "",
      "sbb_aset": golonganAsetModel!.sbbAset,
      "sbb_penyusutan": golonganAsetModel!.sbbPenyusutan,
      "sbb_biaya_penyusutan": golonganAsetModel!.sbbBiayaPenyusutan,
      "sbb_rugi_revaluasi": golonganAsetModel!.sbbRugiRevaluasi,
      "sbb_laba_revaluasi": golonganAsetModel!.sbbLabaRevaluasi,
      "sbb_rugi_jual": golonganAsetModel!.sbbRugiJual,
      "sbb_laba_jual": golonganAsetModel!.sbbLabaJual,
      "sbb_biaya_perbaikan": golonganAsetModel!.sbbBiayaPerbaikan,
    };
  }

  TextEditingController noDok = TextEditingController();
  TextEditingController noaset = TextEditingController();
  TextEditingController namaaset = TextEditingController();
  TextEditingController keterangan = TextEditingController();
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
                          minimumDate: DateTime(
                              int.parse(DateFormat('y').format(tglTransaksi!)),
                              int.parse(
                                  DateFormat('MM').format(tglTransaksi!))),
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

  List<InventarisModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "id": 1,
      "kdaset": "100001",
      "ket": "NMAX 100 CC150",
      "kode_kelompok": "1",
      "nama_kelompok": "TRANSPORTASI",
      "kode_golongan": "001",
      "nama_golongan": "Kendaraan",
      "nodok_beli": "10000101",
      "tgl_beli": "2025-03-01",
      "tgl_terima": "2025-03-07",
      "habeli": "24000000",
      "disc": "500000",
      "biaya": "150000",
      "haper": "23650000",
      "nilai_residu": "1",
      "ppn_beli": "0",
      "tgl_jual": "",
      "nodok_jual": "",
      "hajual": "",
      "ppn_jual": "",
      "margin": "",
      "kode_pt": "",
      "kode_kantor": "",
      "kode_induk": "",
      "lokasi": "",
      "kota": "",
      "masasusut": "10",
      "bln_mulai_susut": "2025-12-01",
      "kdkondisi": "",
      "kondisi": "",
      "satuan_aset": "",
      "nilai_declining": "",
      "perbaikan": "",
      "stsasr": "",
      "nopolis": "",
      "nilai_revaluasi": "",
      "nik": "",
      "nama_pejabat": "",
      "sbb_aset": "",
      "sbb_penyusutan": "",
      "sbb_biaya_penyusutan": "",
      "sbb_rugi_revaluasi": "",
      "sbb_laba_revaluasi": "",
      "sbb_rugi_jual": "",
      "sbb_laba_jual": "",
      "sbb_biaya_perbaikan": ""
    },
  ];
}
