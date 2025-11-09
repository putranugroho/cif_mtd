import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'koreksi_barang_notifier.dart';

class KoreksiBarangPage extends StatelessWidget {
  const KoreksiBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KoreksiBarangNotifier(),
      child: Consumer<KoreksiBarangNotifier>(
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Transaksi Koreksi Barang')),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === CARI BARANG ===
                  Autocomplete<Map<String, dynamic>>(
                    displayStringForOption: (item) => "${item['kode']} - ${item['nama']}",
                    optionsBuilder: (text) {
                      if (text.text.isEmpty) return const Iterable.empty();
                      return model.masterBarang.where((e) =>
                          e['nama'].toLowerCase().contains(text.text.toLowerCase()) || e['kode'].toLowerCase().contains(text.text.toLowerCase()));
                    },
                    onSelected: model.pilihBarang,
                    fieldViewBuilder: (context, controller, focus, onSubmit) {
                      return TextField(
                        controller: controller,
                        focusNode: focus,
                        decoration: const InputDecoration(
                          labelText: 'Cari Barang (kode/nama)',
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  if (model.sudahPilihBarang) ...[
                    _buildInfoBarang(model.selectedBarang!),
                    const Divider(),

                    // === INPUT DASAR ===
                    Row(
                      children: [
                        Expanded(
                          child: Text(model.tanggalReferensi == null
                              ? 'Tanggal Referensi: -'
                              : 'Tanggal Referensi: ${model.tanggalReferensi!.toString().split(" ")[0]}'),
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
                            if (picked != null) model.setTanggalReferensi(picked);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Nomor Referensi',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => model.nomorReferensi = v,
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: Text(model.tanggalKoreksi == null
                              ? 'Tanggal Koreksi: -'
                              : 'Tanggal Koreksi: ${model.tanggalKoreksi!.toString().split(" ")[0]}'),
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
                            if (picked != null) model.setTanggalKoreksi(picked);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Jenis Koreksi',
                        border: OutlineInputBorder(),
                      ),
                      value: model.jenisKoreksi,
                      items: const [
                        DropdownMenuItem(value: 'Ganti Kode Barang', child: Text('Ganti Kode Barang')),
                        DropdownMenuItem(value: 'Stock Opname', child: Text('Stock Opname')),
                      ],
                      onChanged: model.setJenisKoreksi,
                    ),
                    const SizedBox(height: 20),

                    // === FORM GANTI KODE BARANG ===
                    if (model.showGantiKodeForm) ...[
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Nomor Purchase Order (PO)',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (v) => model.nomorPO = v,
                      ),
                      const SizedBox(height: 10),

                      const Text("Barang dari PO (contoh dummy):"),
                      const ListTile(
                        title: Text("Beras 5kg"),
                        subtitle: Text("Qty: 10"),
                      ),
                      const Divider(),

                      // === CARI BARANG BARU ===
                      const Text("Pilih Barang Baru"),
                      const SizedBox(height: 5),
                      Autocomplete<Map<String, dynamic>>(
                        displayStringForOption: (item) => "${item['kode']} - ${item['nama']}",
                        optionsBuilder: (text) {
                          if (text.text.isEmpty) return const Iterable.empty();
                          return model.masterBarang.where((e) =>
                              e['nama'].toLowerCase().contains(text.text.toLowerCase()) || e['kode'].toLowerCase().contains(text.text.toLowerCase()));
                        },
                        onSelected: model.pilihBarangBaru,
                        fieldViewBuilder: (context, controller, focus, onSubmit) {
                          return TextField(
                            controller: controller,
                            focusNode: focus,
                            decoration: const InputDecoration(
                              labelText: 'Cari Barang Baru',
                              border: OutlineInputBorder(),
                            ),
                          );
                        },
                      ),
                      if (model.barangBaru != null) _buildInfoBarang(model.barangBaru!),
                      const SizedBox(height: 10),
                      const Text("Status Barang: Koreksi", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],

                    // === FORM STOCK OPNAME ===
                    if (model.showStockOpnameForm) ...[
                      Text("Jumlah Stok: ${model.selectedBarang!['stok']}"),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Jenis Stock Opname',
                          border: OutlineInputBorder(),
                        ),
                        value: model.jenisStockOpname,
                        items: const [
                          DropdownMenuItem(value: 'Tambah', child: Text('Tambah')),
                          DropdownMenuItem(value: 'Kurang', child: Text('Kurang')),
                        ],
                        onChanged: (v) => {model.jenisStockOpname = v, model.notifyListeners()},
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Jumlah Koreksi',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (v) => model.jumlahKoreksi = int.tryParse(v),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Status Barang',
                          border: OutlineInputBorder(),
                        ),
                        value: model.statusBarang,
                        items: const [
                          DropdownMenuItem(value: 'Expired', child: Text('Expired')),
                          DropdownMenuItem(value: 'Rusak', child: Text('Rusak')),
                          DropdownMenuItem(value: 'Hilang', child: Text('Hilang')),
                          DropdownMenuItem(value: 'Lain-lain', child: Text('Lain-lain')),
                        ],
                        onChanged: (v) => {model.statusBarang = v, model.notifyListeners()},
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Keterangan',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        onChanged: (v) => model.keterangan = v,
                      ),
                    ],

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.save),
                            label: const Text("Simpan"),
                            onPressed: () => model.simpan(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.cancel),
                            label: const Text("Batal"),
                            onPressed: model.reset,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBarang(Map<String, dynamic> barang) {
    return Card(
      color: Colors.grey[100],
      child: ListTile(
        title: Text("${barang['kode']} - ${barang['nama']}"),
        subtitle: Text("Stok: ${barang['stok']} | Status: ${barang['status']}"),
      ),
    );
  }
}
