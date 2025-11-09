import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'kelompok_barang_notifier.dart';

class KelompokBarangPage extends StatelessWidget {
  const KelompokBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KelompokBarangNotifier(),
      child: Consumer<KelompokBarangNotifier>(
        builder: (context, notifier, _) {
          return Row(
            children: [
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
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('GOLONGAN BARANG')),
                        DataColumn(label: Text('KODE KELOMPOK')),
                        DataColumn(label: Text('NAMA KELOMPOK')),
                        DataColumn(label: Text('DESKRIPSI')),
                        DataColumn(label: Text('STATUS')),
                      ],
                      rows: notifier.data
                          .map(
                            (item) => DataRow(cells: [
                              DataCell(Text(item['id'].toString())),
                              DataCell(Text(item['golonganBarang'] ?? '-')),
                              DataCell(Text(item['kodeKelompok'] ?? '-')),
                              DataCell(Text(item['namaKelompok'] ?? '-')),
                              DataCell(Text(item['deskripsi'] ?? '-')),
                              DataCell(Text(item['status'] ?? '-')),
                            ]),
                          )
                          .toList(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tambah Kelompok Barang",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Golongan Barang",
                          border: OutlineInputBorder(),
                        ),
                        value: notifier.selectedGolongan,
                        items: notifier.golonganList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => notifier.selectedGolongan = v,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: notifier.namaKelompokController,
                        decoration: const InputDecoration(
                          labelText: "Kode Kelompok",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: notifier.namaKelompokController,
                        decoration: const InputDecoration(
                          labelText: "Nama Kelompok",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: notifier.deskripsiController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Deskripsi",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Status",
                          border: OutlineInputBorder(),
                        ),
                        value: notifier.selectedStatus,
                        items: notifier.statusList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => notifier.selectedStatus = v,
                      ),
                      const Spacer(),
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
