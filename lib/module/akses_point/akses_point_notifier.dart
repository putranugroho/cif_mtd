import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

class AksesPointNotifier extends ChangeNotifier {
  final BuildContext context;

  AksesPointNotifier({required this.context}) {
    getAksesPoint();
    getKantor();
  }

  TextEditingController noKantor = TextEditingController();
  pilihKantor(KantorModel value) {
    kantor = value;
    noKantor.text = value.kodeKantor;
    notifyListeners();
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": aksesPointModel!.id,
          "kode_pt": "001",
          "no_akses": noAkses.text,
          "akses_id": aksesId.text,
          "kode_kantor": kantor!.kodeKantor,
          "nama_kantor": kantor!.namaKantor,
          "lokasi": "$lokasi",
          "type": "$akses",
          "alamat": alamat.text,
          "keterangan": keterangan.text,
        };
        Setuprepository.updatesetup(token, NetworkURL.editAksesPoint(aksesPointModel!.id), jsonEncode(data)).then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getAksesPoint();
            informationDialog(context, "Information", "Akses Point created Successfully");
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
          "no_akses": noAkses.text,
          "akses_id": aksesId.text,
          "kode_kantor": kantor!.kodeKantor,
          "nama_kantor": kantor!.namaKantor,
          "lokasi": "$lokasi",
          "type": "$akses",
          "alamat": alamat.text,
          "keterangan": keterangan.text,
        };
        Setuprepository.setup(token, NetworkURL.insertAksesPoint(), jsonEncode(data)).then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getAksesPoint();
            informationDialog(context, "Information", "Akses Point created Successfully");
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

  clear() {
    dialog = false;
    noAkses.clear();
    aksesId.clear();
    kantor = null;
    lokasi = null;
    akses = null;
    alamat.clear();
    keterangan.clear();
    notifyListeners();
  }

  confirm() {}
  AksesPointModel? aksesPointModel;
  edit(String id) {
    aksesPointModel = listData.where((e) => e.id == int.parse(id)).first;
    dialog = true;
    editData = true;
    noAkses.text = aksesPointModel!.noAkses;
    aksesId.text = aksesPointModel!.aksesId;
    print(aksesPointModel!.kodeKantor);
    print(aksesPointModel!.id);

    kantor = list.where((e) => e.kodeKantor == aksesPointModel!.kodeKantor).first;
    lokasi = aksesPointModel!.lokasi;
    akses = aksesPointModel!.type;
    alamat.text = aksesPointModel!.alamat;
    keterangan.text = aksesPointModel!.keterangan;
    notifyListeners();
  }

  final keyForm = GlobalKey<FormState>();
  List<AksesPointModel> listData = [];
  getAksesPoint() async {
    listData.clear();
    isLoading = true;
    notifyListeners();
    var data = {
      "kode_pt": "001"
    };
    Setuprepository.setup(token, NetworkURL.getAksesPoint(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listData.add(AksesPointModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<KantorModel> list = [];
  var isLoading = true;
  Future getKantor() async {
    list.clear();
    isLoading = true;
    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.getKantor(token, NetworkURL.getKantor(), jsonEncode(data)).then((value) {
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

  TextEditingController noAkses = TextEditingController();
  TextEditingController aksesId = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  List<String> tipeLokasi = [
    "Kantor",
    "Luar Kantor",
    "Karyawan",
  ];

  List<String> tipeAkses = [
    "LAN",
    "WIFI",
  ];
  String? akses = "LAN";
  pilihAkses(String value) {
    akses = value;
    notifyListeners();
  }

  String? lokasi = "Kantor";
  pilihlokasi(String value) {
    lokasi = value;
    notifyListeners();
  }

  var dialog = false;
  var editData = false;
  tambah() {
    dialog = true;
    noAkses.clear();
    aksesId.clear();
    alamat.clear();
    keterangan.clear();
    // lokasi = null;
    // akses = null;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }
}
