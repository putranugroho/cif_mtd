// Fungsi untuk membulatkan nilai dan menyesuaikan total agar sesuai target
List<int> pembulatanDenganPenyesuaian(List<double> nilaiAsli, double totalTarget) {
  List<int> nilaiBulatan = nilaiAsli.map((e) => e.round()).toList();
  int totalBulatan = nilaiBulatan.fold(0, (a, b) => a + b);
  int selisih = totalTarget.round() - totalBulatan;

  // Penyesuaian nilai berdasarkan selisih
  while (selisih != 0) {
    for (int i = 0; i < nilaiBulatan.length && selisih != 0; i++) {
      if (selisih > 0) {
        nilaiBulatan[i]++;
        selisih--;
      } else if (selisih < 0 && nilaiBulatan[i] > 0) {
        nilaiBulatan[i]--;
        selisih++;
      }
    }
  }

  return nilaiBulatan;
}

// Contoh integrasi ke dalam fungsi utama atau saat pengolahan data
void prosesNilaiTransaksiPPNPPH(List<double> listTransaksi, List<double> listPPN, List<double> listPPH, double totalTransaksi, double totalPPN, double totalPPH) {
  List<int> hasilTransaksi = pembulatanDenganPenyesuaian(listTransaksi, totalTransaksi);
  List<int> hasilPPN = pembulatanDenganPenyesuaian(listPPN, totalPPN);
  List<int> hasilPPH = pembulatanDenganPenyesuaian(listPPH, totalPPH);

  // Lanjutkan dengan penggunaan hasilTransaksi, hasilPPN, dan hasilPPH sesuai kebutuhan
  print('Hasil Transaksi: \$hasilTransaksi');
  print('Hasil PPN: \$hasilPPN');
  print('Hasil PPH: \$hasilPPH');
}
