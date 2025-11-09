import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'master_mover_notifier.dart';

class MasterMoverPage extends StatelessWidget {
  const MasterMoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MasterMoverNotifier(),
      child: Consumer<MasterMoverNotifier>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Master Mover / Kurir')),
            body: Row(
              children: [
                // ====== DATA TABEL ======
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
                          label: const Text("Tambah Mover / Kurir"),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Kode Kurir')),
                                DataColumn(label: Text('Nama Kurir')),
                                DataColumn(label: Text('No. Telepon')),
                                DataColumn(label: Text('Email')),
                                DataColumn(label: Text('No. Kendaraan')),
                                DataColumn(label: Text('Jenis Kendaraan')),
                                DataColumn(label: Text('Alamat / Rute')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('Tanggal Terdaftar')),
                                DataColumn(label: Text('Keterangan')),
                              ],
                              rows: provider.data.map((item) {
                                return DataRow(cells: [
                                  DataCell(Text(item['kodeKurir'] ?? '')),
                                  DataCell(Text(item['nama'] ?? '')),
                                  DataCell(Text(item['telp'] ?? '')),
                                  DataCell(Text(item['email'] ?? '')),
                                  DataCell(Text(item['noKendaraan'] ?? '')),
                                  DataCell(Text(item['jenisKendaraan'] ?? '')),
                                  DataCell(Text(item['alamat'] ?? '')),
                                  DataCell(Text(item['status'] ?? '')),
                                  DataCell(Text(item['tglDaftar'] ?? '')),
                                  DataCell(Text(item['keterangan'] ?? '')),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ====== SIDEBAR FORM TAMBAH DATA ======
                if (provider.isSidebarOpen)
                  Container(
                    width: 380,
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tambah Mover / Kurir',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.namaController,
                            decoration: const InputDecoration(
                              labelText: 'Kode Kurir / Ekspedisi',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.namaController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Kurir / Ekspedisi',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.telpController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Nomor Telepon',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email (opsional)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: provider.selectedJenisMovers,
                            decoration: const InputDecoration(
                              labelText: 'Jenis Movers',
                              border: OutlineInputBorder(),
                            ),
                            items: provider.jenisMoversList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (val) {
                              provider.selectedJenisMovers = val;
                              provider.notifyListeners();
                            },
                          ),
                          const SizedBox(height: 16),
                          provider.selectedJenisMovers == 'Internal'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    TextField(
                                      controller: provider.noKendaraanController,
                                      decoration: const InputDecoration(
                                        labelText: 'Nomor Kendaraan',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    DropdownButtonFormField<String>(
                                      value: provider.selectedJenisKendaraan,
                                      decoration: const InputDecoration(
                                        labelText: 'Jenis Kendaraan',
                                        border: OutlineInputBorder(),
                                      ),
                                      items: provider.jenisKendaraanList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                      onChanged: (val) {
                                        provider.selectedJenisKendaraan = val;
                                        provider.notifyListeners();
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                )
                              : provider.selectedJenisMovers == 'External'
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        TextField(
                                          controller: provider.alamatController,
                                          decoration: const InputDecoration(
                                            labelText: 'Alamat / Rute Wilayah',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    )
                                  : const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: provider.selectedStatus,
                            decoration: const InputDecoration(
                              labelText: 'Status',
                              border: OutlineInputBorder(),
                            ),
                            items: provider.statusList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (val) {
                              provider.selectedStatus = val;
                              provider.notifyListeners();
                            },
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: provider.keteranganController,
                            decoration: const InputDecoration(
                              labelText: 'Keterangan Tambahan',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: provider.tambahData,
                              icon: const Icon(Icons.save),
                              label: const Text('Simpan Data'),
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
