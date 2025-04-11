import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class CoaNotifier extends ChangeNotifier {
  final BuildContext context;

  CoaNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(CoaModel.fromJson(i));
    }
    notifyListeners();
  }

  pilihHeader(CoaModel value) {
    header = value;
    jnsAcc == "Sub Buku Besar" ? () {} : noBb.text = value.nobb;
    noHeader.text = header!.nosbb;
    notifyListeners();
  }

  bool dialogotorisasi = false;
  otorisasi() {
    dialogotorisasi = true;
    notifyListeners();
  }

  pilihBB(CoaModel value) {
    bukuBesar = value;

    noSbb.text = value.nosbb;
    noBb.text = value.nosbb;
    // noHeader.text = header!.nosbb;
    notifyListeners();
  }
  CoaModel? bukuBesar;

  CoaModel? header;
  bool dialog = false;

  tambah() {
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
    jnsAcc = value;
    notifyListeners();
  }

  updateHeader() {
    result = noHeader.text + "0000000";
    resulttext.text = result;
    notifyListeners();
  }

  updatebb() {
    result = header!.nobb.substring(0, 3) + noBb.text.trim() + "0000";
    resulttext.text = result;
    notifyListeners();
  }

  updateSbb() {
    result = header!.nobb.substring(0, 3) +
        bukuBesar!.nosbb.substring(3, 6) +
        noSbb.text.trim();
    resulttext.text = result;
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

  TextEditingController limitdebet = TextEditingController();
  TextEditingController limitkredit = TextEditingController();
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
