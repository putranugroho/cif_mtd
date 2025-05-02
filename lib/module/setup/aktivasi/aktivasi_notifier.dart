import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../network/network.dart';

import 'package:time_picker_spinner/time_picker_spinner.dart';

class AktivasiNotifier extends ChangeNotifier {
  final BuildContext context;

  AktivasiNotifier({required this.context}) {
    getAktivasi();
    notifyListeners();
  }

  final keyForm = GlobalKey<FormState>();
  var editData = false;

  clear() {
    dialog = false;
    editData = false;
    kode.clear();
    nama.clear();
    listHariAdd.clear();
    jamMulai.clear();
    jamSelesai.clear();
    notifyListeners();
  }

  AktivasiModel? aktivasiModel;

  edit(String id) {
    dialog = true;
    editData = true;
    listHariAdd.clear();
    aktivasiModel = list.where((e) => e.id == int.parse(id)).first;
    kode.text = aktivasiModel!.kdAktivasi;
    nama.text = aktivasiModel!.nmAktivasi;
    jamMulai.text = aktivasiModel!.jamMulai;
    jamSelesai.text = aktivasiModel!.jamSelesai;

    List<String> hariList = jsonEncode(aktivasiModel!.hari)
        .toString()
        .replaceAll('[', '')
        .replaceAll("\"", "")
        .replaceAll(']', '')
        .split(',')
        .map((e) => e.trim())
        .toList();
    print(hariList.length);
    for (var i = 0; i < hariList.length; i++) {
      listHariAdd.add(hariList[i]);
    }
    notifyListeners();
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": aktivasiModel!.id,
          "kode_pt": "001",
          "kd_aktivasi": "${kode.text}",
          "nm_aktivasi": "${nama.text}",
          "hari": "${listHariAdd}",
          "jam_mulai": "${jamMulai.text}",
          "jam_selesai": "${jamSelesai.text}",
        };

        Setuprepository.setup(
                token, NetworkURL.editAktivasi(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            clear();
            getAktivasi();
            notifyListeners();
          } else {
            informationDialog(context, "Information", value['message']);
            notifyListeners();
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "001",
          "kd_aktivasi": "${kode.text}",
          "nm_aktivasi": "${nama.text}",
          "hari": "${listHariAdd}",
          "jam_mulai": "${jamMulai.text}",
          "jam_selesai": "${jamSelesai.text}",
        };

        Setuprepository.setup(token, NetworkURL.addAktivasi(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            clear();
            getAktivasi();
            notifyListeners();
          } else {
            informationDialog(context, "Information", value['message']);
            notifyListeners();
          }
        });
      }
    }
  }

  // TextEditingController _controller = TextEditingController();

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      jamMulai.text =
          '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
    }
    notifyListeners();
  }

  Future<void> selectEndTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      jamSelesai.text =
          '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
    }
    notifyListeners();
  }

  var isLoading = true;
  Future getAktivasi() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getAktivasi(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(AktivasiModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  bool dialog = false;
  tambah() {
    dialog = true;

    editData = false;
    kode.clear();
    nama.clear();
    listHariAdd.clear();
    jamMulai.clear();
    jamSelesai.clear();
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  confirm() async {
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
                    "Anda yakin menghapus ${aktivasiModel!.nmAktivasi}?",
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
                          remove();
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

  remove() {
    DialogCustom().showLoading(context);
    var data = {
      "id": aktivasiModel!.id,
    };
    Setuprepository.setup(token, NetworkURL.deleteAktivasi(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getAktivasi();
        clear();

        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message'][0]);
      }
    });
  }

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController jamMulai = TextEditingController();
  TextEditingController jamSelesai = TextEditingController();
  DateTime jamMulaiTime = DateTime.now();
  DateTime jamSelesaiTime = DateTime.now();
  pilihJamMulai() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 600,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Pilih Jam Mulai",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300]),
                            child: Icon(
                              Icons.close,
                              size: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TimePickerSpinner(
                      locale: const Locale('en', ''),
                      time: jamMulaiTime,
                      is24HourMode: true,
                      isShowSeconds: false,
                      itemHeight: 80,
                      normalTextStyle: const TextStyle(
                        fontSize: 24,
                      ),
                      highlightedTextStyle:
                          const TextStyle(fontSize: 24, color: Colors.blue),
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        setState(() {
                          jamMulaiTime = time;

                          notifyListeners();
                        });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ButtonPrimary(
                      onTap: () {
                        Navigator.pop(context);
                        jamMulai.text =
                            DateFormat('HH:mm').format(jamMulaiTime);
                      },
                      name: "Simpan",
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  pilihJamSelesai() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 600,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Pilih Jam Selesai",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300]),
                            child: Icon(
                              Icons.close,
                              size: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TimePickerSpinner(
                      locale: const Locale('en', ''),
                      time: jamSelesaiTime,
                      is24HourMode: true,
                      isShowSeconds: false,
                      itemHeight: 80,
                      normalTextStyle: const TextStyle(
                        fontSize: 24,
                      ),
                      highlightedTextStyle:
                          const TextStyle(fontSize: 24, color: Colors.blue),
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        setState(() {
                          jamSelesaiTime = time;

                          notifyListeners();
                        });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ButtonPrimary(
                      onTap: () {
                        Navigator.pop(context);
                        jamSelesai.text =
                            DateFormat('HH:mm').format(jamSelesaiTime);
                      },
                      name: "Simpan",
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  List<String> listHari = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];

  List<String> listHariAdd = [];

  pilihHari(String value) async {
    if (listHariAdd.isEmpty) {
      listHariAdd.add(value);
    } else {
      if (listHariAdd.where((e) => e == value).isNotEmpty) {
        listHariAdd.remove(value);
      } else {
        listHariAdd.add(value);
      }
    }
    notifyListeners();
  }

  List<AktivasiModel> list = [];
}
