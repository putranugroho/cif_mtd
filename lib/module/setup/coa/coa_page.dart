import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/coa/coa_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';

class CoaPage extends StatelessWidget {
  const CoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoaNotifier(context: context),
      child: Consumer<CoaNotifier>(
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
                        "Chart of Account",
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
                        "Tambah COA",
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
                          columnName: 'gol_acc',
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('Gol. Akun',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 12,
                                  )))),
                      GridColumn(
                          columnName: 'jns_acc',
                          label: Container(
                              color: colorPrimary,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(6),
                              child: Text('Jenis Akun',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'nobb',
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('No. Buku Besar',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'nosbb',
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('ANo. Sub Buku Besar',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'nama_sbb',
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('Nama SBB',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'type_posting',
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('Type Posting',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'sbb_khusus',
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('SBB Khusus',
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
  DetailDataSource(CoaNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  CoaNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<CoaModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(
                    columnName: 'gol_acc',
                    value: data.golAcc == "1"
                        ? "Aktiva"
                        : data.golAcc == "2"
                            ? "Pasiva"
                            : data.golAcc == "3"
                                ? "Pendapatan"
                                : "Biaya"),
                DataGridCell(
                    columnName: 'jns_acc',
                    value: data.jnsAcc == 'A'
                        ? "Header"
                        : data.jnsAcc == 'B'
                            ? "Buku Besar"
                            : "Sub Buku Besar"),
                DataGridCell(columnName: 'nobb', value: data.nobb),
                DataGridCell(columnName: 'nosbb', value: data.nosbb),
                DataGridCell(columnName: 'nama_sbb', value: data.namaSbb),
                DataGridCell(
                    columnName: 'type_posting', value: data.typePosting),
                DataGridCell(columnName: 'sbb_khusus', value: data.sbbKhusus),
                DataGridCell(columnName: 'action', value: data.nosbb),
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
