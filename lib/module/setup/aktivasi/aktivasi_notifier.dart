import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/button_custom.dart';
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
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
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
