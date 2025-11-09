import 'package:flutter/material.dart';

class KategoriBarangNotifier extends ChangeNotifier {
  List<Map<String, dynamic>> dataList = [
    {'id': 1, 'kodeKategori': 'KB001', 'kategoriBarang': 'Barang Dagang', 'deskripsi': 'Barang yang dibeli untuk dijual kembali', 'status': 'Aktif'},
    {'id': 2, 'kodeKategori': 'KB002', 'kategoriBarang': 'Bahan Baku', 'deskripsi': 'Bahan mentah yang digunakan dalam produksi', 'status': 'Aktif'},
    {'id': 3, 'kodeKategori': 'KB003', 'kategoriBarang': 'Barang Jadi', 'deskripsi': 'Produk akhir yang siap dijual', 'status': 'Tidak Aktif'},
  ];

  bool showForm = false;
  String? selectedStatus;
  TextEditingController kodeKategoriController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  void toggleForm() {
    showForm = !showForm;
    notifyListeners();
  }

  void addData() {
    if (kategoriController.text.isNotEmpty) {
      dataList.add({
        'id': dataList.length + 1,
        'kodeKategori': kodeKategoriController.text,
        'kategoriBarang': kategoriController.text,
        'deskripsi': deskripsiController.text,
        'status': selectedStatus ?? 'Aktif',
      });
      kategoriController.clear();
      deskripsiController.clear();
      selectedStatus = null;
      notifyListeners();
    }
  }
}
