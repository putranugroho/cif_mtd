import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// =====================
/// MODE HALAMAN
/// =====================
enum PeroranganMode { initial, search, create }

/// =====================
/// ENUM TIPE FIELD
/// =====================
enum FieldType { text, date, yn, dropdown }

/// =====================
/// MODEL FIELD
/// =====================
class ExcelField {
  final String table;
  final String key;
  final String label;
  final FieldType type;
  final bool required;
  final Map<String, String>? options;

  final bool onlyForSearch;
  final bool readOnly;

  const ExcelField({
    required this.table,
    required this.key,
    required this.label,
    required this.type,
    this.required = false,
    this.options,
    this.onlyForSearch = false,
    this.readOnly = false,
  });
}

/// =====================
/// MODEL STEP
/// =====================
class ExcelStep {
  final String label;
  final List<String> tables;

  const ExcelStep({required this.label, required this.tables});
}

/// =====================
/// NOTIFIER
/// =====================
class PeroranganNotifier extends ChangeNotifier {
  PeroranganMode mode = PeroranganMode.initial;
  bool isLoading = false;
  String? errorMessage;

  String searchNoCif = '';
  String searchNamaCif = '';

  int currentStep = 0;

  final Map<String, dynamic> values = {};

  /// =====================
  /// STEP FLOW
  /// =====================
  final List<ExcelStep> steps = const [
    ExcelStep(label: 'Data Customer', tables: ['customer']),
    ExcelStep(label: 'Data Identitas', tables: ['identity']),
    ExcelStep(label: 'Data Kontak', tables: ['contact']),
    ExcelStep(label: 'Data AO', tables: ['ao']),
    ExcelStep(label: 'Data Kepatuhan & Pelaporan', tables: ['compliance']),
    ExcelStep(label: 'Data Petugas', tables: ['petugas']),
    ExcelStep(label: 'Data Ahli Waris', tables: ['heir']),
    ExcelStep(label: 'Data Sistem', tables: ['system']),
  ];

