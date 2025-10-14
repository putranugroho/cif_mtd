import 'package:flutter/material.dart';

class PengeluaranNotifier extends ChangeNotifier {
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  List<Map<String, dynamic>> _dataPengeluaran = [];
  List<Map<String, dynamic>> get dataPengeluaran => _dataPengeluaran;

  // Form field controller
  final TextEditingController nomorOrderController = TextEditingController();
  final TextEditingController tanggalMasukController = TextEditingController();
  final TextEditingController namaBarangController = TextEditingController();
  final TextEditingController jumlahBarangController = TextEditingController();

  String? selectedGolongan;
  String? selectedKelompok;
  String? selectedJenis;
  String? selectedKategori;

  // Static dummy dropdown data
  final List<String> golonganList = ['Elektronik', 'Pakaian', 'Makanan'];
  final List<String> kelompokList = ['Kelompok A', 'Kelompok B', 'Kelompok C'];
  final List<String> jenisList = ['Jenis 1', 'Jenis 2', 'Jenis 3'];
  final List<String> kategoriList = ['Kategori X', 'Kategori Y', 'Kategori Z'];

  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }

  void tambahData() {
    _dataPengeluaran.add({
      'nomorOrder': nomorOrderController.text,
      'tanggalMasuk': tanggalMasukController.text,
      'namaBarang': namaBarangController.text,
      'golongan': selectedGolongan,
      'kelompok': selectedKelompok,
      'jenis': selectedJenis,
      'kategori': selectedKategori,
      'jumlahBarang': jumlahBarangController.text,
    });
    clearForm();
    _isSidebarOpen = false;
    notifyListeners();
  }

  void clearForm() {
    nomorOrderController.clear();
    tanggalMasukController.clear();
    namaBarangController.clear();
    jumlahBarangController.clear();
    selectedGolongan = null;
    selectedKelompok = null;
    selectedJenis = null;
    selectedKategori = null;
  }
}
