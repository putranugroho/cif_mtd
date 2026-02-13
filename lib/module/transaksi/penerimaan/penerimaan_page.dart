// File: lib/pages/penerimaan_page.dart
import 'package:cif/module/transaksi/penerimaan/penerimaan_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PenerimaanPage extends StatelessWidget {
  const PenerimaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PenerimaanNotifier(),
      child: const _PenerimaanView(),
    );
  }
}

class _PenerimaanView extends StatefulWidget {
  const _PenerimaanView();

  @override
  State<_PenerimaanView> createState() => _PenerimaanViewState();
}

class _PenerimaanViewState extends State<_PenerimaanView> {
  final cariPOController = TextEditingController();

  @override
  void dispose() {
    cariPOController.dispose();
    super.dispose();
  }

  String formatDate(dynamic dt) {
    final dateFmt = DateFormat('dd-MM-yyyy');
    if (dt == null) return '-';
    if (dt is DateTime) return dateFmt.format(dt);
    try {
      return dateFmt.format(DateTime.parse(dt.toString()));
    } catch (e) {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PenerimaanNotifier>();
    final dateFmt = DateFormat('dd-MM-yyyy');

    return Scaffold(
      appBar: AppBar(title: const Text("Transaksi - Penerimaan Barang")),
      body: Stack(
        children: [
          // ========================
          // HISTORY LIST
          // ========================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    DropdownButton<String>(
                      value: model.filterStatus,
                      items: ["Semua", "Belum Diterima", "Sudah Diterima"].map((f) => DropdownMenuItem(value: f, child: Text("Filter: $f"))).toList(),
                      onChanged: (v) => model.setFilter(v!),
                    ),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: model.sortBy,
                      items: ["Nomor PO", "Tanggal PO", "Tanggal Input"].map((s) => DropdownMenuItem(value: s, child: Text("Sort: $s"))).toList(),
                      onChanged: (v) => model.setSort(v!),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () => model.resetFilter(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Reset"),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Cari Nomor Purchase Order"),
                            content: TextField(
                              controller: cariPOController,
                              decoration: const InputDecoration(
                                labelText: "Masukkan Nomor PO",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  cariPOController.clear();
                                  Navigator.pop(context);
                                },
                                child: const Text("Batal"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final query = cariPOController.text.trim().toLowerCase();
                                  final po = model.purchaseOrders.firstWhere(
                                    (x) => (x['nomorPO']?.toString().toLowerCase() ?? '') == query,
                                    orElse: () => <String, dynamic>{},
                                  );

                                  cariPOController.clear();
                                  Navigator.pop(context);

                                  if (po.isNotEmpty) {
                                    model.openSidebar(po);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Nomor PO tidak ditemukan")),
                                    );
                                  }
                                },
                                child: const Text("Cari"),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.search),
                      label: const Text("Cari PO"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.filteredPOs.length,
                    itemBuilder: (context, i) {
                      final po = model.filteredPOs[i];
                      return Card(
                        child: ListTile(
                          title: Text(po['nomorPO'] ?? '-'),
                          subtitle: Text(
                            "Tanggal PO: ${formatDate(po['tanggalPO'])}\n"
                            "Tanggal Input: ${po['tanggalDiterima'] != null ? formatDate(po['tanggalDiterima']) : '-'}\n"
                            "Status: ${po['status'] ?? '-'}",
                          ),
                          trailing: ElevatedButton(
                            onPressed: () => model.openSidebar(po),
                            child: Text(po['status'] == "Sudah Diterima" ? "Lihat Detail" : "Input Penerimaan"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ========================
          // SIDEBAR PENERIMAAN
          // ========================
          if (model.sidebarOpen)
            AnimatedPositioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.6,
              duration: const Duration(milliseconds: 300),
              child: Material(
                elevation: 10,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Input Penerimaan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => model.closeSidebar(),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                        "Nomor PO: ${model.selectedPO?['nomorPO'] ?? '-'}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tanggal PO Dibuat: ${formatDate(model.selectedPO?['tanggalPO'])}",
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Builder(builder: (context) {
                          final barangList = (model.selectedPO?['barang'] as List<dynamic>?) ?? [];
                          return ListView.builder(
                            itemCount: barangList.length,
                            itemBuilder: (context, i) {
                              final brg = barangList[i] as Map<String, dynamic>;
                              final sudahInput = (model.selectedPO?['status'] ?? '') == "Sudah Diterima";
                              return Card(
                                child: ListTile(
                                  title: Text(brg['nama'] ?? '-'),
                                  subtitle: Text(
                                    "Jumlah Beli: ${brg['jumlahBeli']}\n"
                                    "Jumlah Terima: ${brg['jumlahTerima'] ?? '-'}\n"
                                    "Status: ${brg['statusBarang'] ?? '-'}",
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      model.selectBarang(brg);
                                      sudahInput ? _showDetailBarang(context, brg, readOnly: true) : _showDetailBarang(context, brg);
                                    },
                                    child: Text(sudahInput ? "Lihat" : "Input Detail"),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: model.selectedPO?['status'] == "Sudah Diterima" ? null : model.savePenerimaan,
                            child: const Text("Save Penerimaan"),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: model.cancelPenerimaan,
                            child: const Text("Cancel"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showDetailBarang(BuildContext context, Map<String, dynamic> barang, {bool readOnly = false}) async {
    final model = context.read<PenerimaanNotifier>();
    // ensure selectedBarang is set
    model.selectBarang(barang);

    final jumlahCtrl = TextEditingController(text: barang['jumlahTerima']?.toString() ?? '');
    final rusakCtrl = TextEditingController(text: barang['rusak']?.toString() ?? '');
    final ketCtrl = TextEditingController(text: barang['keterangan'] ?? '');
    DateTime? selectedDate = barang['tanggalTerima'];
    String statusBarang = barang['statusBarang'] ?? '';
    String tindakan = barang['tindakan'] ?? '';

    int jumlahBeli = barang['jumlahBeli'] ?? 0;
    int jumlahTerima = int.tryParse(jumlahCtrl.text) ?? 0;
    int selisih = jumlahBeli - jumlahTerima;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Detail Barang - ${barang['nama'] ?? '-'}"),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jumlah Beli: $jumlahBeli", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: jumlahCtrl,
                    enabled: !readOnly,
                    decoration: const InputDecoration(
                      labelText: "Jumlah Terima",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => setState(() {
                      jumlahTerima = int.tryParse(v) ?? 0;
                      selisih = jumlahBeli - jumlahTerima;
                    }),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    enabled: false,
                    controller: TextEditingController(text: selisih.toString()),
                    decoration: const InputDecoration(
                      labelText: "Selisih Barang",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: statusBarang.isEmpty ? null : statusBarang,
                    decoration: const InputDecoration(labelText: "Status Barang"),
                    items: ['Lengkap', 'Tidak Lengkap'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: readOnly ? null : (v) => setState(() => statusBarang = v ?? ''),
                  ),
                  const SizedBox(height: 8),
                  if (statusBarang == 'Tidak Lengkap') ...[
                    TextField(
                      controller: rusakCtrl,
                      enabled: !readOnly,
                      decoration: const InputDecoration(
                        labelText: "Jumlah Rusak",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    if (selisih != 0) ...[
                      TextField(
                        controller: rusakCtrl,
                        enabled: !readOnly,
                        decoration: const InputDecoration(
                          labelText: "Jumlah Kurang",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 8),
                    ],
                    DropdownButtonFormField<String>(
                      value: tindakan.isEmpty ? null : tindakan,
                      decoration: const InputDecoration(labelText: "Tindakan"),
                      items: ['Retur Langsung', 'Akan Diretur', 'Diterima', 'Akan Dikirim']
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: readOnly ? null : (v) => setState(() => tindakan = v ?? ''),
                    ),
                  ],
                  const SizedBox(height: 8),
                  TextField(
                    controller: ketCtrl,
                    enabled: !readOnly,
                    decoration: const InputDecoration(
                      labelText: "Keterangan",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(selectedDate == null ? "Belum pilih tanggal" : "Tanggal diterima: ${DateFormat('dd-MM-yyyy').format(selectedDate!)}"),
                      const Spacer(),
                      if (!readOnly)
                        TextButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: DateTime(now.year - 1),
                              lastDate: now,
                            );
                            if (picked != null) {
                              setState(() => selectedDate = picked);
                            }
                          },
                          child: const Text("Pilih Tanggal"),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup")),
          if (!readOnly)
            ElevatedButton(
              onPressed: () {
                model.updateBarang(
                  jumlahTerima: int.tryParse(jumlahCtrl.text) ?? 0,
                  statusBarang: statusBarang,
                  rusak: int.tryParse(rusakCtrl.text) ?? 0,
                  tindakan: tindakan,
                  keterangan: ketCtrl.text,
                  tanggalTerima: selectedDate ?? DateTime.now(),
                );
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
        ],
      ),
    );

    // dispose controllers created inside this function
    jumlahCtrl.dispose();
    rusakCtrl.dispose();
    ketCtrl.dispose();
  }
}
