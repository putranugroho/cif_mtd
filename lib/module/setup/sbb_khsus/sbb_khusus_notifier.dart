import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../../models/coa_model.dart';
import '../../../models/inquery_gl_model.dart';
import '../../../network/network.dart';

class SbbKhususNotifier extends ChangeNotifier {
  final BuildContext context;

  SbbKhususNotifier({required this.context}) {
    getInquery();
    getGolonganSbb();
    notifyListeners();
  }
  var isLoading = true;
  List<GolonganSbbKhususModel> listGolongan = [];
  GolonganSbbKhususModel? golonganSbbKhususModel;
  pilihGolongan(GolonganSbbKhususModel value) {
    inqueryGlModel = null;
    listGlAdd.clear();
    golonganSbbKhususModel = value;
    notifyListeners();
  }

  List<SbbKhususModel> list = [];
  Future getSbbKhusus() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getSbbKhusus(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(SbbKhususModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future getGolonganSbb() async {
    isLoading = true;
    listGolongan.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getGolonganSbb(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listGolongan.add(GolonganSbbKhususModel.fromJson(i));
        }
        getSbbKhusus();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<Map<String, dynamic>> extractJnsAccB(List<dynamic> items) {
    List<Map<String, dynamic>> result = [];

    for (var item in items) {
      if (item['jns_acc'] == 'B') {
        result.add(item as Map<String, dynamic>);
      }

      if (item['items'] != null && item['items'] is List) {
        result.addAll(extractJnsAccB(item['items']));
      }
    }

    return result;
  }

  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
  List<InqueryGlModel> listGlAdd = [];
  Future getInquery() async {
    isLoadingInquery = true;
    listGl.clear();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccB(value['data']);
        for (Map<String, dynamic> i in jnsAccBItems) {
          listGl.add(InqueryGlModel.fromJson(i));
        }
        print(listGl.length);
        isLoadingInquery = false;
        notifyListeners();
      } else {
        isLoadingInquery = false;
        notifyListeners();
      }
    });
  }

  var editData = false;
  edit(String kode) {
    golonganSbbKhususModel =
        listGolongan.where((e) => e.kodeGolongan == kode).first;
    dialog = true;
    editData = true;
    notifyListeners();
  }

  pilihCoa(InqueryGlModel value) {
    if (listGlAdd.isEmpty) {
      listGlAdd.add(value);
    } else {
      if (listGlAdd.where((e) => e == value).isNotEmpty) {
        listGlAdd.remove(value);
      } else {
        listGlAdd.add(value);
      }
      notifyListeners();
    }

    notifyListeners();
  }

  var dialog = false;
  tambah() {
    golonganSbbKhususModel = null;
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  InqueryGlModel? inqueryGlModel;
  pilihSbbSatu(InqueryGlModel value) {
    inqueryGlModel = value;
    notifyListeners();
  }

  TextEditingController noBb = TextEditingController();
  pilihBB(CoaModel value) {
    bukuBesar = value;
    noBb.text = value.nosbb;

    notifyListeners();
  }

  CoaModel? bukuBesar;

  cek() {
    List<Map<String, dynamic>> json = [];
    print("listGlAdd");
    print(listGlAdd);
    print(listGlAdd.length);
    if (inqueryGlModel == null && listGlAdd.length == 0) {
      informationDialog(context, "Warning", "Harap memilih Sub Buku Besar!!");
    } else {
      DialogCustom().showLoading(context);
      if (golonganSbbKhususModel!.lebihSatuAkun == "Y") {
        for (var i = 0; i < listGlAdd.length; i++) {
          print("listGlAdd${i}");
          print(listGlAdd[i]);
          json.add({
            "id": listGlAdd[i].id,
            "gol_acc": "${listGlAdd[i].golAcc}",
            "jns_acc": "${listGlAdd[i].jnsAcc}",
            "nobb": "${listGlAdd[i].nobb}",
            "nosbb": "${listGlAdd[i].nosbb}",
            "nama_sbb": "${listGlAdd[i].namaSbb}",
            "type_posting": "${listGlAdd[i].typePosting}",
            "kode_golongan": "${golonganSbbKhususModel!.kodeGolongan}",
            "kode_pt": "${golonganSbbKhususModel!.kodePt}",
            "sbb_khusus": ""
          });
        }
      } else {
        json.add({
          "id": inqueryGlModel!.id,
          "gol_acc": "${inqueryGlModel!.golAcc}",
          "jns_acc": "${inqueryGlModel!.jnsAcc}",
          "nobb": "${inqueryGlModel!.nobb}",
          "nosbb": "${inqueryGlModel!.nosbb}",
          "nama_sbb": "${inqueryGlModel!.namaSbb}",
          "type_posting": "${inqueryGlModel!.typePosting}",
          "kode_golongan": "${golonganSbbKhususModel!.kodeGolongan}",
          "kode_pt": "${golonganSbbKhususModel!.kodePt}",
          "sbb_khusus": ""
        });
      }

      var data = {"data": json};
      // print(jsonEncode(data));
      Setuprepository.setup(token, NetworkURL.addSbbKhusus(), jsonEncode(data))
          .then((value) {
        Navigator.pop(context);
        if (value['status'].toString().toLowerCase().contains("success")) {
          informationDialog(context, "Information", value['message']);
          listGlAdd.clear();
          dialog = false;
          getSbbKhusus();
          notifyListeners();
        } else {
          informationDialog(context, "Warning", value['message']);
        }
      });
    }
  }
}
