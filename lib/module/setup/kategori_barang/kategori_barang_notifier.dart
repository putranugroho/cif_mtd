// kategori_barang_notifier.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KategoriBarang {
  final int id;
  final String kodeKategori;
  final String kategoriBarang;
  final String deskripsi;
  final String status;

  KategoriBarang({
    required this.id,
    required this.kodeKategori,
    required this.kategoriBarang,
    required this.deskripsi,
    required this.status,
  });

  factory KategoriBarang.fromJson(Map<String, dynamic> json) {
    return KategoriBarang(
      id: json['id'],
      kodeKategori: json['kode_kategori'] ?? json['kodeKategori'] ?? '-',
      kategoriBarang: json['nama_kategori'] ?? json['kategoriBarang'] ?? '-',
      deskripsi: json['deskripsi'] ?? '-',
      status: json['status'] ?? '-',
    );
  }
}

class KategoriBarangNotifier extends ChangeNotifier {
  final String baseUrl = "http://localhost:8080/api/kategori"; // sesuaikan

  List<KategoriBarang> dataList = [];
  bool isLoading = false;

  bool showForm = false;

  TextEditingController kodeKategoriController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  String? selectedStatus;

  // ===== GET DATA =====
  Future<void> fetchKategori() async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        List jsonData = jsonDecode(res.body);
        dataList = jsonData.map((item) => KategoriBarang.fromJson(item)).toList();
      } else {
        // handle non-200 jika perlu
        debugPrint('fetchKategori failed: ${res.statusCode} ${res.body}');
      }
    } catch (e) {
      debugPrint("Fetch error: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // ===== ADD DATA =====
  Future<void> addKategori() async {
    try {
      final body = {
        "kode_kategori": kodeKategoriController.text,
        "nama_kategori": kategoriController.text,
        "deskripsi": deskripsiController.text,
        "status": selectedStatus ?? "Aktif",
      };

      final res = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (res.statusCode == 201 || res.statusCode == 200) {
        await fetchKategori(); // refresh table
      } else {
        debugPrint('addKategori failed: ${res.statusCode} ${res.body}');
      }
    } catch (e) {
      debugPrint("Add error: $e");
    }

    clearForm();
  }

  void clearForm() {
    kodeKategoriController.clear();
    kategoriController.clear();
    deskripsiController.clear();
    selectedStatus = null;
  }

  void toggleForm() {
    showForm = !showForm;
    notifyListeners();
  }

  @override
  void dispose() {
    kodeKategoriController.dispose();
    kategoriController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }
}
