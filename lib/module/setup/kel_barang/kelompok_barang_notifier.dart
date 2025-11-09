import 'package:flutter/material.dart';

class KelompokBarangNotifier extends ChangeNotifier {
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  String? selectedGolongan;
  String? selectedStatus;
  final TextEditingController namaKelompokController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  final List<String> golonganList = ['Elektronik', 'Makanan', 'Pakaian'];
  final List<String> statusList = ['Aktif', 'Tidak Aktif'];

  final List<Map<String, dynamic>> _data = [
    // === Golongan Elektronik ===
    {
      'id': 1,
      'golonganBarang': 'Elektronik',
      'kodeKelompok': 'KB-EL001',
      'namaKelompok': 'TV',
      'deskripsi': 'Televisi dan perlengkapannya',
      'status': 'Aktif'
    },
    {
      'id': 2,
      'golonganBarang': 'Elektronik',
      'kodeKelompok': 'KB-EL002',
      'namaKelompok': 'Laptop',
      'deskripsi': 'Perangkat komputer portabel',
      'status': 'Aktif'
    },
    {
      'id': 3,
      'golonganBarang': 'Elektronik',
      'kodeKelompok': 'KB-EL003',
      'namaKelompok': 'Peralatan Rumah Tangga',
      'deskripsi': 'Barang-barang elektronik untuk kebutuhan rumah tangga',
      'status': 'Aktif'
    },

    // === Golongan Makanan ===
    {
      'id': 4,
      'golonganBarang': 'Makanan',
      'kodeKelompok': 'KB-MK004',
      'namaKelompok': 'Makanan Ringan',
      'deskripsi': 'Snack dan camilan ringan',
      'status': 'Aktif'
    },
    {
      'id': 5,
      'golonganBarang': 'Makanan',
      'kodeKelompok': 'KB-MK005',
      'namaKelompok': 'Minuman',
      'deskripsi': 'Minuman ringan dan kemasan',
      'status': 'Aktif'
    },
    {
      'id': 6,
      'golonganBarang': 'Makanan',
      'kodeKelompok': 'KB-MK006',
      'namaKelompok': 'Bahan Pokok',
      'deskripsi': 'Beras, gula, minyak, dan kebutuhan utama lainnya',
      'status': 'Aktif'
    },

    // === Golongan Pakaian ===
    {
      'id': 7,
      'golonganBarang': 'Pakaian',
      'kodeKelompok': 'KB-PB007',
      'namaKelompok': 'Seragam',
      'deskripsi': 'Seragam kerja dan sekolah',
      'status': 'Tidak Aktif'
    },
    {
      'id': 8,
      'golonganBarang': 'Pakaian',
      'kodeKelompok': 'KB-PB008',
      'namaKelompok': 'Casual',
      'deskripsi': 'Pakaian santai sehari-hari',
      'status': 'Aktif'
    },
    {
      'id': 9,
      'golonganBarang': 'Pakaian',
      'kodeKelompok': 'KB-PB009',
      'namaKelompok': 'Formal',
      'deskripsi': 'Pakaian untuk acara resmi dan pekerjaan kantor',
      'status': 'Aktif'
    },
  ];

  List<Map<String, dynamic>> get data => _data;

  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }

  void tambahData() {
    _data.add({
      'id': _data.length + 1,
      'golonganBarang': selectedGolongan,
      'namaKelompok': namaKelompokController.text,
      'deskripsi': deskripsiController.text,
      'status': selectedStatus,
    });
    namaKelompokController.clear();
    deskripsiController.clear();
    selectedGolongan = null;
    selectedStatus = null;
    _isSidebarOpen = false;
    notifyListeners();
  }
}
