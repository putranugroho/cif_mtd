import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'status_pengiriman_notifier.dart';

class StatusPengirimanPage extends StatelessWidget {
  const StatusPengirimanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StatusPengirimanNotifier(),
      child: Consumer<StatusPengirimanNotifier>(
        builder: (context, provider, _) {
          return Row(
            children: [
              // ===================== TABEL DATA =====================
              Expanded(
                flex: provider.showForm ? 3 : 4,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: const Text("Master Status Pengiriman"),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ElevatedButton.icon(
                          onPressed: provider.toggleForm,
                          icon: const Icon(Icons.add),
                          label: const Text("Tambah Status"),
                        ),
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('NAMA STATUS')),
                          DataColumn(label: Text('KETERANGAN')),
                          DataColumn(label: Text('WARNA LABEL')),
                          DataColumn(label: Text('STATUS')),
                        ],
                        rows: provider.dataList.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item['id'].toString())),
                              DataCell(Text(item['namaStatus'] ?? '-')),
                              DataCell(Text(item['keterangan'] ?? '-')),
                              DataCell(Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: _parseColor(item['warna']),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(item['warna']),
                                ],
                              )),
                              DataCell(Text(item['status'] ?? '-')),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),

              // ===================== SIDEBAR FORM =====================
              if (provider.showForm)
                Container(
                  width: 350,
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tambah Status Pengiriman",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: provider.namaStatusController,
                        decoration: const InputDecoration(
                          labelText: "Nama Status",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: provider.warnaController,
                        decoration: const InputDecoration(
                          labelText: "Warna Label (contoh: #2196F3)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: provider.keteranganController,
                        decoration: const InputDecoration(
                          labelText: "Keterangan",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Status",
                          border: OutlineInputBorder(),
                        ),
                        value: provider.selectedStatus,
                        items: const [
                          DropdownMenuItem(value: "Aktif", child: Text("Aktif")),
                          DropdownMenuItem(value: "Tidak Aktif", child: Text("Tidak Aktif")),
                        ],
                        onChanged: (val) {
                          provider.selectedStatus = val;
                        },
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: provider.toggleForm,
                            child: const Text("Batal"),
                          ),
                          ElevatedButton(
                            onPressed: provider.addData,
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

  // Helper untuk parsing warna hex
  Color _parseColor(String? hexColor) {
    try {
      if (hexColor == null) return Colors.grey;
      hexColor = hexColor.replaceAll("#", "");
      if (hexColor.length == 6) hexColor = "FF$hexColor";
      return Color(int.parse("0x$hexColor"));
    } catch (e) {
      return Colors.grey;
    }
  }
}
