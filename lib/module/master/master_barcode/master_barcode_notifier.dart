import 'package:flutter/material.dart';

class MasterBarcodeNotifier extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();

  bool isLoading = false;
  bool hasData = false;
  bool isOverwrite = false;

  Map<String, dynamic>? selectedBarang;

  // Dummy data barang
  final List<Map<String, dynamic>> barangList = [
    {'kode': 'BRG-001', 'nama': 'Laptop Lenovo Thinkpad', 'barcode': '1234567890123'},
    {'kode': 'BRG-002', 'nama': 'Kaos Polos Katun', 'barcode': '9876543210987'},
    {'kode': 'BRG-003', 'nama': 'Snack Ring', 'barcode': null},
  ];

  // Hasil pencarian
  List<Map<String, dynamic>> searchResults = [];

  void cariBarang(String query) {
    if (query.isEmpty) {
      searchResults = [];
      notifyListeners();
      return;
    }

    searchResults = barangList
        .where((item) =>
            item['nama'].toString().toLowerCase().contains(query.toLowerCase()) ||
            item['kode'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void pilihBarang(Map<String, dynamic> barang) {
    selectedBarang = barang;
    barcodeController.text = barang['barcode'] ?? '';
    hasData = barang['barcode'] != null;
    isOverwrite = false;
    searchResults = [];
    notifyListeners();
  }

  void toggleOverwrite() {
    isOverwrite = !isOverwrite;
    hasData = false;
    notifyListeners();
  }

  void simpanBarcode() {
    if (selectedBarang != null) {
      selectedBarang!['barcode'] = barcodeController.text;
      hasData = true;
      notifyListeners();
    }
  }

  void resetForm() {
    searchController.clear();
    barcodeController.clear();
    selectedBarang = null;
    hasData = false;
    isOverwrite = false;
    searchResults = [];
    notifyListeners();
  }
}
