import 'package:accounting/models/index.dart';
import 'package:accounting/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class PengadaanNotifier extends ChangeNotifier {
  final BuildContext context;

  PengadaanNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(InventarisModel.fromJson(i));
    }

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

  List<KelompokAsetModel> listKelompok = [];
  KelompokAsetModel? kelompokAsetModel;
  pilihKelompok(KelompokAsetModel value) {
    kelompokAsetModel = value;
    notifyListeners();
  }

  List<GolonganAsetModel> listGolongan = [];
  GolonganAsetModel? golonganAsetModel;
  pilihGolongan(GolonganAsetModel value) {
    golonganAsetModel = value;
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

  DateTime? tglTransaksis;
  Future pilihTanggalTerima() async {
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
          int.parse(DateFormat('y').format(DateTime.now())) - 10,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
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
    kantorModel = value;
    notifyListeners();
  }

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
