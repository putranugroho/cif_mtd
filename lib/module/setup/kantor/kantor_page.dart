import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/kantor/kantor_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';

class KantorPage extends StatelessWidget {
  const KantorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KantorNotifier(context: context),
      child: Consumer<KantorNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Kantor",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colorPrimary,
                        border: Border.all(
                          width: 2,
                          color: colorPrimary,
                        ),
                      ),
                      child: Text(
                        "Tambah Kantor",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  child: SfDataGrid(
                    headerRowHeight: 40,
                    defaultColumnWidth: 180,
                    frozenColumnsCount: 1,

                    // controller: value.dataGridController,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    selectionMode: SelectionMode.single,

                    source: DetailDataSource(value),
                    columns: <GridColumn>[
                      GridColumn(
                          width: 50,
                          columnName: 'no',
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('No',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'kode_induk',
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('Kode Induk',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 12,
                                  )))),
                      GridColumn(
                          columnName: 'kode_kantor',
                          label: Container(
                              color: colorPrimary,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(6),
                              child: Text('Kode Kantor',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'nama_kantor',
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('Nama Kantor',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'alamat',
                          width: 300,
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('Alamat',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'status_kantor',
                          label: Container(
                              color: colorPrimary,
                              padding: EdgeInsets.all(6),
                              alignment: Alignment.center,
                              child: Text('Status Kantor',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'action',
                          label: Container(
                              color: colorPrimary,
                              padding: EdgeInsets.all(6),
                              alignment: Alignment.center,
                              child: Text('Action',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(KantorNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  KantorNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<KantorModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'kode_induk', value: data.kodeInduk),
                DataGridCell(columnName: 'kode_kantor', value: data.kodeKantor),
                DataGridCell(columnName: 'nama_kantor', value: data.namaKantor),
                DataGridCell(columnName: 'alamat', value: data.alamat),
                DataGridCell(
                    columnName: 'status_kantor',
                    value: data.statusKantor == "P"
                        ? "Pusat"
                        : data.statusKantor == "C"
                            ? "Cabang"
                            : data.statusKantor == "D"
                                ? "Anak Cabang"
                                : "Gudang"),
                DataGridCell(columnName: 'action', value: data.kodeKantor),
              ],
            ))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'action') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: colorPrimary,
                border: Border.all(
                  width: 2,
                  color: colorPrimary,
                ),
              ),
              child: Text(
                "Aksi",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
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
