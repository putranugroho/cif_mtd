import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../../network/network.dart';
import '../../../utils/button_custom.dart';

class KelompokAsetNotifier extends ChangeNotifier {
  final BuildContext context;

  KelompokAsetNotifier({required this.context}) {
    getKelompokAset();
    notifyListeners();
  }

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  var isLoading = true;
  Future getKelompokAset() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001"
    };
    Setuprepository.setup(token, NetworkURL.getKelompokAset(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(KelompokAsetModel.fromJson(i));
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

  clear() {
    nama.clear();
    kode.clear();
    dialog = false;
    editData = false;
    notifyListeners();
  }

  final keyForm = GlobalKey<FormState>();

  bool dialog = false;
  var editData = false;
  tambah() {
    clear();
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  edit(String id) {
    kelompokAsetModel = list.where((e) => e.id == int.parse(id)).first;
    nama.text = kelompokAsetModel!.namaKelompokn;
    kode.text = kelompokAsetModel!.kodeKelompok;
    dialog = true;
    editData = true;
    notifyListeners();
  }

  List<KelompokAsetModel> list = [];
  KelompokAsetModel? kelompokAsetModel;
  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": kelompokAsetModel!.id,
          "kode_pt": "001",
          "kode_kelompok": kode.text.trim(),
          "nama_kelompokn": nama.text.trim(),
        };
        Setuprepository.setup(token, NetworkURL.editKelompokAset(), jsonEncode(data)).then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            getKelompokAset();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
            // informationDialog(context, "Warning", value['message'][0]);

            isLoading = false;
            notifyListeners();
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "001",
          "kode_kelompok": kode.text.trim(),
          "nama_kelompokn": nama.text.trim(),
        };
        Setuprepository.setup(token, NetworkURL.addKelompokAset(), jsonEncode(data)).then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            getKelompokAset();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
            // informationDialog(context, "Warning", value['message'][0]);

            isLoading = false;
            notifyListeners();
          }
        });
      }
    }
  }

  confirm() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Anda yakin menghapus ${kelompokAsetModel!.namaKelompokn}?",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
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
      "id": kelompokAsetModel!.id,
    };
    Setuprepository.setup(token, NetworkURL.deleteKelompokAset(), jsonEncode(data)).then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getKelompokAset();
        clear();
        dialog = false;
        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message'][0]);
      }
    });
  }
}
