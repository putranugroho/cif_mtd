import 'package:cif/module/aktivasi_users/aktivasi_users_notifier.dart';
import 'package:cif/module/closing_eom/closing_eom_notifier.dart';
import 'package:cif/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/users_model.dart';
import '../../utils/colors.dart';

class ClosingEomPage extends StatelessWidget {
  const ClosingEomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClosingEomNotifier(context: context),
      child: Consumer<ClosingEomNotifier>(
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
                        "Closing EOM",
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
                          width: 100,
                          columnName: 'status',
                          label: Container(
                              padding: const EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: const Text('Status',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.white,
                                  )))),
                      GridColumn(
                          columnName: 'userid',
                          label: Container(
                              padding: const EdgeInsets.all(6),
                              color: colorPrimary,
                              alignment: Alignment.center,
                              child: const Text('User ID',
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
                              padding: const EdgeInsets.all(6),
                              child: const Text('Nama User',
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
                              padding: const EdgeInsets.all(6),
                              child: const Text('Tanggal Kadaluarsa',
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
                              padding: const EdgeInsets.all(6),
                              child: const Text('Level User',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  )))),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ))),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    ButtonPrimary(
                      onTap: () {
                        value.konfirmasi();
                      },
                      name: "Lanjutkan",
                    )
                  ],
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
  DetailDataSource(ClosingEomNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listData);
  }

  ClosingEomNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<UsersModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'status', value: (index++).toString()),
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
                "Aktifkan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (e.columnName == 'status') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 100,
                child: int.parse(e.value) % 2 == 0
                    ? Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            )),
                      )
                    : Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            )),
                      )),
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
