import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'master_barcode_notifier.dart';

class MasterBarcodePage extends StatelessWidget {
  const MasterBarcodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MasterBarcodeNotifier(),
      child: Consumer<MasterBarcodeNotifier>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Master Barcode'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔍 Input cari barang
                  TextField(
                    controller: provider.searchController,
                    decoration: InputDecoration(
                      labelText: 'Cari Barang (Nama / Kode)',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => provider.cariBarang(provider.searchController.text),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 🔽 Hasil pencarian
                  if (provider.searchResults.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.searchResults.length,
                        itemBuilder: (context, index) {
                          final item = provider.searchResults[index];
                          return ListTile(
                            title: Text(item['nama']),
                            subtitle: Text(item['kode']),
                            trailing: item['barcode'] != null
                                ? const Icon(Icons.qr_code, color: Colors.green)
                                : const Icon(Icons.qr_code_2_outlined, color: Colors.grey),
                            onTap: () => provider.pilihBarang(item),
                          );
                        },
                      ),
                    ),

                  if (provider.selectedBarang != null) ...[
                    const SizedBox(height: 16),
                    Divider(color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text(
                      'Detail Barang',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),

                    Text('Kode Barang: ${provider.selectedBarang!['kode']}'),
                    Text('Nama Barang: ${provider.selectedBarang!['nama']}'),

                    const SizedBox(height: 16),

                    // 🧾 Barcode section
                    if (provider.hasData)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: provider.barcodeController,
                            decoration: const InputDecoration(
                              labelText: 'Kode Barcode',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.qr_code_scanner),
                            label: const Text('Scan Ulang'),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Konfirmasi Overwrite'),
                                  content: const Text('Barcode sudah ada. Apakah ingin mengganti dengan data baru?'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
                                    ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Ya, Ganti')),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                provider.toggleOverwrite();
                                provider.barcodeController.clear();
                              }
                            },
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          TextField(
                            controller: provider.barcodeController,
                            decoration: const InputDecoration(
                              labelText: 'Scan / Masukkan Barcode',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.qr_code_scanner),
                            label: const Text('Scan Barcode'),
                            onPressed: () {
                              // simulasi scan (untuk dummy)
                              provider.barcodeController.text = 'NEWBARCODE-${DateTime.now().millisecondsSinceEpoch}';
                              provider.notifyListeners();
                            },
                          ),
                        ],
                      ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.save),
                          label: const Text('Simpan'),
                          onPressed: provider.simpanBarcode,
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                          onPressed: provider.resetForm,
                        ),
                      ],
                    )
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
