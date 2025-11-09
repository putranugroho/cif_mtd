import 'package:flutter/material.dart';

class PenerimaanNotifier extends ChangeNotifier {
  // ========================
  // Data Dummy
  // ========================
  List<Map<String, dynamic>> purchaseOrders = [
    {
      'nomorPO': 'PO-001',
      'tanggalPO': DateTime(2025, 10, 1),
      'tanggalDiterima': DateTime(2025, 10, 3),
      'tanggalInput': DateTime(2025, 10, 3),
      'status': 'Sudah Diterima',
      'barang': [
        {
          'nama': 'Laptop Asus',
          'jumlahBeli': 10,
          'jumlahTerima': 10,
          'statusBarang': 'Baik',
          'rusak': 0,
          'tindakan': '',
          'perbedaan': 0,
          'keterangan': '',
          'tanggalTerima': DateTime(2025, 10, 3),
        },
        {
          'nama': 'Mouse Logitech',
          'jumlahBeli': 50,
          'jumlahTerima': 45,
          'statusBarang': 'Ada Rusak',
          'rusak': 5,
          'tindakan': 'Akan Diretur',
          'perbedaan': 5,
          'keterangan': '5 unit rusak kemasan',
          'tanggalTerima': DateTime(2025, 10, 3),
        }
      ]
    },
    {
      'nomorPO': 'PO-002',
      'tanggalPO': DateTime(2025, 10, 5),
      'tanggalDiterima': null,
      'tanggalInput': null,
      'status': 'Belum Diterima',
      'barang': [
        {
          'nama': 'Keyboard Logitech',
          'jumlahBeli': 25,
          'jumlahTerima': 0,
          'statusBarang': '',
          'rusak': 0,
          'tindakan': '',
          'perbedaan': 0,
          'keterangan': '',
          'tanggalTerima': null,
        }
      ]
    },
  ];

  // ========================
  // State Variables
  // ========================
  String filterStatus = "Semua";
  String sortBy = "Nomor PO";
  String searchPO = '';
  bool sidebarOpen = false;

  Map<String, dynamic>? selectedPO;
  Map<String, dynamic>? selectedBarang;

  // ========================
  // Getter: Filtered and Sorted Data
  // ========================
  List<Map<String, dynamic>> get filteredPOs {
    List<Map<String, dynamic>> result = List.from(purchaseOrders);

    // Filter
    if (filterStatus != "Semua") {
      result = result.where((po) => po['status'] == filterStatus).toList();
    }

    // Sort
    if (sortBy == "Nomor PO") {
      result.sort((a, b) => a['nomorPO'].compareTo(b['nomorPO']));
    } else if (sortBy == "Tanggal PO") {
      result.sort((a, b) => a['tanggalPO'].compareTo(b['tanggalPO']));
    } else if (sortBy == "Tanggal Input") {
      result.sort((a, b) {
        final tglA = a['tanggalInput'] ?? DateTime(1900);
        final tglB = b['tanggalInput'] ?? DateTime(1900);
        return tglA.compareTo(tglB);
      });
    }

    return result;
  }

  // ========================
  // Actions
  // ========================

  /// Mengembalikan semua filter & sort ke default
  void resetFilter() {
    filterStatus = 'Semua';
    sortBy = 'Nomor PO';
    searchPO = '';
    notifyListeners();
  }

  void setFilter(String status) {
    filterStatus = status;
    notifyListeners();
  }

  void setSort(String sort) {
    sortBy = sort;
    notifyListeners();
  }

  void openSidebar(Map<String, dynamic> po) {
    selectedPO = po;
    sidebarOpen = true;
    notifyListeners();
  }

  void closeSidebar() {
    sidebarOpen = false;
    selectedPO = null;
    notifyListeners();
  }

  void selectBarang(Map<String, dynamic> barang) {
    selectedBarang = barang;
    notifyListeners();
  }

  // ========================
  // Update Data Barang
  // ========================
  void updateBarang({
    required int jumlahTerima,
    required String statusBarang,
    int rusak = 0,
    String tindakan = '',
    String keterangan = '',
    required DateTime tanggalTerima,
  }) {
    if (selectedBarang == null || selectedPO == null) return;

    // Hitung selisih otomatis
    final jumlahBeli = selectedBarang!['jumlahBeli'] ?? 0;
    final perbedaan = jumlahBeli - jumlahTerima;

    // Update item dalam selectedBarang
    selectedBarang!
      ..['jumlahTerima'] = jumlahTerima
      ..['statusBarang'] = statusBarang
      ..['rusak'] = rusak
      ..['tindakan'] = tindakan
      ..['perbedaan'] = perbedaan
      ..['keterangan'] = keterangan
      ..['tanggalTerima'] = tanggalTerima;

    // Update list barang dalam selectedPO agar sinkron
    final idx = selectedPO!['barang'].indexWhere((b) => b['nama'] == selectedBarang!['nama']);
    if (idx != -1) {
      selectedPO!['barang'][idx] = selectedBarang!;
    }

    notifyListeners();
  }

  double hitungSelisih(int jumlahBeli, int jumlahTerima) {
    return (jumlahBeli - jumlahTerima).toDouble();
  }

  void updateBarangAt(
    int index, {
    required int jumlahTerima,
    required String statusBarang,
    required int rusak,
    required String tindakan,
    required String keterangan,
    required DateTime tanggalTerima,
  }) {
    if (selectedPO == null) return;

    selectedPO!['barang'][index] = {
      ...selectedPO!['barang'][index],
      'jumlahTerima': jumlahTerima,
      'statusBarang': statusBarang,
      'rusak': rusak,
      'tindakan': tindakan,
      'keterangan': keterangan,
      'tanggalTerima': tanggalTerima,
    };

    notifyListeners();
  }

  // ========================
  // Simpan & Batal
  // ========================
  void savePenerimaan() {
    if (selectedPO == null) return;

    selectedPO!['tanggalDiterima'] = DateTime.now();
    selectedPO!['tanggalInput'] = DateTime.now();
    selectedPO!['status'] = "Sudah Diterima";
    sidebarOpen = false;
    notifyListeners();
  }

  void cancelPenerimaan() {
    sidebarOpen = false;
    selectedPO = null;
    notifyListeners();
  }
}
