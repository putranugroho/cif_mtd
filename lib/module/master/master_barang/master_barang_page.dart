import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'master_barang_notifier.dart';

class MasterBarangPage extends StatelessWidget {
  const MasterBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MasterBarangNotifier(),
      child: Consumer<MasterBarangNotifier>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Master Barang')),
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
                          label: const Text("Tambah Barang"),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Kode')),
                                DataColumn(label: Text('Nama')),
                                DataColumn(label: Text('Golongan')),
                                DataColumn(label: Text('Kelompok')),
                                DataColumn(label: Text('Jenis')),
                                DataColumn(label: Text('Kategori')),
                                DataColumn(label: Text('Satuan')),
                                DataColumn(label: Text('Stok Min')),
                                DataColumn(label: Text('Harga Beli')),
                                DataColumn(label: Text('Harga Jual')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('Barcode')), // ✅ Tambahan kolom
                              ],
                              rows: provider.data.map((item) {
                                return DataRow(cells: [
                                  DataCell(Text(item['id'].toString())),
                                  DataCell(Text(item['kode'])),
                                  DataCell(Text(item['nama'])),
                                  DataCell(Text(item['golongan'])),
                                  DataCell(Text(item['kelompok'])),
                                  DataCell(Text(item['jenis'])),
                                  DataCell(Text(item['kategori'])),
                                  DataCell(Text(item['satuan'])),
                                  DataCell(Text(item['stokMin'].toString())),
                                  DataCell(Text(item['hargaBeli'].toString())),
                                  DataCell(Text(item['hargaJual'].toString())),
                                  DataCell(Text(item['status'])),
                                  DataCell(Row(
                                    children: [
                                      Icon(
                                        item['barcode'] != null ? Icons.qr_code_2 : Icons.qr_code_2_outlined,
                                        color: item['barcode'] != null ? Colors.green : Colors.grey,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(item['barcode'] != null ? 'Ada Barcode' : 'Belum Ada'),
                                    ],
                                  )),
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
                          const Text('Tambah Barang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.kodeController,
                            decoration: const InputDecoration(
                              labelText: 'Kode Barang',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.namaController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Barang',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: provider.selectedGolongan,
                            decoration: const InputDecoration(
                              labelText: 'Golongan Barang',
                              border: OutlineInputBorder(),
                            ),
                            items: provider.golonganList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (val) {
                              provider.selectedGolongan = val;
                              provider.notifyListeners();
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: provider.selectedKelompok,
                            decoration: const InputDecoration(
                              labelText: 'Kelompok Barang',
                              border: OutlineInputBorder(),
                            ),
                            items: provider.kelompokList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (val) {
                              provider.selectedKelompok = val;
                              provider.notifyListeners();
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: provider.selectedJenis,
                            decoration: const InputDecoration(
                              labelText: 'Jenis Barang',
                              border: OutlineInputBorder(),
                            ),
                            items: provider.jenisList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (val) {
                              provider.selectedJenis = val;
                              provider.notifyListeners();
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: provider.selectedKategori,
                            decoration: const InputDecoration(
                              labelText: 'Kategori Barang',
                              border: OutlineInputBorder(),
                            ),
                            items: provider.kategoriList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (val) {
                              provider.selectedKategori = val;
                              provider.notifyListeners();
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: provider.selectedSatuan,
                            decoration: const InputDecoration(
                              labelText: 'Satuan',
                              border: OutlineInputBorder(),
                            ),
                            items: provider.satuanList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (val) {
                              provider.selectedSatuan = val;
                              provider.notifyListeners();
                            },
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.stokMinController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Stok Minimum',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.hargaBeliController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Harga Beli',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.hargaJualController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Harga Jual',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: provider.selectedStatus,
                            decoration: const InputDecoration(
                              labelText: 'Status Barang',
                              border: OutlineInputBorder(),
                            ),
                            items: provider.statusList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (val) {
                              provider.selectedStatus = val;
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
