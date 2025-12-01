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
