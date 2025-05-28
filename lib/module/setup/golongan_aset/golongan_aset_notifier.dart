import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../../network/network.dart';
import '../../../utils/button_custom.dart';

class GolonganAsetNotifier extends ChangeNotifier {
  final BuildContext context;

  GolonganAsetNotifier({required this.context}) {
    getProfile();
    notifyListeners();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getMetodePenyusutan();
      getInqueryAll();
      getGolonganAset();
      notifyListeners();
    });
  }

  TextEditingController masasusut = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  var editData = false;
  clear() {
    editData = false;
    dialog = false;
    kode.clear();
    nama.clear();
    sbbAset = null;
    sbbpenyusutan = null;
    sbbrugijual = null;
    sbblabajual = null;
    notifyListeners();
  }

  GolonganAsetModel? golonganAsetModel;
  cek() {
    print("Simpan");
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": golonganAsetModel!.id,
          "kode_pt": "${users!.kodePt}",
          "kode_golongan": "${kode.text.trim()}",
          "nama_golongan": "${nama.text.trim()}",
          "masa_susut":
              "${masasusut.text.isEmpty ? "" : masasusut.text.trim()}",
          "nilai_declining": "${nilai.text.isEmpty ? "" : nilai.text.trim()}",
          "sbb_aset": sbbAset == null ? null : sbbAset!.nosbb,
          "sbb_penyusutan": sbbpenyusutan == null ? null : sbbpenyusutan!.nosbb,
          "sbb_rugi_jual": sbbrugijual == null ? null : sbbrugijual!.nosbb,
          "sbb_laba_jual": sbblabajual == null ? null : sbblabajual!.nosbb,
          "sbb_ppn": sbbppn == null ? null : sbbppn!.nosbb,
          "sbb_pph": sbbpph == null ? null : sbbpph!.nosbb,
        };
        Setuprepository.setup(
                token, NetworkURL.editGolonganAset(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            clear();
            getGolonganAset();
            getInqueryAll();
            informationDialog(context, "Information", value['message']);
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "${users!.kodePt}",
          "kode_golongan": "${kode.text.trim()}",
          "nama_golongan": "${nama.text.trim()}",
          "masa_susut":
              "${masasusut.text.isEmpty ? "" : masasusut.text.trim()}",
          "nilai_declining": "${nilai.text.isEmpty ? "" : nilai.text.trim()}",
          "sbb_aset": "${sbbAset!.nosbb}",
          "sbb_penyusutan": "${sbbpenyusutan!.nosbb}",
          "sbb_rugi_jual": "${sbbrugijual!.nosbb}",
          "sbb_laba_jual": "${sbblabajual!.nosbb}",
          "sbb_ppn": sbbppn == null ? null : sbbppn!.nosbb,
          "sbb_pph": sbbpph == null ? null : sbbpph!.nosbb,
        };
        print(jsonEncode(data));
        Setuprepository.setup(
                token, NetworkURL.addGolonganAset(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            clear();
            getGolonganAset();
            getInqueryAll();
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
                    "Anda yakin menghapus (${golonganAsetModel!.kodeGolongan}) ${golonganAsetModel!.namaGolongan}?",
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
      "id": golonganAsetModel!.id,
    };
    Setuprepository.setup(token, NetworkURL.deletedJabatan(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        clear();
        informationDialog(context, "Information", value['message']);
      } else {
        informationDialog(context, "Warning", value['message']);
      }
    });
  }

  Future<List<InqueryGlModel>> getInquerySbbAset(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listGl.clear();
      notifyListeners();

      var data = {"kode_pt": "001"};

      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getInqueryGL(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          final List<Map<String, dynamic>> jnsAccBItems =
              extractJnsAccB(response['data']);
          listGl = jnsAccBItems
              .map((item) => InqueryGlModel.fromJson(item))
              .where((model) =>
                  model.golAcc == "1" &&
                  (model.nosbb.toLowerCase().contains(query.toLowerCase()) ||
                      model.namaSbb
                          .toLowerCase()
                          .contains(query.toLowerCase())))
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        isLoadingInquery = false;
        notifyListeners();
      }
    } else {
      listGl.clear(); // clear on short query
    }

    return listGl;
  }

  Future<List<InqueryGlModel>> getInquerySbbppn(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listGl.clear();
      notifyListeners();

      var data = {"kode_pt": "001"};

      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getInqueryGL(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          final List<Map<String, dynamic>> jnsAccBItems =
              extractJnsAccB(response['data']);
          listGl = jnsAccBItems
              .map((item) => InqueryGlModel.fromJson(item))
              .where((model) =>
                  model.golAcc == "2" &&
                  (model.nosbb.toLowerCase().contains(query.toLowerCase()) ||
                      model.namaSbb
                          .toLowerCase()
                          .contains(query.toLowerCase())))
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        isLoadingInquery = false;
        notifyListeners();
      }
    } else {
      listGl.clear(); // clear on short query
    }

    return listGl;
  }

  Future<List<InqueryGlModel>> getInquerySbbpph(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listGl.clear();
      notifyListeners();

      var data = {"kode_pt": "001"};

      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getInqueryGL(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          final List<Map<String, dynamic>> jnsAccBItems =
              extractJnsAccB(response['data']);
          listGl = jnsAccBItems
              .map((item) => InqueryGlModel.fromJson(item))
              .where((model) =>
                  model.golAcc == "2" &&
                  (model.nosbb.toLowerCase().contains(query.toLowerCase()) ||
                      model.namaSbb
                          .toLowerCase()
                          .contains(query.toLowerCase())))
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        isLoadingInquery = false;
        notifyListeners();
      }
    } else {
      listGl.clear(); // clear on short query
    }

    return listGl;
  }

  Future<List<InqueryGlModel>> getInquerySbbPenyusutan(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listGl.clear();
      notifyListeners();

      var data = {"kode_pt": "001"};

      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getInqueryGL(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          final List<Map<String, dynamic>> jnsAccBItems =
              extractJnsAccB(response['data']);
          listGl = jnsAccBItems
              .map((item) => InqueryGlModel.fromJson(item))
              .where((model) =>
                  model.golAcc == "4" &&
                  (model.nosbb.toLowerCase().contains(query.toLowerCase()) ||
                      model.namaSbb
                          .toLowerCase()
                          .contains(query.toLowerCase())))
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        isLoadingInquery = false;
        notifyListeners();
      }
    } else {
      listGl.clear(); // clear on short query
    }

    return listGl;
  }

  Future<List<InqueryGlModel>> getInquerySbbLabaJual(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listGl.clear();
      notifyListeners();

      var data = {"kode_pt": "001"};

      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getInqueryGL(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          final List<Map<String, dynamic>> jnsAccBItems =
              extractJnsAccB(response['data']);
          listGl = jnsAccBItems
              .map((item) => InqueryGlModel.fromJson(item))
              .where((model) =>
                  model.golAcc == "3" &&
                  (model.nosbb.toLowerCase().contains(query.toLowerCase()) ||
                      model.namaSbb
                          .toLowerCase()
                          .contains(query.toLowerCase())))
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        isLoadingInquery = false;
        notifyListeners();
      }
    } else {
      listGl.clear(); // clear on short query
    }

    return listGl;
  }

  Future getInqueryAll() async {
    listGl.clear();
    notifyListeners();
    var data = {"kode_pt": "${users!.kodePt}"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccB(value['data']);
        listGl =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        notifyListeners();
      }
    });
  }

  List<Map<String, dynamic>> extractJnsAccB(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];

    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          if (item['jns_acc'] == 'C') {
            result.add(item);
          }

          if (item.containsKey('items') && item['items'] is List) {
            traverse(item['items']);
          }
        }
      }
    }

    traverse(rawData);
    return result;
  }

  List<MetodePenyusutanModel> listPenyusutan = [];
  MetodePenyusutanModel? metodePenyusutanModel;
  Future getMetodePenyusutan() async {
    isLoading = true;
    listPenyusutan.clear();
    var data = {
      "kode_pt": "${users!.kodePt}",
    };
    notifyListeners();
    Setuprepository.setup(
            token, NetworkURL.getMetodePenyusutan(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listPenyusutan.add(MetodePenyusutanModel.fromJson(i));
        }
        metodePenyusutanModel = listPenyusutan[0];
        metode = int.parse(metodePenyusutanModel!.metodePenyusutan);
        // nilai.text = metodePenyusutanModel!.nilaiAkhir.toString();
        print(metodePenyusutanModel!.declining.toString());
        nilai.text = metodePenyusutanModel!.declining.toString();
        isLoading = false;
        notifyListeners();
      } else {
        // informationDialog(context, "Warning", value['message'][0]);
        notifyListeners();
      }
    });
    notifyListeners();
  }

  int metode = 0;

  InqueryGlModel? sbbAset;
  InqueryGlModel? sbbppn;
  InqueryGlModel? sbbpph;
  InqueryGlModel? sbbpenyusutan;
  InqueryGlModel? sbbrugijual;
  InqueryGlModel? sbblabajual;

  TextEditingController nosbbaset = TextEditingController();
  TextEditingController nosbbppn = TextEditingController();
  TextEditingController nosbbpph = TextEditingController();
  TextEditingController nossbpenyusutan = TextEditingController();
  TextEditingController nosbbrugijual = TextEditingController();
  TextEditingController nosbblabajual = TextEditingController();
  TextEditingController namasbbaset = TextEditingController();
  TextEditingController namasbbppn = TextEditingController();
  TextEditingController namasbbpph = TextEditingController();
  TextEditingController namasbbpenyusutan = TextEditingController();
  TextEditingController namasbbrugijual = TextEditingController();
  TextEditingController namasbblabajual = TextEditingController();

  pilihSbbAset(InqueryGlModel value) {
    sbbAset = value;
    namasbbaset.text = value.namaSbb;
    nosbbaset.text = value.nosbb;
    notifyListeners();
  }

  pilihsbbppn(InqueryGlModel value) {
    sbbppn = value;
    namasbbppn.text = value.namaSbb;
    nosbbppn.text = value.nosbb;
    notifyListeners();
  }

  pilihsbbpph(InqueryGlModel value) {
    sbbpph = value;
    namasbbpph.text = value.namaSbb;
    nosbbpph.text = value.nosbb;
    notifyListeners();
  }

  pilihSbbPenyusutan(InqueryGlModel value) {
    sbbpenyusutan = value;
    namasbbpenyusutan.text = value.namaSbb;
    nossbpenyusutan.text = value.nosbb;
    notifyListeners();
  }

  pilihSbbRugiJual(InqueryGlModel value) {
    sbbrugijual = value;
    namasbbrugijual.text = value.namaSbb;
    nosbbrugijual.text = value.nosbb;
    notifyListeners();
  }

  pilihSbbLabaJual(InqueryGlModel value) {
    sbblabajual = value;
    namasbblabajual.text = value.namaSbb;
    nosbblabajual.text = value.nosbb;
    notifyListeners();
  }

  var isLoading = true;
  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];

  Future getGolonganAset() async {
    isLoading = true;
    listData.clear();
    var data = {"kode_pt": "${users!.kodePt}"};
    Setuprepository.setup(token, NetworkURL.getGolonganAset(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listData.add(GolonganAsetModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController masa = TextEditingController();
  TextEditingController nilai = TextEditingController();

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

  List<GolonganAsetModel> listData = [];

  edit(String id) {
    golonganAsetModel = listData.where((e) => e.id == int.parse(id)).first;
    editData = true;
    dialog = true;
    kode.text = golonganAsetModel!.kodeGolongan;
    nama.text = golonganAsetModel!.namaGolongan;
    nilai.text = golonganAsetModel!.nilaiDeclining;
    masasusut.text = golonganAsetModel!.masaSusut;
    // print(golonganAsetModel!.sbbAset.substring(1, 13));
    sbbAset = listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbAset.toString().substring(1, 13))
            .isNotEmpty
        ? listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbAset.toString().substring(1, 13))
            .first
        : null;
    sbbpenyusutan = listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbPenyusutan.toString().substring(1, 13))
            .isNotEmpty
        ? listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbPenyusutan.toString().substring(1, 13))
            .first
        : null;
    sbbrugijual = listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbRugiJual.toString().substring(1, 13))
            .isNotEmpty
        ? listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbRugiJual.toString().substring(1, 13))
            .first
        : null;
    sbblabajual = listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbLabaJual.toString().substring(1, 13))
            .isNotEmpty
        ? listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbLabaJual.toString().substring(1, 13))
            .first
        : null;
    sbbppn = listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbPpn.toString().substring(1, 13))
            .isNotEmpty
        ? listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbPpn.toString().substring(1, 13))
            .first
        : null;
    sbbpph = listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbPph.toString().substring(1, 13))
            .isNotEmpty
        ? listGl
            .where((e) =>
                e.nosbb ==
                golonganAsetModel!.sbbPph.toString().substring(1, 13))
            .first
        : null;
    namasbbaset.text = sbbAset == null ? "" : sbbAset!.namaSbb;
    namasbbppn.text = sbbppn == null ? "" : sbbppn!.namaSbb;
    nosbbppn.text = sbbppn == null ? "" : sbbppn!.nosbb;

    namasbbpph.text = sbbpph == null ? "" : sbbpph!.namaSbb;
    nosbbpph.text = sbbpph == null ? "" : sbbpph!.nosbb;
    nosbbaset.text = sbbAset == null ? "" : sbbAset!.nosbb;
    namasbbpenyusutan.text =
        sbbpenyusutan == null ? "" : sbbpenyusutan!.namaSbb;
    nossbpenyusutan.text = sbbpenyusutan == null ? "" : sbbpenyusutan!.nosbb;
    namasbbrugijual.text = sbbrugijual == null ? "" : sbbrugijual!.namaSbb;
    nosbbrugijual.text = sbbrugijual == null ? "" : sbbrugijual!.nosbb;
    namasbblabajual.text = sbblabajual == null ? "" : sbblabajual!.namaSbb;
    nosbblabajual.text = sbblabajual == null ? "" : sbblabajual!.nosbb;
    notifyListeners();
  }
}
