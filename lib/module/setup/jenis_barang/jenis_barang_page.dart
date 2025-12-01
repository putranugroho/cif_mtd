// jenis_barang_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'jenis_barang_notifier.dart';

class JenisBarangPage extends StatelessWidget {
  const JenisBarangPage({super.key});

  bool _formIsValid(JenisBarangNotifier n) {
    return n.selectedGolonganId != null &&
        n.selectedKelompokId != null &&
        n.kodeJenisController.text.trim().isNotEmpty &&
        n.namaJenisController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JenisBarangNotifier()..init(),
      child: Consumer<JenisBarangNotifier>(
        builder: (context, notifier, _) {
          return Row(
            children: [
              // TABLE
              Expanded(
                flex: notifier.isSidebarOpen ? 3 : 4,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Master Jenis Barang'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ElevatedButton.icon(
                          onPressed: notifier.toggleSidebar,
                          icon: const Icon(Icons.add),
                          label: const Text('Tambah Jenis Barang'),
                        ),
                      )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: notifier.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : notifier.jenisList.isEmpty
                            ? const Center(child: Text('Belum ada data'))
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: const [
                                    DataColumn(label: Text('ID')),
                                    DataColumn(label: Text('GOLONGAN')),
                                    DataColumn(label: Text('KELOMPOK')),
                                    DataColumn(label: Text('KODE JENIS')),
                                    DataColumn(label: Text('NAMA JENIS')),
                                    DataColumn(label: Text('DESKRIPSI')),
                                    DataColumn(label: Text('STATUS')),
                                    DataColumn(label: Text('DIBUAT')),
                                  ],
                                  rows: notifier.jenisList.map((item) {
                                    return DataRow(cells: [
                                      DataCell(Text(item['id']?.toString() ?? '-')),
                                      DataCell(Text(item['golonganLabel'] ?? '-')),
                                      DataCell(Text(item['kelompokLabel'] ?? '-')),
                                      DataCell(Text(item['kodeJenis'] ?? '-')),
                                      DataCell(Text(item['namaJenis'] ?? '-')),
                                      DataCell(Text(item['deskripsi'] ?? '-')),
                                      DataCell(Text(item['status'] ?? '-')),
                                      DataCell(Text(item['created_at']?.toString().split('T').first ?? '-')),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                  ),
                ),
              ),

              // SIDEBAR FORM
              if (notifier.isSidebarOpen)
                Container(
                  width: 420,
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tambah Jenis Barang', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 12),

                      // Golongan dropdown (int id)
                      DropdownButtonFormField<int>(
                        decoration: const InputDecoration(labelText: 'Golongan Barang', border: OutlineInputBorder()),
                        value: notifier.selectedGolonganId,
                        items: notifier.golonganList.map((g) {
                          final idRaw = g['id'];
                          final id = idRaw is int ? idRaw : int.tryParse(idRaw.toString());
                          final kode = g['kode_golongan'] ?? g['kodeGolongan'] ?? g['kode'];
                          final nama = g['nama_golongan'] ?? g['namaGolongan'] ?? g['nama'];
                          final labelParts = [
                            if (kode != null && kode.toString().trim().isNotEmpty) kode.toString(),
                            if (nama != null && nama.toString().trim().isNotEmpty) nama.toString(),
                          ];
                          final label = labelParts.isNotEmpty ? labelParts.join(' - ') : (id?.toString() ?? '');
                          return DropdownMenuItem<int>(value: id, child: Text(label));
                        }).toList(),
                        onChanged: (val) {
                          notifier.selectGolongan(val);
                        },
                      ),

                      const SizedBox(height: 12),

                      // Kelompok dropdown filtered
                      DropdownButtonFormField<int>(
                        decoration: const InputDecoration(labelText: 'Kelompok Barang', border: OutlineInputBorder()),
                        value: notifier.selectedKelompokId,
                        items: notifier.kelompokFiltered.map((k) {
                          final idRaw = k['id'];
                          final id = idRaw is int ? idRaw : int.tryParse(idRaw.toString());
                          final kode = k['kode_kelompok'] ?? k['kodeKelompok'] ?? k['kode'];
                          final nama = k['nama_kelompok'] ?? k['namaKelompok'] ?? k['nama'];
                          final labelParts = [
                            if (kode != null && kode.toString().trim().isNotEmpty) kode.toString(),
                            if (nama != null && nama.toString().trim().isNotEmpty) nama.toString(),
                          ];
                          final label = labelParts.isNotEmpty ? labelParts.join(' - ') : (id?.toString() ?? '');
                          return DropdownMenuItem<int>(value: id, child: Text(label));
                        }).toList(),
                        onChanged: (val) {
                          notifier.selectKelompok(val);
                        },
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: notifier.kodeJenisController,
                        decoration: const InputDecoration(labelText: 'Kode Jenis', border: OutlineInputBorder()),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: notifier.namaJenisController,
                        decoration: const InputDecoration(labelText: 'Nama Jenis', border: OutlineInputBorder()),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: notifier.deskripsiController,
                        maxLines: 3,
                        decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
                      ),

                      const SizedBox(height: 12),

                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
                        value: notifier.selectedStatus,
                        items: notifier.statusList.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                        onChanged: (v) {
                          notifier.selectedStatus = v;
                          notifier.notifyListeners();
                        },
                      ),

                      const Spacer(),

                      if (notifier.errorMessage != null) Text(notifier.errorMessage!, style: const TextStyle(color: Colors.red)),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: notifier.toggleSidebar,
                              child: const Text('Batal'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: notifier.isSubmitting
                                  ? null
                                  : _formIsValid(notifier)
                                      ? () async {
                                          final scaffold = ScaffoldMessenger.of(context);
                                          scaffold.hideCurrentSnackBar();
                                          final ok = await notifier.tambahData();
                                          if (ok) {
                                            scaffold.showSnackBar(const SnackBar(content: Text('Data berhasil disimpan')));
                                          } else {
                                            scaffold.showSnackBar(SnackBar(content: Text(notifier.errorMessage ?? 'Gagal simpan')));
                                          }
                                        }
                                      : null,
                              child: notifier.isSubmitting
                                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                  : const Text('Simpan'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
