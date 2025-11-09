import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'kategori_barang_notifier.dart';

class KategoriBarangPage extends StatelessWidget {
  const KategoriBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KategoriBarangNotifier(),
      child: Consumer<KategoriBarangNotifier>(
        builder: (context, notifier, _) {
          return Row(
            children: [
              // === MAIN TABLE ===
              Expanded(
                flex: notifier.showForm ? 3 : 4,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: const Text('Master Kategori Barang'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ElevatedButton.icon(
                          onPressed: notifier.toggleForm,
                          icon: const Icon(Icons.add),
                          label: const Text("Tambah Kategori"),
                        ),
                      )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('KODE KATEGORI')),
                          DataColumn(label: Text('NAMA KATEGORI')),
                          DataColumn(label: Text('DESKRIPSI')),
                          DataColumn(label: Text('STATUS')),
                        ],
                        rows: notifier.dataList.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item['id'].toString())),
                              DataCell(Text(item['kodeKategori'] ?? '-')),
                              DataCell(Text(item['kategoriBarang'] ?? '-')),
                              DataCell(Text(item['deskripsi'] ?? '-')),
                              DataCell(Text(item['status'] ?? '-')),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),

              // === SIDEBAR FORM ===
              if (notifier.showForm)
                Container(
                  width: 350,
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(16),
                  child: _buildSidebarForm(context, notifier),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSidebarForm(BuildContext context, KategoriBarangNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tambah Kategori Barang",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: notifier.kategoriController,
          decoration: const InputDecoration(
            labelText: "Kode Kategori",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: notifier.kategoriController,
          decoration: const InputDecoration(
            labelText: "Nama Kategori",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            labelText: "Deskripsi",
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          onChanged: (val) {
            // optional: bisa disimpan sementara di model
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: "Status",
            border: OutlineInputBorder(),
          ),
          value: notifier.selectedStatus,
          items: const [
            DropdownMenuItem(value: "Aktif", child: Text("Aktif")),
            DropdownMenuItem(value: "Tidak Aktif", child: Text("Tidak Aktif")),
          ],
          onChanged: (val) {
            notifier.selectedStatus = val;
          },
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: notifier.toggleForm,
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                notifier.addData();
                notifier.toggleForm();
              },
              child: const Text("Simpan"),
            ),
          ],
        )
      ],
    );
  }
}
