import 'package:flutter/material.dart';

class MutasiBarangNotifier extends ChangeNotifier {
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  String? selectedGudangAsal;
  String? selectedGudangTujuan;
  String? selectedBarang;
  String? selectedStatus;
  DateTime? selectedTanggal;

  final List<String> gudangList = ['Gudang Utama', 'Gudang Cabang', 'Gudang Timur'];
  final List<String> barangList = ['Laptop Lenovo', 'Monitor 24"', 'Keyboard Logitech'];
  final List<String> statusList = ['Draft', 'Dikirim', 'Diterima', 'Selesai'];

  // ==== Dummy Data ====
  final List<Map<String, dynamic>> _data = [
    {
      'id': 'MUT-001',
      'tanggal': '2025-10-10',
      'gudangAsal': 'Gudang Utama',
      'gudangTujuan': 'Gudang Cabang',
      'barang': 'Laptop Lenovo',
      'jumlah': 10,
      'status': 'Dikirim',
      'tanggalDiterima': '-',
      'petugas': 'Andi',
      'keterangan': 'Mutasi rutin antar gudang'
    },
    {
      'id': 'MUT-002',
      'tanggal': '2025-10-11',
      'gudangAsal': 'Gudang Cabang',
      'gudangTujuan': 'Gudang Utama',
      'barang': 'Monitor 24"',
      'jumlah': 5,
      'status': 'Diterima',
      'tanggalDiterima': '2025-10-13',
      'petugas': 'Budi',
      'keterangan': 'Mutasi retur monitor'
    },
  ];

  List<Map<String, dynamic>> get data => _data;

  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }

  Future<void> pilihTanggal(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      selectedTanggal = pickedDate;
      notifyListeners();
    }
  }

  void tambahData() {
    _data.add({
      'id': 'MUT-${(_data.length + 1).toString().padLeft(3, '0')}',
      'tanggal': selectedTanggal?.toString().split(' ')[0] ?? DateTime.now().toString().split(' ')[0],
      'gudangAsal': selectedGudangAsal ?? '-',
      'gudangTujuan': selectedGudangTujuan ?? '-',
      'barang': selectedBarang ?? '-',
      'jumlah': int.tryParse(jumlahController.text) ?? 0,
      'status': selectedStatus ?? 'Draft',
      'tanggalDiterima': selectedStatus == 'Diterima' ? DateTime.now().toString().split(' ')[0] : '-',
      'petugas': 'Admin',
      'keterangan': keteranganController.text,
    });

    jumlahController.clear();
    keteranganController.clear();
    selectedGudangAsal = null;
    selectedGudangTujuan = null;
    selectedBarang = null;
    selectedStatus = null;
    selectedTanggal = null;

    _isSidebarOpen = false;
    notifyListeners();
  }
}
