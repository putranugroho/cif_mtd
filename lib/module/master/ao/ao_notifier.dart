import 'dart:convert';

import 'package:cif/models/index.dart';
import 'package:cif/network/network.dart';
import 'package:cif/pref/pref.dart';
import 'package:cif/repository/SetupRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/dialog_loading.dart';
import '../../../utils/informationdialog.dart';

class AoNotifier extends ChangeNotifier {
  final BuildContext context;

  AoNotifier({required this.context}) {
    getProfile();
    notifyListeners();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getAoMarketing();
      getKantor();
      notifyListeners();
    });
  }

  List<KaryawanModel> listKaryawan = [];
  KaryawanModel? karyawanModel;
  piliAkunKaryawan(KaryawanModel value) {
    karyawanModel = value;
    nm.text = karyawanModel!.namaLengkap;
    notifyListeners();
  }

  Future<List<KaryawanModel>> getInqKaryawan(String query) async {
    if (query.isNotEmpty && query.length > 2 && editData == false) {
      listKaryawan.clear();
      notifyListeners();
      var data = {"nama": query};
      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.cariKaryawan(),
          jsonEncode(data),
        );

        for (Map<String, dynamic> i in response) {
          listKaryawan.add(KaryawanModel.fromJson(i));
        }
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print("Error: $e");
        }
      } finally {
        notifyListeners();
      }
    } else {
      listKaryawan.clear(); // clear on short query
    }

    return listKaryawan;
  }

  List<KantorModel> listKantor = [];
  Future getKantor() async {
    listKantor.clear();
    isLoading = true;
    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.getKantor(token, NetworkURL.getKantor(), jsonEncode(data)).then((value) {
      if (value['status'] == "Success") {
        for (Map<String, dynamic> i in value['data']) {
          listKantor.add(KantorModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  KantorModel? kantorModel;
  pilihKantor(KantorModel value) {
    kantorModel = value;
    notifyListeners();
  }

  var isLoading = true;
  getAoMarketing() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getAoMarketing(), jsonEncode(data)).then((value) {
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
          "userinput": users!.namauser,
          "userterm": "114.80.30.143",
          "kode_pt": kantorModel!.kodePt,
          "kode_kantor": kantorModel!.kodeKantor,
          "kode_induk": kantorModel!.kodeInduk,
          "nama_kantor": kantorModel!.namaKantor,
          "gol_cust": penempatanModel == "Customer"
              ? "1"
              : penempatanModel == "Supplier"
                  ? "2"
                  : "3",
        };
        print(jsonEncode(data));
        Setuprepository.setup(token, NetworkURL.editAoMarketing(), jsonEncode(data)).then((value) {
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
          "userinput": users!.namauser,
          "userterm": "114.80.30.143",
          "gol_cust": penempatanModel == "Customer"
              ? "1"
              : penempatanModel == "Supplier"
                  ? "2"
                  : "3",
          "kode_pt": kantorModel!.kodePt,
          "kode_kantor": kantorModel!.kodeKantor,
          "nama_kantor": kantorModel!.namaKantor,
          "kode_induk": kantorModel!.kodeInduk,
        };
        Setuprepository.setup(token, NetworkURL.addAoMarketing(), jsonEncode(data)).then((value) {
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
    kantorModel = listKantor.where((e) => e.kodeKantor == aoModel!.kodeKantor).first;
    kd.text = aoModel!.kode;
    nm.text = aoModel!.nama;
    penempatanModel = aoModel!.golCust == "1"
        ? "Customer"
        : aoModel!.golCust == "2"
            ? "Supplier"
            : "Customer / Supplier";
    notifyListeners();
  }

  List<AoModel> list = [];

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
                    "Anda yakin menghapus ${aoModel!.nama}?",
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

  confirmnonaktif() async {
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
                    "Anda yakin nonaktifkan ${aoModel!.nama}?",
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
                          nonaktifkan();
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

  nonaktifkan() async {
    DialogCustom().showLoading(context);
    var data = {
      "id": aoModel!.id,
      "kode": kd.text.trim(),
      "nama": nm.text.trim(),
      "userinput": users!.namauser,
      "userterm": "114.80.30.143",
      "kode_pt": kantorModel!.kodePt,
      "kode_kantor": kantorModel!.kodeKantor,
      "kode_induk": kantorModel!.kodeInduk,
      "nama_kantor": kantorModel!.namaKantor,
      "gol_cust": penempatanModel == "Customer"
          ? "1"
          : penempatanModel == "Supplier"
              ? "2"
              : "3",
    };
    Setuprepository.setup(token, NetworkURL.nonaktif(), jsonEncode(data)).then((value) {
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

  List<String> listPenempatan = ["Customer", "Supplier", "Customer / Supplier"];
  String? penempatanModel = "Customer";
  pilihPenempatan(String value) {
    penempatanModel = value;
    notifyListeners();
  }

  remove() {
    DialogCustom().showLoading(context);
    var data = {
      "id": aoModel!.id,
      "kode": kd.text.trim(),
      "nama": nm.text.trim(),
      "userinput": users!.namauser,
      "userterm": "114.80.30.143",
      "kode_pt": kantorModel!.kodePt,
      "kode_kantor": kantorModel!.kodeKantor,
      "kode_induk": kantorModel!.kodeInduk,
      "nama_kantor": kantorModel!.namaKantor,
      "gol_cust": penempatanModel == "Customer"
          ? "1"
          : penempatanModel == "Supplier"
              ? "2"
              : "3",
    };
    Setuprepository.setup(token, NetworkURL.deleteAoMarketing(), jsonEncode(data)).then((value) {
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
