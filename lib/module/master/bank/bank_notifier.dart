import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BankNotifier extends ChangeNotifier {
  final BuildContext context;

  BankNotifier({required this.context}) {
    // for (Map<String, dynamic> i in json) {
    //   list.add(BankModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in coa) {
    //   listCoa.add(CoaModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in bankJson) {
    //   listBank.add(SandiBankModel.fromJson(i));
    // }
    notifyListeners();
  }

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  DateTime? tglBuka = DateTime.now();
  DateTime? tglJatuhTempo = DateTime.now();

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
      firstDate: DateTime(1950),
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
      tglBuka = pickedendDate;
      tglBukaRekening.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  Future pilihTanggalJatuhTempo() async {
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
      firstDate: DateTime(1950),
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
      tglJatuhTempo = pickedendDate;
      tglJatuhTempoRekening.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController nilai = TextEditingController();
  TextEditingController saldoEOM = TextEditingController();
  TextEditingController noRek = TextEditingController();
  TextEditingController tglBukaRekening = TextEditingController();
  TextEditingController tglJatuhTempoRekening = TextEditingController();
  List<String> jnsRekening = [
    "Tabungan",
    "Giro",
    "Deposito",
  ];
  String? rekening;
  pilihRekening(String value) {
    rekening = value;
    notifyListeners();
  }

  List<CoaModel> listCoa = [];

  TextEditingController namaSbbAset = TextEditingController();
  CoaModel? sbbAset;
  pilihSbbAset(CoaModel value) {
    sbbAset = value;
    namaSbbAset.text = value.nosbb;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

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

  List<BankModel> list = [];
  List<Map<String, dynamic>> json = [
    {
      "kode_bank": "10001",
      "nm_bank": "BANK MANDIRI",
      "no_rek": "30000112333",
      "kd_rek": "10",
      "nosbb": "100100000006",
      "nama_sbb": "BANK MANDIRI",
      "nominal": "10000000",
      "jw": "",
      "tglbuka": "",
      "tgljtempo": "",
      "saldoeom": "",
      "kode_pt": "001",
      "kode_kantor": "10001",
      "kode_induk": ""
    }
  ];
  var search = false;
  cariRekening() async {
    search = true;
    namaRek.text = "PT TEGUH AMAN LESTARI";
    notifyListeners();
  }

  TextEditingController kodeBank = TextEditingController();
  TextEditingController namaRek = TextEditingController();
  List<SandiBankModel> listBank = [];
  SandiBankModel? sandiBankModel;
  pilihSandi(SandiBankModel value) {
    sandiBankModel = value;
    kodeBank.text = sandiBankModel!.kodeBank;
    notifyListeners();
  }

  List<Map<String, dynamic>> bankJson = [
    {
      "id": 1,
      "sandi_bic": "AGTBIDJA",
      "nama_bank": "PT. BANK RAYA INDONESIA, TBK",
      "nama_bank_singkat": "BANK RAYA",
      "kode_bank": "494",
      "kode_kantor": "0014"
    },
    {
      "id": 83,
      "sandi_bic": "CENAIDJA",
      "nama_bank": "PT. BANK CENTRAL ASIA Tbk.",
      "nama_bank_singkat": "BCA",
      "kode_bank": "014",
      "kode_kantor": "0397"
    },
    {
      "id": 43,
      "sandi_bic": "BMRIIDJA",
      "nama_bank": "PT. BANK MANDIRI (PERSERO) TBK",
      "nama_bank_singkat": "BANK MANDIRI",
      "kode_bank": "008",
      "kode_kantor": "0017"
    },
  ];
}
