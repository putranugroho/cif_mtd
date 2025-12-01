// jenis_barang_notifier.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JenisBarangNotifier extends ChangeNotifier {
  // ========== CONFIG ==========
  final String baseUrl = 'http://localhost:8080/api'; // sesuaikan jika perlu

  // ========== UI State ==========
  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  bool isLoading = false;
  bool isSubmitting = false;
  String? errorMessage;

  // ========== FORM ==========
  int? selectedGolonganId;
  int? selectedKelompokId;
  String? selectedStatus;

  final TextEditingController kodeJenisController = TextEditingController();
  final TextEditingController namaJenisController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  final List<String> statusList = ['Aktif', 'Tidak Aktif'];

  // ========== DATA FROM API ==========
  List<Map<String, dynamic>> golonganList = []; // raw objects from API
  Map<int, Map<String, dynamic>> golonganMap = {}; // id -> full object

  List<Map<String, dynamic>> kelompokList = []; // raw kelompok from API
  List<Map<String, dynamic>> kelompokFiltered = []; // filtered by selectedGolonganId

  List<Map<String, dynamic>> jenisList = []; // mapped jenis displayed in table

  // prevent double init
  bool _initialized = false;

  JenisBarangNotifier();

  /// call this once after provider creation: ChangeNotifierProvider(create: (_) => JenisBarangNotifier()..init())
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    await _fetchAll();
  }

  Future<void> _fetchAll() async {
    isLoading = true;
    notifyListeners();
    try {
      await fetchGolongan();
      await fetchKelompok();
      await fetchJenis();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ------------------
  // FETCH GOLONGAN
  // ------------------
  Future<void> fetchGolongan() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/golongan'));

      if (res.statusCode == 200) {
        final List<dynamic> arr = jsonDecode(res.body);
        golonganList = arr.map((e) => e as Map<String, dynamic>).toList();
        debugPrint("GOLONGAN LIST: ${golonganList.length}");

        // Map id -> full object (untuk lookup saat fetchJenis)
        golonganMap = {};
        for (final g in golonganList) {
          final idRaw = g['id'] ?? g['ID'];
          if (idRaw == null) continue;
          final id = int.tryParse(idRaw.toString());
          if (id != null) {
            golonganMap[id] = g;
          } else {
            debugPrint("Tidak bisa parse ID golongan: $idRaw");
          }
        }

        notifyListeners();
      } else {
        debugPrint("fetchGolongan failed: ${res.statusCode} ${res.body}");
      }
    } catch (e) {
      debugPrint("fetchGolongan exception: $e");
    }
  }

  // ------------------
  // FETCH KELOMPOK (all) -> we'll filter locally by selectedGolonganId
  // ------------------
  Future<void> fetchKelompok() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/kelompok'));
      if (res.statusCode == 200) {
        final List<dynamic> arr = jsonDecode(res.body);
        kelompokList = arr.map((e) => e as Map<String, dynamic>).toList();
        _refreshKelompokFiltered();
        notifyListeners();
      } else {
        debugPrint('fetchKelompok failed: ${res.statusCode} ${res.body}');
      }
    } catch (e) {
      debugPrint('fetchKelompok exception: $e');
    }
  }

  void _refreshKelompokFiltered() {
    if (selectedGolonganId == null) {
      kelompokFiltered = [];
      return;
    }
    kelompokFiltered = kelompokList
        .where((k) {
          final gidRaw = k['golongan_id'] ?? k['golonganId'] ?? k['golongan'];
          final gid = gidRaw == null ? null : int.tryParse(gidRaw.toString());
          return gid != null && gid == selectedGolonganId;
        })
        .map((k) => k)
        .toList();
  }

  // ------------------
  // FETCH JENIS (mapping happens here)
  // ------------------
  Future<void> fetchJenis() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/jenis'));

      if (res.statusCode == 200) {
        final List<dynamic> arr = jsonDecode(res.body);

        jenisList = arr.map<Map<String, dynamic>>((raw) {
          final m = raw as Map<String, dynamic>;

          // ---- GOLONGAN ----
          final gidRaw = m['golongan_id'] ?? m['golonganId'] ?? m['golongan'];
          final gid = gidRaw != null ? int.tryParse(gidRaw.toString()) : null;

          String golonganLabel = "-";
          if (gid != null && golonganMap.containsKey(gid)) {
            final gol = golonganMap[gid]!;
            final kodeG = gol['kode_golongan'] ?? gol['kodeGolongan'] ?? gol['kode'] ?? '';
            final namaG = gol['nama_golongan'] ?? gol['namaGolongan'] ?? gol['nama'] ?? '';
            final parts = [
              if (kodeG != null && kodeG.toString().trim().isNotEmpty) kodeG.toString(),
              if (namaG != null && namaG.toString().trim().isNotEmpty) namaG.toString(),
            ];
            golonganLabel = parts.isNotEmpty ? parts.join(' - ') : gid.toString();
          } else if (gidRaw != null) {
            golonganLabel = gidRaw.toString();
          }

          // ---- KELOMPOK ----
          final kidRaw = m['kelompok_id'] ?? m['kelompokId'] ?? m['kelompok'];
          final kid = kidRaw != null ? int.tryParse(kidRaw.toString()) : null;

          String kelompokLabel = "-";
          if (kid != null) {
            final k = kelompokList.firstWhere(
              (x) {
                final xid = x['id'] ?? x['ID'];
                final xidInt = xid != null ? int.tryParse(xid.toString()) : null;
                return xidInt != null && xidInt == kid;
              },
              orElse: () => {},
            );
            if (k.isNotEmpty) {
              final kodeK = k['kode_kelompok'] ?? k['kodeKelompok'] ?? k['kode'] ?? '';
              final namaK = k['nama_kelompok'] ?? k['namaKelompok'] ?? k['nama'] ?? '';
              final parts = [
                if (kodeK != null && kodeK.toString().trim().isNotEmpty) kodeK.toString(),
                if (namaK != null && namaK.toString().trim().isNotEmpty) namaK.toString(),
              ];
              kelompokLabel = parts.isNotEmpty ? parts.join(' - ') : kid.toString();
            } else {
              kelompokLabel = kid.toString();
            }
          } else if (kidRaw != null) {
            kelompokLabel = kidRaw.toString();
          }

          return {
            'id': m['id'],
            'golonganLabel': golonganLabel,
            'kelompokLabel': kelompokLabel,
            'kodeJenis': m['kode_jenis'] ?? m['kodeJenis'] ?? m['kode'] ?? '',
            'namaJenis': m['nama_jenis'] ?? m['namaJenis'] ?? m['nama'] ?? '',
            'deskripsi': m['deskripsi'] ?? '',
            'status': m['status'] ?? '',
            'created_at': m['created_at'] ?? m['createdAt'] ?? '',
          };
        }).toList();

        debugPrint('fetchJenis mapped count=${jenisList.length}');
        notifyListeners();
      } else {
        debugPrint("fetchJenis failed: ${res.statusCode} ${res.body}");
      }
    } catch (e) {
      debugPrint("fetchJenis exception: $e");
    }
  }

  // ------------------
  // CREATE JENIS (POST)
  // ------------------
  Future<bool> tambahData() async {
    if (selectedGolonganId == null || selectedKelompokId == null) {
      errorMessage = 'Pilih golongan dan kelompok';
      notifyListeners();
      return false;
    }
    if (kodeJenisController.text.trim().isEmpty || namaJenisController.text.trim().isEmpty) {
      errorMessage = 'Isi kode dan nama jenis';
      notifyListeners();
      return false;
    }

    isSubmitting = true;
    errorMessage = null;
    notifyListeners();

    final payload = {
      'golongan_id': selectedGolonganId,
      'kelompok_id': selectedKelompokId,
      'kode_jenis': kodeJenisController.text.trim(),
      'nama_jenis': namaJenisController.text.trim(),
      'deskripsi': deskripsiController.text.trim(),
      'status': selectedStatus ?? 'Aktif',
    };

    try {
      final res = await http.post(
        Uri.parse('$baseUrl/jenis'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
      if (res.statusCode == 201 || res.statusCode == 200) {
        // refresh lists
        await fetchJenis();
        clearForm();
        isSubmitting = false;
        notifyListeners();
        return true;
      } else {
        errorMessage = 'Gagal simpan: ${res.statusCode}';
        debugPrint('tambahData failed: ${res.statusCode} ${res.body}');
      }
    } catch (e) {
      errorMessage = 'Exception: $e';
      debugPrint('tambahData exception: $e');
    }

    isSubmitting = false;
    notifyListeners();
    return false;
  }

  // ------------------
  // UI helpers
  // ------------------
  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    if (!_isSidebarOpen) clearForm();
    notifyListeners();
  }

  void selectGolongan(int? id) {
    selectedGolonganId = id;
    // refresh kelompok filtered and reset kelompok selection
    _refreshKelompokFiltered();
    selectedKelompokId = null;
    notifyListeners();
  }

  void selectKelompok(int? id) {
    selectedKelompokId = id;
    notifyListeners();
  }

  void clearForm() {
    kodeJenisController.clear();
    namaJenisController.clear();
    deskripsiController.clear();
    selectedGolonganId = null;
    selectedKelompokId = null;
    selectedStatus = null;
    errorMessage = null;
  }

  @override
  void dispose() {
    kodeJenisController.dispose();
    namaJenisController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }
}
