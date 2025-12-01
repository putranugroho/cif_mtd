import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GolonganBarangNotifier extends ChangeNotifier {
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  // === Controller & Dropdown ===
  final TextEditingController kodeGolonganController = TextEditingController();
  final TextEditingController namaGolonganController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  String? selectedStatus;
  final List<String> statusList = ['Aktif', 'Tidak Aktif'];

  // === State ===
  bool isLoading = false;
  bool isSubmitting = false;
  String? errorMessage;

  // === Data dari API ===
  final List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> get data => _data;

  // === API base URL - sesuaikan jika diperlukan ===
  String baseUrl = 'http://localhost:8080'; // ubah sesuai environment

  // === Function ===
  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }

  void setSelectedStatus(String? s) {
    selectedStatus = s;
    notifyListeners();
  }

  // Fetch data dari API
  Future<void> fetchData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final url = Uri.parse('$baseUrl/api/golongan');
      final resp = await http.get(url).timeout(const Duration(seconds: 10));
      if (resp.statusCode == 200) {
        final List<dynamic> list = json.decode(resp.body);
        _data.clear();
        for (final e in list) {
          // Normalize keys in case backend uses snake_case
          _data.add({
            'id': e['id'],
            'kode_golongan': e['kode_golongan'] ?? e['kodeGolongan'] ?? e['kodeGolongan'],
            'nama_golongan': e['nama_golongan'] ?? e['namaGolongan'] ?? e['namaGolongan'],
            'deskripsi': e['deskripsi'],
            'status': e['status'],
            'created_at': e['created_at'] ?? e['createdAt'] ?? '',
          });
        }
      } else {
        errorMessage = 'Failed to load (${resp.statusCode})';
      }
    } catch (ex) {
      errorMessage = 'Error: $ex';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Tambah data ke API (POST)
  Future<void> tambahDataToApi() async {
    final kode = kodeGolonganController.text.trim();
    final nama = namaGolonganController.text.trim();
    final desk = deskripsiController.text.trim();
    final status = selectedStatus ?? 'Aktif';

    if (kode.isEmpty || nama.isEmpty) {
      errorMessage = 'Kode dan Nama wajib diisi';
      notifyListeners();
      return;
    }

    isSubmitting = true;
    notifyListeners();

    try {
      final url = Uri.parse('$baseUrl/api/golongan');
      final body = json.encode({
        'kode_golongan': kode,
        'nama_golongan': nama,
        'deskripsi': desk,
        'status': status,
      });

      final resp = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body).timeout(const Duration(seconds: 10));

      if (resp.statusCode == 201 || resp.statusCode == 200) {
        // sukses - refresh data
        await fetchData();

        // reset form
        kodeGolonganController.clear();
        namaGolonganController.clear();
        deskripsiController.clear();
        selectedStatus = null;
        _isSidebarOpen = false;
        errorMessage = null;
      } else {
        errorMessage = 'Gagal menyimpan (${resp.statusCode}): ${resp.body}';
      }
    } catch (ex) {
      errorMessage = 'Error saat menyimpan: $ex';
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  // Optional: method untuk clear & dispose controllers
  @override
  void dispose() {
    kodeGolonganController.dispose();
    namaGolonganController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }
}
