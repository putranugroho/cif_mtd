import 'package:flutter/material.dart';

class JenisBarangNotifier extends ChangeNotifier {
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  String? selectedGolongan;
  String? selectedKelompok;
  String? selectedStatus;

  final TextEditingController kodeJenisController = TextEditingController();
  final TextEditingController namaJenisController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  // === Data Relasi Golongan → Kelompok ===
  final Map<String, List<String>> kelompokByGolongan = {
    'Elektronik': ['TV', 'Laptop', 'Peralatan Rumah Tangga'],
    'Makanan': ['Makanan Ringan', 'Minuman', 'Bahan Pokok'],
    'Pakaian': ['Seragam', 'Casual', 'Formal'],
  };

  final List<String> statusList = ['Aktif', 'Tidak Aktif'];

  // === Dummy Data ===
  final List<Map<String, dynamic>> _data = [
    {
      'id': 1,
      'golongan': 'Elektronik',
      'kelompok': 'TV',
      'kodeJenis': 'JB-EL001',
      'namaJenis': 'Elektronik Kecil',
      'deskripsi': 'Barang-barang elektronik ukuran kecil seperti kipas, setrika, dll',
      'status': 'Aktif',
      'tanggal': '2025-10-01'
    },
    {
      'id': 2,
      'golongan': 'Makanan',
      'kelompok': 'Minuman',
      'kodeJenis': 'JB-MK002',
      'namaJenis': 'Minuman Dingin',
      'deskripsi': 'Kategori berisi minuman kemasan dingin dan jus segar',
      'status': 'Tidak Aktif',
      'tanggal': '2025-09-15'
    },
  ];

  List<Map<String, dynamic>> get data => _data;

  List<String> get golonganList => kelompokByGolongan.keys.toList();

  // === Get Kelompok Berdasarkan Golongan ===
  List<String> get kelompokList {
    if (selectedGolongan == null) return [];
    return kelompokByGolongan[selectedGolongan] ?? [];
  }

  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }

  void onGolonganChanged(String? value) {
    selectedGolongan = value;
    selectedKelompok = null; // reset kelompok saat golongan berubah
    notifyListeners();
  }

  void tambahData() {
    _data.add({
      'id': _data.length + 1,
      'golongan': selectedGolongan,
      'kelompok': selectedKelompok,
      'kodeJenis': kodeJenisController.text,
      'namaJenis': namaJenisController.text,
      'deskripsi': deskripsiController.text,
      'status': selectedStatus,
      'tanggal': DateTime.now().toIso8601String().split('T').first,
    });

    // Reset form
    kodeJenisController.clear();
    namaJenisController.clear();
    deskripsiController.clear();
    selectedGolongan = null;
    selectedKelompok = null;
    selectedStatus = null;
    _isSidebarOpen = false;

    notifyListeners();
  }
}
