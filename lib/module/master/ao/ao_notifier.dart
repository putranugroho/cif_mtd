import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/dialog_loading.dart';
import '../../../utils/informationdialog.dart';

class AoNotifier extends ChangeNotifier {
  final BuildContext context;

  AoNotifier({required this.context}) {
    getAoMarketing();
    notifyListeners();
  }
  var isLoading = true;
  getAoMarketing() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getAoMarketing(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(AoModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  TextEditingController kd = TextEditingController();
  TextEditingController nm = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  AoModel? aoModel;
  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": aoModel!.id,
          "kode": kd.text.trim(),
          "nama": nm.text.trim(),
          "kode_pt": aoModel!.kodePt,
          "kode_kantor": aoModel!.kodeKantor,
          "kode_induk": aoModel!.kodeInduk,
        };
        print(jsonEncode(data));
        Setuprepository.setup(
                token, NetworkURL.editAoMarketing(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getAoMarketing();
            clear();
            informationDialog(context, "Information", value['message']);
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode": kd.text.trim(),
          "nama": nm.text.trim(),
          "kode_pt": "001",
          "kode_kantor": "",
          "kode_induk": "",
        };
        Setuprepository.setup(
                token, NetworkURL.addAoMarketing(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getAoMarketing();
            clear();
            informationDialog(context, "Information", value['message']);
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      }
    }
  }

  var editData = false;
  clear() async {
    dialog = false;
    editData = false;
    kd.clear();
    nm.clear();
    notifyListeners();
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

  edit(String id) {
    dialog = true;
    editData = true;
    aoModel = list.where((e) => e.id == int.parse(id)).first;
    kd.text = aoModel!.kode;
    nm.text = aoModel!.nama;
    notifyListeners();
  }

  List<AoModel> list = [];

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
                    "Anda yakin menghapus ${aoModel!.nama}?",
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
      "id": aoModel!.id,
    };
    Setuprepository.setup(
            token, NetworkURL.deleteAoMarketing(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getAoMarketing();
        clear();

        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message'][0]);
      }
    });
  }
}
