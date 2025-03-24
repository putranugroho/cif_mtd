import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class PerusahaanNotifier extends ChangeNotifier {
  final BuildContext context;

  PerusahaanNotifier({required this.context}) {
    perusahaanModel = PerusahaanModel(
        kodePt: "001",
        namaPt: "PT TEGUH AMAN LESTARI",
        alamat: "TRASA COWORKING SPACE",
        kelurahan: "PROCOT",
        kecamatan: "SLAWI",
        kota: "KABUPATEN TEGAL",
        provinsi: "JAWA TENGAH",
        kodePos: "52419",
        npwp: "000288282882882",
        dirut: "",
        dirKeuangan: "",
        dirOperasi: "");
    kodePerusahaan.text = perusahaanModel!.kodePt;
    namaPerusahaan.text = perusahaanModel!.namaPt;
    alamat.text = perusahaanModel!.alamat;
    kelurahan.text = perusahaanModel!.kelurahan;
    kecamatan.text = perusahaanModel!.kecamatan;
    kota.text = perusahaanModel!.kota;
    provinsi.text = perusahaanModel!.provinsi;
    kodePos.text = perusahaanModel!.kodePos;
    npwp.text = perusahaanModel!.npwp;
    dirut.text = perusahaanModel!.dirut;
    dirKeuangan.text = perusahaanModel!.dirKeuangan;
    dirOperasi.text = perusahaanModel!.dirOperasi;
    notifyListeners();
  }

  PerusahaanModel? perusahaanModel;

  final keyForm = GlobalKey<FormState>();
  TextEditingController kodePerusahaan = TextEditingController();
  TextEditingController namaPerusahaan = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController kelurahan = TextEditingController();
  TextEditingController kecamatan = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController provinsi = TextEditingController();
  TextEditingController kodePos = TextEditingController();
  TextEditingController npwp = TextEditingController();
  TextEditingController dirut = TextEditingController();
  TextEditingController dirKeuangan = TextEditingController();
  TextEditingController dirOperasi = TextEditingController();

  cek() {
    if (keyForm.currentState!.validate()) {}
  }
}
