import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KelompokBarangNotifier extends ChangeNotifier {
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  // ==========================
  // API BASE URL
  // ==========================
  final String baseUrl = "http://localhost:8080/api";

  // ==========================
  // GOLONGAN (from API)
  // ==========================
  List<Map<String, dynamic>> golonganList = [];
  int? selectedGolonganId; // gunakan int agar konsisten dengan golongan_id dari API

  // ==========================
  // STATUS
  // ==========================
  List<String> statusList = ["Aktif", "Tidak Aktif"];
  String? selectedStatus;

  // ==========================
  // FORM CONTROLLERS
  // ==========================
  final TextEditingController kodeKelompokController = TextEditingController();
  final TextEditingController namaKelompokController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  // ==========================
  // DATA KELOMPOK BARANG
  // ==========================
  List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> get data => _data;

  Map<int, String> _golonganMap = {};

  // prevent double init
  bool _isInitializing = false;

  KelompokBarangNotifier();

  /// Panggil ini dari UI setelah provider dibuat:
  /// ChangeNotifierProvider(create: (_) => KelompokBarangNotifier()..init())
  Future<void> init() async {
    if (_isInitializing) return;
    _isInitializing = true;
    try {
      await fetchGolongan(); // tunggu map golongan siap
      await fetchKelompokBarang(); // baru fetch kelompok dan gunakan map
    } finally {
      _isInitializing = false;
    }
  }

  // ==========================================================
  // GET GOLONGAN DARI API
  // ==========================================================
  Future<void> fetchGolongan() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/golongan"));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        golonganList = jsonData.map((e) => e as Map<String, dynamic>).toList();

        // build map id -> "kode_golongan - nama_golongan"
        _golonganMap = {};
        for (final g in golonganList) {
          final id = g['id'];
          final nama = g['nama_golongan'] ?? g['namaGolongan'] ?? g['nama'];
          final kode = g['kode_golongan'] ?? g['kodeGolongan'] ?? g['kode'];
          if (id != null) {
            final displayName = [
              if (kode != null) kode.toString(),
              if (nama != null) nama.toString(),
            ].join(" - ");
            _golonganMap[int.parse(id.toString())] = displayName.isNotEmpty ? displayName : id.toString();
          }
        }
        notifyListeners();
      } else {
        debugPrint("ERROR Fetch Golongan: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception Fetch Golongan: $e");
    }
  }

  // ==========================================================
  // GET KELOMPOK BARANG DARI API
  // ==========================================================
  Future<void> fetchKelompokBarang() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/kelompok"));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        _data = jsonData.map<Map<String, dynamic>>((raw) {
          final m = raw as Map<String, dynamic>;

          final golonganIdRaw = m['golongan_id'] ?? m['golonganId'] ?? m['golongan'];
          final golonganId = golonganIdRaw != null ? int.tryParse(golonganIdRaw.toString()) : null;

          String golonganNama = "-";
          if (golonganId != null && _golonganMap.containsKey(golonganId)) {
            golonganNama = _golonganMap[golonganId]!;
          } else if (golonganIdRaw != null) {
            golonganNama = golonganIdRaw.toString();
          }

          return {
            'id': m['id'],
            'golonganBarang': golonganNama,
            'kodeKelompok': m['kode_kelompok'] ?? m['kodeKelompok'] ?? m['kode'],
            'namaKelompok': m['nama_kelompok'] ?? m['namaKelompok'] ?? m['nama'],
            'deskripsi': m['deskripsi'] ?? '',
            'status': m['status'] ?? '',
            'created_at': m['created_at'] ?? m['createdAt'] ?? '',
          };
        }).toList();

        notifyListeners();
      } else {
        debugPrint("ERROR Fetch Kelompok: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception Fetch Kelompok: $e");
    }
  }

  // ==========================================================
  // POST TAMBAH KELOMPOK BARANG
  // ==========================================================
  Future<void> tambahData() async {
    try {
      // Pastikan selectedGolonganId dikirim sebagai integer key yang sesuai API
      final Map<String, dynamic> body = {
        "golongan_id": selectedGolonganId,
        "kode_kelompok": kodeKelompokController.text,
        "nama_kelompok": namaKelompokController.text,
        "deskripsi": deskripsiController.text,
        "status": selectedStatus,
      };

      final response = await http.post(
        Uri.parse("$baseUrl/kelompok"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchKelompokBarang(); // refresh table
        toggleSidebar(); // close sidebar
      } else {
        debugPrint("Gagal Simpan: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception Tambah Data: $e");
    }
  }

  // ==========================================================
  // SIDEBAR TOGGLE
  // ==========================================================
  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    if (!_isSidebarOpen) {
      kodeKelompokController.clear();
      namaKelompokController.clear();
      deskripsiController.clear();
      selectedGolonganId = null;
      selectedStatus = null;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    kodeKelompokController.dispose();
    namaKelompokController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }
}
