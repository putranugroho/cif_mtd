import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';

import '../../../network/network.dart';
import '../../../repository/wilayah_repository.dart';
import '../../../utils/button_custom.dart';
import '../../../utils/dialog_loading.dart';
import '../../../utils/informationdialog.dart';

class CustomerNotifier extends ChangeNotifier {
  final BuildContext context;

  CustomerNotifier({required this.context}) {
    getAoMarketing();
    getProvinsi();
    notifyListeners();
  }

  List<AoModel> listAoModel = [];
  var isLoading = true;
  getAoMarketing() async {
    isLoading = true;
    listAoModel.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getAoMarketing(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listAoModel.add(AoModel.fromJson(i));
        }
        getCustomers();
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<CustomerSupplierModel> list = [];
  getCustomers() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getCustomer(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(CustomerSupplierModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  clear() {
    dialog = false;
    editData = false;
    customerSupplierModel = null;
    noSif.clear();
    namaSif.clear();
    golCust = "Customer";
    bidangUsaha.clear();
    alamat.clear();
    kelurahan.clear();
    kecamatan.clear();
    kota.clear();
    provinsi.clear();
    kodepos.clear();
    npwp.clear();
    notelp.clear();
    email.clear();
    kontak1.clear();
    hp1.clear();
    email1.clear();
    keterangan1.clear();
    kontak2.clear();
    hp2.clear();
    email2.clear();
    keterangan2.clear();
    kontak3.clear();
    hp3.clear();
    email3.clear();
    keterangan3.clear();
    notifyListeners();
  }

  CustomerSupplierModel? customerSupplierModel;
  final keyForm = GlobalKey<FormState>();
  var editData = false;
  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": customerSupplierModel!.id,
          "kode_pt": "${customerSupplierModel!.kodePt}",
          "no_sif": "${noSif.text.trim()}",
          "nm_sif": "${namaSif.text.trim()}",
          "gol_cust":
              "${golCust == "Customer" ? 1 : golCust == "Supplier" ? 2 : 3}",
          "bidang_usaha": "${bidangUsaha.text}",
          "alamat": "${alamat.text.trim()}",
          "kelurahan": "${kelurahanModel!.name}",
          "kecamatan": "${kecamatanModel!.name}",
          "kota": "${kotaModal!.name}",
          "provinsi": "${provinsiModel!.name}",
          "kdpos": "${kodepos.text.trim()}",
          "npwp": "${npwp.text.trim()}",
          "pkp": "${pkp ? "Y" : "N"}",
          "no_telp": "${notelp.text.trim()}",
          "email": "${email.text.trim()}",
          "kontak1": "${kontak1.text.trim()}",
          "hp1": "${hp1.text.trim()}",
          "email1": "${email1.text.trim()}",
          "keterangan1": "${keterangan1.text.trim()}",
          "kontak2": "${kontak2.text.trim()}",
          "hp2": "${hp2.text.trim()}",
          "email2": "${email2.text.trim()}",
          "keterangan2": "${keterangan2.text.trim()}",
          "kontak3": "${kontak3.text.trim()}",
          "hp3": "${hp3.text.trim()}",
          "email3": "${email3.text.trim()}",
          "keterangan3": "${keterangan3.text.trim()}",
          "kode_ao_customer": "${aoModel == null ? null : aoModel!.kode}",
          "kode_ao_supplier":
              "${aoModelKRedit == null ? null : aoModelKRedit!.kode}",
        };
        // print(jsonEncode(data));
        Setuprepository.setup(
                token, NetworkURL.editCustomer(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getCustomers();
            clear();
            informationDialog(context, "Information", value['message']);
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "001",
          "no_sif": "${noSif.text.trim()}",
          "nm_sif": "${namaSif.text.trim()}",
          "gol_cust":
              "${golCust == "Customer" ? 1 : golCust == "Supplier" ? 2 : 3}",
          "bidang_usaha": "${bidangUsaha.text}",
          "alamat": "${alamat.text.trim()}",
          "kelurahan": "${kelurahanModel!.name}",
          "kecamatan": "${kecamatanModel!.name}",
          "kota": "${kotaModal!.name}",
          "provinsi": "${provinsiModel!.name}",
          "kdpos": "${kodepos.text.trim()}",
          "npwp": "${npwp.text.trim()}",
          "pkp": "${pkp ? "Y" : "N"}",
          "no_telp": "${notelp.text.trim()}",
          "email": "${email.text.trim()}",
          "kontak1": "${kontak1.text.trim()}",
          "hp1": "${hp1.text.trim()}",
          "email1": "${email1.text.trim()}",
          "keterangan1": "${keterangan1.text.trim()}",
          "kontak2": "${kontak2.text.trim()}",
          "hp2": "${hp2.text.trim()}",
          "email2": "${email2.text.trim()}",
          "keterangan2": "${keterangan2.text.trim()}",
          "kontak3": "${kontak3.text.trim()}",
          "hp3": "${hp3.text.trim()}",
          "email3": "${email3.text.trim()}",
          "keterangan3": "${keterangan3.text.trim()}",
          "kode_ao_customer": "${aoModel == null ? null : aoModel!.kode}",
          "kode_ao_supplier":
              "${aoModelKRedit == null ? null : aoModelKRedit!.kode}",
        };
        Setuprepository.setup(token, NetworkURL.addCustomer(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getCustomers();
            clear();
            informationDialog(context, "Information", value['message']);
          } else {
            informationDialog(context, "Warning", value['message']);
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
              padding: EdgeInsets.all(20),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Anda yakin menghapus ${customerSupplierModel!.nmSif}?",
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
      "id": customerSupplierModel!.id,
    };
    Setuprepository.setup(token, NetworkURL.deleteCustomer(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getCustomers();
        clear();

        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message'][0]);
      }
    });
  }

  edit(String id) {
    DialogCustom().showLoading(context);

    customerSupplierModel = list.where((e) => e.id == int.parse(id)).first;
    aoModel = listAoModel
        .where((e) => e.kode == customerSupplierModel!.kodeAoCustomer)
        .first;
    aoModelKRedit = listAoModel
        .where((e) => e.kode == customerSupplierModel!.kodeAoSupplier)
        .first;
    noSif.text = customerSupplierModel!.noSif;
    namaSif.text = customerSupplierModel!.nmSif;
    golCust = customerSupplierModel!.golCust == "1"
        ? "Customer"
        : customerSupplierModel!.golCust == "2"
            ? "Supplier"
            : "Customer dan Supplier";
    bidangUsaha.text = customerSupplierModel!.bidangUsaha;
    alamat.text = customerSupplierModel!.alamat;
    provinsiModel = listProvinsi
        .where((e) => e.name == customerSupplierModel!.provinsi)
        .first;
    listKota.clear();
    notifyListeners();
    WilayahRepository.getKota(NetworkURL.getKota(provinsiModel!.id.toString()))
        .then((value) {
      for (var i = 0; i < value.length; i++) {
        listKota.add(KotaModel(
            id: value[i]['id'],
            name: value[i]['name'],
            provinceId: provinsiModel!.id));
      }
      kotaModal =
          listKota.where((e) => e.name == customerSupplierModel!.kota).first;
      listKecamatan.clear();
      notifyListeners();
      WilayahRepository.getKota(
              NetworkURL.getKecamatan(kotaModal!.id.toString()))
          .then((valuess) {
        for (var i = 0; i < valuess.length; i++) {
          listKecamatan.add(KecamatanModel(
              id: valuess[i]['id'],
              name: valuess[i]['name'],
              regencyId: kotaModal!.id));
        }
        kecamatanModel = listKecamatan
            .where((e) => e.name == customerSupplierModel!.kecamatan)
            .first;
        listKelurahan.clear();
        notifyListeners();
        WilayahRepository.getKelurahan(
                NetworkURL.getKelurahan(kecamatanModel!.id))
            .then((e) {
          Navigator.pop(context);
          for (var i = 0; i < e.length; i++) {
            listKelurahan.add(KelurahanModel(
                id: e[i]['id'],
                name: e[i]['name'],
                districtId: kecamatanModel!.id));
          }
          kelurahanModel = listKelurahan
              .where((e) => e.name == customerSupplierModel!.kelurahan)
              .first;
          dialog = true;
          editData = true;
          notifyListeners();
        });
      });

      notifyListeners();
    });

    kodepos.text = customerSupplierModel!.kdpos;
    npwp.text = customerSupplierModel!.npwp;
    pkp = customerSupplierModel!.pkp == "Y" ? true : false;
    notelp.text = customerSupplierModel!.noTelp;
    email.text = customerSupplierModel!.email;
    kontak1.text = customerSupplierModel!.kontak1;
    hp1.text = customerSupplierModel!.hp1;
    email1.text = customerSupplierModel!.email1;
    keterangan1.text = customerSupplierModel!.keterangan1;
    kontak2.text = customerSupplierModel!.kontak2;
    hp2.text = customerSupplierModel!.hp2;
    email2.text = customerSupplierModel!.email2;
    keterangan2.text = customerSupplierModel!.keterangan2;
    kontak3.text = customerSupplierModel!.kontak3;
    hp3.text = customerSupplierModel!.hp3;
    email3.text = customerSupplierModel!.email3;
    keterangan3.text = customerSupplierModel!.keterangan3;
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

  TextEditingController noSif = TextEditingController();
  TextEditingController namaSif = TextEditingController();
  TextEditingController bidangUsaha = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController provinsi = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController kecamatan = TextEditingController();
  TextEditingController kodepos = TextEditingController();
  TextEditingController npwp = TextEditingController();
  TextEditingController kelurahan = TextEditingController();
  TextEditingController notelp = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController kontak1 = TextEditingController();
  TextEditingController hp1 = TextEditingController();
  TextEditingController email1 = TextEditingController();
  TextEditingController keterangan1 = TextEditingController();
  TextEditingController kontak2 = TextEditingController();
  TextEditingController hp2 = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController keterangan2 = TextEditingController();
  TextEditingController kontak3 = TextEditingController();
  TextEditingController hp3 = TextEditingController();
  TextEditingController email3 = TextEditingController();
  TextEditingController keterangan3 = TextEditingController();
  List<String> listGolCust = [
    "Customer",
    "Supplier",
    "Customer dan Supplier",
  ];
  String? golCust = "Customer";
  pilihGolCust(String value) {
    golCust = value;
    notifyListeners();
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
        listProvinsi.add(ProvinsiModel(
            id: value[i]['id'].toString(), name: value[i]['name']));
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
    WilayahRepository.getKota(NetworkURL.getKota(provinsiModel!.id.toString()))
        .then((value) {
      for (var i = 0; i < value.length; i++) {
        listKota.add(KotaModel(
            id: value[i]['id'],
            name: value[i]['name'],
            provinceId: provinsiModel!.id));
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
    WilayahRepository.getKota(NetworkURL.getKecamatan(kotaModal!.id.toString()))
        .then((value) {
      for (var i = 0; i < value.length; i++) {
        listKecamatan.add(KecamatanModel(
            id: value[i]['id'],
            name: value[i]['name'],
            regencyId: kotaModal!.id));
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
    WilayahRepository.getKelurahan(NetworkURL.getKelurahan(kecamatanModel!.id))
        .then((value) {
      for (var i = 0; i < value.length; i++) {
        listKelurahan.add(KelurahanModel(
            id: value[i]['id'],
            name: value[i]['name'],
            districtId: kecamatanModel!.id));
      }
      notifyListeners();
    });
  }

  pilihKelurahan(KelurahanModel value) async {
    kelurahanModel = value;
    notifyListeners();
  }

  bool pkp = false;
  pilihPkp(bool value) {
    pkp = value;
    notifyListeners();
  }

  List<AoModel> listAo = [];
  AoModel? aoModel;
  AoModel? aoModelKRedit;
  pilihAoModelDebet(AoModel value) {
    aoModel = value;
    notifyListeners();
  }

  pilihAoModelKredit(AoModel value) {
    aoModelKRedit = value;
    notifyListeners();
  }
}
