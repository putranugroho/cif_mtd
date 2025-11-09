import 'package:flutter/material.dart';

class PengeluaranNotifier extends ChangeNotifier {
  // =========================
  // Dummy orders (outgoing)
  // =========================
  List<Map<String, dynamic>> orders = [
    {
      'orderNo': 'ORD-1001',
      'tanggalOrder': DateTime(2025, 10, 10),
      'tanggalKirim': null,
      'tujuan': 'Gudang B',
      'status': 'Belum Dikirim',
      'items': [
        {
          'kode': 'BRG-001',
          'nama': 'Laptop Lenovo',
          'jumlahOrder': 5,
          'jumlahKirim': 0,
          'keterangan': '',
          'kodeBarangId': 1,
        },
        {
          'kode': 'BRG-002',
          'nama': 'Mouse Logitech',
          'jumlahOrder': 20,
          'jumlahKirim': 0,
          'keterangan': '',
          'kodeBarangId': 2,
        },
      ],
      'suratJalan': null,
    },
    {
      'orderNo': 'ORD-1002',
      'tanggalOrder': DateTime(2025, 10, 12),
      'tanggalKirim': null,
      'tujuan': 'Toko A',
      'status': 'Sudah Dikirim',
      'items': [
        {
          'kode': 'BRG-003',
          'nama': 'Keyboard Rexus',
          'jumlahOrder': 10,
          'jumlahKirim': 10,
          'keterangan': 'Packing lengkap',
          'kodeBarangId': 3,
        }
      ],
      'suratJalan': {
        'tanggalKirim': DateTime(2025, 10, 13),
        'moverType': 'External',
        'externalMover': 'JNE',
        'noResi': 'JNE12345',
        'estimasi': '2 hari',
      },
    },
  ];

  // =========================
  // Filter & Sort state
  // =========================
  String filterStatus = 'Semua';
  String sortBy = 'Nomor Order';

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> list = [...orders];

    // Filter by status
    if (filterStatus != 'Semua') {
      list = list.where((o) => o['status'] == filterStatus).toList();
    }

    // Sort logic
    if (sortBy == 'Nomor Order') {
      list.sort((a, b) => a['orderNo'].compareTo(b['orderNo']));
    } else if (sortBy == 'Tanggal Order') {
      list.sort((a, b) => a['tanggalOrder'].compareTo(b['tanggalOrder']));
    }

