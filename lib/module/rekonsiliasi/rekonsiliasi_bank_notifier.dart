import 'package:accounting/models/index.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

import '../../utils/button_custom.dart';
import '../../utils/colors.dart';

class RekonsiliasiBankNotifier extends ChangeNotifier {
  final BuildContext context;

  RekonsiliasiBankNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(RekonBankModel.fromJson(i));
    }
    for (var item in data) {
      String typePosting = item['type_posting'];
      List<Map<String, dynamic>> sbbItems = List<Map<String, dynamic>>.from(item['sbb_item']);

      double subtotal = sbbItems.fold(0, (sum, sbb) => sum + (sbb['saldo'] ?? 0));
      double subtotals = sbbItems.fold(0, (sum, sbb) => sum + (sbb['saldo_sistem'] ?? 0));

      if (typePosting == 'AKTIVA') {
        totalAktiva += subtotal;
        totalSistem += subtotals;
      }
    }
    notifyListeners();
  }

  var dialog = false;
  RekonBankItemModel? rekonBankItemModel;
  TextEditingController nominal = TextEditingController();
  TextEditingController selisih = TextEditingController();
  TextEditingController saldo = TextEditingController();
  TextEditingController akun = TextEditingController();
  TextEditingController nosbb = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController jamMulai = TextEditingController();

  DateTime? jamMeetingDate = DateTime.now();
  pilihJam() {
    showModalBottomSheet(
        context: context,
        constraints: const BoxConstraints(maxWidth: 400),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Pilih Jam"),
                  const SizedBox(
                    height: 8,
                  ),
                  TimePickerSpinner(
                    time: jamMeetingDate,
                    is24HourMode: true,
                    isShowSeconds: false,
                    itemHeight: 80,
                    normalTextStyle: const TextStyle(
                      fontSize: 24,
                    ),
                    highlightedTextStyle: const TextStyle(fontSize: 24, color: colorPrimary),
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      setState(() {
                        jamMeetingDate = time;
                        jamMulai.text = DateFormat('HH:mm').format(jamMeetingDate!);
                        notifyListeners();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ButtonPrimary(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    name: "Simpan",
                  )
                ],
              ),
            );
          });
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
          int.parse(DateFormat('y').format(DateTime.now())) - 50,
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
      tglTransaksiText.text = DateFormat("dd-MMM-yyyy").format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  edit(RekonBankItemModel value) {
    rekonBankItemModel = value;
    nosbb.text = rekonBankItemModel!.nosbb;
    akun.text = rekonBankItemModel!.namaSbb;
    saldo.text = FormatCurrency.oCcyDecimal.format(rekonBankItemModel!.saldo).replaceAll(".", ",");
    nominal.text = FormatCurrency.oCcyDecimal.format(rekonBankItemModel!.saldoSistem).replaceAll(".", ",");
    selisih.text = FormatCurrency.oCcyDecimal.format(rekonBankItemModel!.saldo - rekonBankItemModel!.saldoSistem).replaceAll(".", ",");
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    rekonBankItemModel = null;
    notifyListeners();
  }

  onChangeTotal() {
    double total = rekonBankItemModel!.saldo - double.parse(nominal.text);
    selisih.text = FormatCurrency.oCcyDecimal.format(total).replaceAll(".", ',');
    notifyListeners();
  }

  getProfile() async {}

  double totalAktiva = 0;
  double totalSistem = 0;

  List<RekonBankModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "nobb": "200000000001",
      "nama_bb": "BL - GIRO",
      "type_posting": "AKTIVA",
      "sbb_item": [
        {
          "nosbb": "0130103",
          "nama_sbb": "Giro Bank Mandiri",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 44.06,
          "saldo_sistem": 45,
        },
        {
          "nosbb": "0130109",
          "nama_sbb": "Giro Bank BNI",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 374746.11,
          "saldo_sistem": 374800
        },
        {
          "nosbb": "0130111",
          "nama_sbb": "Giro Bank BSI",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 2158.21,
          "saldo_sistem": 2158.21,
        },
      ],
    },
    {
      "nobb": "200000000001",
      "nama_bb": "BL -  DEPOSITO BERJANGKA",
      "type_posting": "AKTIVA",
      "sbb_item": [
        {
          "nosbb": "0130225",
          "nama_sbb": "Dep. Bank Mandiri",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 30000.00,
          "saldo_sistem": 30000.00,
        },
        {
          "nosbb": "0130231",
          "nama_sbb": "DEP. Bank BNI",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 300000.00,
          "saldo_sistem": 300000.00,
        },
        {
          "nosbb": "0130251",
          "nama_sbb": "DEP. Bank BSI",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 92450000.00,
          "saldo_sistem": 92450000.00,
        },
        {
          "nosbb": "0130270",
          "nama_sbb": "DEP. BPD Jateng",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 107000000.00,
          "saldo_sistem": 107000000.00,
        },
        {
          "nosbb": "0130274",
          "nama_sbb": "DEP Bank Muamalat",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 1800000.00,
          "saldo_sistem": 1800000.00,
        },
      ],
    },
    {
      "nobb": "200000000001",
      "nama_bb": "BL - TABUNGAN",
      "type_posting": "AKTIVA",
      "sbb_item": [
        {
          "nosbb": "0130301",
          "nama_sbb": "Tab BCA 823",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 5561022.55,
          "saldo_sistem": 5561022.55,
        },
        {
          "nosbb": "0130304",
          "nama_sbb": "Tab Bank Jateng 303",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 560147.03,
          "saldo_sistem": 560147.03,
        },
        {
          "nosbb": "0130305",
          "nama_sbb": "Tab Bank Jateng 304",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 3403847.55,
          "saldo_sistem": 3403847.55,
        },
        {
          "nosbb": "0130307",
          "nama_sbb": "Tab Bank Jateng 305",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 515.66,
          "saldo_sistem": 515.66,
        },
        {
          "nosbb": "0130308",
          "nama_sbb": "Tab Bank Jateng 306",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 333685.81,
          "saldo_sistem": 333685.81,
        },
        {
          "nosbb": "0130309",
          "nama_sbb": "Tab Bank Jateng 307",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 438481.91,
          "saldo_sistem": 438481.91,
        },
        {
          "nosbb": "0130324",
          "nama_sbb": "Tab Bank Jateng 308",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 299375.5,
          "saldo_sistem": 299375.5,
        },
        {
          "nosbb": "0130327",
          "nama_sbb": "Tab Bank Jateng 309",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 10409338.94,
          "saldo_sistem": 10409338.94,
        },
        {
          "nosbb": "0130332",
          "nama_sbb": "Tab Bank Jateng 310",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 10008423.9,
          "saldo_sistem": 10008423.9,
        },
        {
          "nosbb": "0130338",
          "nama_sbb": "Tab Bank Jateng 311",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 87366.07,
          "saldo_sistem": 87366.07,
        },
        {
          "nosbb": "0130340",
          "nama_sbb": "TAB. Bank Mandiri 723",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 87714.79,
          "saldo_sistem": 87714.79,
        },
        {
          "nosbb": "0130341",
          "nama_sbb": "TAB. Bank Mandiri 724",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 4940.39,
          "saldo_sistem": 4940.39,
        },
        {
          "nosbb": "0130342",
          "nama_sbb": "TAB. Bank Mandiri 725",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 1649.94,
          "saldo_sistem": 1649.94,
        },
        {
          "nosbb": "0130343",
          "nama_sbb": "TAB. Bank Mandiri 726",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 181.72,
          "saldo_sistem": 181.72,
        },
        {
          "nosbb": "0130344",
          "nama_sbb": "TAB. Bank Mandiri 727",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 1803.14,
          "saldo_sistem": 1803.14,
        },
        {
          "nosbb": "0130345",
          "nama_sbb": "TAB. Bank Mandiri 728",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 185.55,
          "saldo_sistem": 185.55,
        },
        {
          "nosbb": "0130346",
          "nama_sbb": "TAB. Bank Mandiri 729",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 298869.06,
          "saldo_sistem": 298869.06,
        },
        {
          "nosbb": "0130347",
          "nama_sbb": "TAB. Bank Mandiri 730",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 219213.91,
          "saldo_sistem": 219213.91,
        },
        {
          "nosbb": "0130348",
          "nama_sbb": "TAB. Bank Mandiri 731",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 270565.35,
          "saldo_sistem": 270565.35,
        },
        {
          "nosbb": "0130349",
          "nama_sbb": "TAB. BNI 424",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 466.62,
          "saldo_sistem": 466.62,
        },
        {
          "nosbb": "0130350",
          "nama_sbb": "TAB. BNI 425",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 3048.88,
          "saldo_sistem": 3048.88,
        },
        {
          "nosbb": "0130351",
          "nama_sbb": "TAB. BNI 426",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 167.91,
          "saldo_sistem": 167.91,
        },
        {
          "nosbb": "0130352",
          "nama_sbb": "TAB. BNI 427",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 3000030.5,
          "saldo_sistem": 3000030.5,
        },
        {
          "nosbb": "0130353",
          "nama_sbb": "TAB. BNI 428",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 688268.64,
          "saldo_sistem": 688268.64,
        },
        {
          "nosbb": "0130354",
          "nama_sbb": "TAB. BNI 429",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 76657.5,
          "saldo_sistem": 76657.5,
        },
        {
          "nosbb": "0130356",
          "nama_sbb": "TAB. BNI 430",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 1168.31,
          "saldo_sistem": 1168.31,
        },
        {
          "nosbb": "0130357",
          "nama_sbb": "TAB. BNI 431",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 24265431.54,
          "saldo_sistem": 24265431.54,
        },
        {
          "nosbb": "0130358",
          "nama_sbb": "TAB. BNI 432",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 14778.86,
          "saldo_sistem": 14778.86,
        },
        {
          "nosbb": "0130359",
          "nama_sbb": "Tab. Bank Muamalat 245",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 16459.22,
          "saldo_sistem": 16459.22,
        },
        {
          "nosbb": "0130362",
          "nama_sbb": "TAB. BANK BSI 345",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 652.54,
          "saldo_sistem": 652.54,
        },
        {
          "nosbb": "0130363",
          "nama_sbb": "TAB. BANK BSI 346",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 53468.1,
          "saldo_sistem": 53468.1,
        },
        {
          "nosbb": "0130364",
          "nama_sbb": "TAB. BANK BSI 347",
          "type_posting": "",
          "tgl_transaksi": "2025-04-10 10:00:00",
          "saldo": 2701.8,
          "saldo_sistem": 2701.8,
        }
      ],
    },
  ];
}
