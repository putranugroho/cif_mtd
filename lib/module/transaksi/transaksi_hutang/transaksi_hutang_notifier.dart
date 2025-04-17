import 'package:accounting/models/index.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/piutang_hutang_model.dart';

class TransaksiHutangNotifier extends ChangeNotifier {
  final BuildContext context;

  TransaksiHutangNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(PiutangHutangModel.fromJson(i));
    }
    for (Map<String, dynamic> i in dataCoa) {
      listCoa.add(NeracaItemModel.fromJson(i));
    }
    for (Map<String, dynamic> i in jsoncustomer) {
      listcustomer.add(CustomerSupplierModel.fromJson(i));
    }
    for (var i = 0; i < list.length; i++) {
      listCustomerInvoice.add(false);
    }
    notifyListeners();
  }

  TextEditingController noInvoice = TextEditingController();
  TextEditingController tglInvoice = TextEditingController();
  TextEditingController customer = TextEditingController();

  Future<List<PiutangHutangModel>> cariInvoice(String e) async {
    if (e.isNotEmpty && e.length > 2) {
      return list
          .where((f) => f.noInvoice.toLowerCase().contains(e.toLowerCase()))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<NeracaItemModel>> cariAkun(String e) async {
    if (e.isNotEmpty && e.length > 2) {
      return listCoa
          .where((f) => f.namaSbb.toLowerCase().contains(e.toLowerCase()))
          .toList();
    } else {
      return [];
    }
  }

  CustomerSupplierModel? customerSupplierModel;
  pilihCustomer(CustomerSupplierModel value) {
    customerSupplierModel = value;
    customer.text = value.nmSif;
    pencarianInvoice = false;
    notifyListeners();
  }

  Future<List<CustomerSupplierModel>> caricustomer(String e) async {
    if (e.isNotEmpty && e.length > 2) {
      return listcustomer
          .where((f) => f.nmSif.toLowerCase().contains(e.toLowerCase()))
          .toList();
    } else {
      return [];
    }
  }

  gantinominal() {
    sisa.text = FormatCurrency.oCcy
        .format(int.parse(nominal.text.replaceAll(",", "")) -
            int.parse(piutangHutangModel!.nilaiInvoice))
        .replaceAll(".", ",");
    notifyListeners();
  }

  TextEditingController sisa = TextEditingController();
  TextEditingController nominal = TextEditingController();
  TextEditingController namaSbbDebet = TextEditingController();
  TextEditingController tagihan = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController noSbbDebet = TextEditingController();
  TextEditingController tahap = TextEditingController();
  TextEditingController namaSbbKredit = TextEditingController();
  TextEditingController noSbbKredit = TextEditingController();
  pilihCoaDebet(NeracaItemModel value) {
    namaSbbDebet.text = value.namaSbb;
    noSbbDebet.text = value.nosbb;
    notifyListeners();
  }

  pilihCoaKredit(NeracaItemModel value) {
    namaSbbKredit.text = value.namaSbb;
    noSbbKredit.text = value.nosbb;
    notifyListeners();
  }

  var pencarianInvoice = true;
  pilihInvoice(PiutangHutangModel value) {
    pencarianInvoice = true;
    piutangHutangModel = value;
    jenis.text = piutangHutangModel!.jnsInvoice == "1" ? "Hutang" : "Piutang";
    noInvoice.text = piutangHutangModel!.noInvoice;
    tglInvoice.text = piutangHutangModel!.tglInvoice;
    customer.text = piutangHutangModel!.nmSif;
    tahap.text = ((piutangHutangModel!.itemPembayaran.length) + 1).toString();
    tagihan.text = piutangHutangModel!.bertahap == "Y"
        ? FormatCurrency.oCcy
            .format(int.parse(piutangHutangModel!.nilaiInvoice) /
                int.parse(piutangHutangModel!.jumlahTahap))
            .replaceAll(".", ",")
        : FormatCurrency.oCcy
            .format(int.parse(piutangHutangModel!.nilaiInvoice))
            .replaceAll(".", ",");
    notifyListeners();
  }

  rincianBertahap() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 600,
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Rincian Pembayaran",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[300], shape: BoxShape.circle),
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ListView.builder(
                      itemCount: int.parse(piutangHutangModel!.jumlahTahap),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, i) {
                        var no = i + 1;
                        double tagihan =
                            int.parse(piutangHutangModel!.nilaiInvoice) /
                                int.parse(piutangHutangModel!.jumlahTahap);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 26,
                                  child: Text(
                                    "$no. ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    "${DateFormat('dd MMM y').format(
                                      DateTime(
                                          int.parse(DateFormat('y').format(
                                            DateTime.parse(
                                                piutangHutangModel!.tglInvoice),
                                          )),
                                          int.parse(DateFormat('MM').format(
                                                DateTime.parse(
                                                    piutangHutangModel!
                                                        .tglInvoice),
                                              )) +
                                              i,
                                          int.parse(DateFormat('dd').format(
                                            DateTime.parse(
                                                piutangHutangModel!.tglInvoice),
                                          ))),
                                    )}",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  "${FormatCurrency.oCcy.format(tagihan.toInt())}",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )),
                                Icon(
                                  (i + 1) <=
                                          (piutangHutangModel!
                                              .itemPembayaran.length)
                                      ? Icons.check_circle
                                      : Icons.warning,
                                  color: (i + 1) <=
                                          (piutangHutangModel!
                                              .itemPembayaran.length)
                                      ? Colors.green
                                      : Colors.orange,
                                  size: 15,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        );
                      })
                ],
              ),
            ),
          );
        });
  }

  List<CustomerSupplierModel> listcustomer = [];
  List<Map<String, dynamic>> jsoncustomer = [
    {
      "no_sif": "100000011",
      "nm_sif": "PT Global Teknologi Indonesia",
      "gol_cust": "3",
      "bidang_usaha": "Teknologi",
      "alamat": "Jl. Randu No. 82",
      "kelurahan": "KAGOK",
      "kecamatan": "SLAWI",
      "kota": "KABUPATEN TEGAL",
      "provinsi": "JAWA TENGAH",
      "kdpos": "52419",
      "npwp": "2389013840980183",
      "pkp": "Y",
      "no_telp": "085642990808",
      "email": "gti@gmail.com",
      "kontak1": "Edi Kurniawan",
      "hp1": "085642990808",
      "email1": "edi.cybereye@gmail.com",
      "keterangan1": "Direktur Utama",
      "kontak2": "",
      "hp2": "",
      "email2": "",
      "keterangan2": "",
      "kontak3": "",
      "hp3": "",
      "email3": "",
      "keterangan3": ""
    }
  ];

  bool semua = false;
  List<bool> listCustomerInvoice = [];
  pilihCustomerInvoice(int index) {
    listCustomerInvoice[index] = !listCustomerInvoice[index];
    notifyListeners();
  }

  pilihSemua() {
    semua = !semua;
    if (semua) {
      for (var i = 0; i < listCustomerInvoice.length; i++) {
        listCustomerInvoice[i] = true;
      }
    } else {
      for (var i = 0; i < listCustomerInvoice.length; i++) {
        listCustomerInvoice[i] = false;
      }
    }
    notifyListeners();
  }

  PiutangHutangModel? piutangHutangModel;
  List<PiutangHutangModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "no_invoice": "INV10000001",
      "jns_invoice": "1",
      "no_sif": "100011",
      "nm_sif": "PT GLOBAL TEKNOLOGI INDONESIA",
      "tgl_invoice": "2025-04-07",
      "nilai_invoice": "78500000",
      "ppn": "0",
      "pph": "0",
      "tgl_jt_tempo": "2025-04-30",
      "bertahap": "N",
      "jumlah_tahap": "",
      "tgl_bayar": "",
      "nilai_bayar": "0",
      "status_invoice": "A",
      "kode_pt": "001",
      "kode_kantor": "10011",
      "kode_induk": "",
      "kode_ao": "",
      "item_pembayaran": []
    },
    {
      "no_invoice": "INV10000002",
      "jns_invoice": "2",
      "no_sif": "100011",
      "nm_sif": "PT GLOBAL TEKNOLOGI INDONESIA",
      "tgl_invoice": "2025-04-07",
      "nilai_invoice": "120000000",
      "ppn": "0",
      "pph": "0",
      "tgl_jt_tempo": "2025-04-30",
      "bertahap": "Y",
      "jumlah_tahap": "12",
      "tgl_bayar": "",
      "nilai_bayar": "2000000",
      "status_invoice": "A",
      "kode_pt": "001",
      "kode_kantor": "10011",
      "kode_induk": "",
      "kode_ao": "",
      "item_pembayaran": [
        {
          "no_invoice": "INV10000002",
          "jns_invoice": "2",
          "jumlah_tahap": "12",
          "ke": "1",
          "nilai_tahap": "1000000",
          "nilai_bayar": "1000000",
          "tgl_jt_tempo": "2025-05-30",
          "status_bayar": "1"
        },
        {
          "no_invoice": "INV10000002",
          "jns_invoice": "2",
          "jumlah_tahap": "12",
          "ke": "2",
          "nilai_tahap": "1000000",
          "nilai_bayar": "1000000",
          "tgl_jt_tempo": "2025-06-30",
          "status_bayar": "1"
        },
      ]
    }
  ];

  List<NeracaItemModel> listCoa = [];
  List<Map<String, dynamic>> dataCoa = [
    {
      "nosbb": "0110101",
      "nama_sbb": "Kas Kantor",
      "type_posting": "",
      "saldo": 108694.50,
    },
    {
      "nosbb": "0130103",
      "nama_sbb": "Giro Bank Mandiri",
      "type_posting": "",
      "saldo": 44.06,
    },
    {
      "nosbb": "0130109",
      "nama_sbb": "Giro Bank BNI",
      "type_posting": "",
      "saldo": 374746.11,
    },
    {
      "nosbb": "0130111",
      "nama_sbb": "Giro Bank BSI",
      "type_posting": "",
      "saldo": 2158.21,
    },
    {
      "nosbb": "0130225",
      "nama_sbb": "Dep. Bank Mandiri",
      "type_posting": "",
      "saldo": 30000.00,
    },
    {
      "nosbb": "0130231",
      "nama_sbb": "DEP. Bank BNI",
      "type_posting": "",
      "saldo": 300000.00,
    },
    {
      "nosbb": "0130251",
      "nama_sbb": "DEP. Bank BSI",
      "type_posting": "",
      "saldo": 92450000.00,
    },
    {
      "nosbb": "0130270",
      "nama_sbb": "DEP. BPD Jateng",
      "type_posting": "",
      "saldo": 107000000.00,
    },
    {
      "nosbb": "0130274",
      "nama_sbb": "DEP Bank Muamalat",
      "type_posting": "",
      "saldo": 1800000.00,
    },
    {
      "nosbb": "0130301",
      "nama_sbb": "Tab BCA 823",
      "type_posting": "",
      "saldo": 5561022.55
    },
    {
      "nosbb": "0130304",
      "nama_sbb": "Tab Bank Jateng 303",
      "type_posting": "",
      "saldo": 560147.03
    },
    {
      "nosbb": "0130305",
      "nama_sbb": "Tab Bank Jateng 304",
      "type_posting": "",
      "saldo": 3403847.55
    },
    {
      "nosbb": "0130307",
      "nama_sbb": "Tab Bank Jateng 305",
      "type_posting": "",
      "saldo": 515.66
    },
    {
      "nosbb": "0130308",
      "nama_sbb": "Tab Bank Jateng 306",
      "type_posting": "",
      "saldo": 333685.81
    },
    {
      "nosbb": "0130309",
      "nama_sbb": "Tab Bank Jateng 307",
      "type_posting": "",
      "saldo": 438481.91
    },
    {
      "nosbb": "0130324",
      "nama_sbb": "Tab Bank Jateng 308",
      "type_posting": "",
      "saldo": 299375.5
    },
    {
      "nosbb": "0130327",
      "nama_sbb": "Tab Bank Jateng 309",
      "type_posting": "",
      "saldo": 10409338.94
    },
    {
      "nosbb": "0130332",
      "nama_sbb": "Tab Bank Jateng 310",
      "type_posting": "",
      "saldo": 10008423.9
    },
    {
      "nosbb": "0130338",
      "nama_sbb": "Tab Bank Jateng 311",
      "type_posting": "",
      "saldo": 87366.07
    },
    {
      "nosbb": "0130340",
      "nama_sbb": "TAB. Bank Mandiri 723",
      "type_posting": "",
      "saldo": 87714.79
    },
    {
      "nosbb": "0130341",
      "nama_sbb": "TAB. Bank Mandiri 724",
      "type_posting": "",
      "saldo": 4940.39
    },
    {
      "nosbb": "0130342",
      "nama_sbb": "TAB. Bank Mandiri 725",
      "type_posting": "",
      "saldo": 1649.94
    },
    {
      "nosbb": "0130343",
      "nama_sbb": "TAB. Bank Mandiri 726",
      "type_posting": "",
      "saldo": 181.72
    },
    {
      "nosbb": "0130344",
      "nama_sbb": "TAB. Bank Mandiri 727",
      "type_posting": "",
      "saldo": 1803.14
    },
    {
      "nosbb": "0130345",
      "nama_sbb": "TAB. Bank Mandiri 728",
      "type_posting": "",
      "saldo": 185.55
    },
    {
      "nosbb": "0130346",
      "nama_sbb": "TAB. Bank Mandiri 729",
      "type_posting": "",
      "saldo": 298869.06
    },
    {
      "nosbb": "0130347",
      "nama_sbb": "TAB. Bank Mandiri 730",
      "type_posting": "",
      "saldo": 219213.91
    },
    {
      "nosbb": "0130348",
      "nama_sbb": "TAB. Bank Mandiri 731",
      "type_posting": "",
      "saldo": 270565.35
    },
    {
      "nosbb": "0130349",
      "nama_sbb": "TAB. BNI 424",
      "type_posting": "",
      "saldo": 466.62
    },
    {
      "nosbb": "0130350",
      "nama_sbb": "TAB. BNI 425",
      "type_posting": "",
      "saldo": 3048.88
    },
    {
      "nosbb": "0130351",
      "nama_sbb": "TAB. BNI 426",
      "type_posting": "",
      "saldo": 167.91
    },
    {
      "nosbb": "0130352",
      "nama_sbb": "TAB. BNI 427",
      "type_posting": "",
      "saldo": 3000030.5
    },
    {
      "nosbb": "0130353",
      "nama_sbb": "TAB. BNI 428",
      "type_posting": "",
      "saldo": 688268.64
    },
    {
      "nosbb": "0130354",
      "nama_sbb": "TAB. BNI 429",
      "type_posting": "",
      "saldo": 76657.5
    },
    {
      "nosbb": "0130356",
      "nama_sbb": "TAB. BNI 430",
      "type_posting": "",
      "saldo": 1168.31
    },
    {
      "nosbb": "0130357",
      "nama_sbb": "TAB. BNI 431",
      "type_posting": "",
      "saldo": 24265431.54
    },
    {
      "nosbb": "0130358",
      "nama_sbb": "TAB. BNI 432",
      "type_posting": "",
      "saldo": 14778.86
    },
    {
      "nosbb": "0130359",
      "nama_sbb": "Tab. Bank Muamalat 245",
      "type_posting": "",
      "saldo": 16459.22
    },
    {
      "nosbb": "0130362",
      "nama_sbb": "TAB. BANK BSI 345",
      "type_posting": "",
      "saldo": 652.54
    },
    {
      "nosbb": "0130363",
      "nama_sbb": "TAB. BANK BSI 346",
      "type_posting": "",
      "saldo": 53468.1
    },
    {
      "nosbb": "0130364",
      "nama_sbb": "TAB. BANK BSI 347",
      "type_posting": "",
      "saldo": 2701.8
    },
    {
      "nosbb": "0140101",
      "type_posting": "",
      "nama_sbb": "Kredit Angsuran Bulanan",
      "saldo": 11511966.67
    },
    {
      "nosbb": "0140102",
      "type_posting": "",
      "nama_sbb": "Kredit Angsuran Musiman",
      "saldo": 902882.68
    },
    {
      "nosbb": "0140201",
      "type_posting": "",
      "nama_sbb": "Kredit Rekening Koran",
      "saldo": 5427813.63
    },
    {
      "nosbb": "0140301",
      "nama_sbb": "Kredit Bunga Bulanan",
      "type_posting": "",
      "saldo": 7172340
    },
    {
      "nosbb": "0140302",
      "nama_sbb": "Kredit Bunga Sekaligus",
      "type_posting": "",
      "saldo": 930900
    },
    {
      "nosbb": "0140304",
      "nama_sbb": "Kredit Bunga Di Belakang",
      "type_posting": "",
      "saldo": 5700000
    },
  ];
}
