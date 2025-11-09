import 'package:flutter/material.dart';

class SatuanBarangNotifier extends ChangeNotifier {
  bool isSidebarOpen = false;

  // Controller untuk form input
  final TextEditingController namaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  String selectedStatus = 'Aktif';

  // Daftar status
  final List<String> statusList = ['Aktif', 'Nonaktif'];

  // Data dummy sementara (simulasi database)
  List<Map<String, dynamic>> data = [
    {'id': 1, 'nama': 'Pcs', 'deskripsi': 'Satuan per item', 'status': 'Aktif'},
    {'id': 2, 'nama': 'Box', 'deskripsi': 'Satuan dalam kotak', 'status': 'Nonaktif'},
    {'id': 3, 'nama': 'Liter', 'deskripsi': 'Satuan per liter', 'status': 'Aktif'},
    {'id': 4, 'nama': 'Meter', 'deskripsi': 'Satuan per meter', 'status': 'Aktif'},
  ];

  // Fungsi membuka/tutup sidebar
  void toggleSidebar() {
    isSidebarOpen = !isSidebarOpen;
    notifyListeners();
  }

  // Fungsi menambah data satuan
  void tambahData() {
    if (namaController.text.isEmpty) return;

    int newId = (data.isEmpty) ? 1 : data.last['id'] + 1;

    data.add({
      'id': newId,
      'nama': namaController.text,
      'deskripsi': deskripsiController.text,
      'status': selectedStatus,
    });

    // Reset form
    namaController.clear();
    deskripsiController.clear();
    selectedStatus = 'Aktif';
    isSidebarOpen = false;
    notifyListeners();
  }

  // Fungsi menghapus data
  void hapusData(int id) {
    data.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }
}
