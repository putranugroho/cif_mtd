import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../../network/network.dart';
import '../../../utils/button_custom.dart';

class JabatanNotifier extends ChangeNotifier {
  final BuildContext context;

  JabatanNotifier({required this.context}) {
    getLevel();
    notifyListeners();
  }

  var isLoading = true;
  Future getLevel() async {
    list.clear();
    isLoading = true;
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getLevelJabatan(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(LevelModel.fromJson(i));
        }
        getJabatan();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future getJabatan() async {
    isLoading = true;
    listJabatan.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getjabatan(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listJabatan.add(JabatanModel.fromJson(i));
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
    clear();
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  JabatanModel? jabatanModel;
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
                    "Anda yakin menghapus ${jabatanModel!.namaJabatan}?",
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
      "id": jabatanModel!.id,
    };
    Setuprepository.setup(token, NetworkURL.deletedJabatan(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getLevel();
        clear();
        dialog = false;
        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message']);
      }
    });
  }

  edit(String kodes) {
    jabatanModel = listJabatan.where((e) => e.id == int.parse(kodes)).first;
    kode.text = jabatanModel!.kodeJabatan;
    nama.text = jabatanModel!.namaJabatan;
    levelModel = jabatanModel!.idLevel == null
        ? null
        : list.where((e) => e.id == int.parse(jabatanModel!.idLevel)).isNotEmpty
            ? list.where((e) => e.id == int.parse(jabatanModel!.idLevel)).first
            : null;
    dialog = true;
    editData = true;
    notifyListeners();
  }

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  var editData = false;
  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": jabatanModel!.id,
          "kode_pt": "001",
          "kode_kantor": "1001",
          "id_level": levelModel!.id.toString(),
          "kode_jabatan": kode.text.trim(),
          "nama_jabatan": nama.text.trim(),
        };
        print(jsonEncode(data));
        Setuprepository.setup(
                token, NetworkURL.updatedJabatan(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            getJabatan();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "001",
          "kode_kantor": "1001",
          "id_level": levelModel!.id.toString(),
          "kode_jabatan": kode.text.trim(),
          "nama_jabatan": nama.text.trim(),
        };
        Setuprepository.setup(token, NetworkURL.addJabatan(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            getJabatan();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
          }
        });
      }
    }
  }

  clear() {
    editData = false;
    dialog = false;
    levelModel = null;
    kode.clear();
    nama.clear();
    notifyListeners();
  }

  List<JabatanModel> listJabatan = [];

  List<LevelModel> list = [];
  LevelModel? levelModel;
  pilihLevel(LevelModel value) {
    levelModel = value;
    notifyListeners();
  }
}
