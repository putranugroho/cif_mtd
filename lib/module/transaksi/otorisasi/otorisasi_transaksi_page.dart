import 'package:accounting/models/index.dart';

import 'package:accounting/module/transaksi/otorisasi/otorisasi_transaksi_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';
import '../../../utils/format_currency.dart';

class OtorisasiTransaksiPage extends StatelessWidget {
  const OtorisasiTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtorisasiTransaksiNotifier(context: context),
      child: Consumer<OtorisasiTransaksiNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Transaksi Otorisasi",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height,
                        child: SfDataGrid(
                          headerRowHeight: 40,
                          defaultColumnWidth: 180,
                          frozenColumnsCount: 2,

                          // controller: value.dataGridController,
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                          selectionMode: SelectionMode.single,

                          source: DetailDataSource(value),
                          columns: <GridColumn>[
                            GridColumn(
                                width: 80,
                                columnName: 'aksi',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Aksi',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 100,
                                columnName: 'status',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Status',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                width: 100,
                                columnName: 'tgl_val',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Tanggal Valuta',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                width: 100,
                                columnName: 'tgl_trans',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Tanggal Input',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                width: 120,
                                columnName: 'nomor_dok',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nomor Dokumen',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 120,
                                columnName: 'nomor_ref',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nomor Referensi',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 150,
                                columnName: 'modul',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Modul',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 200,
                                columnName: 'keterangan_otor',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Keterangan Otorisasi',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 150,
                                columnName: 'nominal',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nominal',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 200,
                                columnName: 'nama_debet',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nama Akun Debet',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 200,
                                columnName: 'nama_credit',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nama Akun Kredit',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 200,
                                columnName: 'keterangan',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Keterangan',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 120,
                                columnName: 'debet_acc',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Akun Debet',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 120,
                                columnName: 'credit_acc',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Akun Kredit',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: value.dialog
                    ? Container(
                        color: Colors.black.withOpacity(0.5),
                      )
                    : const SizedBox(),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: value.dialog
                    ? Container(
                        width: 600,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Otorisasi Detail",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => value.close(),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
                                    child: const Icon(Icons.close),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Expanded(
                                child: ListView(
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "Tanggal",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(value.transaksiPendModel!.inputtgljam),
                                const SizedBox(height: 16),
                                const Row(
                                  children: [
                                    Text(
                                      "Modul",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(value.transaksiPendModel!.modul),
                                const SizedBox(height: 16),
                                const Row(
                                  children: [
                                    Text(
                                      "User",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(value.transaksiPendModel!.userinput),
                                const SizedBox(height: 16),
                                const Row(
                                  children: [
                                    Text(
                                      "Otorisasi",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(value.transaksiPendModel!.keteranganOtor),
                                const SizedBox(height: 16),
                                value.transaksiPendModel!.keteranganOtor.contains("Pembatalan")
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          const Row(
                                            children: [
                                              Text(
                                                "Alasan Pembatalan",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(value.transaksiPendModel!.alasan),
                                          const SizedBox(height: 16),
                                        ],
                                      )
                                    : const SizedBox(),
                                const Row(
                                  children: [
                                    Text(
                                      "Data",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Nomor Dokumen : ${value.transaksiPendModel!.noDokumen}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Nomor Referensi : ${value.transaksiPendModel!.noRef}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Nominal : ${FormatCurrency.oCcyDecimal.format(double.parse(value.transaksiPendModel!.nominal))}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Keterangan : ${value.transaksiPendModel!.keterangan}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    ButtonPrimary(
                                      onTap: () {
                                        value.confirm();
                                      },
                                      name: "Setujui",
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    ButtonPrimary(
                                      onTap: () {},
                                      name: "Tolak",
                                    ),
                                  ],
                                )
                              ],
                            ))
                          ],
                        ),
                      )
                    : const SizedBox(),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(OtorisasiTransaksiNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listTransasiAdd);
  }

  OtorisasiTransaksiNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<TransaksiPendModel> list) {
    int index = 1;

    // 🔽 Sort data terlebih dahulu
    list.sort((a, b) {
      final tglA = DateTime.tryParse(a.tglValuta) ?? DateTime(1900);
      final tglB = DateTime.tryParse(b.tglValuta) ?? DateTime(1900);

      if (tglA.compareTo(tglB) != 0) {
        return tglA.compareTo(tglB); // urut berdasarkan tanggal dulu
      }

      return a.noDokumen.compareTo(b.noDokumen); // lalu urut berdasarkan nomor dokumen
    });

    // 🧱 Bangun data grid setelah data diurutkan
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'aksi', value: data.rrn),
                DataGridCell(columnName: 'status', value: data.status),
                DataGridCell(columnName: 'tgl_val', value: data.tglValuta),
                DataGridCell(columnName: 'tgl_trans', value: data.tglTransaksi),
                DataGridCell(columnName: 'nomor_dok', value: data.noDokumen),
                DataGridCell(columnName: 'nomor_ref', value: data.noRef),
                DataGridCell(columnName: 'modul', value: data.modul),
                DataGridCell(columnName: 'keterangan_otor', value: data.keteranganOtor),
                DataGridCell(columnName: 'nominal', value: FormatCurrency.oCcyDecimal.format(double.parse(data.nominal))),
                DataGridCell(columnName: 'nama_debet', value: data.namaDr),
                DataGridCell(columnName: 'nama_credit', value: data.namaCr),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
                DataGridCell(columnName: 'debet_acc', value: data.dracc),
                DataGridCell(columnName: 'credit_acc', value: data.cracc),
              ],
            ))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'nominal') {
          return Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        } else if (e.columnName == 'aksi') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                tindakanNotifier!.edit(e.value);
              },
              child: Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorPrimary,
                  border: Border.all(
                    width: 2,
                    color: colorPrimary,
                  ),
                ),
                child: const Text(
                  "Aksi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        } else if (e.columnName == 'status') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: e.value == "PENDING"
                      ? Colors.orange
                      : e.value == "CANCEL"
                          ? Colors.red
                          : Colors.green),
              child: Text(
                e.value,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
      }).toList(),
    );
  }

  String formatStringData(String data) {
    int numericData = int.tryParse(data) ?? 0;
    final formatter = NumberFormat("#,###");
    return formatter.format(numericData);
  }
}
