import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../../utils/button_custom.dart';

class KantorNotifier extends ChangeNotifier {
  final BuildContext context;

  KantorNotifier({required this.context}) {
    getPerusahaan();
  }
  List<PerusahaanModel> listPerusahaan = [];
  PerusahaanModel? perusahaanModel;
  Future getPerusahaan() async {
    isLoading = true;
    listPerusahaan.clear();

    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.getPerusahaan(
            token, NetworkURL.gerPerusahaan(), jsonEncode(data))
        .then((value) {
      if (value['status'] == "Success") {
        for (Map<String, dynamic> i in value['data']) {
          listPerusahaan.add(PerusahaanModel.fromJson(i));
        }
        perusahaanModel = listPerusahaan[0];
        getKantor();
      } else {
        isLoading = false;
        notifyListeners();
      }

      notifyListeners();
    });
  }

  Future getKantor() async {
    list.clear();
    isLoading = true;
    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.getKantor(token, NetworkURL.getKantor(), jsonEncode(data))
        .then((value) {
      if (value['status'] == "Success") {
        for (Map<String, dynamic> i in value['data']) {
          list.add(KantorModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  KantorModel? kantor;

  edit(String id) {
    dialog = true;
    editData = true;
    kantor = list.where((e) => e.id == int.parse(id)).first;
    provinsi.text = kantor!.provinsi;
    kota.text = kantor!.kota;
    noKantor.text = kantor!.kodeKantor;
    kecamatan.text = kantor!.kecamatan;
    kelurahan.text = kantor!.kelurahan;
    kode.text = kantor!.kodeKantor;
    alamat.text = kantor!.alamat;
    kodepos.text = kantor!.kodePos;
    status = kantor!.statusKantor == "P"
        ? "Pusat"
        : kantor!.statusKantor == "C"
            ? "Cabang"
            : kantor!.statusKantor == "D"
                ? "Anak Cabang"
                : "Outlet/Gudang";
    kantorModel =
        list.where((e) => e.kodeKantor == kantor!.kodeInduk).isNotEmpty
            ? list.where((e) => e.kodeKantor == kantor!.kodeInduk).first
            : null;
    nama.text = kantor!.namaKantor;
    notelp.text = kantor!.telp;
    fax.text = kantor!.fax;
    kode.text = kantor!.kodeKantor;
    kodepos.text = kantor!.kodePos;
    notifyListeners();
  }

  var isLoading = true;
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

  KantorModel? kantorModel;

  pilihKantor(KantorModel value) {
    kantorModel = value;
    noKantor.text = value!.kodeKantor;
    notifyListeners();
  }

  pilihPerusahaan(PerusahaanModel value) {
    perusahaanModel = value;
    notifyListeners();
  }

  TextEditingController kode = TextEditingController();
  TextEditingController noKantor = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController provinsi = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController kecamatan = TextEditingController();
  TextEditingController kelurahan = TextEditingController();
  TextEditingController kodepos = TextEditingController();
  TextEditingController notelp = TextEditingController();
  TextEditingController fax = TextEditingController();
  final keyForm = GlobalKey<FormState>();

  List<String> listStatus = [
    "Cabang",
    "Anak Cabang",
    "Outlet/Gudang",
  ];

  String? status = "Cabang";
  pilihStatus(String value) {
    status = value;
    notifyListeners();
  }

  List<KantorModel> list = [];

  clear() {
    editData = false;
    kantorModel = null;
    status = null;
    kode.clear();
    nama.clear();
    noKantor.clear();
    alamat.clear();
    provinsi.clear();
    kota.clear();
    kecamatan.clear();
    kelurahan.clear();
    kodepos.clear();
    notelp.clear();
    fax.clear();
    notifyListeners();
  }

  var editData = false;

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
                    "Anda yakin menghapus ${kantorModel!.namaKantor}?",
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
    var json = {
      "id": kantor!.id,
    };
    Setuprepository.deleteKantor(
            token, NetworkURL.deletedKantor(), jsonEncode(json))
        .then((value) {
      Navigator.pop(context);
      if (value['status'] == "success") {
        getKantor();
        clear();
        dialog = false;
        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message']);
      }
    });
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var json = {
          "id": kantor!.id,
          "kode_pt": "${perusahaanModel!.kodePt}",
          "kode_kantor": "${kode.text}",
          "kode_induk": "${kantorModel == null ? "" : kantorModel!.kodeKantor}",
          "nama_kantor": "${nama.text}",
          "status_kantor":
              "${status == "Pusat" ? "P" : status == "Cabang" ? "C" : status == "Anak Cabang" ? "D" : "E"}",
          "alamat": "${alamat.text}",
          "kelurahan": "${kelurahan.text}",
          "kecamatan": "${kecamatan.text}",
          "kota": "${kota.text}",
          "provinsi": "${provinsi.text}",
          "kode_pos": "${kodepos.text}",
          "telp": "${notelp.text.isEmpty ? "" : notelp.text}",
          "fax": "${fax.text.isEmpty ? "" : fax.text}",
        };
        print(jsonEncode(json));
        Setuprepository.insertKantor(
                token, NetworkURL.updateKantor(), jsonEncode(json))
            .then((value) {
          Navigator.pop(context);
          if (value['status'] == "success") {
            getKantor();
            clear();
            dialog = false;
            informationDialog(context, "Information", value['message']);
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var json = {
          "kode_pt": "${perusahaanModel!.kodePt}",
          "kode_kantor": "${kode.text}",
          "kode_induk": "${kantorModel == null ? "" : kantorModel!.kodeKantor}",
          "nama_kantor": "${nama.text}",
          "status_kantor":
              "${status == "Pusat" ? "P" : status == "Cabang" ? "C" : status == "Anak Cabang" ? "D" : "E"}",
          "alamat": "${alamat.text}",
          "kelurahan": "${kelurahan.text}",
          "kecamatan": "${kecamatan.text}",
          "kota": "${kota.text}",
          "provinsi": "${provinsi.text}",
          "kode_pos": "${kodepos.text}",
          "telp": "${notelp.text.isEmpty ? "" : notelp.text}",
          "fax": "${fax.text.isEmpty ? "" : fax.text}",
        };
        Setuprepository.insertKantor(
                token, NetworkURL.addKantor(), jsonEncode(json))
            .then((value) {
          Navigator.pop(context);
          if (value['status'] == "success") {
            informationDialog(context, "Information", value['message']);
            getKantor();
            clear();
            dialog = false;
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
          }
        });
      }
    }
  }
}