  /// =====================
  /// FIELD CONFIG (MASTER)
  /// =====================
  final List<ExcelField> fields = [
    // =====================
    // DATA CUSTOMER
    // =====================
    ExcelField(
      table: 'customer',
      key: 'no_cif',
      label: 'Nomer CIF',
      type: FieldType.text,
      onlyForSearch: true,
      readOnly: true,
    ),
    ExcelField(table: 'customer', key: 'gol_cust', label: 'Golongan Customer', type: FieldType.dropdown, required: true, options: {
      '1': 'Perorangan',
      '2': 'Perusahaan',
    }),
    ExcelField(table: 'customer', key: 'nama_cif', label: 'Nama CIF', type: FieldType.text, required: true),
    ExcelField(table: 'customer', key: 'tgl_lahir', label: 'Tanggal Lahir', type: FieldType.date),
    ExcelField(table: 'customer', key: 'tempat_lahir', label: 'Tempat Lahir', type: FieldType.text),
    ExcelField(table: 'customer', key: 'kelamin', label: 'Jenis Kelamin', type: FieldType.dropdown, options: {
      'L': 'Laki-laki',
      'P': 'Perempuan',
    }),
    ExcelField(table: 'customer', key: 'agama', label: 'Agama', type: FieldType.dropdown, options: {
      '1': 'Islam',
      '2': 'Kristen',
      '3': 'Katolik',
      '4': 'Hindu',
      '5': 'Budha',
      '6': 'Konghucu',
    }),
    ExcelField(table: 'customer', key: 'status_kawin', label: 'Status Perkawinan', type: FieldType.dropdown, options: {
      '1': 'Lajang',
      '2': 'Kawin',
      '3': 'Cerai Hidup',
      '4': 'Cerai Mati',
    }),
    ExcelField(table: 'customer', key: 'warganegara', label: 'Kewarganegaraan', type: FieldType.dropdown, options: {
      '1': 'WNI',
      '2': 'WNA',
    }),
    ExcelField(table: 'customer', key: 'nama_ibu', label: 'Nama Ibu Kandung', type: FieldType.text),
    ExcelField(table: 'customer', key: 'npwp', label: 'NPWP', type: FieldType.text),
    ExcelField(table: 'customer', key: 'pendidikan', label: 'Pendidikan Terakhir', type: FieldType.dropdown, options: {
      '1': 'SD',
      '2': 'SMP',
      '3': 'SMA',
      '4': 'D1',
      '5': 'D2',
      '6': 'D3',
      '7': 'D4',
      '8': 'S1',
      '9': 'S2',
      '10': 'S3',
    }),
    ExcelField(table: 'customer', key: 'vip', label: 'Nasabah VIP', type: FieldType.yn),
    ExcelField(table: 'customer', key: 'terkait', label: 'Pihak Terkait', type: FieldType.yn),

    // =====================
    // DATA IDENTITAS
    // =====================
    ExcelField(
      table: 'identity',
      key: 'jns_id',
      label: 'Jenis Identitas',
      type: FieldType.dropdown,
      required: true,
      options: {
        '1': 'KTP',
        '2': 'SIM',
        '3': 'PASSPORT',
        '4': 'KIMS / KITAS / KITAP',
        '5': 'SIUP',
        '6': 'TDP',
        '99': 'LAINNYA',
      },
    ),
    ExcelField(
      table: 'identity',
      key: 'no_id',
      label: 'Nomor Identitas',
      type: FieldType.text,
      required: true,
    ),
    ExcelField(
      table: 'identity',
      key: 'alamat',
      label: 'Alamat Sesuai Identitas',
      type: FieldType.text,
    ),
    ExcelField(
      table: 'identity',
      key: 'kelurahan',
      label: 'Kelurahan',
      type: FieldType.text,
    ),
    ExcelField(
      table: 'identity',
      key: 'kecamatan',
      label: 'Kecamatan',
      type: FieldType.text,
    ),
    ExcelField(
      table: 'identity',
      key: 'kota',
      label: 'Kota',
      type: FieldType.text,
    ),
    ExcelField(
      table: 'identity',
      key: 'provinsi',
      label: 'Provinsi',
      type: FieldType.text,
    ),
    ExcelField(
      table: 'identity',
      key: 'kode_pos',
      label: 'Kode Pos',
      type: FieldType.text,
    ),
    ExcelField(
      table: 'identity',
      key: 'negara_penerbit',
      label: 'Negara Penerbit',
      type: FieldType.text,
    ),
    ExcelField(
      table: 'identity',
      key: 'tempat_terbit',
      label: 'Instansi Penerbit',
      type: FieldType.text,
    ),
    ExcelField(
      table: 'identity',
      key: 'tanggal_terbit',
      label: 'Tanggal Terbit Identitas',
      type: FieldType.date,
    ),
    ExcelField(
      table: 'identity',
      key: 'tanggal_exp',
      label: 'Tanggal Kadaluarsa',
      type: FieldType.date,
    ),
    ExcelField(
      table: 'identity',
      key: 'fhoto_id',
      label: 'Nama File Foto Identitas',
      type: FieldType.text,
    ),
    ExcelField(
      table: 'identity',
      key: 'keterangan',
      label: 'Keterangan Tambahan',
      type: FieldType.text,
    ),

    // =====================
    // DATA KONTAK
    // =====================
    ExcelField(table: 'contact', key: 'no_hp1', label: 'Nomer Handphone 1', type: FieldType.text),
    ExcelField(table: 'contact', key: 'no_hp2', label: 'Nomer Handphone 2', type: FieldType.text),
    ExcelField(table: 'contact', key: 'email', label: 'Email', type: FieldType.text),
    ExcelField(table: 'contact', key: 'telepon', label: 'Telepon', type: FieldType.text),

    // =====================
    // DATA AO
    // =====================
    ExcelField(table: 'ao', key: 'ao_ref', label: 'Kode AO', type: FieldType.text),
    // ExcelField(table: 'ao', key: 'nama_ao', label: 'Nama AO', type: FieldType.text),

    // =====================
    // DATA KEPATUHAN
    // =====================
    ExcelField(table: 'compliance', key: 'gol_cust_apolo', label: 'Golongan Customer Apolo', type: FieldType.text),
    ExcelField(table: 'compliance', key: 'gol_cust_slik', label: 'Golongan Customer SLIK', type: FieldType.text),
    ExcelField(table: 'compliance', key: 'sandi_bank', label: 'Sandi Bank', type: FieldType.text),
    ExcelField(table: 'compliance', key: 'sandi_pekerja', label: 'Sandi Pekerjaan', type: FieldType.text),
    ExcelField(table: 'compliance', key: 'sandi_usaha', label: 'Sandi Usaha', type: FieldType.text),
    ExcelField(table: 'compliance', key: 'segmen_bisnis', label: 'Segmen Bisnis', type: FieldType.text),
    ExcelField(table: 'compliance', key: 'pendapatan_bulan', label: 'Pendapatan Bulan', type: FieldType.text),

    // =====================
    // DATA PETUGAS
    // =====================
    ExcelField(table: 'petugas', key: 'id_petugas', label: 'ID Petugas', type: FieldType.text),
    ExcelField(table: 'petugas', key: 'nama_petugas', label: 'Nama Petugas', type: FieldType.text),
    ExcelField(table: 'petugas', key: 'hp_petugas', label: 'Handphone Petugas', type: FieldType.text),

    // =====================
    // DATA AHLI WARIS
    // =====================
    ExcelField(table: 'heir', key: 'nama_waris', label: 'Nama Ahli Waris', type: FieldType.text),
    ExcelField(table: 'heir', key: 'no_id_waris', label: 'ID Ahli Waris', type: FieldType.text),
    ExcelField(table: 'heir', key: 'tgl_lahir_waris', label: 'Tanggal Lahir Ahli Waris', type: FieldType.text),
    ExcelField(table: 'heir', key: 'hubungan', label: 'Hubungan', type: FieldType.dropdown, options: {
      '1': 'Suami',
      '2': 'Istri',
      '3': 'Anak',
      '4': 'Orang Tua',
      '5': 'Saudara',
    }),

    // =====================
    // BADAN HUKUM / PENGURUS
    // =====================
    ExcelField(table: 'legal', key: 'jenis_badan_hukum', label: 'Jenis Badan Hukum', type: FieldType.text),
    ExcelField(table: 'legal', key: 'nama_pengurus', label: 'Nama Pengurus', type: FieldType.text),
    ExcelField(table: 'legal', key: 'no_id_pengurus', label: 'ID Pengurus', type: FieldType.text),
    ExcelField(table: 'legal', key: 'jabatan_pengurus', label: 'Jabatan Pengurus', type: FieldType.text),
    ExcelField(table: 'legal', key: 'nama_pengurus_2', label: 'Nama Pengurus 2', type: FieldType.text),
    ExcelField(table: 'legal', key: 'no_id_pengurus_2', label: 'ID Pengurus 2', type: FieldType.text),
    ExcelField(table: 'legal', key: 'jabatan_pengurus_2', label: 'Jabatan Pengurus 2', type: FieldType.text),
    ExcelField(table: 'legal', key: 'keterangan_kuasa', label: 'Keterangan Kuasa', type: FieldType.text),
    ExcelField(table: 'legal', key: 'otorisasi_pengurus', label: 'Otorisasi Pengurus', type: FieldType.text),

    // =====================
    // DATA SISTEM
    // =====================
    ExcelField(table: 'system', key: 'input_user', label: 'Dibuat Oleh', type: FieldType.text),
    ExcelField(table: 'system', key: 'input_term', label: 'Tanggal Dibuat', type: FieldType.date),
    ExcelField(table: 'system', key: 'kode_kantor', label: 'Kode Kantor', type: FieldType.date),
  ];

