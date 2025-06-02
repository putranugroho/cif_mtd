import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/utils/colors.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';
import '../../../utils/format_currency.dart';

class NeracaBerjalanNotiifer extends ChangeNotifier {
  final BuildContext context;

  NeracaBerjalanNotiifer({required this.context}) {
    getProfile();
    notifyListeners();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getNeracaAll();
      notifyListeners();
    });
  }

  double totalAktiva = 0;
  double totalPasiva = 0;
  var isLoading = true;
  List<NeracaModel> listNeraca = [];
  NeracaModel? neracaModel;
  Future getNeracaAll() async {
    isLoading = true;
    var data = {
      "kode_pt": "001",
      "kode_kantor": "100",
      "kode_induk": "001",
      "userinput": "Farhan Ramadhan",
      "modul": "neraca",
      "userterm": "PC accounting"
    };
    notifyListeners();
    Setuprepository.setup(token, NetworkURL.neracaBerjalan(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listNeraca.add(NeracaModel.fromJson(i));
        }
        for (var item in value['data']) {
          String typePosting = item['gol_acc'];
          List<Map<String, dynamic>> sbbItems =
              List<Map<String, dynamic>>.from(item['sbb_item']);

          double subtotal =
              sbbItems.fold(0, (sum, sbb) => sum + (sbb['saldo'] ?? 0));

          if (typePosting == '1') {
            totalAktiva += subtotal;
          } else if (typePosting == '2') {
            totalPasiva += subtotal;
          }
        }

        print(listNeraca);
        notifyListeners();
      }
    });
  }

  List<Map<String, dynamic>> extractNeraca(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];

    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          String typePosting = item['type_posting'];
          List<Map<String, dynamic>> sbbItems =
              List<Map<String, dynamic>>.from(item['sbb_item']);

          double subtotal =
              sbbItems.fold(0, (sum, sbb) => sum + (sbb['saldo'] ?? 0));

          if (typePosting == 'AKTIVA') {
            totalAktiva += subtotal;
          } else if (typePosting == 'PASIVA') {
            totalPasiva += subtotal;
          }
        }
      }
    }

    traverse(rawData);
    return result;
  }

  // List<Map<String, dynamic>> data = [
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "KAS INDUK",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {
  //         "nosbb": "0110101",
  //         "nama_sbb": "Kas Kantor",
  //         "type_posting": "",
  //         "saldo": 108694.50,
  //       },
  //     ],
  //   },
  //   {
  //     "nobb": "200000000001",
  //     "nama_bb": "BL - GIRO",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {
  //         "nosbb": "0130103",
  //         "nama_sbb": "Giro Bank Mandiri",
  //         "type_posting": "",
  //         "saldo": 44.06,
  //       },
  //       {
  //         "nosbb": "0130109",
  //         "nama_sbb": "Giro Bank BNI",
  //         "type_posting": "",
  //         "saldo": 374746.11,
  //       },
  //       {
  //         "nosbb": "0130111",
  //         "nama_sbb": "Giro Bank BSI",
  //         "type_posting": "",
  //         "saldo": 2158.21,
  //       },
  //     ],
  //   },
  //   {
  //     "nobb": "200000000001",
  //     "nama_bb": "BL -  DEPOSITO BERJANGKA",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {
  //         "nosbb": "0130225",
  //         "nama_sbb": "Dep. Bank Mandiri",
  //         "type_posting": "",
  //         "saldo": 30000.00,
  //       },
  //       {
  //         "nosbb": "0130231",
  //         "nama_sbb": "DEP. Bank BNI",
  //         "type_posting": "",
  //         "saldo": 300000.00,
  //       },
  //       {
  //         "nosbb": "0130251",
  //         "nama_sbb": "DEP. Bank BSI",
  //         "type_posting": "",
  //         "saldo": 92450000.00,
  //       },
  //       {
  //         "nosbb": "0130270",
  //         "nama_sbb": "DEP. BPD Jateng",
  //         "type_posting": "",
  //         "saldo": 107000000.00,
  //       },
  //       {
  //         "nosbb": "0130274",
  //         "nama_sbb": "DEP Bank Muamalat",
  //         "type_posting": "",
  //         "saldo": 1800000.00,
  //       },
  //     ],
  //   },
  //   {
  //     "nobb": "200000000001",
  //     "nama_bb": "BL - TABUNGAN",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0130301", "nama_sbb": "Tab BCA 823", "type_posting": "", "saldo": 5561022.55},
  //       {"nosbb": "0130304", "nama_sbb": "Tab Bank Jateng 303", "type_posting": "", "saldo": 560147.03},
  //       {"nosbb": "0130305", "nama_sbb": "Tab Bank Jateng 304", "type_posting": "", "saldo": 3403847.55},
  //       {"nosbb": "0130307", "nama_sbb": "Tab Bank Jateng 305", "type_posting": "", "saldo": 515.66},
  //       {"nosbb": "0130308", "nama_sbb": "Tab Bank Jateng 306", "type_posting": "", "saldo": 333685.81},
  //       {"nosbb": "0130309", "nama_sbb": "Tab Bank Jateng 307", "type_posting": "", "saldo": 438481.91},
  //       {"nosbb": "0130324", "nama_sbb": "Tab Bank Jateng 308", "type_posting": "", "saldo": 299375.5},
  //       {"nosbb": "0130327", "nama_sbb": "Tab Bank Jateng 309", "type_posting": "", "saldo": 10409338.94},
  //       {"nosbb": "0130332", "nama_sbb": "Tab Bank Jateng 310", "type_posting": "", "saldo": 10008423.9},
  //       {"nosbb": "0130338", "nama_sbb": "Tab Bank Jateng 311", "type_posting": "", "saldo": 87366.07},
  //       {"nosbb": "0130340", "nama_sbb": "TAB. Bank Mandiri 723", "type_posting": "", "saldo": 87714.79},
  //       {"nosbb": "0130341", "nama_sbb": "TAB. Bank Mandiri 724", "type_posting": "", "saldo": 4940.39},
  //       {"nosbb": "0130342", "nama_sbb": "TAB. Bank Mandiri 725", "type_posting": "", "saldo": 1649.94},
  //       {"nosbb": "0130343", "nama_sbb": "TAB. Bank Mandiri 726", "type_posting": "", "saldo": 181.72},
  //       {"nosbb": "0130344", "nama_sbb": "TAB. Bank Mandiri 727", "type_posting": "", "saldo": 1803.14},
  //       {"nosbb": "0130345", "nama_sbb": "TAB. Bank Mandiri 728", "type_posting": "", "saldo": 185.55},
  //       {"nosbb": "0130346", "nama_sbb": "TAB. Bank Mandiri 729", "type_posting": "", "saldo": 298869.06},
  //       {"nosbb": "0130347", "nama_sbb": "TAB. Bank Mandiri 730", "type_posting": "", "saldo": 219213.91},
  //       {"nosbb": "0130348", "nama_sbb": "TAB. Bank Mandiri 731", "type_posting": "", "saldo": 270565.35},
  //       {"nosbb": "0130349", "nama_sbb": "TAB. BNI 424", "type_posting": "", "saldo": 466.62},
  //       {"nosbb": "0130350", "nama_sbb": "TAB. BNI 425", "type_posting": "", "saldo": 3048.88},
  //       {"nosbb": "0130351", "nama_sbb": "TAB. BNI 426", "type_posting": "", "saldo": 167.91},
  //       {"nosbb": "0130352", "nama_sbb": "TAB. BNI 427", "type_posting": "", "saldo": 3000030.5},
  //       {"nosbb": "0130353", "nama_sbb": "TAB. BNI 428", "type_posting": "", "saldo": 688268.64},
  //       {"nosbb": "0130354", "nama_sbb": "TAB. BNI 429", "type_posting": "", "saldo": 76657.5},
  //       {"nosbb": "0130356", "nama_sbb": "TAB. BNI 430", "type_posting": "", "saldo": 1168.31},
  //       {"nosbb": "0130357", "nama_sbb": "TAB. BNI 431", "type_posting": "", "saldo": 24265431.54},
  //       {"nosbb": "0130358", "nama_sbb": "TAB. BNI 432", "type_posting": "", "saldo": 14778.86},
  //       {"nosbb": "0130359", "nama_sbb": "Tab. Bank Muamalat 245", "type_posting": "", "saldo": 16459.22},
  //       {"nosbb": "0130362", "nama_sbb": "TAB. BANK BSI 345", "type_posting": "", "saldo": 652.54},
  //       {"nosbb": "0130363", "nama_sbb": "TAB. BANK BSI 346", "type_posting": "", "saldo": 53468.1},
  //       {"nosbb": "0130364", "nama_sbb": "TAB. BANK BSI 347", "type_posting": "", "saldo": 2701.8}
  //     ],
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "KYD - KREDIT ANGSURAN",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0140101", "type_posting": "", "nama_sbb": "Kredit Angsuran Bulanan", "saldo": 11511966.67},
  //       {"nosbb": "0140102", "type_posting": "", "nama_sbb": "Kredit Angsuran Musiman", "saldo": 902882.68}
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "KYD - KREDIT REKENING KORAN",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0140201", "type_posting": "", "nama_sbb": "Kredit Rekening Koran", "saldo": 5427813.63}
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "KYD - KREDIT PINJAMAN TETAP",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0140301", "nama_sbb": "Kredit Bunga Bulanan", "type_posting": "", "saldo": 7172340},
  //       {"nosbb": "0140302", "nama_sbb": "Kredit Bunga Sekaligus", "type_posting": "", "saldo": 930900},
  //       {"nosbb": "0140304", "nama_sbb": "Kredit Bunga Di Belakang", "type_posting": "", "saldo": 5700000}
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "KYD - PROVISI DAN BIAYA TRANSAKSI",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0140401", "type_posting": "", "nama_sbb": "KYD - Propisi", "saldo": -192277.92}
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "CADANGAN UMUM PPAP",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0150101", "nama_sbb": "PPAP-penempatan pada bank lain Umum", "type_posting": "", "saldo": -1239271.87},
  //       {"nosbb": "0150102", "nama_sbb": "PPAP Cadangan Umum PPAP", "type_posting": "", "saldo": -129242},
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "CADANGAN KHUSUS PPAP",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0150202", "nama_sbb": "PPAP Cadangan Khusus PPAP", "type_posting": "", "saldo": -80006.66},
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "INVENTARIS",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0160201", "nama_sbb": "Inventaris Golongan I", "type_posting": "", "saldo": 505269.3},
  //       {"nosbb": "0160202", "nama_sbb": "Inventaris Golongan II", "type_posting": "", "saldo": 213740},
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "AKUMULASI PENYUSUTAN INVENTARIS -/-",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0170201", "nama_sbb": "Inventaris Golongan I", "type_posting": "", "saldo": -505269.23},
  //       {"nosbb": "0170202", "nama_sbb": "Inventaris Golongan II", "type_posting": "", "saldo": -186135.84},
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "RRA - PENDAPATAN BUNGA YG AKAN DITERIMA",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0190101", "nama_sbb": "Kredit Angsuran Bulanan", "type_posting": "", "saldo": 233.45},
  //       {"nosbb": "0190103", "nama_sbb": "Kredit Bunga Bulanan", "type_posting": "", "saldo": 225}
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "RRA - BEBAN DIBAYAR DIMUKA",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0190301", "nama_sbb": "Biaya Dibayar dimuka - Sewa Gedung", "type_posting": "", "saldo": 640000},
  //       {"nosbb": "0190304", "nama_sbb": "Biaya Dibayar dimuka - Lainnya", "type_posting": "", "saldo": 8512},
  //       {"nosbb": "0190315", "nama_sbb": "Uang Muka Pajak", "type_posting": "", "saldo": 215449.36},
  //       {"nosbb": "0190319", "nama_sbb": "Biaya Dibayar Dimuka - OJK", "type_posting": "", "saldo": 40027.64},
  //       {"nosbb": "0190321", "nama_sbb": "BDD LAINNYA 3", "type_posting": "", "saldo": 94540},
  //       {"nosbb": "0190322", "nama_sbb": "DEPOSIT INVELLI", "type_posting": "", "saldo": 264.63},
  //       {"nosbb": "0190323", "nama_sbb": "DEPOSIT MTD", "type_posting": "", "saldo": 10000}
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "RRA - AGUNAN YANG DIAMBIL ALIH",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0190401", "nama_sbb": "Agunan Yang Diambil alih", "type_posting": "", "saldo": 6151740.00},
  //     ]
  //   },
  //   {
  //     "nobb": "400000000001",
  //     "nama_bb": "RRA - LAINNYA",
  //     "type_posting": "AKTIVA",
  //     "sbb_item": [
  //       {"nosbb": "0190501", "nama_sbb": "Persediaan Materai", "type_posting": "", "saldo": 2625.00},
  //       {"nosbb": "0190504", "nama_sbb": "Deposit E-Money", "type_posting": "", "saldo": 247.50},
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "KEWAJIBAN SEGERA PPH BUNGA DEPOSITO",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0210101", "nama_sbb": "PPH Bunga Deposito (Pemerintah)", "type_posting": "", "saldo": 185447.34},
  //     ],
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "KEWAJIBAN SEGERA PPH TABUNGAN",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0210202", "nama_sbb": "PPH BT- Tab Mandiri", "type_posting": "", "saldo": 0},
  //       {"nosbb": "0210203", "nama_sbb": "PPH BT- Tab BNI", "type_posting": "", "saldo": -113.55},
  //       {"nosbb": "0210205", "nama_sbb": "PPH BT- Tab BSI", "type_posting": "", "saldo": 0},
  //       {"nosbb": "0210206", "nama_sbb": "PPH BT- Tab Muamalat", "type_posting": "", "saldo": 0}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "KEWAJIBAN SEGERA LAINNYA",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0210301", "nama_sbb": "Asuransi Kredit", "type_posting": "", "saldo": 29.1},
  //       {"nosbb": "0210303", "nama_sbb": "Biaya Notaris", "type_posting": "", "saldo": 19419.63},
  //       {"nosbb": "0210309", "nama_sbb": "Titipan Bunga Pinjaman", "type_posting": "", "saldo": 33116.83},
  //       {"nosbb": "0210311", "nama_sbb": "Titipan Doku", "type_posting": "", "saldo": 91.31},
  //       {"nosbb": "0210312", "nama_sbb": "Imbalan Kerja", "type_posting": "", "saldo": 7062.5},
  //       {"nosbb": "0210313", "nama_sbb": "Titipan Doku PPOB", "type_posting": "", "saldo": 16351.62},
  //       {"nosbb": "0210316", "nama_sbb": "Titipan Invelli", "type_posting": "", "saldo": 25.5},
  //       {"nosbb": "0210323", "nama_sbb": "PPH NOTARIS", "type_posting": "", "saldo": 123.75},
  //       {"nosbb": "0210324", "nama_sbb": "PPH PSL 21", "type_posting": "", "saldo": 52.38},
  //       {"nosbb": "0210325", "nama_sbb": "PPH PSL 23", "type_posting": "", "saldo": 1189.57},
  //       {"nosbb": "0210399", "nama_sbb": "Lainnya", "type_posting": "", "saldo": 226281.52}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "TABUNGAN",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0210401", "nama_sbb": "Tabungan Umum", "type_posting": "", "saldo": 2535505.22},
  //       {"nosbb": "0210402", "nama_sbb": "Tabungan Platinum", "type_posting": "", "saldo": 2940560.03},
  //       {"nosbb": "0210403", "nama_sbb": "Tabungan Gold", "type_posting": "", "saldo": 19334423.51},
  //       {"nosbb": "0210405", "nama_sbb": "Tabungan Silver", "type_posting": "", "saldo": 9078458.64},
  //       {"nosbb": "0210406", "nama_sbb": "Tabungan Perunggu", "type_posting": "", "saldo": 202874.1}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "DEPOSITO BERJANGKA",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0210501", "nama_sbb": "Dep. 1 Bulan", "type_posting": "", "saldo": 169418489.2},
  //       {"nosbb": "0210503", "nama_sbb": "Dep. 3 Bulan", "type_posting": "", "saldo": 11448006.39},
  //       {"nosbb": "0210506", "nama_sbb": "Dep. 6 Bulan", "type_posting": "", "saldo": 2895392.45},
  //       {"nosbb": "0210512", "nama_sbb": "Dep. 12 Bulan", "type_posting": "", "saldo": 6270000},
  //       {"nosbb": "0210524", "nama_sbb": "Dep. 24 Bulan", "type_posting": "", "saldo": 1389440}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "DEPOSITO BERJANGKA",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0220201", "nama_sbb": "Dep. 1 Bulan", "type_posting": "", "saldo": 2000000},
  //       {"nosbb": "0220212", "nama_sbb": "Dep. 12 Bulan", "type_posting": "", "saldo": 1675000}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "REKENING ANTAR KANTOR",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0230102", "nama_sbb": "RAK-Cabang 01", "type_posting": "", "saldo": 40040443.42},
  //       {"nosbb": "0230103", "nama_sbb": "RAK-Cabang 02", "type_posting": "", "saldo": 1673042.23},
  //       {"nosbb": "0230104", "nama_sbb": "RAK-Cabang 03", "type_posting": "", "saldo": -2287254.99},
  //       {"nosbb": "0230106", "nama_sbb": "RAK-Anak Cabang 11", "type_posting": "", "saldo": 3110128.69},
  //       {"nosbb": "0230108", "nama_sbb": "RAK-Anak Cabang 12", "type_posting": "", "saldo": -8615773.37},
  //       {"nosbb": "0230109", "nama_sbb": "RAK-Anak Cabang 13", "type_posting": "", "saldo": 3908883.42},
  //       {"nosbb": "0230110", "nama_sbb": "RAK Outlet 112", "type_posting": "", "saldo": 10863030.29},
  //       {"nosbb": "0230111", "nama_sbb": "RAK Outlet 113", "type_posting": "", "saldo": 6495496.54},
  //       {"nosbb": "0230113", "nama_sbb": "RAK Outlet 114", "type_posting": "", "saldo": -1281761.97}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "RRP-BEBAN BUNGA YANG MASIH HARUS DIBAYAR",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0290101", "nama_sbb": "Bunga Deposito", "type_posting": "", "saldo": 70173.48},
  //       {"nosbb": "0290102", "nama_sbb": "Titipan Bunga Deposito Accrual", "type_posting": "", "saldo": 7782.21}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "RRP - TAKSIRAN PAJAK PENGHASILAN",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0290202", "nama_sbb": "Taksiran Pajak Penghasilan Psl 25", "type_posting": "", "saldo": 180362.42}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "RRP - LAINNYA",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0290901", "nama_sbb": "Cadangan Dana Pendidikan", "type_posting": "", "saldo": 24776.57},
  //       {"nosbb": "0290902", "nama_sbb": "Selisih Uang Kas", "type_posting": "", "saldo": 100}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "M O D A L",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0310101", "nama_sbb": "Modal Dasar", "type_posting": "", "saldo": 3000000},
  //       {"nosbb": "0310102", "nama_sbb": "Modal Belum Disetor -/-", "type_posting": "", "saldo": -1000000}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "CADANGAN",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0310301", "nama_sbb": "Cadangan Umum", "type_posting": "", "saldo": 400000}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "LABA/RUGI TAHUN YANG LALU",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0320101", "nama_sbb": "LABA/RUGI TAHUN YANG LALU", "type_posting": "", "saldo": 12684789.5}
  //     ]
  //   },
  //   {
  //     "nobb": "100000000001",
  //     "nama_bb": "LABA/RUGI TAHUN BERJALAN",
  //     "type_posting": "PASIVA",
  //     "sbb_item": [
  //       {"nosbb": "0320201", "nama_sbb": "LABA/RUGI TAHUN BERJALAN", "type_posting": "", "saldo": 421399.92}
  //     ]
  //   }
  // ];
}
