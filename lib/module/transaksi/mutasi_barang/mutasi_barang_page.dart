import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mutasi_barang_notifier.dart';

class MutasiBarangPage extends StatelessWidget {
  const MutasiBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MutasiBarangNotifier(),
      child: Consumer<MutasiBarangNotifier>(
        builder: (context, notifier, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Mutasi Barang Antar Gudang')),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ============ TABEL DATA MUTASI ============
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: notifier.toggleSidebar,
                          icon: const Icon(Icons.add),
                          label: const Text("Tambah Mutasi Barang"),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('ID Mutasi')),
                                DataColumn(label: Text('Tanggal Mutasi')),
                                DataColumn(label: Text('Gudang Asal')),
                                DataColumn(label: Text('Gudang Tujuan')),
                                DataColumn(label: Text('Nama Barang')),
                                DataColumn(label: Text('Jumlah')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('Tanggal Diterima')),
                                DataColumn(label: Text('Petugas')),
                              ],
                              rows: notifier.data.map((item) {
                                return DataRow(cells: [
                                  DataCell(Text(item['id'])),
                                  DataCell(Text(item['tanggal'])),
                                  DataCell(Text(item['gudangAsal'])),
                                  DataCell(Text(item['gudangTujuan'])),
                                  DataCell(Text(item['barang'])),
                                  DataCell(Text(item['jumlah'].toString())),
                                  DataCell(_buildStatusChip(item['status'])),
                                  DataCell(Text(item['tanggalDiterima'])),
                                  DataCell(Text(item['petugas'])),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ============ SIDEBAR FORM INPUT ============
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
                            "Tambah Mutasi Barang",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),

                          // Nomor Mutasi (auto)
                          Text("Nomor Mutasi: MUT-${(notifier.data.length + 1).toString().padLeft(3, '0')}"),

                          const SizedBox(height: 16),
                          // Tanggal Mutasi
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text("Tanggal Mutasi"),
                            subtitle: Text(
                              notifier.selectedTanggal == null ? 'Pilih tanggal' : notifier.selectedTanggal.toString().split(' ')[0],
                            ),
                            trailing: const Icon(Icons.calendar_today),
                            onTap: () => notifier.pilihTanggal(context),
                          ),

                          const SizedBox(height: 8),
                          // Dropdown Gudang Asal
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(labelText: 'Gudang Asal', border: OutlineInputBorder()),
                            value: notifier.selectedGudangAsal,
                            items: notifier.gudangList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (v) => notifier.selectedGudangAsal = v,
                          ),

                          const SizedBox(height: 8),
                          // Dropdown Gudang Tujuan
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(labelText: 'Gudang Tujuan', border: OutlineInputBorder()),
                            value: notifier.selectedGudangTujuan,
                            items: notifier.gudangList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (v) => notifier.selectedGudangTujuan = v,
                          ),

                          const SizedBox(height: 8),
                          // Dropdown Barang
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(labelText: 'Nama Barang', border: OutlineInputBorder()),
                            value: notifier.selectedBarang,
                            items: notifier.barangList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (v) => notifier.selectedBarang = v,
                          ),

                          const SizedBox(height: 8),
                          // Jumlah Barang
                          TextField(
                            controller: notifier.jumlahController,
                            decoration: const InputDecoration(
                              labelText: 'Jumlah Barang',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),

                          const SizedBox(height: 8),
                          // Dropdown Status
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
                            value: notifier.selectedStatus,
                            items: notifier.statusList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (v) => notifier.selectedStatus = v,
                          ),

                          const SizedBox(height: 8),
                          // Keterangan
                          TextField(
                            controller: notifier.keteranganController,
                            decoration: const InputDecoration(
                              labelText: 'Keterangan (opsional)',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 2,
                          ),

                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: notifier.tambahData,
                            icon: const Icon(Icons.save),
                            label: const Text('Simpan'),
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

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Dikirim':
        color = Colors.orange;
        break;
      case 'Diterima':
        color = Colors.green;
        break;
      case 'Selesai':
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }
    return Chip(
      label: Text(status, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
