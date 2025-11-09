import 'package:flutter/material.dart';

class KoreksiBarangNotifier extends ChangeNotifier {
  // === MASTER DATA ===
  List<Map<String, dynamic>> masterBarang = [
    {
      'id': 1,
      'kode': 'BRG-001',
      'nama': 'Laptop Lenovo Thinkpad',
      'golongan': 'Elektronik',
      'kelompok': 'Kelompok A',
      'jenis': 'Laptop',
      'kategori': 'Barang Jadi',
      'satuan': 'pcs',
      'stokMin': 2,
      'stok': 10,
      'hargaBeli': 15000000,
      'hargaJual': 18000000,
      'barcode': '1234567890123',
      'status': 'Aktif',
    },
    {
      'id': 2,
      'kode': 'BRG-002',
      'nama': 'Kaos Polos Katun',
      'golongan': 'Pakaian',
      'kelompok': 'Kelompok B',
      'jenis': 'Kaos',
      'kategori': 'Barang Jadi',
      'satuan': 'pcs',
      'stokMin': 10,
      'stok': 40,
      'hargaBeli': 45000,
      'hargaJual': 60000,
      'barcode': '9876543210987',
      'status': 'Aktif',
    },
    {
      'id': 3,
      'kode': 'BRG-003',
      'nama': 'Snack Ring',
      'golongan': 'Makanan',
      'kelompok': 'Kelompok C',
      'jenis': 'Snack',
      'kategori': 'Barang Dagang',
      'satuan': 'box',
      'stokMin': 5,
      'stok': 20,
      'hargaBeli': 15000,
      'hargaJual': 25000,
      'lokasi': 'Rak D4',
      'barcode': null, // belum ada barcode
      'status': 'Aktif',
    },
  ];

  // === INPUT FIELD ===
  Map<String, dynamic>? selectedBarang;
  String? nomorReferensi;
  DateTime? tanggalReferensi;
  DateTime? tanggalKoreksi;
  String? jenisKoreksi; // Ganti Kode Barang / Stock Opname
  String? nomorPO;
  Map<String, dynamic>? barangBaru; // untuk ganti kode barang
  String? jenisStockOpname; // tambah/kurang
  int? jumlahKoreksi;
  String? statusBarang;
  String? keterangan;

  // === UI STATE ===
  bool get sudahPilihBarang => selectedBarang != null;
  bool get showGantiKodeForm => jenisKoreksi == 'Ganti Kode Barang';
  bool get showStockOpnameForm => jenisKoreksi == 'Stock Opname';

  // === RESET ===
  void reset() {
    selectedBarang = null;
    nomorReferensi = null;
    tanggalReferensi = null;
    tanggalKoreksi = null;
    jenisKoreksi = null;
    nomorPO = null;
    barangBaru = null;
    jenisStockOpname = null;
    jumlahKoreksi = null;
    statusBarang = null;
    keterangan = null;
    notifyListeners();
  }

  // === SETTERS ===
  void pilihBarang(Map<String, dynamic> barang) {
    selectedBarang = barang;
    notifyListeners();
  }

  void setTanggalKoreksi(DateTime tgl) {
    tanggalKoreksi = tgl;
    notifyListeners();
  }

  void setTanggalReferensi(DateTime tgl) {
    tanggalReferensi = tgl;
    notifyListeners();
  }

  void setJenisKoreksi(String? jenis) {
    jenisKoreksi = jenis;
    notifyListeners();
  }

  void pilihBarangBaru(Map<String, dynamic> barang) {
    barangBaru = barang;
    notifyListeners();
  }

  void simpan(BuildContext context) {
    // --- Simpan data koreksi (dummy flow) ---
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Koreksi barang berhasil disimpan.")),
    );
    reset();
  }
}
