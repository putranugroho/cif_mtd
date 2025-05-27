import 'dart:convert';
import 'dart:developer';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../../utils/button_custom.dart';

class SetupTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  SetupTransaksiNotifier({required this.context}) {
    // for (Map<String, dynamic> i in data) {
    //   list.add(CoaModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in json) {
    //   listData.add(SetupTransModel.fromJson(i));
    // }
    getProfile();
    notifyListeners();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getSetupTrans();

      getInqueryAll();
      getSetupkaskecil();
      notifyListeners();
    });
  }

  List<KasKecilModel> listkas = [];
  KasKecilModel? kasKecilModel;
  Future getSetupkaskecil() async {
    isLoading = true;
    listkas.clear();
    notifyListeners();
    var data = {"kode_pt": "${users!.kodePt}"};
    Setuprepository.setup(
            token, NetworkURL.getSetupKasKecil(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listkas.add(KasKecilModel.fromJson(i));
        }
        if (listkas.isNotEmpty) {
          kasKecilModel = listkas[0];
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future getInqueryAll() async {
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "${users!.kodePt}"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccB(value['data']);
        list =
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

  var perantara = false;
  List<String> listHutang = [
    "HUTANG",
    "PIUTANG",
  ];
  String? hutangPiutang;

  gantiHutangPiutang(String value) {
    if (hutangPiutang == value) {
      hutangPiutang = null;
    } else {
      hutangPiutang = value;
    }
    notifyListeners();
  }

  SetupTransModel? setupTransModel;
  edit(String id) {
    setupTransModel = listData.where((e) => e.id == int.parse(id)).first;
    dialog = true;
    editData = true;
    kodeTransaksi.text = setupTransModel!.kdTrans;
    namaTransaksi.text = setupTransModel!.namaTrans;
    nosbbdeb.text = setupTransModel!.namaDeb;
    nossbcre.text = setupTransModel!.namaKre;
    inqueryGlModeldeb =
        list.where((e) => e.nosbb == setupTransModel!.glDeb).isNotEmpty
            ? list.where((e) => e.nosbb == setupTransModel!.glDeb).first
            : null;
    inqueryGlModelcre =
        list.where((e) => e.nosbb == setupTransModel!.glKre).isNotEmpty
            ? list.where((e) => e.nosbb == setupTransModel!.glKre).first
            : null;
    namaSbbDeb.text = setupTransModel!.glDeb;
    namaSbbCre.text = setupTransModel!.glKre;
    modul = setupTransModel!.modul;
    hutangPiutang = setupTransModel!.hutangPiutang;
    notifyListeners();
  }

  var editData = false;
  final keyForm = GlobalKey<FormState>();
  cek() {
    if (keyForm.currentState!.validate()) {
      if (modul == "KAS KECIL") {
        if (listkas.isNotEmpty) {
          if (namaSbbCre.text == kasKecilModel!.nosbbKasKecil ||
              namaSbbCre.text == kasKecilModel!.nosbbKasBon ||
              namaSbbDeb.text == kasKecilModel!.nosbbKasKecil ||
              namaSbbDeb.text == kasKecilModel!.nosbbKasBon) {
            if (editData) {
              DialogCustom().showLoading(context);
              var data = {
                "id": setupTransModel!.id,
                "kode_pt": "${users!.kodePt}",
                "kd_trans": kodeTransaksi.text.trim(),
                "nama_trans": namaTransaksi.text.trim(),
                "gl_deb": namaSbbDeb.text.trim(),
                "gl_kre": namaSbbCre.text.trim(),
                "modul": modul,
                "hutang_piutang": hutangPiutang,
              };
              Setuprepository.setup(
                      token, NetworkURL.editSetupTrans(), jsonEncode(data))
                  .then((value) {
                Navigator.pop(context);
                if (value['status']
                    .toString()
                    .toLowerCase()
                    .contains("success")) {
                  clear();
                  getSetupTrans();
                  informationDialog(context, "Information", value['message']);
                } else {
                  clear();
                  informationDialog(
                      context, "Information", value['message'][0]);
                }
              });
            } else {
              DialogCustom().showLoading(context);
              var data = {
                "kode_pt": "${users!.kodePt}",
                "kd_trans": kodeTransaksi.text.trim(),
                "nama_trans": namaTransaksi.text.trim(),
                "gl_deb": namaSbbDeb.text.trim(),
                "gl_kre": namaSbbCre.text.trim(),
                "modul": modul,
                "hutang_piutang": hutangPiutang,
              };
              Setuprepository.setup(
                      token, NetworkURL.addSetupTrans(), jsonEncode(data))
                  .then((value) {
                Navigator.pop(context);
                if (value['status']
                    .toString()
                    .toLowerCase()
                    .contains("success")) {
                  clear();
                  getSetupTrans();
                  informationDialog(context, "Information", value['message']);
                } else {
                  clear();
                  informationDialog(
                      context, "Information", value['message'][0]);
                }
              });
            }
          } else {
            informationDialog(context, "Warning",
                "Akun setup kas kecil tidak digunakan, tidak bisa melakukan simpan setup trans. pada modul Kas Kecil");
          }
        } else {
          informationDialog(context, "Warning",
              "Tidak ada akun setup kas kecil, silahkan cek akun setup kas kecil");
        }
      } else {
        if (editData) {
          DialogCustom().showLoading(context);
          var data = {
            "id": setupTransModel!.id,
            "kode_pt": "${users!.kodePt}",
            "kd_trans": kodeTransaksi.text.trim(),
            "nama_trans": namaTransaksi.text.trim(),
            "gl_deb": namaSbbDeb.text.trim(),
            "gl_kre": namaSbbCre.text.trim(),
            "modul": modul,
            "hutang_piutang": hutangPiutang,
          };
          Setuprepository.setup(
                  token, NetworkURL.editSetupTrans(), jsonEncode(data))
              .then((value) {
            Navigator.pop(context);
            if (value['status'].toString().toLowerCase().contains("success")) {
              clear();
              getSetupTrans();
              informationDialog(context, "Information", value['message']);
            } else {
              clear();
              informationDialog(context, "Information", value['message'][0]);
            }
          });
        } else {
          DialogCustom().showLoading(context);
          var data = {
            "kode_pt": "${users!.kodePt}",
            "kd_trans": kodeTransaksi.text.trim(),
            "nama_trans": namaTransaksi.text.trim(),
            "gl_deb": namaSbbDeb.text.trim(),
            "gl_kre": namaSbbCre.text.trim(),
            "modul": modul,
            "hutang_piutang": hutangPiutang,
          };
          Setuprepository.setup(
                  token, NetworkURL.addSetupTrans(), jsonEncode(data))
              .then((value) {
            Navigator.pop(context);
            if (value['status'].toString().toLowerCase().contains("success")) {
              clear();
              getSetupTrans();
              informationDialog(context, "Information", value['message']);
            } else {
              clear();
              informationDialog(context, "Information", value['message'][0]);
            }
          });
        }
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
                    "Anda yakin menghapus (${setupTransModel!.kdTrans}) ${setupTransModel!.namaTrans}?",
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
      "id": setupTransModel!.id,
    };
    Setuprepository.setup(
            token, NetworkURL.deleteSetupTrans(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getSetupTrans();
        clear();
        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message'][0]);
      }
    });
  }

  clear() {
    dialog = false;
    editData = false;
    inqueryGlModelcre = null;
    inqueryGlModeldeb = null;
    nosbbdeb.clear();
    nossbcre.clear();
    namaSbbDeb.clear();
    namaSbbCre.clear();
    kodeTransaksi.clear();
    namaTransaksi.clear();
    notifyListeners();
  }

  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nosbbdeb.text = value.namaSbb;
    namaSbbDeb.text = value.nosbb;
    notifyListeners();
  }

  pilihAkunCre(InqueryGlModel value) {
    inqueryGlModelcre = value;
    nossbcre.text = value.namaSbb;
    namaSbbCre.text = value.nosbb;
    notifyListeners();
  }

  InqueryGlModel? inqueryGlModeldeb;
  InqueryGlModel? inqueryGlModelcre;
  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
  TextEditingController nosbbdeb = TextEditingController();
  TextEditingController nossbcre = TextEditingController();
  Future<List<InqueryGlModel>> getInquery(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
      listGl.clear();
      notifyListeners();

      var data = {
        "kode_pt": "${users!.kodePt}",
      };

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

  var isLoading = true;
  Future getSetupTrans() async {
    isLoading = true;
    listData.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getSetupTrans(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listData.add(SetupTransModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<InqueryGlModel> list = [];
  CoaModel? coaModelDeb;
  pilihDeb(CoaModel value) {
    coaModelDeb = value;
    namaSbbDeb.text = value.nosbb;
    notifyListeners();
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

  TextEditingController kodeTransaksi = TextEditingController();
  TextEditingController namaTransaksi = TextEditingController();
  TextEditingController namaSbbDeb = TextEditingController();
  TextEditingController namaSbbCre = TextEditingController();

  CoaModel? coaModelCre;
  pilihCre(CoaModel value) {
    coaModelCre = value;
    namaSbbCre.text = value.nosbb;
    notifyListeners();
  }

  String? modul = "BACKOFFICE";
  gantimodul(String value) {
    modul = value;
    notifyListeners();
  }

  List<MenuModel> listMenu = [];
  List<MenuModel> listMenuAdd = [];

  pilihMenu(MenuModel value) {
    if (listMenuAdd.isEmpty) {
      listMenuAdd.add(value);
    } else {
      if (listMenuAdd.where((e) => e == value).isNotEmpty) {
        listMenuAdd.remove(value);
      } else {
        listMenuAdd.add(value);
      }
    }
    notifyListeners();
  }

  List<SetupTransModel> listData = [];
}
