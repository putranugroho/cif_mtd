import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:flutter/material.dart';

import '../../../network/network.dart';
import '../../../utils/button_custom.dart';
import '../../../utils/informationdialog.dart';

class TambahKelompokSbbKhususNotifier extends ChangeNotifier {
  final BuildContext context;

  TambahKelompokSbbKhususNotifier({required this.context}) {
    getGolonganSbb();
    notifyListeners();
  }
  var isLoading = true;
  Future getGolonganSbb() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001",
    };
    Setuprepository.setup(token, NetworkURL.getGolonganSbb(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(GolonganSbbKhususModel.fromJson(i));
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

  edit(String id) {
    golonganSbbKhususModel = list.where((e) => e.id == int.parse(id)).first;
    kode.text = golonganSbbKhususModel!.kodeGolongan;
    nama.text = golonganSbbKhususModel!.namaGolongan;
    satu = golonganSbbKhususModel!.lebihSatuAkun == "Y" ? true : false;
    editData = true;
    dialog = true;
    notifyListeners();
  }

  clear() {
    kode.clear();
    nama.clear();
    dialog = false;
    satu = false;
    editData = false;
    notifyListeners();
  }

  GolonganSbbKhususModel? golonganSbbKhususModel;

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  var editData = false;
  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": golonganSbbKhususModel!.id,
          "kode_pt": "001",
          "kode_golongan": "${kode.text.trim()}",
          "nama_golongan": "${nama.text.trim()}",
          "lebih_satu_akun": "${satu ? "Y" : "N"}",
        };
        Setuprepository.setup(
                token, NetworkURL.editGolonganSbb(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            getGolonganSbb();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
            notifyListeners();
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "001",
          "kode_golongan": "${kode.text.trim()}",
          "nama_golongan": "${nama.text.trim()}",
          "lebih_satu_akun": "${satu ? "Y" : "N"}",
        };
        Setuprepository.setup(
                token, NetworkURL.addGolonganSbb(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            getGolonganSbb();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
            notifyListeners();
          }
        });
      }
    }
  }

  bool satu = false;
  gantisatuan() {
    satu = !satu;
    notifyListeners();
  }

  bool dialog = false;
  tambah() {
    clear();
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<GolonganSbbKhususModel> list = [];

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
                    "Anda yakin menghapus ${golonganSbbKhususModel!.namaGolongan}?",
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
      "id": golonganSbbKhususModel!.id,
    };
    Setuprepository.setup(
            token, NetworkURL.deleteGolonganSbb(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getGolonganSbb();
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
