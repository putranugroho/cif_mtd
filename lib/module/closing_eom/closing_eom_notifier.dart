import 'package:accounting/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../models/users_model.dart';
import '../../utils/colors.dart';

class ClosingEomNotifier extends ChangeNotifier {
  final BuildContext context;

  ClosingEomNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      listData.add(UsersModel.fromJson(i));
    }
    notifyListeners();
  }

  TextEditingController closingDate = TextEditingController();
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
                              closingDate.text = DateFormat('MMMM y').format(now);

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
                        final int selisihBulan = monthDifference(now, DateTime.now());
                        print('Bulan ke belakang: $selisihBulan bulan');
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

  int monthDifference(DateTime from, DateTime to) {
    return (to.year - from.year) * 12 + to.month - from.month;
  }

  konfirmasi() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 600,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        "Konfirmasi Closing",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
                          child: const Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Jika melakukan closing EOM, Users yang online akan di non-aktifkan, apakah Anda yakin akan melanjutkan closing EOM?",
                  ),
                  const SizedBox(
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
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: ButtonPrimary(
                              onTap: () {
                                Navigator.pop(context);
                                notifyListeners();
                              },
                              name: "Ya")),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  List<UsersModel> listData = [];
  List<Map<String, dynamic>> data = [
    {
      "userid": "edicybereye",
      "pass": "123123",
      "namauser": "Edi Kurniawan",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": "",
      "tglexp": "2025-12-30",
      "lvluser": "A",
      "terminal_id": "",
      "akses_kasir": "N",
      "sbb_kasir": "",
      "nama_sbb": "",
      "fhoto_1": "",
      "fhoto_2": "",
      "fhoto_3": "",
      "level_otor": "1",
      "beda_kantor": "Y",
      "min_otor": "10000000",
      "max_otor": "20000000"
    },
    {
      "userid": "fadli",
      "pass": "123123",
      "namauser": "Fadli",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": "",
      "tglexp": "2025-12-30",
      "lvluser": "A",
      "terminal_id": "",
      "akses_kasir": "N",
      "sbb_kasir": "",
      "nama_sbb": "",
      "fhoto_1": "",
      "fhoto_2": "",
      "fhoto_3": "",
      "level_otor": "1",
      "beda_kantor": "Y",
      "min_otor": "10000000",
      "max_otor": "20000000"
    },
    {
      "userid": "nugroho",
      "pass": "123123",
      "namauser": "Hari Nugroho",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": "",
      "tglexp": "2025-12-30",
      "lvluser": "A",
      "terminal_id": "",
      "akses_kasir": "N",
      "sbb_kasir": "",
      "nama_sbb": "",
      "fhoto_1": "",
      "fhoto_2": "",
      "fhoto_3": "",
      "level_otor": "1",
      "beda_kantor": "Y",
      "min_otor": "10000000",
      "max_otor": "20000000"
    },
  ];
}
