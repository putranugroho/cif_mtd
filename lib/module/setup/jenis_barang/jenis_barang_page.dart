import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'jenis_barang_notifier.dart';

class JenisBarangPage extends StatelessWidget {
  const JenisBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JenisBarangNotifier(),
      child: Consumer<JenisBarangNotifier>(
        builder: (context, notifier, _) {
          return Row(
            children: [
              Expanded(
                flex: notifier.isSidebarOpen ? 3 : 4,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Master Jenis Barang'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ElevatedButton.icon(
                          onPressed: notifier.toggleSidebar,
                          icon: const Icon(Icons.add),
                          label: const Text("Tambah Jenis Barang"),
                        ),
                      )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('GOLONGAN BARANG')),
                          DataColumn(label: Text('KELOMPOK BARANG')),
                          DataColumn(label: Text('KODE JENIS BARANG')),
                          DataColumn(label: Text('NAMA JENIS')),
                          DataColumn(label: Text('DESKRIPSI')),
                          DataColumn(label: Text('STATUS')),
                          DataColumn(label: Text('TANGGAL DIBUAT')),
                        ],
                        rows: notifier.data
                            .map(
                              (item) => DataRow(cells: [
                                DataCell(Text(item['id'].toString())),
                                DataCell(Text(item['golongan'] ?? '-')),
                                DataCell(Text(item['kelompok'] ?? '-')),
                                DataCell(Text(item['kodeJenis'] ?? '-')),
                                DataCell(Text(item['namaJenis'] ?? '-')),
                                DataCell(Text(item['deskripsi'] ?? '-')),
                                DataCell(Text(item['status'] ?? '-')),
                                DataCell(Text(item['tanggal'] ?? '-')),
                              ]),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),

              // === Sidebar Form ===
              if (notifier.isSidebarOpen)
                Container(
                  width: 350,
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tambah Jenis Barang",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        // Dropdown Golongan Barang
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Golongan Barang",
                            border: OutlineInputBorder(),
                          ),
                          value: notifier.selectedGolongan,
                          items: notifier.golonganList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: notifier.onGolonganChanged,
                        ),
                        const SizedBox(height: 16),

                        // Dropdown Kelompok Barang
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Kelompok Barang",
                            border: OutlineInputBorder(),
                          ),
                          value: notifier.selectedKelompok,
                          items: notifier.kelompokList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (v) {
                            notifier.selectedKelompok = v;
                            notifier.notifyListeners();
                          },
                        ),
                        const SizedBox(height: 16),

                        // TextField Kode Jenis Barang
                        TextField(
                          controller: notifier.kodeJenisController,
                          decoration: const InputDecoration(
                            labelText: "Kode Jenis Barang",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // TextField Nama Jenis
                        TextField(
                          controller: notifier.namaJenisController,
                          decoration: const InputDecoration(
                            labelText: "Nama Jenis",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // TextArea Deskripsi
                        TextField(
                          controller: notifier.deskripsiController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: "Deskripsi",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Dropdown Status
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
                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: notifier.toggleSidebar,
                              child: const Text("Batal"),
                            ),
                            ElevatedButton(
                              onPressed: notifier.tambahData,
                              child: const Text("Simpan"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
