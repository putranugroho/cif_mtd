import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pengeluaran_notifier.dart';

class PengeluaranPage extends StatelessWidget {
  const PengeluaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PengeluaranNotifier(),
      child: Consumer<PengeluaranNotifier>(
        builder: (context, notifier, _) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: const Text('Penerimaan Barang'),
              backgroundColor: Colors.blueAccent,
              elevation: 0,
            ),
            body: Row(
              children: [
                // MAIN CONTENT: TABLE
                Expanded(
                  flex: notifier.isSidebarOpen ? 2 : 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: notifier.toggleSidebar,
                          icon: const Icon(Icons.add),
                          label: const Text("Tambah Penerimaan"),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            child: DataTable(
                              border: TableBorder.all(color: Colors.grey),
                              columns: const [
                                DataColumn(label: Text('Nomor Order')),
                                DataColumn(label: Text('Tanggal Masuk')),
                                DataColumn(label: Text('Nama Barang')),
                                DataColumn(label: Text('Golongan')),
                                DataColumn(label: Text('Kelompok')),
                                DataColumn(label: Text('Jenis')),
                                DataColumn(label: Text('Kategori')),
                                DataColumn(label: Text('Jumlah')),
                              ],
                              rows: notifier.dataPenerimaan.map((data) {
                                return DataRow(cells: [
                                  DataCell(Text(data['nomorOrder'] ?? '')),
                                  DataCell(Text(data['tanggalMasuk'] ?? '')),
                                  DataCell(Text(data['namaBarang'] ?? '')),
                                  DataCell(Text(data['golongan'] ?? '')),
                                  DataCell(Text(data['kelompok'] ?? '')),
                                  DataCell(Text(data['jenis'] ?? '')),
                                  DataCell(Text(data['kategori'] ?? '')),
                                  DataCell(Text(data['jumlahBarang'] ?? '')),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // SIDEBAR FORM
                if (notifier.isSidebarOpen)
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Form Input Penerimaan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: notifier.toggleSidebar,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  _buildTextField(notifier.nomorOrderController,
                                      'Nomor Order'),
                                  _buildTextField(
                                      notifier.tanggalMasukController,
                                      'Tanggal Masuk'),
                                  _buildTextField(notifier.namaBarangController,
                                      'Nama Barang'),
                                  _buildDropdown(
                                    'Golongan Barang',
                                    notifier.selectedGolongan,
                                    notifier.golonganList,
                                    (val) {
                                      notifier.selectedGolongan = val;
                                      notifier.notifyListeners();
                                    },
                                  ),
                                  _buildDropdown(
                                    'Kelompok Barang',
                                    notifier.selectedKelompok,
                                    notifier.kelompokList,
                                    (val) {
                                      notifier.selectedKelompok = val;
                                      notifier.notifyListeners();
                                    },
                                  ),
                                  _buildDropdown(
                                    'Jenis Barang',
                                    notifier.selectedJenis,
                                    notifier.jenisList,
                                    (val) {
                                      notifier.selectedJenis = val;
                                      notifier.notifyListeners();
                                    },
                                  ),
                                  _buildDropdown(
                                    'Kategori Barang',
                                    notifier.selectedKategori,
                                    notifier.kategoriList,
                                    (val) {
                                      notifier.selectedKategori = val;
                                      notifier.notifyListeners();
                                    },
                                  ),
                                  _buildTextField(
                                      notifier.jumlahBarangController,
                                      'Jumlah Barang'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: notifier.tambahData,
                            icon: const Icon(Icons.save),
                            label: const Text("Simpan"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(45),
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

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String? selectedValue,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        value: selectedValue,
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
