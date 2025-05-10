import 'package:accounting/module/aktivasi_users/aktivasi_users_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/users_model.dart';
import '../../utils/colors.dart';

class AktivasiUsersPage extends StatelessWidget {
  const AktivasiUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AktivasiUsersNotifier(context: context),
      child: Consumer<AktivasiUsersNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Aktivasi Users",
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
                          columnName: 'userid',
                          label: Container(
                              padding: EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: Text('User ID',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 12,
                                  )))),
                      GridColumn(
                          columnName: 'namauser',
                          label: Container(
                              color: colorPrimary,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(6),
                              child: Text('Nama User',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'tglexp',
                          label: Container(
                              color: colorPrimary,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(6),
                              child: Text('Tanggal Kadaluarsa',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'lvluser',
                          label: Container(
                              color: colorPrimary,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(6),
                              child: Text('Level User',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'action',
                          width: 80,
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
              )
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(AktivasiUsersNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listData);
  }

  AktivasiUsersNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<UsersModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'userid', value: data.userid),
                DataGridCell(columnName: 'namauser', value: data.namauser),
                DataGridCell(columnName: 'tglexp', value: data.tglexp),
                DataGridCell(
                    columnName: 'lvluser',
                    value: data.lvluser == "A"
                        ? "Administrator"
                        : data.lvluser == "S"
                            ? "Supervisor"
                            : "User"),
                DataGridCell(columnName: 'action', value: data.userid),
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
                "Aktifkan",
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
