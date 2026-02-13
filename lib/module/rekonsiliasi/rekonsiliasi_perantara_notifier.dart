import 'package:cif/models/index.dart';
import 'package:cif/models_manual/rekon_perantara_item_model.dart';
import 'package:cif/models_manual/rekon_perantara_model.dart';
import 'package:flutter/material.dart';

class RekonsiliasiPerantaraNotifier extends ChangeNotifier {
  final BuildContext context;

  RekonsiliasiPerantaraNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(RekonPerantaraModel.fromJson(i));
    }
    for (Map<String, dynamic> i in dataPasiva) {
      listPasive.add(RekonPerantaraModel.fromJson(i));
    }
    for (Map<String, dynamic> i in coa) {
      listCoa.add(CoaModel.fromJson(i));
    }
    for (Map<String, dynamic> i in coaDebet) {
      listCoaDebet.add(CoaModel.fromJson(i));
    }

    for (var bb in data) {
      for (var sbb in bb['sbb_item']) {
        double saldoAwal = sbb['saldo'] ?? 0.0;
        List transaksi = sbb['item_transaksi'];

        for (var trx in transaksi) {
          double nominal = trx['nominal'] ?? 0.0;
          saldoAwal -= nominal;

          trx['sisaSaldo'] = saldoAwal;
        }
      }
    }

    notifyListeners();
  }

  List<String> listJenis = [];
  String? jenis = "AKTIVA";
  gantijenis(String value) {
    jenis = value;
    notifyListeners();
  }

  var dialog = false;

  tambah(RekonPerantaraItemModel value) {
    dialog = true;
    nomorRef.text = "8902989844i9491";
    namaSbbpenyusutan.text = value.nosbb;
    namaSbbKredit.text = value.namaSbb;
    keterangan.text = value.typePosting;

    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController namaSbbDebit = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController namaSbbKredit = TextEditingController();
  TextEditingController nomorRef = TextEditingController();
  TextEditingController namaSbbAset = TextEditingController();
  TextEditingController namaTransaksi = TextEditingController();
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

  List<CoaModel> listCoa = [];
  List<Map<String, dynamic>> coa = [
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "0190301",
      "nama_sbb": "Biaya Dibayar dimuka - Sewa Gedung",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "0190304",
      "nama_sbb": "Biaya Dibayar dimuka - Lainnya",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
  ];

  List<CoaModel> listCoaDebet = [];
  List<Map<String, dynamic>> coaDebet = [
    {"gol_acc": "1", "jns_acc": "C", "nobb": "10001000", "nosbb": "0110101", "nama_sbb": "Kas Kantor", "type_posting": "Y", "sbb_khusus": "kas"},
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "0130103",
      "nama_sbb": "Giro Bank Mandiri",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {"gol_acc": "1", "jns_acc": "C", "nobb": "10001000", "nosbb": "0130109", "nama_sbb": "Giro Bank BNI", "type_posting": "Y", "sbb_khusus": "kas"},
    {"gol_acc": "1", "jns_acc": "C", "nobb": "10001000", "nosbb": "0130111", "nama_sbb": "Giro Bank BSI", "type_posting": "Y", "sbb_khusus": "kas"},
    {"gol_acc": "1", "jns_acc": "C", "nobb": "10001000", "nosbb": "0130231", "nama_sbb": "DEP. Bank BNI", "type_posting": "Y", "sbb_khusus": "kas"},
  ];

  int totalActive = 0;
  int totalMacet = 0;
  List<RekonPerantaraModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "nobb": "400000000001",
      "nama_bb": "RRA - BEBAN DIBAYAR DIMUKA",
      "type_posting": "AKTIVA",
      "sbb_item": [
        {
          "nosbb": "0190301",
          "nama_sbb": "Biaya Dibayar dimuka - Sewa Gedung",
          "type_posting": "Gdng. Graha Muncul Mekar",
          "saldo": 640000.00,
          "item_transaksi": [
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449491",
              "debet_acc": "0190301",
              "nama_debet": "Biaya Dibayar dimuka - Sewa Gedung",
              "credit_acc": "0130109",
              "nama_credit": "Giro Bank BNI",
              "nomor_dok": "",
              "nomor_ref": "89029898449491",
              "nominal": 320000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449492",
              "debet_acc": "0190301",
              "nama_debet": "Biaya Dibayar dimuka - Sewa Gedung",
              "credit_acc": "0130109",
              "nama_credit": "Giro Bank BNI",
              "nomor_dok": "",
              "nomor_ref": "89029898449492",
              "nominal": 150000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            }
          ],
        },
        {
          "nosbb": "0190304",
          "nama_sbb": "Biaya Dibayar dimuka - Lainnya",
          "type_posting": "",
          "saldo": 850000.00,
          "item_transaksi": [
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449492",
              "debet_acc": "0190304",
              "nama_debet": "Biaya Dibayar dimuka - Lainnya",
              "credit_acc": "0130109",
              "nama_credit": "Giro Bank BNI",
              "nomor_dok": "",
              "nomor_ref": "89029898449492",
              "nominal": 150000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
          ],
        },
        // {
        //   "nosbb": "0190315",
        //   "nama_sbb": "Uang Muka Pajak",
        //   "type_posting": "",
        //   "saldo": 215449.36,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190319",
        //   "nama_sbb": "Biaya Dibayar Dimuka - OJK",
        //   "type_posting": "",
        //   "saldo": 40027.64,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190321",
        //   "nama_sbb": "BDD LAINNYA 3",
        //   "type_posting": "",
        //   "saldo": 94540.00,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190322",
        //   "nama_sbb": "DEPOSIT INVELLI",
        //   "type_posting": "",
        //   "saldo": 264.63,
        //   "item_transaksi": [],
        // },
        // {
        //   "nosbb": "0190323",
        //   "nama_sbb": "DEPOSIT MTD",
        //   "type_posting": "",
        //   "saldo": 10000.00,
        //   "item_transaksi": [],
        // }
      ]
    },
  ];

  List<RekonPerantaraModel> listPasive = [];
  List<Map<String, dynamic>> dataPasiva = [
    {
      "nobb": "100000000001",
      "nama_bb": "RRP - LAINNYA",
      "type_posting": "PASIVA",
      "sbb_item": [
        {
          "nosbb": "0290901",
          "nama_sbb": "Cadangan Dana Pendidikan",
          "type_posting": "Training CCNA",
          "saldo": 750000.00,
          "item_transaksi": [
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449491",
              "debet_acc": "0290901",
              "nama_debet": "Cadangan Dana Pendidikan",
              "credit_acc": "0110101",
              "nama_credit": "Kas Kantor",
              "nomor_dok": "",
              "nomor_ref": "89029898449491",
              "nominal": 320000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
            {
              "tgl_trans": "2025-03-26",
              "trans_user": "Edi Kurniawan",
              "kode_trans": "89029898449491",
              "debet_acc": "0290901",
              "nama_debet": "Cadangan Dana Pendidikan",
              "credit_acc": "0110101",
              "nama_credit": "Kas Kantor",
              "nomor_dok": "",
              "nomor_ref": "89029898449491",
              "nominal": 230000.00,
              "keterangan": "",
              "kode_pt": "001",
              "kode_kantor": "10001",
              "kode_induk": "",
              "kode_ao_debet": "",
              "kode_ao_credit": ""
            },
          ],
        },
      ]
    },
  ];
}
