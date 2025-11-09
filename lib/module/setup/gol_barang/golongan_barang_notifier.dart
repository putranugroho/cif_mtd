import 'package:flutter/material.dart';

class GolonganBarangNotifier extends ChangeNotifier {
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  // === Controller & Dropdown ===
  final TextEditingController kodeGolonganController = TextEditingController();
  final TextEditingController namaGolonganController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  String? selectedStatus;
  final List<String> statusList = ['Aktif', 'Tidak Aktif'];

  // === Dummy Data ===
  final List<Map<String, dynamic>> _data = [
    {
      'id': 1,
      'kodeGolongan': 'GB-EL001',
      'namaGolongan': 'Elektronik',
      'deskripsi': 'Barang-barang elektronik seperti TV, Kulkas, Laptop',
      'status': 'Aktif',
      'tanggalDibuat': '2024-05-12',
    },
    {
      'id': 2,
      'kodeGolongan': 'GB-PB002',
      'namaGolongan': 'Pakaian',
      'deskripsi': 'Semua jenis pakaian dan aksesori',
      'status': 'Tidak Aktif',
      'tanggalDibuat': '2024-03-08',
    },
    {
      'id': 3,
      'kodeGolongan': 'GB-MK003',
      'namaGolongan': 'Makanan',
      'deskripsi': 'Produk konsumsi seperti makanan ringan dan minuman',
      'status': 'Aktif',
      'tanggalDibuat': '2024-01-15',
    },
  ];

  List<Map<String, dynamic>> get data => _data;

  // === Function ===
  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }

  void tambahData() {
    _data.add({
      'id': _data.length + 1,
      'kodeGolongan': kodeGolonganController.text,
      'namaGolongan': namaGolonganController.text,
      'deskripsi': deskripsiController.text,
      'status': selectedStatus ?? 'Aktif',
      'tanggalDibuat': DateTime.now().toString().split(' ')[0],
    });

    // Reset form
    namaGolonganController.clear();
    deskripsiController.clear();
    selectedStatus = null;
    _isSidebarOpen = false;

    notifyListeners();
  }
}
