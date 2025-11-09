import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pengeluaran_notifier.dart';
import 'package:intl/intl.dart';

class PengeluaranPage extends StatelessWidget {
  const PengeluaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PengeluaranNotifier(),
      child: const _PengeluaranView(),
    );
  }
}

class _PengeluaranView extends StatefulWidget {
  const _PengeluaranView();

  @override
  State<_PengeluaranView> createState() => _PengeluaranViewState();
}

class _PengeluaranViewState extends State<_PengeluaranView> {
  final dateFmt = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengeluaranNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Transaksi - Pengeluaran Barang')),
      body: Stack(
        children: [
          // ======= LEFT: Order List =======
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // === Filter, Sort, Reset, Search ===
                Row(
                  children: [
                    DropdownButton<String>(
                      value: model.filterStatus,
                      items: ['Semua', 'Belum Dikirim', 'Sudah Dikirim']
                          .map((v) => DropdownMenuItem(
                                value: v,
                                child: Text('Status: $v'),
                              ))
                          .toList(),
                      onChanged: (v) => model.setFilter(v!),
                    ),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: model.sortBy,
                      items: ['Nomor Order', 'Tanggal Order']
                          .map((v) => DropdownMenuItem(
                                value: v,
                                child: Text('Sort: $v'),
                              ))
                          .toList(),
                      onChanged: (v) => model.setSort(v!),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: model.resetFilter,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                    const Spacer(),
                    // Tombol cari nomor order
                    ElevatedButton.icon(
                      onPressed: () async {
                        final searchCtrl = TextEditingController();
                        await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Cari Nomor Order'),
                            content: TextField(
                              controller: searchCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Masukkan Nomor Order',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                              ElevatedButton(
                                onPressed: () {
                                  final ok = model.searchOrder(searchCtrl.text.trim());
                                  Navigator.pop(context);
                                  if (!ok) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Order tidak ditemukan')),
                                    );
                                  }
                                },
                                child: const Text('Cari'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('Cari No Order'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // === List Order ===
                Expanded(
                  child: ListView.builder(
                    itemCount: model.filteredOrders.length,
                    itemBuilder: (context, i) {
                      final o = model.filteredOrders[i];
                      return Card(
                        child: ListTile(
                          title: Text(o['orderNo']),
                          subtitle: Text(
                            'Tanggal Order: ${dateFmt.format(o['tanggalOrder'])}\n'
                            'Tujuan: ${o['tujuan']}\nStatus: ${o['status']}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () => model.openSidebarForOrder(o['orderNo']),
                                child: const Text('Detail'),
                              ),
                              const SizedBox(width: 8),
                              if (model.canShowUpdateResiButton(o))
                                IconButton(
                                  tooltip: 'Update Resi',
                                  onPressed: () {
                                    model.openSidebarForOrder(o['orderNo']);
                                    Future.delayed(const Duration(milliseconds: 200), () {
                                      _showUpdateResiDialog(context, o);
                                    });
                                  },
                                  icon: const Icon(Icons.receipt_long),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ======= RIGHT: Sidebar =======
          if (model.sidebarOpen)
            AnimatedPositioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.58,
              duration: const Duration(milliseconds: 250),
              child: Material(
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: model.suratJalanOpen ? _buildSuratJalanForm(context, model) : _buildOrderDetail(context, model),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // =====================================================
  // 1️⃣ FORM DETAIL ORDER (barang yang akan dikirim)
  // =====================================================
  Widget _buildOrderDetail(BuildContext context, PengeluaranNotifier model) {
    final order = model.selectedOrder!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Order: ${order['orderNo']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(onPressed: model.closeSidebar, icon: const Icon(Icons.close)),
          ],
        ),
        Text('Tanggal Order: ${DateFormat('dd-MM-yyyy').format(order['tanggalOrder'])}'),
        Text('Tujuan: ${order['tujuan']}'),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: order['items'].length,
            itemBuilder: (context, idx) {
              final it = order['items'][idx];
              final readOnly = order['status'] != 'Belum Dikirim';
              return Card(
                child: ListTile(
                  title: Text('${it['kode']} - ${it['nama']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jumlah Pesan: ${it['jumlahOrder']}'),
                      const SizedBox(height: 6),
                      if (!readOnly)
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: TextFormField(
                                initialValue: it['jumlahKirim'].toString(),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Jumlah Kirim',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (v) {
                                  model.updateItemAt(idx, jumlahKirim: int.tryParse(v) ?? 0, keterangan: it['keterangan']);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                initialValue: it['keterangan'] ?? '',
                                decoration: const InputDecoration(
                                  labelText: 'Keterangan',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (v) {
                                  model.updateItemAt(idx, jumlahKirim: it['jumlahKirim'], keterangan: v);
                                },
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jumlah Kirim: ${it['jumlahKirim']}'),
                            Text('Keterangan: ${it['keterangan'] ?? '-'}'),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: model.canProceedToSuratJalan() ? model.openSuratJalanForm : null,
              child: const Text('Next (Surat Jalan)'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: model.closeSidebar,
              child: const Text('Cancel'),
            ),
            const Spacer(),
            if (order['suratJalan'] != null)
              ElevatedButton.icon(
                onPressed: () => _showPreviewSuratJalan(context, order),
                icon: const Icon(Icons.print),
                label: const Text('Print Preview'),
              ),
          ],
        ),
      ],
    );
  }

  // =====================================================
  // 2️⃣ FORM SURAT JALAN
  // =====================================================
  Widget _buildSuratJalanForm(BuildContext context, PengeluaranNotifier model) {
    final order = model.selectedOrder!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Form Surat Jalan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(onPressed: model.closeSidebar, icon: const Icon(Icons.close)),
          ],
        ),
        const Divider(),
        Text('No Order: ${order['orderNo']}'),
        Text('Tanggal Order: ${DateFormat('dd-MM-yyyy').format(order['tanggalOrder'])}'),
        const SizedBox(height: 8),
        const Text('Tanggal Barang Keluar:'),
        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: DateTime(now.year - 1),
                  lastDate: now,
                );
                if (picked != null) model.setTanggalKirim(picked);
              },
              child: const Text('Pilih Tanggal'),
            ),
            const SizedBox(width: 8),
            Text(model.tanggalKirim != null ? DateFormat('dd-MM-yyyy').format(model.tanggalKirim!) : '-'),
          ],
        ),
        const SizedBox(height: 12),

        // === Mover Type ===
        DropdownButton<String>(
          value: model.selectedMoverType,
          items: ['External', 'Internal'].map((v) => DropdownMenuItem(value: v, child: Text('Movers: $v'))).toList(),
          onChanged: (v) => model.setMoverType(v!),
        ),
        const SizedBox(height: 8),

        if (model.selectedMoverType == 'External') ...[
          DropdownButton<String>(
            value: model.selectedExternalMover,
            hint: const Text('Pilih Jasa Pengiriman'),
            items: model.externalMovers.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (v) => model.setExternalMover(v!),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Surat jalan'),
            onChanged: model.setNoResi,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'No Resi'),
            onChanged: model.setNoResi,
          ),
          const SizedBox(height: 8),
          const Text('Estimasi Pengiriman:'),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(now.year - 1),
                    lastDate: now,
                  );
                  if (picked != null) model.setEstimasi(picked);
                },
                child: const Text('Pilih Tanggal'),
              ),
              const SizedBox(width: 8),
              Text(model.estimasi != null ? DateFormat('dd-MM-yyyy').format(model.estimasi!) : '-'),
            ],
          ),
        ] else ...[
          DropdownButton<String>(
            value: model.selectedInternalMover,
            hint: const Text('Pilih Kurir Internal'),
            items: model.internalMovers
                .map((v) => DropdownMenuItem(
                      value: v['nama'],
                      child: Text('${v['nama']} - ${v['kendaraan']}'),
                    ))
                .toList(),
            onChanged: (v) {
              final m = model.internalMovers.firstWhere((e) => e['nama'] == v);
              model.setInternalMover(m['nama']!, m['kendaraan']!);
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Surat jalan'),
            onChanged: model.setNoResi,
          ),
          const SizedBox(height: 8),
          const Text('Estimasi Pengiriman:'),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(now.year - 1),
                    lastDate: now,
                  );
                  if (picked != null) model.setEstimasi(picked);
                },
                child: const Text('Pilih Tanggal'),
              ),
              const SizedBox(width: 8),
              Text(model.estimasi != null ? DateFormat('dd-MM-yyyy').format(model.estimasi!) : '-'),
            ],
          ),
        ],
        const Spacer(),
        Row(
          children: [
            ElevatedButton(
              onPressed: model.saveSuratJalan,
              child: const Text('Save'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () => model.suratJalanOpen = false,
              child: const Text('Cancel'),
            ),
          ],
        )
      ],
    );
  }

  // =====================================================
  // 🔹 Update Resi Dialog
  // =====================================================
  static void _showUpdateResiDialog(BuildContext context, Map<String, dynamic> order) {
    final notifier = Provider.of<PengeluaranNotifier>(context, listen: false);
    final noResiCtrl = TextEditingController(text: order['suratJalan']?['noResi'] ?? '');
    final etaCtrl = TextEditingController(text: order['suratJalan']?['estimasi'] ?? '');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Update No Resi & Estimasi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Order: ${order['orderNo']}'),
            const SizedBox(height: 8),
            TextFormField(controller: noResiCtrl, decoration: const InputDecoration(labelText: 'No Resi')),
            const SizedBox(height: 8),
            TextFormField(controller: etaCtrl, decoration: const InputDecoration(labelText: 'Estimasi')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              notifier.updateResiForOrder(noResiCtrl.text, etaCtrl.text);
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // 🔹 Preview Surat Jalan (A4)
  // =====================================================
  static void _showPreviewSuratJalan(BuildContext context, Map<String, dynamic> order) {
    final sj = order['suratJalan'] ?? {};
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          width: 800,
          height: 1100,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SURAT JALAN', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 12),
                Text('No Order: ${order['orderNo']}'),
                Text('Tanggal Order: ${DateFormat('dd-MM-yyyy').format(order['tanggalOrder'])}'),
                Text('Tanggal Kirim: ${sj['tanggalKirim'] != null ? DateFormat('dd-MM-yyyy').format(sj['tanggalKirim']) : '-'}'),
                Text('Tujuan: ${order['tujuan']}'),
                const Divider(),
                const Text('Daftar Barang:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Expanded(
                  child: ListView(
                    children: (order['items'] as List).map((it) => Text('${it['kode']} - ${it['nama']} - Qty: ${it['jumlahKirim']}')).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Mover: ${sj['moverType'] ?? '-'}'),
                Text('No Resi: ${sj['noResi'] ?? '-'}'),
                Text('Estimasi: ${sj['estimasi'] ?? '-'}'),
                const Spacer(),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Simulasi print')));
                      },
                      icon: const Icon(Icons.print),
                      label: const Text('Print'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Simulasi kirim email')));
                      },
                      icon: const Icon(Icons.email),
                      label: const Text('Kirim Email'),
                    ),
                    const Spacer(),
                    OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