    return list;
  }

  void setFilter(String status) {
    filterStatus = status;
    notifyListeners();
  }

  void setSort(String value) {
    sortBy = value;
    notifyListeners();
  }

  void resetFilter() {
    filterStatus = 'Semua';
    sortBy = 'Nomor Order';
    notifyListeners();
  }

  // =========================
  // Sidebar & Detail State
  // =========================
  bool sidebarOpen = false;
  Map<String, dynamic>? selectedOrder;
  bool suratJalanOpen = false;

  DateTime? tanggalKirim;
  String selectedMoverType = 'External';
  String? moverType;
  String? selectedExternalMover;
  String? selectedInternalMover;
  String? kendaraanInternal;
  String? noResi;
  DateTime? estimasi;

  final List<String> externalMovers = ['JNE', 'JNT', 'TIKI', 'SiCepat'];
  final List<Map<String, String>> internalMovers = [
    {'nama': 'Andi', 'kendaraan': 'Motor - AB 1234 CD'},
    {'nama': 'Budi', 'kendaraan': 'PickUp - AB 9876 XY'},
  ];

  void resetSidebarState() {
    suratJalanOpen = false;
    tanggalKirim = null;
    selectedMoverType = 'External';
    selectedExternalMover = null;
    selectedInternalMover = null;
    kendaraanInternal = null;
    noResi = '';
    estimasi = null;
  }

  void openSidebarForOrder(String orderNo) {
    selectedOrder = orders.firstWhere(
      (o) => o['orderNo'] == orderNo,
      orElse: () => {},
    );
    if (selectedOrder!.isEmpty) {
      selectedOrder = null;
      return;
    }
    sidebarOpen = true;
    resetSidebarState();
    notifyListeners();
  }

  void closeSidebar() {
    sidebarOpen = false;
    selectedOrder = null;
    resetSidebarState();
    notifyListeners();
  }

  bool searchOrder(String orderNo) {
    final found = orders.indexWhere(
      (o) => o['orderNo'].toString().toLowerCase() == orderNo.toLowerCase(),
    );
    if (found >= 0) {
      openSidebarForOrder(orders[found]['orderNo']);
      return true;
    }
    return false;
  }

  void updateItemAt(int index, {required int jumlahKirim, String? keterangan}) {
    if (selectedOrder == null) return;
    final items = selectedOrder!['items'] as List;
    if (index < 0 || index >= items.length) return;
    items[index]['jumlahKirim'] = jumlahKirim;
    items[index]['keterangan'] = keterangan ?? items[index]['keterangan'];
    notifyListeners();
  }

  bool canProceedToSuratJalan() {
    if (selectedOrder == null) return false;
    final items = selectedOrder!['items'] as List;
    for (var it in items) {
      if ((it['jumlahKirim'] ?? 0) <= 0) return false;
    }
    return true;
  }

  void openSuratJalanForm() {
    if (!canProceedToSuratJalan()) return;
    suratJalanOpen = true;
    notifyListeners();
  }

  void setTanggalKirim(DateTime date) {
    tanggalKirim = date;
    notifyListeners();
  }

  void setMoverType(String type) {
    selectedMoverType = type;
    selectedExternalMover = null;
    selectedInternalMover = null;
    kendaraanInternal = null;
    noResi = '';
    estimasi = null;
    notifyListeners();
  }

  void setExternalMover(String mover) {
    selectedExternalMover = mover;
    notifyListeners();
  }

  void setInternalMover(String nama, String kendaraan) {
    selectedInternalMover = nama;
    kendaraanInternal = kendaraan;
    notifyListeners();
  }

  void setNoResi(String? v) {
    noResi = v;
    notifyListeners();
  }

  void setEstimasi(DateTime date) {
    estimasi = date;
    notifyListeners();
  }

  void setResiAndEstimasi(String resi, DateTime eta) {
    noResi = resi;
    estimasi = eta;
    notifyListeners();
  }

  void saveSuratJalan() {
    if (selectedOrder == null) return;
    selectedOrder!['suratJalan'] = {
      'tanggalKirim': tanggalKirim ?? DateTime.now(),
      'moverType': selectedMoverType,
      'externalMover': selectedExternalMover,
      'internalMover': selectedInternalMover,
      'kendaraanInternal': kendaraanInternal,
      'noResi': noResi,
      'estimasi': estimasi,
    };
    selectedOrder!['tanggalKirim'] = tanggalKirim ?? DateTime.now();
    selectedOrder!['status'] = 'Sudah Dikirim';
    suratJalanOpen = false;
    sidebarOpen = false;
    notifyListeners();
  }

  void updateResiForOrder(String resi, String eta) {
    if (selectedOrder == null) return;
    if (selectedOrder!['suratJalan'] == null) {
      selectedOrder!['suratJalan'] = {};
    }
    selectedOrder!['suratJalan']['noResi'] = resi;
    selectedOrder!['suratJalan']['estimasi'] = eta;
    notifyListeners();
  }

  bool canShowUpdateResiButton(Map<String, dynamic> order) {
    final sj = order['suratJalan'];
    if (sj == null) return false;
    final noResi = (sj['noResi'] ?? '').toString();
    final estimasi = (sj['estimasi'] ?? '').toString();
    return noResi.isEmpty || estimasi.isEmpty;
  }

  void markAsDelivered(String orderNo) {
    final idx = orders.indexWhere((o) => o['orderNo'] == orderNo);
    if (idx >= 0) {
      orders[idx]['status'] = 'Terkirim';
      orders[idx]['tanggalKirim'] = DateTime.now();
      notifyListeners();
    }
  }
}
