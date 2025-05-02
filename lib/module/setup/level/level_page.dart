import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/level/level_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';
import '../../../utils/pro_shimmer.dart';

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LevelNotifier(context: context),
      child: Consumer<LevelNotifier>(
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
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Level ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => value.tambah(),
                            child: Container(
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
                                "Tambah Level ",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: value.isLoading
                          ? Container(
                              padding: const EdgeInsets.all(16),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProShimmer(height: 10, width: 200),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ProShimmer(height: 10, width: 120),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ProShimmer(height: 10, width: 100),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(20),
                              height: MediaQuery.of(context).size.height,
                              child: SfDataGrid(
                                headerRowHeight: 40,
                                defaultColumnWidth: 180,
                                frozenColumnsCount: 1,

                                // controller: value.dataGridController,
                                gridLinesVisibility: GridLinesVisibility.both,
                                headerGridLinesVisibility:
                                    GridLinesVisibility.both,
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
                                      columnName: 'level',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Level',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'jabatan',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Nama Level',
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
                    : SizedBox(),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: value.dialog
                    ?  Container(
                        padding: EdgeInsets.all(20),
                        width: 600,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Form(
                          key: value.keyForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      value.editData
                                          ? "Ubah / Hapus Level "
                                          : "Tambah Level ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => value.tutup(),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.circle),
                                      child: Icon(Icons.close),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Level",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "*",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                controller: value.level,
                                maxLines: 1,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (e) {
                                  if (e!.isEmpty) {
                                    return "Wajib diisi";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Level",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Text(
                                    "Nama Level",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "*",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                controller: value.jabatan,
                                maxLines: 1,
                                // inputFormatters: [
                                //   FilteringTextInputFormatter.digitsOnly
                                // ],
                                validator: (e) {
                                  if (e!.isEmpty) {
                                    return "Wajib diisi";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Nama Level",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ButtonPrimary(
                                onTap: () {
                                  value.cek();
                                },
                                name: "Simpan",
                              ),
                              value.editData
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(height: 16),
                                        ButtonPrimary(
                                          onTap: () {
                                            value.confirm();
                                          },
                                          name: "Hapus",
                                        ),
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(LevelNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  LevelNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<LevelModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'level', value: data.lvlJabatan),
                DataGridCell(columnName: 'jabatan', value: data.kelJabatan),
                DataGridCell(columnName: 'action', value: data.id.toString()),
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
            child: InkWell(
              onTap: () {
                tindakanNotifier!.edit(e.value);
              },
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
