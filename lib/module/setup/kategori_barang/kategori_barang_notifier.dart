// kategori_barang_notifier.dart
import 'dart:convert';
import 'package:accounting/network/network_aset.dart';
import 'package:accounting/repository/master_repository.dart';
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
  final BuildContext context;
  KategoriBarangNotifier({required this.context}) {
    fetchKategori();
  }

  final String baseUrl = "http://localhost:8080/api/kategori"; // sesuaikan

  List<KategoriBarang> dataList = [];
  bool isLoading = false;

  bool showForm = false;

  TextEditingController kodeKategoriController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  String? selectedStatus;

  List<Map<String, dynamic>> list = [];
  Map<String, dynamic> kategoriModel = {};

  onEdit(Map<String, dynamic> value) {
    kategoriModel = value;
    print("${kategoriModel['id']}, ${kategoriModel['kode_kategori']}");
    notifyListeners();
  }

  Future<void> fetchKategori() async {
    list.clear();
    notifyListeners();
    try {
      isLoading = true;
      notifyListeners();

      MasterRepository.kategori(NetworkAset.kategori()).then((value) {
        list = List<Map<String, dynamic>>.from(value ?? []);
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      debugPrint("Fetch error: $e");
      SnackBar(content: Text("Fetch error: $e"));
      isLoading = false;
      notifyListeners();
    }
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
