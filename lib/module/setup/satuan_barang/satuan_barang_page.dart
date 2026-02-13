import 'package:cif/module/setup/satuan_barang/satuan_barang_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SatuanBarangPage extends StatelessWidget {
  const SatuanBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SatuanBarangNotifier(),
      child: Consumer<SatuanBarangNotifier>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Setup Satuan Barang')),
            body: Row(
              children: [
                // ====== TABEL DATA ======
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: provider.toggleSidebar,
                          icon: const Icon(Icons.add),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow, // warna latar tombol
                            foregroundColor: Colors.black, // warna teks & ikon
                          ),
                          label: const Text("Tambah Satuan"),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Nama Satuan')),
                                DataColumn(label: Text('Deskripsi')),
                                DataColumn(label: Text('Status')),
                              ],
                              rows: provider.data.map((item) {
                                return DataRow(cells: [
                                  DataCell(Text(item['id'].toString())),
                                  DataCell(Text(item['nama'])),
                                  DataCell(Text(item['deskripsi'])),
                                  DataCell(Text(item['status'])),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ====== SIDEBAR FORM ======
                if (provider.isSidebarOpen)
                  Container(
                    width: 380,
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tambah Satuan Barang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.namaController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Satuan',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.deskripsiController,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: provider.selectedStatus,
                            decoration: const InputDecoration(
                              labelText: 'Status',
                              border: OutlineInputBorder(),
                            ),
                            items: provider.statusList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (val) {
                              provider.selectedStatus = val!;
                              provider.notifyListeners();
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: provider.tambahData,
                              icon: const Icon(Icons.save),
                              label: const Text('Simpan'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: provider.toggleSidebar,
                              icon: const Icon(Icons.cancel),
                              label: const Text('Batal'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
