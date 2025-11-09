import 'package:flutter/material.dart';

class MasterMoverNotifier extends ChangeNotifier {
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  // Controllers
  final TextEditingController namaController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noKendaraanController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  String? selectedJenisMovers;
  String? selectedJenisKendaraan;
  String? selectedStatus;

  final List<String> jenisMoversList = ['External', 'Internal'];
  final List<String> jenisKendaraanList = ['Motor', 'Mobil Box', 'Truck'];
  final List<String> statusList = ['Aktif', 'Nonaktif'];

  // Dummy data
  final List<Map<String, dynamic>> _data = [
    {
      'kodeKurir': 'MV001',
      'nama': 'Kurir JNE - Agus Setiawan',
      'telp': '08123456789',
      'email': 'agus@jne.co.id',
      'noKendaraan': 'B 1234 CD',
      'jenisKendaraan': 'Motor',
      'alamat': 'Jakarta Selatan',
      'status': 'Aktif',
      'tglDaftar': '2024-05-12',
      'keterangan': 'Kurir cepat tanggap',
    },
    {
      'kodeKurir': 'MV002',
      'nama': 'Kurir TIKI - Budi Santoso',
      'telp': '082112223333',
      'email': 'budi@tiki.co.id',
      'noKendaraan': 'B 9087 XY',
      'jenisKendaraan': 'Mobil Box',
      'alamat': 'Bekasi Timur',
      'status': 'Aktif',
      'tglDaftar': '2024-08-03',
      'keterangan': 'Rute Jabodetabek',
    },
    {
      'kodeKurir': 'MV003',
      'nama': 'Kurir Internal - Dedi Pratama',
      'telp': '085700112233',
      'email': 'dedi@gudang.co.id',
      'noKendaraan': 'B 4512 LM',
      'jenisKendaraan': 'Truck',
      'alamat': 'Gudang Utama Tangerang',
      'status': 'Nonaktif',
      'tglDaftar': '2023-11-10',
      'keterangan': 'Sedang cuti panjang',
    },
  ];

  List<Map<String, dynamic>> get data => _data;

  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }

  void tambahData() {
    final newId = 'MV${(_data.length + 1).toString().padLeft(3, '0')}';

    _data.add({
      'kodeKurir': newId,
      'nama': namaController.text,
      'telp': telpController.text,
      'email': emailController.text,
      'noKendaraan': noKendaraanController.text,
      'jenisKendaraan': selectedJenisKendaraan ?? '-',
      'alamat': alamatController.text,
      'status': selectedStatus ?? 'Aktif',
      'tglDaftar': DateTime.now().toIso8601String().split('T').first,
      'keterangan': keteranganController.text,
    });

    // Reset form
    namaController.clear();
    telpController.clear();
    emailController.clear();
    noKendaraanController.clear();
    alamatController.clear();
    keteranganController.clear();
    selectedJenisKendaraan = null;
    selectedStatus = null;

    _isSidebarOpen = false;
    notifyListeners();
  }
}
