import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../network/network.dart';
import '../../utils/button_custom.dart';

class PejabatNotifier extends ChangeNotifier {
  final BuildContext context;

  PejabatNotifier({required this.context}) {
    getKantor();
    getPejabat();

    notifyListeners();
  }

  Future getPejabat() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001",
      "kode_kantor": "1001",
    };
    Setuprepository.setup(token, NetworkURL.getPejabat(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(PejabatModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  var isLoading = true;
  var isLoadingKantor = true;
  Future getKantor() async {
    isLoadingKantor = true;
    listKantor.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001",
    };
    Setuprepository.setup(token, NetworkURL.getKantor(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listKantor.add(KantorModel.fromJson(i));
        }
        getJabatan();
      } else {
        isLoadingKantor = false;
        notifyListeners();
      }
    });
  }

  Future getJabatan() async {
    isLoadingKantor = true;
    listJabatan.clear();
    notifyListeners();
    var data = {
      "kode_pt": "001",
      "kode_kantor": "1001",
    };
    Setuprepository.setup(token, NetworkURL.getjabatan(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listJabatan.add(JabatanModel.fromJson(i));
        }
        isLoadingKantor = false;
        notifyListeners();
      } else {
        isLoadingKantor = false;
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
                    "Anda yakin menghapus ${pejabatModel!.namaPejabat}?",
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

  simpan() async {
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
                    "Apakah data sudah benar ?",
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
                          cek();
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
    var data = {"id": pejabatModel!.id};
    Setuprepository.setup(token, NetworkURL.deletedPejabat(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getPejabat();
        clear();
        dialog = false;
        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message']);
      }
    });
  }

  PejabatModel? pejabatModel;
  edit(String value) {
    print(value);
    pejabatModel = list.where((e) => e.id == int.parse(value)).first;
    nik.text = pejabatModel!.nik;
    nama.text = pejabatModel!.namaPejabat;
    noHp.text = pejabatModel!.noHpPejabat;
    kantorModel =
        listKantor.where((e) => e.kodeKantor == pejabatModel!.kodeKantor).first;
    jabatanModel = listJabatan
        .where((e) => e.kodeJabatan == pejabatModel!.kodeJabatan)
        .first;
    dialog = true;
    editData = true;
    notifyListeners();
  }

  TextEditingController nik = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController noHp = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  var editData = false;
  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": pejabatModel!.id,
          "kode_pt": "${kantorModel!.kodePt}",
          "kode_kantor": "${kantorModel!.kodeKantor}",
          "kode_induk": "${kantorModel!.kodeInduk}",
          "nik": "${nik.text.trim()}",
          "nama_pejabat": "${nama.text.trim()}",
          "no_hp_pejabat": "${noHp.text.trim()}",
          "kode_jabatan": "${jabatanModel!.kodeJabatan}",
        };
        Setuprepository.setup(
                token, NetworkURL.updatedPejabat(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            clear();
            getPejabat();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "${kantorModel!.kodePt}",
          "kode_kantor": "${kantorModel!.kodeKantor}",
          "kode_induk": "${kantorModel!.kodeInduk}",
          "nik": "${nik.text.trim()}",
          "nama_pejabat": "${nama.text.trim()}",
          "no_hp_pejabat": "${noHp.text.trim()}",
          "kode_jabatan": "${jabatanModel!.kodeJabatan}",
        };
        Setuprepository.setup(token, NetworkURL.addPejabat(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            clear();
            getPejabat();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      }
    }
  }

  clear() async {
    dialog = false;
    editData = false;
    jabatanModel = null;
    kantorModel = null;
    nik.clear();
    nama.clear();
    noHp.clear();
    notifyListeners();
  }

  List<KantorModel> listKantor = [];
  List<PejabatModel> list = [];
  List<JabatanModel> listJabatan = [];
  JabatanModel? jabatanModel;
  KantorModel? kantorModel;
  pilihJabatan(JabatanModel value) {
    jabatanModel = value;
    notifyListeners();
  }

  pilihKantor(KantorModel value) {
    kantorModel = value;
    notifyListeners();
  }
}
