import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BanyakTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  BanyakTransaksiNotifier({required this.context}) {
    for (Map<String, dynamic> i in coa) {
      listCoa.add(CoaModel.fromJson(i));
    }
    for (Map<String, dynamic> i in data) {
      listData.add(TransaksiModel.fromJson(i));
    }
    for (Map<String, dynamic> i in ao) {
      listAo.add(AoModel.fromJson(i));
    }
    listAmount.add(TextEditingController(text: "0"));
    notifyListeners();
  }

  int transaksi = 1;

  List<TextEditingController> listAmount = [];

  tambahTransaksi() {
    transaksi++;
    listAmount.add(TextEditingController(text: "0"));
    notifyListeners();
  }

  changeMaster() {
    total = int.parse(nominal.text.replaceAll(",", ''));
    notifyListeners();
  }

  int total = 0;
  changeTotal() {
    total = int.parse(nominal.text.replaceAll(",", '')) -
        listAmount
            .map((e) => int.parse(e.text.replaceAll(",", "")))
            .reduce((a, b) => a + b);
    notifyListeners();
  }

  confirmPrint() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog();
        });
  }

  DateTime? tglTransaksi;
  Future pilihTanggalBuka() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) + 10,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
    ));
    if (pickedendDate != null) {
      tglTransaksi = pickedendDate;
      tglTransaksiText.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController nomorRef = TextEditingController();

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<TransaksiModel> listData = [];
  List<Map<String, dynamic>> data = [
    {
      "tgl_trans": "2025-03-26",
      "trans_user": "Edi Kurniawan",
      "kode_trans": "8902989844i9491",
      "debet_acc": "100010001",
      "nama_debet": "Kas Besar",
      "credit_acc": "100010002",
      "nama_credit": "Kas Kecil",
      "nomor_dok": "",
      "nomor_ref": "8902989844i9491",
      "nominal": "1000000",
      "keterangan": "",
      "kode_pt": "001",
      "kode_kantor": "10001",
      "kode_induk": "",
      "kode_ao_debet": "",
      "kode_ao_credit": ""
    }
  ];

  List<CoaModel> listCoa = [];

  TextEditingController namaSbbAset = TextEditingController();
  CoaModel? sbbAset;
  pilihSbbAset(CoaModel value) {
    sbbAset = value;
    namaSbbAset.text = value.nosbb;
    notifyListeners();
  }

  TextEditingController masasusut = TextEditingController();
  TextEditingController namaSbbpenyusutan = TextEditingController();
  CoaModel? sbbpenyusutan;
  pilihSbbpenyusutan(CoaModel value) {
    sbbpenyusutan = value;
    namaSbbpenyusutan.text = value.nosbb;
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

  List<Map<String, dynamic>> ao = [
    {
      "kd_ao": "100001",
      "nm_ao": "Account Officer 1",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": ""
    },
    {
      "kd_ao": "100002",
      "nm_ao": "Account Officer 2",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": ""
    },
    {
      "kd_ao": "100003",
      "nm_ao": "Marketing 1",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": ""
    },
  ];

  List<Map<String, dynamic>> coa = [
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
