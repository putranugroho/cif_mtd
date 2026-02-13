import 'dart:convert';
import 'dart:math';

import 'package:cif/models/index.dart';
import 'package:cif/network/network.dart';
import 'package:cif/repository/SetupRepository.dart';
import 'package:cif/utils/dialog_loading.dart';
import 'package:cif/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../../repository/wilayah_repository.dart';
import '../../../utils/button_custom.dart';

class SandiBiNotifier extends ChangeNotifier {
  final BuildContext context;

  SandiBiNotifier({required this.context}) {
    getPerusahaan();
    getProvinsi();
  }

  List<ProvinsiModel> listProvinsi = [];
  ProvinsiModel? provinsiModel;
  List<KotaModel> listKota = [];
  KotaModel? kotaModal;
  List<KecamatanModel> listKecamatan = [];
  KecamatanModel? kecamatanModel;
  List<KelurahanModel> listKelurahan = [];
  KelurahanModel? kelurahanModel;
  Future getProvinsi() async {
    WilayahRepository.getProvinsi(NetworkURL.getProvinsi()).then((value) {
      for (var i = 0; i < value.length; i++) {
        listProvinsi.add(ProvinsiModel(id: value[i]['id'].toString(), name: value[i]['name']));
      }
      notifyListeners();
    });
  }

  pilihProvinsi(ProvinsiModel value) {
    provinsiModel = value;
    kotaModal = null;
    kecamatanModel = null;
    kelurahanModel = null;
    listKota.clear();
    listKecamatan.clear();
    listKelurahan.clear();
    getKota();
    notifyListeners();
  }

  getKota() async {
    listKota.clear();
    notifyListeners();
    WilayahRepository.getKota(NetworkURL.getKota(provinsiModel!.id.toString())).then((value) {
      for (var i = 0; i < value.length; i++) {
        listKota.add(KotaModel(id: value[i]['id'], name: value[i]['name'], provinceId: provinsiModel!.id));
      }

      notifyListeners();
    });
  }

  pilihKota(KotaModel value) {
    kotaModal = value;
    kecamatanModel = null;
    kelurahanModel = null;
    listKecamatan.clear();
    listKelurahan.clear();
    getKecamatan();
    notifyListeners();
  }

  getKecamatan() async {
    listKecamatan.clear();
    notifyListeners();
    WilayahRepository.getKota(NetworkURL.getKecamatan(kotaModal!.id.toString())).then((value) {
      for (var i = 0; i < value.length; i++) {
        listKecamatan.add(KecamatanModel(id: value[i]['id'], name: value[i]['name'], regencyId: kotaModal!.id));
      }

      notifyListeners();
    });
  }

  pilihKecamatan(KecamatanModel value) {
    kecamatanModel = value;
    kelurahanModel = null;
    listKelurahan.clear();
    getKelurahan();
    notifyListeners();
  }

  getKelurahan() async {
    listKelurahan.clear();
    notifyListeners();
    WilayahRepository.getKelurahan(NetworkURL.getKelurahan(kecamatanModel!.id)).then((value) {
      for (var i = 0; i < value.length; i++) {
        listKelurahan.add(KelurahanModel(id: value[i]['id'], name: value[i]['name'], districtId: kecamatanModel!.id));
      }
      notifyListeners();
    });
  }

