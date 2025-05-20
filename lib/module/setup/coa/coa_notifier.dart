import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

import '../../../utils/button_custom.dart';

class CoaNotifier extends ChangeNotifier {
  final BuildContext context;

  CoaNotifier({required this.context}) {
    getMasterGl();
    getMasterGlSubtree();
    getKantor();
    notifyListeners();
  }
  List<KantorModel> listKantor = [];
  Future getKantor() async {
    listKantor.clear();
    isLoading = true;
    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.getKantor(token, NetworkURL.getKantor(), jsonEncode(data))
        .then((value) {
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

  List<dynamic> listJson = [];
  List<MasterglSubtreModel> listSubtree = [];
  Future getMasterGlSubtree() async {
    isLoading = true;
    listSubtree.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(
            token, NetworkURL.getMasterGlSubtree(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listSubtree.add(MasterglSubtreModel.fromJson(i));
        }
        listJson = value['data'];
        print(listJson);
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  var isLoading = true;
  Future getMasterGl() async {
    var data = {
      "kode_pt": "001",
    };
    isLoading = true;
    list.clear();
    notifyListeners();
    Setuprepository.setup(token, NetworkURL.getMasterGl(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(CoaModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  pilihHeader(CoaModel value) {
    header = value;
    // jnsAcc == "Sub Buku Besar" ? () {} : noBb.text = value.nobb;
    noHeader.text = header!.nosbb;
    if (noBb.text != "") {
      updatebb();
    }
    notifyListeners();
  }

  bool dialogotorisasi = false;
  otorisasi() {
    dialogotorisasi = true;
    notifyListeners();
  }

  pilihBB(CoaModel value) {
    bukuBesar = value;
    noBb.text = value.nosbb;

    if (noSbb.text != "") {
      updateSbb();
    }
    // noSbb.text = value.nosbb;
    // noHeader.text = header!.nosbb;
    notifyListeners();
  }

  CoaModel? bukuBesar;

  CoaModel? header;
  bool dialog = false;

  tambah() {
    clear();
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    dialogotorisasi = false;
    notifyListeners();
  }

  List<String> listGol = [
    "Aktiva",
    "Pasiva",
    "Pendapatan",
    "Biaya",
    "Pos Administrative",
  ];

  String? golongan;
  pilihGolongan(String value) {
    golongan = value;
    notifyListeners();
  }

  List<String> listJns = [
    "Header",
    "Buku Besar",
    "Sub Buku Besar",
  ];
  String? jnsAcc;
  pilihJenis(String value) {
    resulttext.clear();
    header = null;
    noHeader.clear();
    noBb.clear();
    bukuBesar = null;
    noSbb.clear();
    jnsAcc = value;
    notifyListeners();
  }

  updateHeader() {
    result = noHeader.text + "000000000";
    resulttext.text = result;
    notifyListeners();
  }

  updatebb() {
    result = header!.nobb.substring(0, 3) + noBb.text.trim() + "000000";
    resulttext.text = result;
    notifyListeners();
  }

  updateSbb() {
    result = bukuBesar!.nosbb.substring(0, 6) + noSbb.text.trim();
    resulttext.text = result;
    notifyListeners();
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

  confirmotorisasi() async {
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
                    "Anda yakin menjalankan otorisasi Master GL ke semua kantor?",
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
                          otorisasiSemua();
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

  otorisasiSemua() async {
    DialogCustom().showLoading(context);
    List<Map<String, dynamic>> listTmp = [];
    for (var i = 0; i < listKantor.length; i++) {
      listTmp.add(
        {
          "kode_pt": "${listKantor[i].kodePt}",
          "kode_kantor": "${listKantor[i].kodeKantor}",
          "kode_induk": "${listKantor[i].kodeInduk}"
        },
      );
    }
    var data = {
      "kode_pt": '001',
      "kode_kantor": '1000',
      "kode_induk": '',
      "userinput": 'Testing',
      "userterm": '114.80.64.90',
      "data": listTmp,
    };
    Setuprepository.setup(token, NetworkURL.otorisasi(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['code'] == "000") {
        informationDialog(context, "Warning", value['message']);
      } else {
        informationDialog(context, "Warning", value['message']);
      }
    });
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
                    "Anda yakin menghapus ${coaModel!.namaSbb}?",
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
      "nosbb": coaModel!.nosbb,
      "userinput": "Testing",
      "userterm": "114.80.30.143",
    };
    Setuprepository.setup(token, NetworkURL.deleteMasterGl(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getMasterGlSubtree();
        getMasterGl();
        clear();
        dialog = false;
        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message']);
      }
    });
  }

  clear() {
    dialog = false;
    editData = false;
    hutangPiutang = null;
    jnsAcc = null;
    perantara = false;
    resulttext.clear();
    header = null;
    noHeader.clear();
    noBb.clear();
    bukuBesar = null;
    noSbb.clear();
    namaSbb.clear();
    limitdebet.clear();
    limitkredit.clear();
    golongan = null;
    notifyListeners();
  }

  final keyForm = GlobalKey<FormState>();
  var editData = false;
  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": coaModel!.id,
          "kode_pt": "001",
          "kode_kantor": "1001",
          "kode_induk": "200",
          "userinput": "Testing",
          "userterm": "114.80.30.143",
          "gol_acc":
              "${golongan == "Aktiva" ? "1" : golongan == "Pasiva" ? "2" : golongan == "Pendapatan" ? "3" : golongan == "Biaya" ? "4" : "5"}",
          "jns_acc":
              "${jnsAcc == "Header" ? "A" : jnsAcc == "Buku Besar" ? "B" : jnsAcc == "Sub Buku Besar" ? "C" : "C"}",
          "nobb":
              "${jnsAcc == "Header" ? resulttext.text.trim() : jnsAcc == "Buku Besar" ? header!.nosbb : bukuBesar!.nosbb}",
          "nosbb": "${resulttext.text.trim()}",
          "nama_sbb": "${namaSbb.text.trim()}",
          "type_posting": "$typePosting",
          "sbb_khusus": "",
          "limit_debet":
              "${limitdebet.text.isEmpty ? "0" : limitdebet.text.replaceAll(",", "")}",
          "limit_kredit":
              "${limitkredit.text.isEmpty ? "0" : limitkredit.text.replaceAll(",", "")}",
          "akun_perantara": "${perantara ? "Y" : "N"}",
          "hutang":
              "${hutangPiutang == null ? "N" : hutangPiutang == "HUTANG" ? "Y" : "N"}",
          "piutang":
              "${hutangPiutang == null ? "N" : hutangPiutang == "PIUTANG" ? "Y" : "N"}",
        };
        print(jsonEncode(data));
        Setuprepository.setup(
                token, NetworkURL.editMasterGl(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            clear();
            getMasterGlSubtree();
            getMasterGl();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "001",
          "kode_kantor": "1001",
          "kode_induk": "200",
          "userinput": "Testing",
          "userterm": "114.80.30.143",
          "gol_acc":
              "${golongan == "Aktiva" ? "1" : golongan == "Pasiva" ? "2" : golongan == "Pendapatan" ? "3" : golongan == "Biaya" ? "4" : "5"}",
          "jns_acc":
              "${jnsAcc == "Header" ? "A" : jnsAcc == "Buku Besar" ? "B" : jnsAcc == "Sub Buku Besar" ? "C" : "C"}",
          "nobb":
              "${jnsAcc == "Header" ? resulttext.text.trim() : jnsAcc == "Buku Besar" ? header!.nosbb : bukuBesar!.nosbb}",
          "nosbb": "${resulttext.text.trim()}",
          "nama_sbb": "${namaSbb.text.trim()}",
          "type_posting": "$typePosting",
          "sbb_khusus": "",
          "limit_debet":
              "${limitdebet.text.isEmpty ? "0" : limitdebet.text.replaceAll(",", "")}",
          "limit_kredit":
              "${limitkredit.text.isEmpty ? "0" : limitkredit.text.replaceAll(",", "")}",
          "akun_perantara": "${perantara ? "Y" : "N"}",
          "hutang":
              "${hutangPiutang == null ? "N" : hutangPiutang == "HUTANG" ? "Y" : "N"}",
          "piutang":
              "${hutangPiutang == null ? "N" : hutangPiutang == "PIUTANG" ? "Y" : "N"}",
        };
        Setuprepository.setup(token, NetworkURL.addMasterGl(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            clear();
            getMasterGlSubtree();
            getMasterGl();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      }
    }
  }

  CoaModel? coaModel;
  edit(String id) {
    coaModel = list.where((e) => e.nosbb == id).first;
    confirm();
    notifyListeners();
  }

  gantiperantara() {
    perantara = !perantara;
    notifyListeners();
  }

  String result = "0000000000";
  bool seluruhKantor = false;
  gantiseluruh() {
    seluruhKantor = !seluruhKantor;
    if (seluruhKantor) {
      pilihSemua();
    } else {
      listAdd.clear();
    }
    notifyListeners();
  }

  TextEditingController limitdebet = TextEditingController(text: "0");
  TextEditingController limitkredit = TextEditingController(text: "0");
  TextEditingController resulttext = TextEditingController();
  TextEditingController noBb = TextEditingController();
  TextEditingController noKantor = TextEditingController();
  TextEditingController noHeader = TextEditingController();
  TextEditingController noSbb = TextEditingController();
  TextEditingController namaSbb = TextEditingController();
  String? typePosting = "Y";
  gantiPosting(String value) {
    typePosting = value;
    notifyListeners();
  }

  List<String> listSbbTambahanKhusus = [];

  List<String> listSBBKhusus = [
    "Kas",
    "Kas ATM",
    "Kas EDC",
    "Bank",
    "Rak",
    "Pend. RAK",
    "LR Berjalan",
    "LR Tahun Lalu",
    "Biaya RAK",
  ];

  List<String> listSBBKhusus2 = [
    "Modal",
    "ATMR",
    "Biaya Ops",
    "Pendapatan Ops",
    "Dana Pihak III",
    "Proof Sheet",
    "Loan",
    "Rupa-rupa",
  ];

  pilihSbbKhusus(String value) {
    if (listSbbTambahanKhusus.isEmpty) {
      listSbbTambahanKhusus.add(value);
    } else {
      if (listSbbTambahanKhusus.where((e) => e == value).isNotEmpty) {
        listSbbTambahanKhusus.remove(value);
      } else {
        listSbbTambahanKhusus.add(value);
      }
    }
    notifyListeners();
  }

  List<CoaModel> list = [];
  List<CoaModel> listAdd = [];

  pilihCoa(CoaModel value) {
    if (listAdd.isEmpty) {
      listAdd.add(value);
    } else {
      if (listAdd.where((e) => e == value).isNotEmpty) {
        listAdd.remove(value);
      } else {
        listAdd.add(value);
      }
    }
    notifyListeners();
  }

  pilihSemua() async {
    listAdd.addAll(list);
    notifyListeners();
  }

  List<Map<String, dynamic>> data = [
    {
      "gol_acc": "1",
      "jns_acc": "A",
      "nobb": "10000000",
      "nosbb": "10000000",
      "nama_sbb": "Kas",
      "type_posting": "N",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "B",
      "nobb": "10000000",
      "nosbb": "10001000",
      "nama_sbb": "Kas",
      "type_posting": "N",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "10001001",
      "nama_sbb": "Kas Besar",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "10001002",
      "nama_sbb": "Kas Kecil",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "10001003",
      "nama_sbb": "Kas Transaksi",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
  ];
}
