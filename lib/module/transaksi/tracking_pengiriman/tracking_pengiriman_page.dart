import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tracking_pengiriman_notifier.dart';

class TrackingPengirimanPage extends StatelessWidget {
  const TrackingPengirimanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrackingPengirimanNotifier(),
      child: Consumer<TrackingPengirimanNotifier>(
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Tracking Pengiriman Barang')),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ======== LIST DATA =========
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // === FILTER & SORT ===
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Filter Status',
                                  border: OutlineInputBorder(),
                                ),
                                value: model.selectedFilter,
                                items: ['Semua', ...model.statusList]
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: model.setFilter,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Sortir Berdasarkan',
                                  border: OutlineInputBorder(),
                                ),
                                value: model.selectedSort,
                                items: model.sortOptions
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: model.setSort,
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.refresh),
                              label: const Text('Reset'),
                              onPressed: model.resetFilter,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // === TABLE ===
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Surat Jalan')),
                                DataColumn(label: Text('Nomor Resi')),
                                DataColumn(label: Text('Kurir / Mover')),
                                DataColumn(label: Text('Tanggal Update')),
                                DataColumn(label: Text('Nama Penerima')),
                                DataColumn(label: Text('Tanggal Penerima')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('Catatan')),
                                DataColumn(label: Text('Aksi')),
                              ],
                              rows: model.filteredData.map((item) {
                                final index = model.filteredData.indexOf(item);
                                final disabled = item['status'] != 'Dalam Perjalanan';

                                return DataRow(cells: [
                                  DataCell(Text(item['nomorRef'])),
                                  DataCell(Text(item['id'])),
                                  DataCell(Text(item['kurir'])),
                                  DataCell(Text(item['tanggalUpdate'])),
                                  DataCell(Text(item['namaPenerima'] ?? '-')),
                                  DataCell(Text(item['tanggalTerima'] ?? '-')),
                                  DataCell(_buildStatusChip(item['status'])),
                                  DataCell(Text(item['catatan'] ?? '-')),
                                  DataCell(
                                    IconButton(
                                      icon: Icon(Icons.edit, color: disabled ? Colors.grey : Colors.blue),
                                      onPressed: disabled ? null : () => model.toggleSidebar(index),
                                    ),
                                  ),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ======== SIDEBAR ========

                if (model.isSidebarOpen)
                  Container(
                    width: 400,
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Update Status Pengiriman", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Text("ID Pengiriman: ${model.currentSelected?['id'] ?? '-'}"),
                          const SizedBox(height: 12),

                          // === STATUS ===
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Status Pengiriman',
                              border: OutlineInputBorder(),
                            ),
                            value: model.selectedStatus,
                            items: ['Selesai', 'Retur', 'Hilang', 'Cancel'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (v) {
                              model.selectedStatus = v;
                              model.selectedJenisRetur = null;
                              model.notifyListeners();
                            },
                          ),
                          const SizedBox(height: 12),

                          // === STATUS: SELESAI ===
                          if (model.selectedStatus == 'Selesai') ...[
                            _buildDatePicker(context, "Tanggal Terima", model.tanggalTerima, model.setTanggalTerima),
                            const SizedBox(height: 12),
                            TextField(
                              controller: model.namaPenerimaController,
                              decoration: const InputDecoration(labelText: 'Nama Penerima', border: OutlineInputBorder()),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: model.catatanController,
                              decoration: const InputDecoration(labelText: 'Keterangan / Catatan', border: OutlineInputBorder()),
                              maxLines: 3,
                            ),
                          ],

                          // === STATUS: RETUR ===
                          if (model.selectedStatus == 'Retur') ...[
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(labelText: 'Jenis Retur', border: OutlineInputBorder()),
                              value: model.selectedJenisRetur,
                              items: model.jenisReturList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                              onChanged: (v) {
                                model.selectedJenisRetur = v;
                                model.notifyListeners();
                              },
                            ),
                            const SizedBox(height: 12),

                            // === RETUR: SEBAGIAN ===
                            if (model.selectedJenisRetur == 'Sebagian') ...[
                              const SizedBox(height: 12),
                              const Text("Pilih Barang Retur:"),
                              const SizedBox(height: 8),
                              ...(model.currentSelected?['barang'] ?? []).map<Widget>((brg) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        CheckboxListTile(
                                          title: Text("${brg['nama']} (${brg['jumlah']})"),
                                          value: brg['selected'] ?? false,
                                          onChanged: (val) {
                                            brg['selected'] = val;
                                            model.notifyListeners();
                                          },
                                        ),
                                        if (brg['selected'] == true) ...[
                                          TextField(
                                            decoration: const InputDecoration(labelText: 'Jumlah Retur', border: OutlineInputBorder()),
                                            keyboardType: TextInputType.number,
                                            onChanged: (v) => brg['jumlahRetur'] = int.tryParse(v) ?? 0,
                                          ),
                                          const SizedBox(height: 8),
                                          TextField(
                                            decoration: const InputDecoration(labelText: 'Keterangan', border: OutlineInputBorder()),
                                            onChanged: (v) => brg['catatan'] = v,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                            _buildDatePicker(context, "Tanggal Retur", model.tanggalRetur, model.setTanggalRetur),
                            const SizedBox(height: 12),
                            TextField(
                              controller: model.namaPenerimaController,
                              decoration: const InputDecoration(labelText: 'Nama Penerima', border: OutlineInputBorder()),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: model.catatanController,
                              decoration: const InputDecoration(labelText: 'Keterangan / Catatan', border: OutlineInputBorder()),
                              maxLines: 3,
                            ),
                          ],

                          // === STATUS: HILANG ===
                          if (model.selectedStatus == 'Hilang') ...[
                            TextField(
                              controller: model.catatanController,
                              decoration: const InputDecoration(labelText: 'Keterangan / Catatan', border: OutlineInputBorder()),
                              maxLines: 3,
                            ),
                          ],

                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.save),
                                  label: const Text("Simpan"),
                                  onPressed: model.updateStatus,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.cancel),
                                  label: const Text("Batal"),
                                  onPressed: model.cancelSidebar,
                                ),
                              ),
                            ],
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

  Widget _buildDatePicker(
    BuildContext context,
    String label,
    DateTime? value,
    Function(DateTime) onSelect,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(value == null ? '$label: -' : '$label: ${value.toString().split(' ')[0]}'),
        ),
        IconButton(
          icon: const Icon(Icons.date_range),
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 30)),
              lastDate: DateTime.now(),
            );
            if (picked != null) onSelect(picked);
          },
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Dalam Perjalanan':
        color = Colors.lightBlue;
        break;
      case 'Selesai':
        color = Colors.green;
        break;
      case 'Retur':
        color = Colors.orange;
        break;
      case 'Cancel':
        color = Colors.red;
        break;
      case 'Hilang':
        color = Colors.red;
        break;
      default:
        color = Colors.blueGrey;
    }
    return Chip(label: Text(status, style: const TextStyle(color: Colors.white)), backgroundColor: color);
  }
}
