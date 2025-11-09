import 'package:flutter/material.dart';

class MasterBarangNotifier extends ChangeNotifier {
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  // Controller input
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController stokMinController = TextEditingController();
  final TextEditingController stokController = TextEditingController();
  final TextEditingController hargaBeliController = TextEditingController();
  final TextEditingController hargaJualController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();

  // Dropdowns
  String? selectedGolongan;
  String? selectedKelompok;
  String? selectedJenis;
  String? selectedKategori;
  String? selectedSatuan;
  String? selectedStatus;

  final List<String> golonganList = ['Elektronik', 'Pakaian', 'Makanan'];
  final List<String> kelompokList = ['Kelompok A', 'Kelompok B', 'Kelompok C'];
  final List<String> jenisList = ['Laptop', 'Kaos', 'Snack'];
  final List<String> kategoriList = ['Barang Jadi', 'Barang Baku', 'Barang Dagang'];
  final List<String> satuanList = ['pcs', 'box', 'liter', 'meter'];
  final List<String> statusList = ['Aktif', 'Tidak Aktif'];

  // Dummy data
  final List<Map<String, dynamic>> _data = [
    {
      'id': 1,
      'kode': 'BRG-001',
      'nama': 'Laptop Lenovo Thinkpad',
      'golongan': 'Elektronik',
      'kelompok': 'Kelompok A',
      'jenis': 'Laptop',
      'kategori': 'Barang Jadi',
      'satuan': 'pcs',
      'stokMin': 2,
      'stok': 10,
      'hargaBeli': 15000000,
      'hargaJual': 18000000,
      'barcode': '1234567890123',
      'status': 'Aktif',
    },
    {
      'id': 2,
      'kode': 'BRG-002',
      'nama': 'Kaos Polos Katun',
      'golongan': 'Pakaian',
      'kelompok': 'Kelompok B',
      'jenis': 'Kaos',
      'kategori': 'Barang Jadi',
      'satuan': 'pcs',
      'stokMin': 10,
      'stok': 40,
      'hargaBeli': 45000,
      'hargaJual': 60000,
      'barcode': '9876543210987',
      'status': 'Aktif',
    },
    {
      'id': 3,
      'kode': 'BRG-003',
      'nama': 'Snack Ring',
      'golongan': 'Makanan',
      'kelompok': 'Kelompok C',
      'jenis': 'Snack',
      'kategori': 'Barang Dagang',
      'satuan': 'box',
      'stokMin': 5,
      'stok': 20,
      'hargaBeli': 15000,
      'hargaJual': 25000,
      'lokasi': 'Rak D4',
      'barcode': null, // belum ada barcode
      'status': 'Tidak Aktif',
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
      'kode': kodeController.text,
      'nama': namaController.text,
      'golongan': selectedGolongan ?? '-',
      'kelompok': selectedKelompok ?? '-',
      'jenis': selectedJenis ?? '-',
      'kategori': selectedKategori ?? '-',
      'satuan': selectedSatuan ?? '-',
      'stokMin': int.tryParse(stokMinController.text) ?? 0,
      'stok': int.tryParse(stokController.text) ?? 0,
      'hargaBeli': double.tryParse(hargaBeliController.text) ?? 0,
      'hargaJual': double.tryParse(hargaJualController.text) ?? 0,
      'lokasi': lokasiController.text,
      'status': selectedStatus ?? 'Aktif',
      'barcode': null, // default belum ada barcode
    });

    // Reset form
    kodeController.clear();
    namaController.clear();
    stokMinController.clear();
    stokController.clear();
    hargaBeliController.clear();
    hargaJualController.clear();
    lokasiController.clear();

    selectedGolongan = null;
    selectedKelompok = null;
    selectedJenis = null;
    selectedKategori = null;
    selectedSatuan = null;
    selectedStatus = null;

    _isSidebarOpen = false;
    notifyListeners();
  }
}
