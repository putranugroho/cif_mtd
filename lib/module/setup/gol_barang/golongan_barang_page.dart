import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'golongan_barang_notifier.dart';

class GolonganBarangPage extends StatelessWidget {
  const GolonganBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GolonganBarangNotifier()..fetchData(),
      child: Consumer<GolonganBarangNotifier>(
        builder: (context, notifier, _) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: const Text('Master Golongan Barang'),
              backgroundColor: Colors.blueAccent,
            ),
            body: Row(
              children: [
                // Tabel utama
                Expanded(
                  flex: notifier.isSidebarOpen ? 2 : 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: notifier.toggleSidebar,
                          icon: const Icon(Icons.add),
                          label: const Text('Tambah Golongan Barang'),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: notifier.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(label: Text('ID')),
                                      DataColumn(label: Text('KODE GOLONGAN')),
                                      DataColumn(label: Text('NAMA GOLONGAN')),
                                      DataColumn(label: Text('DESKRIPSI')),
                                      DataColumn(label: Text('STATUS')),
                                      DataColumn(label: Text('TANGGAL DIBUAT')),
                                    ],
                                    rows: notifier.data.map((item) {
                                      return DataRow(cells: [
                                        DataCell(Text(item['id'].toString())),
                                        DataCell(Text(item['kode_golongan'] ?? '')),
                                        DataCell(Text(item['nama_golongan'] ?? '')),
                                        DataCell(Text(item['deskripsi'] ?? '')),
                                        DataCell(Text(item['status'] ?? '')),
                                        DataCell(Text(item['created_at'] != null ? (item['created_at'] as String).split('T')[0] : '')),
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Sidebar form input
                if (notifier.isSidebarOpen)
                  Container(
                    width: 350,
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tambah Golongan Barang',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        // Kode Golongan
                        TextField(
                          controller: notifier.kodeGolonganController,
                          decoration: const InputDecoration(
                            labelText: 'Kode Golongan',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Nama Golongan
                        TextField(
                          controller: notifier.namaGolonganController,
                          decoration: const InputDecoration(
                            labelText: 'Nama Golongan',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: notifier.deskripsiController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Deskripsi',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Status',
                            border: OutlineInputBorder(),
                          ),
                          value: notifier.selectedStatus,
                          items: notifier.statusList
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            notifier.setSelectedStatus(value);
                          },
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: notifier.isSubmitting
                                    ? null
                                    : () async {
                                        await notifier.tambahDataToApi();
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: notifier.isSubmitting
                                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                    : const Text('Simpan'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: notifier.toggleSidebar,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                                child: const Text('Batal'),
                              ),
                            ),
                          ],
                        )
                      ],
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
