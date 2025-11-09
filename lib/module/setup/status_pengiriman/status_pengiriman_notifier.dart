import 'package:flutter/material.dart';

class StatusPengirimanNotifier extends ChangeNotifier {
  // ==== Dummy Data ====
  List<Map<String, dynamic>> dataList = [
    {'id': 1, 'namaStatus': 'Selesai', 'keterangan': 'Pesanan sudah diterima pelanggan', 'warna': '#4CAF50', 'status': 'Aktif'},
    {'id': 2, 'namaStatus': 'Dalam Perjalanan', 'keterangan': 'Kurir sedang mengantarkan barang', 'warna': '#2196F3', 'status': 'Aktif'},
    {'id': 3, 'namaStatus': 'Cancel', 'keterangan': 'Pesanan dibatalkan oleh pengguna', 'warna': '#F44336', 'status': 'Tidak Aktif'},
    {'id': 4, 'namaStatus': 'Retur', 'keterangan': 'Barang dikembalikan ke penjual', 'warna': '#FFC107', 'status': 'Aktif'},
  ];

  bool showForm = false;
  String? selectedStatus;

  // Controller
  final TextEditingController namaStatusController = TextEditingController();
  final TextEditingController warnaController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  void toggleForm() {
    showForm = !showForm;
    notifyListeners();
  }

  void addData() {
    if (namaStatusController.text.isNotEmpty) {
      dataList.add({
        'id': dataList.length + 1,
        'namaStatus': namaStatusController.text,
        'keterangan': keteranganController.text,
        'warna': warnaController.text.isNotEmpty ? warnaController.text : '#000000',
        'status': selectedStatus ?? 'Aktif',
      });

      namaStatusController.clear();
      warnaController.clear();
      keteranganController.clear();
      selectedStatus = null;
      showForm = false;

      notifyListeners();
    }
  }
}
