import 'package:flutter/material.dart';

class TrackingPengirimanNotifier extends ChangeNotifier {
  // === DATA DASAR ===
  List<Map<String, dynamic>> data = [];
  List<String> statusList = ['Dalam Perjalanan', 'Selesai', 'Retur', 'Cancel'];
  List<String> sortOptions = ['ID Pengiriman', 'Nomor Ref', 'Tanggal Update'];
  List<String> jenisReturList = ['Semua', 'Sebagian'];

  // === FILTER & SORT ===
  String? selectedFilter = 'Semua';
  String? selectedSort;
  bool isSidebarOpen = false;
  int? selectedIndex;

  // === FORM STATES ===
  Map<String, dynamic>? currentSelected;
  String? selectedStatus;
  DateTime? tanggalTerima;
  DateTime? tanggalRetur;
  String? selectedJenisRetur;
  final TextEditingController namaPenerimaController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  TrackingPengirimanNotifier() {
    // Dummy data
    data = [
      {
        'id': 'TRK001',
        'nomorRef': 'REF001',
        'kurir': 'JNE',
        'tanggalUpdate': '2025-10-15',
        'status': 'Dalam Perjalanan',
        'namaPenerima': null,
        'tanggalTerima': null,
        'catatan': null,
        'barang': [
          {'id': 'B001', 'nama': 'Keyboard', 'jumlah': 3, 'selected': false},
          {'id': 'B002', 'nama': 'Mouse', 'jumlah': 2, 'selected': false},
        ],
      },
      {
        'id': 'TRK002',
        'nomorRef': 'REF002',
        'kurir': 'J&T',
        'tanggalUpdate': '2025-10-16',
        'status': 'Selesai',
        'namaPenerima': 'Budi',
        'tanggalTerima': '2025-10-17',
        'catatan': 'Sudah diterima dengan baik',
        'barang': [
          {'id': 'B003', 'nama': 'Monitor', 'jumlah': 1, 'selected': false},
        ],
      },
    ];
  }

  // === FILTER & SORT ===
  void setFilter(String? val) {
    selectedFilter = val;
    notifyListeners();
  }

  void setSort(String? val) {
    selectedSort = val;
    if (val == 'ID Pengiriman') {
      data.sort((a, b) => a['id'].compareTo(b['id']));
    } else if (val == 'Nomor Ref') {
      data.sort((a, b) => a['nomorRef'].compareTo(b['nomorRef']));
    } else if (val == 'Tanggal Update') {
      data.sort((a, b) => b['tanggalUpdate'].compareTo(a['tanggalUpdate']));
    }
    notifyListeners();
  }

  void resetFilter() {
    selectedFilter = 'Semua';
    selectedSort = null;
    notifyListeners();
  }

  List<Map<String, dynamic>> get filteredData {
    if (selectedFilter == null || selectedFilter == 'Semua') return data;
    return data.where((e) => e['status'] == selectedFilter).toList();
  }

  // === SIDEBAR CONTROL ===
  void toggleSidebar(int index) {
    if (isSidebarOpen && selectedIndex == index) {
      cancelSidebar();
    } else {
      selectedIndex = index;
      currentSelected = filteredData[index];
      selectedStatus = null;
      selectedJenisRetur = null;
      tanggalTerima = null;
      tanggalRetur = null;
      namaPenerimaController.clear();
      catatanController.clear();
      isSidebarOpen = true;
      notifyListeners();
    }
  }

  void cancelSidebar() {
    isSidebarOpen = false;
    selectedIndex = null;
    currentSelected = null;
    selectedStatus = null;
    selectedJenisRetur = null;
    tanggalTerima = null;
    tanggalRetur = null;
    notifyListeners();
  }

  // === FORM ===
  void setTanggalTerima(DateTime date) {
    tanggalTerima = date;
    notifyListeners();
  }

  void setTanggalRetur(DateTime date) {
    tanggalRetur = date;
    notifyListeners();
  }

  // === UPDATE STATUS ===
  void updateStatus() {
    if (selectedIndex == null || currentSelected == null) return;
    final idx = data.indexWhere((e) => e['id'] == currentSelected!['id']);
    if (idx == -1) return;

    final updated = {...data[idx]};
    updated['status'] = selectedStatus ?? updated['status'];
    updated['namaPenerima'] = namaPenerimaController.text.isEmpty ? null : namaPenerimaController.text;
    updated['catatan'] = catatanController.text.isEmpty ? null : catatanController.text;

    if (selectedStatus == 'Selesai') {
      updated['tanggalTerima'] = tanggalTerima?.toString().split(' ')[0];
    }

    if (selectedStatus == 'Retur') {
      if (selectedJenisRetur == 'Semua') {
        updated['tanggalTerima'] = tanggalRetur?.toString().split(' ')[0];
      } else if (selectedJenisRetur == 'Sebagian') {
        final barangDipilih = (currentSelected!['barang'] as List)
            .where((b) => b['selected'] == true)
            .map((b) => {
                  'id': b['id'],
                  'nama': b['nama'],
                  'jumlahRetur': b['jumlahRetur'] ?? 0,
                  'catatan': b['catatan'] ?? '',
                })
            .toList();
        updated['barangRetur'] = barangDipilih;
      }
    }

    data[idx] = updated;
    cancelSidebar();
    notifyListeners();
  }
}
