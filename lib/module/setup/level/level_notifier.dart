import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../../network/network.dart';
import '../../../utils/button_custom.dart';

class LevelNotifier extends ChangeNotifier {
  final BuildContext context;

  LevelNotifier({required this.context}) {
    getLevel();
  }

  TextEditingController level = TextEditingController();
  TextEditingController jabatan = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  var editData = false;

  clear() {
    level.clear();
    editData = false;
    jabatan.clear();
    notifyListeners();
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": levelModel!.id,
          "kode_pt": "001",
          "kode_kantor": "1001",
          "lvl_jabatan": level.text.trim(),
          "kel_jabatan": jabatan.text.trim(),
        };
        Setuprepository.setup(token, NetworkURL.updateLevelJabatan(), jsonEncode(data)).then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            dialog = false;
            getLevel();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
            notifyListeners();
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "001",
          "kode_kantor": "1001",
          "lvl_jabatan": level.text.trim(),
          "kel_jabatan": jabatan.text.trim(),
        };
        Setuprepository.setup(token, NetworkURL.addLevelJabatan(), jsonEncode(data)).then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            dialog = false;
            getLevel();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
            notifyListeners();
          }
        });
      }
    }
  }

  bool dialog = false;
  tambah() {
    editData = false;
    dialog = true;
    notifyListeners();
  }

  LevelModel? levelModel;
  edit(String id) {
    editData = true;
    levelModel = list.where((e) => e.id == int.parse(id)).first;
    level.text = levelModel!.lvlJabatan;
    jabatan.text = levelModel!.kelJabatan;
    dialog = true;
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
              padding: const EdgeInsets.all(20),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Anda yakin menghapus ${levelModel!.kelJabatan}?",
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
      "id": levelModel!.id,
    };
    Setuprepository.setup(token, NetworkURL.deletedLevelJabatan(), jsonEncode(data)).then((value) {
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

  var isLoading = true;
  Future getLevel() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001",
    };
    Setuprepository.setup(token, NetworkURL.getLevelJabatan(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(LevelModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<LevelModel> list = [];
}
