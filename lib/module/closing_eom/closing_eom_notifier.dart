import 'package:accounting/utils/button_custom.dart';
import 'package:flutter/material.dart';

import '../../models/users_model.dart';

class ClosingEomNotifier extends ChangeNotifier {
  final BuildContext context;

  ClosingEomNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      listData.add(UsersModel.fromJson(i));
    }
    notifyListeners();
  }

  konfirmasi() async {
    showDialog(
        context: context,
        builder: (context) {
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
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Jika melakukan closing EOM, Users yang online akan di non-aktifkan, apakah Anda yakin akan melanjutkan closing EOM?",
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
