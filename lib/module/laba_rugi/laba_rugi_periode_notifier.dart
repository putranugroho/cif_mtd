import 'package:cif/models/index.dart';
import 'package:flutter/material.dart';

class LabaRugiPeriodeNotifier extends ChangeNotifier {
  final BuildContext context;

  LabaRugiPeriodeNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(NeracaModel.fromJson(i));
    }
    for (var item in data) {
      String typePosting = item['type_posting'];
      List<Map<String, dynamic>> sbbItems = List<Map<String, dynamic>>.from(item['sbb_item']);

      double subtotal = sbbItems.fold(0, (sum, sbb) => sum + (sbb['saldo'] ?? 0));

      if (typePosting == 'BIAYA') {
        totalAktiva += subtotal;
      } else if (typePosting == 'PENDAPATAN') {
        totalPasiva += subtotal;
      }
    }

    notifyListeners();
  }

  double totalAktiva = 0;
  double totalPasiva = 0;
  List<NeracaModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "nobb": "100000000001",
      "nama_bb": "BL - DEPOSITO BERJANGKA",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0510201", "nama_sbb": "Biaya Bunga Dep. 1 Bulan", "type_posting": "", "saldo": 124827.1},
        {"nosbb": "0510212", "nama_sbb": "Biaya Bunga Dep. 12 Bulan", "type_posting": "", "saldo": 44470.17},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "TABUNGAN",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0520101", "nama_sbb": "Biaya Bunga Tabungan Umum", "type_posting": "", "saldo": 26936.9},
        {"nosbb": "0520102", "nama_sbb": "Biaya Bunga Tabungan Platinum", "type_posting": "", "saldo": 16114.03},
        {"nosbb": "0520103", "nama_sbb": "Biaya Bunga Tabungan Gold", "type_posting": "", "saldo": 550668.59},
        {"nosbb": "0520105", "nama_sbb": "Biaya Bunga Tabungan Silver", "type_posting": "", "saldo": 40867.39},
        {"nosbb": "0520106", "nama_sbb": "Biaya Bunga Tabungan Perunggu", "type_posting": "", "saldo": 524.2},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "DEPOSITO BERJANGKA",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0520201", "nama_sbb": "Biaya Bunga Dep. 1 Bulan", "type_posting": "", "saldo": 9642639.34},
        {"nosbb": "0520203", "nama_sbb": "Biaya Bunga Dep. 3 Bulan", "type_posting": "", "saldo": 450102.77},
        {"nosbb": "0520206", "nama_sbb": "Biaya Bunga Dep. 6 Bulan", "type_posting": "", "saldo": 197887.77},
        {"nosbb": "0520212", "nama_sbb": "Biaya Bunga Dep. 12 Bulan", "type_posting": "", "saldo": 333866.55},
        {"nosbb": "0520224", "nama_sbb": "Biaya Bunga Dep. 24 Bulan", "type_posting": "", "saldo": 41466.59},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BTK - GAJI DAN UPAH",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0540101", "nama_sbb": "Gaji dan Upah", "type_posting": "", "saldo": 605193},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BTK - HONORARIUM",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0540201", "nama_sbb": "Peghimpunan Dana", "type_posting": "", "saldo": 10096.7},
        {"nosbb": "0540202", "nama_sbb": "Penyaluran Dana", "type_posting": "", "saldo": 1337.8},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BTK - PPH PASAL 21",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0540301", "nama_sbb": "Tunjangan PPH", "type_posting": "", "saldo": 26037.49},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BTK - THR",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0540401", "nama_sbb": "THR", "type_posting": "", "saldo": 160142},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BTK - ASTEK/JAMSOSTEK",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0540501", "nama_sbb": "Asuransi - ASTEK/Jamsostek", "type_posting": "", "saldo": 114319.46},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BTK - LAINNYA",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0540701", "nama_sbb": "Tunjangan Makan", "type_posting": "", "saldo": 136014.4},
        {"nosbb": "0540702", "nama_sbb": "Tunjangan Kesehatan", "type_posting": "", "saldo": 94300},
        {"nosbb": "0540703", "nama_sbb": "Tunjangan Transportasi", "type_posting": "", "saldo": 111972.5},
        {"nosbb": "0540704", "nama_sbb": "Tunjangan Jabatan", "type_posting": "", "saldo": 940541.6},
        {"nosbb": "0540705", "nama_sbb": "Tunjangan Sosial", "type_posting": "", "saldo": 11072},
        {"nosbb": "0540706", "nama_sbb": "Uang Hadir", "type_posting": "", "saldo": 49145},
        {"nosbb": "0540707", "nama_sbb": "Uang Lembur", "type_posting": "", "saldo": 4524.34},
        {"nosbb": "0540708", "nama_sbb": "Makan Lembur", "type_posting": "", "saldo": 9290},
        {"nosbb": "0540709", "nama_sbb": "Seragam", "type_posting": "", "saldo": 530},
        {"nosbb": "0540710", "nama_sbb": "Tumapan", "type_posting": "", "saldo": 41703},
        {"nosbb": "0540799", "nama_sbb": "Lainnya", "type_posting": "", "saldo": 83087.4},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA PENDIDIKAN DAN PELATIHAN",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0540801", "nama_sbb": "Biaya Pendidikan", "type_posting": "", "saldo": 63803.41},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BTK-HONORARIUM KOMISARIS",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0540901", "nama_sbb": "Honorarium Komisaris", "type_posting": "", "saldo": 164400},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA SEWA",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0550101", "nama_sbb": "Gedung/Kantor", "type_posting": "", "saldo": 160000},
        {"nosbb": "0550102", "nama_sbb": "Kendaraan Bermotor", "type_posting": "", "saldo": 269387.24},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA PAJAK BUMI DAN BANGUNANSEWA",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0560101", "nama_sbb": "PBB", "type_posting": "", "saldo": 525.64},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA PAJAK KENDARAAN KANTOR PUSAT",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0560299", "nama_sbb": "Lainnya", "type_posting": "", "saldo": 3580},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA PEMELIHARAAN DAN PERBAIKAN",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0570101", "nama_sbb": "Biaya Pemeliharaan & Perbaikan", "type_posting": "", "saldo": 149177.85},
        {"nosbb": "0570102", "nama_sbb": "BY JASA PEMELIHARAAN & PERBAIKAN KENDARA", "type_posting": "", "saldo": 1063.95},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BPP - LAINNYA",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0570501", "nama_sbb": "Instalasi Listrik dan PAM", "type_posting": "", "saldo": 948.5},
        {"nosbb": "0570502", "nama_sbb": "Komputer", "type_posting": "", "saldo": 17851.94},
        {"nosbb": "0570503", "nama_sbb": "BY JASA PEMELIHARAAN & PERBAIKAN LAINNYA", "type_posting": "", "saldo": 2875.13},
        {"nosbb": "0570599", "nama_sbb": "Lainnya (Pemeliharaan & Perbaikan)", "type_posting": "", "saldo": 11159.1},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA PENYUSUTAN/PPAP KREDIT",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0580102", "nama_sbb": "Biaya PPAP Penempatan Pd Bank Lain", "type_posting": "", "saldo": 247079.95},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA PENYUSUTAN INVENTARIS",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0580203", "nama_sbb": "Biaya Peny. Inventaris & Golongan II", "type_posting": "", "saldo": 13434.41},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA PERJALANAN DINAS",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0590101", "nama_sbb": "Perjalanan Dinas", "type_posting": "", "saldo": 45309.9},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA ALAT TULIS",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0590201", "nama_sbb": "Peralatan/Alat Tulis Kantor", "type_posting": "", "saldo": 10388.9},
        {"nosbb": "0590202", "nama_sbb": "Foto Copy", "type_posting": "", "saldo": 6452},
        {"nosbb": "0590204", "nama_sbb": "Percetakan", "type_posting": "", "saldo": 15981.5},
        {"nosbb": "0590205", "nama_sbb": "JASA ATK, PERCETAKAN, DLL", "type_posting": "", "saldo": 4583.85},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA TELEPHONE, LISTRIK, DAN AIR",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0590301", "nama_sbb": "Telepon", "type_posting": "", "saldo": 78425.66},
        {"nosbb": "0590303", "nama_sbb": "Listrik", "type_posting": "", "saldo": 79701.04},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA RUMAH TANGGA",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0590401", "nama_sbb": "Majalah/Koran", "type_posting": "", "saldo": 20},
        {"nosbb": "0590402", "nama_sbb": "Perlengkapan Dapur", "type_posting": "", "saldo": 12667.7},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA KORESPONDENSI",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0590501", "nama_sbb": "Materai", "type_posting": "", "saldo": 7134},
        {"nosbb": "0590502", "nama_sbb": "Jasa Pos/Pengiriman Surat", "type_posting": "", "saldo": 2505.74},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "JASA PIHAK KE III",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0590601", "nama_sbb": "Jasa Pihak Ke III", "type_posting": "", "saldo": 49191.14},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA NOTARIS",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0590701", "nama_sbb": "Biaya Notaris", "type_posting": "", "saldo": 4500},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA PROMOSI",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0591104", "nama_sbb": "Iklan Di Media", "type_posting": "", "saldo": 7750},
        {"nosbb": "0591106", "nama_sbb": "ENTERTAIN", "type_posting": "", "saldo": 129723.32},
        {"nosbb": "0591199", "nama_sbb": "Lainnya", "type_posting": "", "saldo": 43025.4},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BANTUAN PENGOBATAN",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0591201", "nama_sbb": "Bantuan Pengobatan Karyawan", "type_posting": "", "saldo": 1390},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA LAINNYA",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0591901", "nama_sbb": "Lembaga Penjaminan Simpanan", "type_posting": "", "saldo": 431488.74},
        {"nosbb": "0591904", "nama_sbb": "Otoritas Jasa Keuangan", "type_posting": "", "saldo": 164454.44},
        {"nosbb": "0591999", "nama_sbb": "Lainnya ( Pajak & ADM ABA, dll )", "type_posting": "", "saldo": 134088.85},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BNOP - BUNGA ANTAR KANTOR",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0593101", "nama_sbb": "BNOP-Bunga RAK", "type_posting": "", "saldo": 3366873.22},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "KERUGIAN PENJUALAN/KEHILANGAN",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0593202", "nama_sbb": "AYDA", "type_posting": "", "saldo": 4489.42},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BNOP - LAINNYA",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0593901", "nama_sbb": "Sumbangan - Sumbangan", "type_posting": "", "saldo": 1300},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BNOP - LAINNYA",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0593902", "nama_sbb": "CSR", "type_posting": "", "saldo": 2925.72},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BIAYA TAKSIRAN PAJAK PENGHASILAN",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0594101", "nama_sbb": "Biaya Taksiran Pajak Penghasilan Pph 25", "type_posting": "", "saldo": 180362.42},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "LABA/RUGI TAHUN BERJALAN",
      "type_posting": "BIAYA",
      "sbb_item": [
        {"nosbb": "0320201", "nama_sbb": "LABA/RUGI TAHUN BERJALAN", "type_posting": "", "saldo": 421399.92}
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BL - GIRO",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0410204", "nama_sbb": "BUNGA GIRO BNI", "type_posting": "", "saldo": 6112},
        {"nosbb": "0410205", "nama_sbb": "BUNGA GIRO BANK MANDIRI", "type_posting": "", "saldo": 2124.13},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BL - TABUNGAN",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0410302", "nama_sbb": "Bunga Tab. BCA 823", "type_posting": "", "saldo": 1182.65},
        {"nosbb": "0410303", "nama_sbb": "Bunga Tab. Bank Jateng 303", "type_posting": "", "saldo": 310410.61},
        {"nosbb": "0410305", "nama_sbb": "Bunga Tab. Bank Mandiri 723", "type_posting": "", "saldo": 79489},
        {"nosbb": "0410306", "nama_sbb": "Bunga Tab. Bank Mandiri 729", "type_posting": "", "saldo": 159.81},
        {"nosbb": "0410308", "nama_sbb": "Bunga Tab. BNI 424", "type_posting": "", "saldo": 1298.77},
        {"nosbb": "0410309", "nama_sbb": "Bunga Tab. BNI 427", "type_posting": "", "saldo": 3186.55},
        {"nosbb": "0410316", "nama_sbb": "Bunga Tab. Muamalat 245", "type_posting": "", "saldo": 108106.7},
        {"nosbb": "0410322", "nama_sbb": "Bunga Tab. Bank BSI 347", "type_posting": "", "saldo": 1386929.05},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BL - DEPOSITO BERJANGKA",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0410401", "nama_sbb": "Bunga Dep. Mandiri 653474", "type_posting": "", "saldo": 25270.64},
        {"nosbb": "0410404", "nama_sbb": "Bunga Dep. Mandiri 653475", "type_posting": "", "saldo": 21306.75},
        {"nosbb": "0410434", "nama_sbb": "Bunga Dep. Mandiri 653476", "type_posting": "", "saldo": 34500},
        {"nosbb": "0410439", "nama_sbb": "Bunga Dep. Mandiri 653477", "type_posting": "", "saldo": 17013.2},
        {"nosbb": "0410454", "nama_sbb": "Bunga Dep. Mandiri 653478", "type_posting": "", "saldo": 3188128.65},
        {"nosbb": "0410455", "nama_sbb": "Bunga Dep. Mandiri 653479", "type_posting": "", "saldo": 59699.16},
        {"nosbb": "0410456", "nama_sbb": "Bunga Dep. Mandiri 653480", "type_posting": "", "saldo": 31698.98},
        {"nosbb": "0410457", "nama_sbb": "Bunga Dep. Mandiri 653481", "type_posting": "", "saldo": 1240994.3},
        {"nosbb": "0410462", "nama_sbb": "Bunga Dep. Mandiri 653482", "type_posting": "", "saldo": 10726.03},
        {"nosbb": "0410463", "nama_sbb": "Bunga Dep. BNI 12436", "type_posting": "", "saldo": 34397.26},
        {"nosbb": "0410467", "nama_sbb": "Bunga Dep. BNI 12437", "type_posting": "", "saldo": 2237.07},
        {"nosbb": "0410468", "nama_sbb": "Bunga Dep. BNI 12438", "type_posting": "", "saldo": 16875},
        {"nosbb": "0410469", "nama_sbb": "Bunga Dep. BNI 12439", "type_posting": "", "saldo": 67500},
        {"nosbb": "0410470", "nama_sbb": "Bunga Dep. BNI 12440", "type_posting": "", "saldo": 35432.88},
        {"nosbb": "0410471", "nama_sbb": "Bunga Dep. BNI 12441", "type_posting": "", "saldo": 41572.6},
        {"nosbb": "0410472", "nama_sbb": "Bunga Dep. BNI 12442", "type_posting": "", "saldo": 33788.21},
        {"nosbb": "0410473", "nama_sbb": "Bunga Dep. BNI 12443", "type_posting": "", "saldo": 7143294.92},
        {"nosbb": "0410474", "nama_sbb": "Bunga Dep. Jateng 5435636", "type_posting": "", "saldo": 16875},
        {"nosbb": "0410475", "nama_sbb": "Bunga Dep. Jateng 5435637", "type_posting": "", "saldo": 16875},
        {"nosbb": "0410476", "nama_sbb": "Bunga Dep. Jateng 5435638", "type_posting": "", "saldo": 16108.13},
        {"nosbb": "0410477", "nama_sbb": "Bunga Dep. Jateng 5435639", "type_posting": "", "saldo": 90838.36},
        {"nosbb": "0410478", "nama_sbb": "Bunga Dep. Jateng 5435640", "type_posting": "", "saldo": 50625},
        {"nosbb": "0410479", "nama_sbb": "Bunga Dep. Jateng 5435641", "type_posting": "", "saldo": 60726.88},
        {"nosbb": "0410480", "nama_sbb": "Bunga Dep. Jateng 5435642", "type_posting": "", "saldo": 17013.8},
        {"nosbb": "0410481", "nama_sbb": "Bunga Dep. BSI 243646", "type_posting": "", "saldo": 51041.1},
        {"nosbb": "0410482", "nama_sbb": "Bunga Dep. BSI 243647", "type_posting": "", "saldo": 34027.4},
        {"nosbb": "0410483", "nama_sbb": "Bunga Dep. BSI 243648", "type_posting": "", "saldo": 29043.49},
        {"nosbb": "0410484", "nama_sbb": "Bunga Dep. Muamalat 53536", "type_posting": "", "saldo": 9769.02},
        {"nosbb": "0410485", "nama_sbb": "Bunga Dep. Muamalat 53537", "type_posting": "", "saldo": 16836.47},
        {"nosbb": "0410486", "nama_sbb": "Bunga Dep. Muamalat 53538", "type_posting": "", "saldo": 8506.85},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BUNGA - PINJAMAN ANGSURAN",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0420101", "nama_sbb": "Bunga Kredit Angsuran Bulanan", "type_posting": "", "saldo": 1576406.82},
        {"nosbb": "0420102", "nama_sbb": "Bunga Kredit Angsuran Musiman", "type_posting": "", "saldo": 222483.79},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BUNGA - PINJAMAN REKENING KORAN",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0420201", "nama_sbb": "Bunga Rekening Koran", "type_posting": "", "saldo": 535983.98},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "BUNGA - PINJAMAN TETAP",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0420301", "nama_sbb": "Bunga Kredit Bunga Bulanan", "type_posting": "", "saldo": 1032690.96},
        {"nosbb": "0420302", "nama_sbb": "Bunga Kredit Bunga Sekaligus", "type_posting": "", "saldo": 176396.58},
        {"nosbb": "0420304", "nama_sbb": "Bunga Kredit Bunga Di Belakang", "type_posting": "", "saldo": 726725.15},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "PROVISI DAN KOMISI",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0430101", "nama_sbb": "Provisi Dari Kredit Yang Diberikan", "type_posting": "", "saldo": 390403.31},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "LAINNYA",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0430201", "nama_sbb": "Adm. Tabungan Bulanan", "type_posting": "", "saldo": 31941.07},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "POL - PENUTUPAN REKENING",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0440101", "nama_sbb": "Penutupan Rekening Tab. Umum", "type_posting": "", "saldo": 51.44},
        {"nosbb": "0440102", "nama_sbb": "Penutupan Rekening Tab. Platinum", "type_posting": "", "saldo": 290.03},
        {"nosbb": "0440103", "nama_sbb": "Penutupan Rekening Tab. Gold", "type_posting": "", "saldo": 278.26},
        {"nosbb": "0440105", "nama_sbb": "Penutupan Rekening Tab. Silver", "type_posting": "", "saldo": 930.05},
        {"nosbb": "0440106", "nama_sbb": "Penutupan Rekening Tab. Perunggu", "type_posting": "", "saldo": 21.04},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "POL - BUNGA DENDA YANG DIKENAKAN",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0440201", "nama_sbb": "Bunga Denda Yang Dikenakan", "type_posting": "", "saldo": 72245.23},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "POL - ADM PERCETAKAN",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0440401", "nama_sbb": "Percetakan", "type_posting": "", "saldo": 3000},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "POL - ADM TRANSFER",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0440501", "nama_sbb": "Pend. Transfer", "type_posting": "", "saldo": 3003.2},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "POL - LAINNYA",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0440906", "nama_sbb": "Pendapatan PPOB", "type_posting": "", "saldo": 1458.77},
        {"nosbb": "0440907", "nama_sbb": "Penerimaan Kredit yg dihapusbuku", "type_posting": "", "saldo": 2600},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "POL - LAINNYA",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0440908", "nama_sbb": "Pemulihan PPAP", "type_posting": "", "saldo": 260015.17},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "POL - LAINNYA",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0440909", "nama_sbb": "Pendapatan e-money", "type_posting": "", "saldo": 16},
        {"nosbb": "0440999", "nama_sbb": "Lainnya", "type_posting": "", "saldo": 38898.21},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "PNOP - BUNGA ANTAR KANTOR",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0450101", "nama_sbb": "PNOP-Bunga RAK", "type_posting": "", "saldo": 783213.55},
      ]
    },
    {
      "nobb": "100000000001",
      "nama_bb": "PNOP LAINNYA",
      "type_posting": "PENDAPATAN",
      "sbb_item": [
        {"nosbb": "0450301", "nama_sbb": "PNOP - Lainnya", "type_posting": "", "saldo": 324.08}
      ]
    },
  ];

  DateTime now = DateTime.now();
  Future changeStartDate() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2040),
    ));
    now = pickedendDate!;

    notifyListeners();
  }
}
