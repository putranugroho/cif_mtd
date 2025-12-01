import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'kelompok_barang_notifier.dart';

class KelompokBarangPage extends StatelessWidget {
  const KelompokBarangPage({super.key});

  bool _formIsValid(KelompokBarangNotifier n) {
    return n.selectedGolonganId != null && n.kodeKelompokController.text.trim().isNotEmpty && n.namaKelompokController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // important: call init() to ensure golongan map is ready before fetching kelompok
      create: (_) => KelompokBarangNotifier()..init(),
      child: Consumer<KelompokBarangNotifier>(
        builder: (context, notifier, _) {
          return Row(
            children: [
              // =======================
              // MAIN TABLE SECTION
              // =======================
              Expanded(
                flex: notifier.isSidebarOpen ? 3 : 4,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: const Text('Master Kelompok Barang'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ElevatedButton.icon(
                          onPressed: notifier.toggleSidebar,
                          icon: const Icon(Icons.add),
                          label: const Text("Tambah Kelompok Barang"),
                        ),
                      )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: notifier.data.isEmpty
                        ? const Center(child: Text('Belum ada data'))
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('GOLONGAN BARANG')),
                                DataColumn(label: Text('KODE KELOMPOK')),
                                DataColumn(label: Text('NAMA KELOMPOK')),
                                DataColumn(label: Text('DESKRIPSI')),
                                DataColumn(label: Text('STATUS')),
                              ],
                              rows: notifier.data.map((item) {
                                return DataRow(cells: [
                                  DataCell(Text(item['id'].toString())),
                                  DataCell(Text(item['golonganBarang'] ?? '-')),
                                  DataCell(Text(item['kodeKelompok'] ?? '-')),
                                  DataCell(Text(item['namaKelompok'] ?? '-')),
                                  DataCell(Text(item['deskripsi'] ?? '-')),
                                  DataCell(Text(item['status'] ?? '-')),
                                ]);
                              }).toList(),
                            ),
                          ),
                  ),
                ),
              ),

              // =======================
              // SIDEBAR ADD FORM
              // =======================
              if (notifier.isSidebarOpen)
                Container(
                  width: 380,
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tambah Kelompok Barang",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      // DROPDOWN GOLONGAN (int id, display kode - nama)
                      DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          labelText: "Golongan Barang",
                          border: OutlineInputBorder(),
                        ),
                        value: notifier.selectedGolonganId,
                        items: notifier.golonganList.map((g) {
                          // try multiple key names from API
                          final id = g['id'];
                          final kode = g['kode_golongan'] ?? g['kodeGolongan'] ?? g['kode'];
                          final nama = g['nama_golongan'] ?? g['namaGolongan'] ?? g['nama'];
                          final label = [if (kode != null) kode.toString(), if (nama != null) nama.toString()].join(' - ');
                          return DropdownMenuItem<int>(
                            value: id is int ? id : int.tryParse(id.toString()),
                            child: Text(label.isNotEmpty ? label : id.toString()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          notifier.selectedGolonganId = val;
                          notifier.notifyListeners();
                        },
                      ),

                      const SizedBox(height: 16),

                      // KODE KELOMPOK
                      TextField(
                        controller: notifier.kodeKelompokController,
                        decoration: const InputDecoration(
                          labelText: "Kode Kelompok",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // NAMA KELOMPOK
                      TextField(
                        controller: notifier.namaKelompokController,
                        decoration: const InputDecoration(
                          labelText: "Nama Kelompok",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // DESKRIPSI
                      TextField(
                        controller: notifier.deskripsiController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Deskripsi",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // STATUS
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Status",
                          border: OutlineInputBorder(),
                        ),
                        value: notifier.selectedStatus,
                        items: notifier.statusList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) {
                          notifier.selectedStatus = v;
                          notifier.notifyListeners();
                        },
                      ),

                      const Spacer(),

                      // BUTTONS
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: notifier.toggleSidebar,
                              child: const Text("Batal"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _formIsValid(notifier)
                                  ? () async {
                                      // disable UI while submitting by temporarily closing sidebar toggle or show loading (simple approach)
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      try {
                                        await notifier.tambahData();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Data berhasil disimpan')),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Gagal menyimpan: $e')),
                                        );
                                      }
                                    }
                                  : null,
                              child: const Text("Simpan"),
                            ),
                          ),
                        ],
                      )
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