  pilihKelurahan(KelurahanModel value) async {
    kelurahanModel = value;
    notifyListeners();
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
    Setuprepository.getPerusahaan(token, NetworkURL.gerPerusahaan(), jsonEncode(data)).then((value) {
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

  edit(String id) {
    DialogCustom().showLoading(context);
    kantor = list.where((e) => e.id == int.parse(id)).first;
    provinsiModel = listProvinsi.where((e) => e.name == kantor!.provinsi).first;
    listKota.clear();
    notifyListeners();
    WilayahRepository.getKota(NetworkURL.getKota(provinsiModel!.id.toString())).then((value) {
      for (var i = 0; i < value.length; i++) {
        listKota.add(KotaModel(id: value[i]['id'], name: value[i]['name'], provinceId: provinsiModel!.id));
      }
      kotaModal = listKota.where((e) => e.name == kantor!.kota).first;
      listKecamatan.clear();
      notifyListeners();
      WilayahRepository.getKota(NetworkURL.getKecamatan(kotaModal!.id.toString())).then((valuess) {
        for (var i = 0; i < valuess.length; i++) {
          listKecamatan.add(KecamatanModel(id: valuess[i]['id'], name: valuess[i]['name'], regencyId: kotaModal!.id));
        }
        kecamatanModel = listKecamatan.where((e) => e.name == kantor!.kecamatan).first;
        listKelurahan.clear();
        notifyListeners();
        WilayahRepository.getKelurahan(NetworkURL.getKelurahan(kecamatanModel!.id)).then((e) {
          Navigator.pop(context);
          for (var i = 0; i < e.length; i++) {
            listKelurahan.add(KelurahanModel(id: e[i]['id'], name: e[i]['name'], districtId: kecamatanModel!.id));
          }
          kelurahanModel = listKelurahan.where((e) => e.name == kantor!.kelurahan).first;
          dialog = true;
          editData = true;
          notifyListeners();
        });
      });

      notifyListeners();
    });

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
    kantorModel = list.where((e) => e.kodeKantor == kantor!.kodeInduk).isNotEmpty ? list.where((e) => e.kodeKantor == kantor!.kodeInduk).first : null;
    noKantor.text = kantorModel!.kodeKantor;
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
    noKantor.text = value.kodeKantor;
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

  String? status;
  pilihStatus(String value) {
    status = value;
    kantorModel = null;
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
              padding: const EdgeInsets.all(20),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Anda yakin menghapus ${kantor!.namaKantor}?",
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
    var json = {
      "id": kantor!.id,
    };
    Setuprepository.deleteKantor(token, NetworkURL.deletedKantor(), jsonEncode(json)).then((value) {
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
      final random = Random();
      int randomNumber = 1000 + random.nextInt(9000);
      if (editData) {
        DialogCustom().showLoading(context);
        var json = {
          "id": kantor!.id,
          "kode_pt": perusahaanModel!.kodePt,
          "kode_kantor": kode.text,
          "kode_induk": kantorModel == null ? "" : kantorModel!.kodeKantor,
          "nama_kantor": nama.text,
          "status_kantor": status == "Pusat"
              ? "P"
              : status == "Cabang"
                  ? "C"
                  : status == "Anak Cabang"
                      ? "D"
                      : "E",
          "alamat": alamat.text,
          "kelurahan": kelurahanModel!.name,
          "kecamatan": kecamatanModel!.name,
          "kota": kotaModal!.name,
          "provinsi": provinsiModel!.name,
          "kode_pos": kodepos.text,
          "telp": notelp.text.isEmpty ? "" : notelp.text,
          "fax": fax.text.isEmpty ? "" : fax.text,
        };
        print(jsonEncode(json));
        Setuprepository.insertKantor(token, NetworkURL.updateKantor(), jsonEncode(json)).then((value) {
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
          "kode_pt": perusahaanModel!.kodePt,
          "kode_kantor": kode.text,
          "kode_induk": kantorModel == null ? "" : kantorModel!.kodeKantor,
          "nama_kantor": nama.text,
          "status_kantor": status == "Pusat"
              ? "P"
              : status == "Cabang"
                  ? "C"
                  : status == "Anak Cabang"
                      ? "D"
                      : "E",
          "alamat": alamat.text,
          "kelurahan": kelurahanModel!.name,
          "kecamatan": kecamatanModel!.name,
          "kota": kotaModal!.name,
          "provinsi": provinsiModel!.name,
          "kode_pos": kodepos.text,
          "telp": notelp.text.isEmpty ? "" : notelp.text,
          "fax": fax.text.isEmpty ? "" : fax.text,
        };
        Setuprepository.insertKantor(token, NetworkURL.addKantor(), jsonEncode(json)).then((value) {
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
