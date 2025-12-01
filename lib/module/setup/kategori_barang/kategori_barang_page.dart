// kategori_barang_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'kategori_barang_notifier.dart';

class KategoriBarangPage extends StatelessWidget {
  const KategoriBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KategoriBarangNotifier(context: context),
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
                  body: notifier.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('KODE KATEGORI')),
                                DataColumn(label: Text('NAMA KATEGORI')),
                                DataColumn(label: Text('DESKRIPSI')),
                                DataColumn(label: Text('STATUS')),
                                DataColumn(label: Text('ACTION')),
                              ],
                              rows: notifier.list.map((item) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(item['id'].toString())),
                                    DataCell(Text(item['kode_kategori'])),
                                    DataCell(Text(item['nama_kategori'])),
                                    DataCell(Text(item['deskripsi'])),
                                    DataCell(Text(item['status'])),
                                    DataCell(Row(
                                      children: [
                                        IconButton(
                                            tooltip: "Edit",
                                            onPressed: () {
                                              notifier.onEdit(item);
                                            },
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            tooltip: "Delete",
                                            onPressed: () {},
                                            icon: Icon(Icons.delete))
                                      ],
                                    )),
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

  Widget _buildSidebarForm(
      BuildContext context, KategoriBarangNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notifier.edit ? "Edit Kategori Barang" : "Tambah Kategori Barang",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: notifier.kodeKategoriController,
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
          controller: notifier.deskripsiController,
          decoration: const InputDecoration(
            labelText: "Deskripsi",
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: notifier.selectedStatus,
          decoration: const InputDecoration(
            labelText: "Status",
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: "Aktif", child: Text("Aktif")),
            DropdownMenuItem(value: "Tidak Aktif", child: Text("Tidak Aktif")),
          ],
          onChanged: (val) {
            notifier.selectedStatus = val;
            notifier.notifyListeners();
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
              onPressed: () async {
                await notifier.addKategori();
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
