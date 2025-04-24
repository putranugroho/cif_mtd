import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../../network/network.dart';
import '../../../utils/button_custom.dart';

class GolonganAsetNotifier extends ChangeNotifier {
  final BuildContext context;

  GolonganAsetNotifier({required this.context}) {
    getMetodePenyusutan();
    getInqueryAll();
    getGolonganAset();
    notifyListeners();
  }
  TextEditingController masasusut = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  var editData = false;
  clear() {
    editData = false;
    dialog = false;
    kode.clear();
    nama.clear();
    masasusut.clear();
    nilai.clear();
    sbbAset = null;
    sbbpenyusutan = null;
    sbbrugijual = null;
    sbblabajual = null;
    notifyListeners();
  }

  GolonganAsetModel? golonganAsetModel;
  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": golonganAsetModel!.id,
          "kode_pt": "001",
          "kode_golongan": "${kode.text.trim()}",
          "nama_golongan": "${nama.text.trim()}",
          "masa_susut": "${masasusut.text.trim()}",
          "nilai_declining": "${nilai.text.trim()}",
          "sbb_aset": "${sbbAset!.nosbb}",
          "sbb_penyusutan": "${sbbpenyusutan!.nosbb}",
          "sbb_rugi_jual": "${sbbrugijual!.nosbb}",
          "sbb_laba_jual": "${sbblabajual!.nosbb}",
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
            informationDialog(context, "Warning", value['message'][0]);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "001",
          "kode_golongan": "${kode.text.trim()}",
          "nama_golongan": "${nama.text.trim()}",
          "masa_susut": "${masasusut.text.trim()}",
          "nilai_declining": "${nilai.text.trim()}",
          "sbb_aset": "${sbbAset!.nosbb}",
          "sbb_penyusutan": "${sbbpenyusutan!.nosbb}",
          "sbb_rugi_jual": "${sbbrugijual!.nosbb}",
          "sbb_laba_jual": "${sbblabajual!.nosbb}",
        };
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
            informationDialog(context, "Warning", value['message'][0]);
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
        informationDialog(context, "Warning", value['message'][0]);
      }
    });
  }

  Future<List<InqueryGlModel>> getInquery(String query) async {
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
                  model.nosbb.toLowerCase().contains(query.toLowerCase()) ||
                  model.namaSbb.toLowerCase().contains(query.toLowerCase()))
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
    var data = {"kode_pt": "001"};
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
      "kode_pt": "001",
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
        nilai.text = metodePenyusutanModel!.nilaiAkhir.toString();
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
  InqueryGlModel? sbbpenyusutan;
  InqueryGlModel? sbbrugijual;
  InqueryGlModel? sbblabajual;

  TextEditingController nosbbaset = TextEditingController();
  TextEditingController nossbpenyusutan = TextEditingController();
  TextEditingController nosbbrugijual = TextEditingController();
  TextEditingController nosbblabajual = TextEditingController();
  TextEditingController namasbbaset = TextEditingController();
  TextEditingController namasbbpenyusutan = TextEditingController();
  TextEditingController namasbbrugijual = TextEditingController();
  TextEditingController namasbblabajual = TextEditingController();

  pilihSbbAset(InqueryGlModel value) {
    sbbAset = value;
    namasbbaset.text = value.namaSbb;
    nosbbaset.text = value.nosbb;
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
    var data = {"kode_pt": "001"};
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
    sbbAset = listGl
        .where((e) => e.nosbb == golonganAsetModel!.sbbAset.substring(1, 13))
        .first;
    sbbpenyusutan = listGl
        .where(
            (e) => e.nosbb == golonganAsetModel!.sbbPenyusutan.substring(1, 13))
        .first;
    sbbrugijual = listGl
        .where(
            (e) => e.nosbb == golonganAsetModel!.sbbRugiJual.substring(1, 13))
        .first;
    sbblabajual = listGl
        .where(
            (e) => e.nosbb == golonganAsetModel!.sbbLabaJual.substring(1, 13))
        .first;
    namasbbaset.text = sbbAset!.namaSbb;
    nosbbaset.text = sbbAset!.nosbb;
    namasbbpenyusutan.text = sbbpenyusutan!.namaSbb;
    nossbpenyusutan.text = sbbpenyusutan!.nosbb;
    namasbbrugijual.text = sbbrugijual!.namaSbb;
    nosbbrugijual.text = sbbrugijual!.nosbb;
    namasbblabajual.text = sbblabajual!.namaSbb;
    nosbblabajual.text = sbblabajual!.nosbb;
    notifyListeners();
  }
}