  /// =====================
  /// DERIVED
  /// =====================
  List<ExcelField> get currentFields {
    final step = steps[currentStep];

    return fields.where((f) {
      // 🔑 no_cif selalu muncul saat search
      if (f.key == 'no_cif' && mode == PeroranganMode.search) {
        return true;
      }

      // normal step-based rendering
      if (!step.tables.contains(f.table)) return false;

      // sembunyikan field search-only saat create
      if (mode == PeroranganMode.create && f.onlyForSearch) return false;

      return true;
    }).toList();
  }

  /// =====================
  /// MODE CONTROL
  /// =====================
  void startCreate() {
    reset();
    mode = PeroranganMode.create;
    notifyListeners();
  }

  void startSearch() {
    reset();
    mode = PeroranganMode.search;
    notifyListeners();
  }

  /// =====================
  /// SEARCH API
  /// =====================
  Future<void> submitSearch() async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await http.post(
        Uri.parse('http://103.96.147.187:7006/cari-cif'),
        headers: {'Content-Type': 'application/json', 'api-key': '123'},
        body: jsonEncode({
          "filter": {
            "general": {
              "no_cif": searchNoCif,
              "nama_cif": searchNamaCif,
            }
          },
          "pagination": {"page": 1, "limit": 1}
        }),
      );

      final json = jsonDecode(res.body);
      final data = json['data'][0];

      values.clear();

      for (final f in fields) {
        final raw = data[f.key];

        if (raw == null || raw.toString().isEmpty) {
          values[f.key] = null; // <-- KOSONGKAN SAJA
          continue;
        }

        switch (f.type) {
          case FieldType.date:
            values[f.key] = DateTime.tryParse(raw.toString());
            break;

          case FieldType.yn:
          case FieldType.dropdown:
          case FieldType.text:
            values[f.key] = raw.toString();
            break;
        }
      }

      mode = PeroranganMode.search;
      currentStep = 0;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// =====================
  /// VALUE HANDLER
  /// =====================
  void setValue(String key, dynamic value) {
    values[key] = value;
    notifyListeners();
  }

  dynamic getValue(String key) => values[key];

  /// =====================
  /// STEP CONTROL
  /// =====================
  void nextStep() {
    if (currentStep < steps.length - 1) {
      currentStep++;
      notifyListeners();
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  void reset() {
    values.clear();
    currentStep = 0;
  }
}
