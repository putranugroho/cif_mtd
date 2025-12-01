import 'package:accounting/network/network_aset.dart';
import 'package:accounting/repository/master_repository.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';

class KategoriBarangNotifier extends ChangeNotifier {
  final BuildContext context;
  KategoriBarangNotifier({required this.context}) {
    fetchKategori();
  }

  bool isLoading = false;

  bool showForm = false;
  bool edit = false;
  TextEditingController kodeKategoriController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  String? selectedStatus;

  List<Map<String, dynamic>> list = [];
  Map<String, dynamic> kategoriModel = {};

  onEdit(Map<String, dynamic> value) {
    kategoriModel = value;
    kodeKategoriController.text = kategoriModel['kode_kategori'];
    kategoriController.text = kategoriModel['nama_kategori'];
    deskripsiController.text = kategoriModel['deskripsi'];
    selectedStatus = kategoriModel['status'];
    showForm = true;
    edit = true;
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
    if (edit) {
      try {
        final body = {
          "kode_kategori": kodeKategoriController.text,
          "nama_kategori": kategoriController.text,
          "deskripsi": deskripsiController.text,
          "status": selectedStatus ?? "Aktif",
        };
        MasterRepository.updatekategori(
                NetworkAset.kategoriupdate(kategoriModel['id']), body)
            .then((value) {
          fetchKategori();
          clearForm();
          informationDialog(context, "Informasi", value['message']);
        });
      } catch (e) {
        debugPrint("Add error: $e");
        informationDialog(context, "Peringatan", "$e");
      }
    } else {
      try {
        final body = {
          "kode_kategori": kodeKategoriController.text,
          "nama_kategori": kategoriController.text,
          "deskripsi": deskripsiController.text,
          "status": selectedStatus ?? "Aktif",
        };
        MasterRepository.addkategori(NetworkAset.kategori(), body)
            .then((value) {
          fetchKategori();
          clearForm();
          informationDialog(context, "Informasi", value['message']);
        });
      } catch (e) {
        debugPrint("Add error: $e");
        informationDialog(context, "Peringatan", "$e");
      }
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
    edit = false;
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
