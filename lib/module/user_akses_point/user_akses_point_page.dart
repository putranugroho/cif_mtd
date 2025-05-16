import 'package:accounting/models/index.dart';
import 'package:accounting/module/user_akses_point/user_akses_point_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/colors.dart';

class UserAksesPointPage extends StatelessWidget {
  const UserAksesPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserAksesPointNotifier(context: context),
      child: Consumer<UserAksesPointNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "User Akses Point",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text("Cari user"),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 200,
                          child: TypeAheadField<UsersModel>(
                            controller: value.namaKaryawan,
                            suggestionsCallback: (search) =>
                                value.getInquery(search),
                            builder: (context, controller, focusNode) {
                              return TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Cari Akun',
                                  ));
                            },
                            itemBuilder: (context, city) {
                              return ListTile(
                                title: Text(city.namauser),
                                subtitle: Text(city.userid),
                              );
                            },
                            onSelected: (city) {
                              // value.selectInvoice(city);
                              value.piliAkunKaryawan(city);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text("User ID"),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            controller: value.nikKaryawan,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: "User ID",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            controller: value.namaKantor,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: "Kantor",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            value.getUsersAksesPoint();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(
                              "Tambah",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 200,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
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
                                    columnName: 'no_akses',
                                    label: Container(
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(6),
                                        child: Text('No Akses',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            )))),
                                GridColumn(
                                    columnName: 'akses_id',
                                    label: Container(
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(6),
                                        child: Text('Akses ID',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            )))),
                                GridColumn(
                                    columnName: 'type',
                                    label: Container(
                                        padding: EdgeInsets.all(6),
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        child: Text('Type',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                              fontSize: 12,
                                            )))),
                                GridColumn(
                                    columnName: 'lokasi',
                                    label: Container(
                                        padding: EdgeInsets.all(6),
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        child: Text('Lokasi',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                              fontSize: 12,
                                            )))),
                                GridColumn(
                                    columnName: 'alamat',
                                    label: Container(
                                        padding: EdgeInsets.all(6),
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        child: Text('Alamat',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                              fontSize: 12,
                                            )))),
                                GridColumn(
                                    columnName: 'keterangan',
                                    label: Container(
                                        padding: EdgeInsets.all(6),
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        child: Text('Keterangan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                              fontSize: 12,
                                            )))),
                                GridColumn(
                                    width: 80,
                                    columnName: 'aksi',
                                    label: Container(
                                        color: colorPrimary,
                                        padding: EdgeInsets.all(6),
                                        alignment: Alignment.center,
                                        child: Text('Aksi',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            )))),
                              ],
                            ),
                          ),
                          value.listUsers.isEmpty
                              ? Container(
                                  height: 140,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[200]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Belum ada akses point ditambahkan")
                                    ],
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    value.tambah
                        ? Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SfDataGrid(
                              headerRowHeight: 40,
                              defaultColumnWidth: 180,
                              frozenColumnsCount: 1,

                              // controller: value.dataGridController,
                              gridLinesVisibility: GridLinesVisibility.both,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.both,
                              selectionMode: SelectionMode.single,

                              source: DetailDataSources(value),
                              columns: <GridColumn>[
                                GridColumn(
                                    columnName: 'no_akses',
                                    label: Container(
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(6),
                                        child: Text('No Akses',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            )))),
                                GridColumn(
                                    columnName: 'akses_id',
                                    label: Container(
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(6),
                                        child: Text('Akses ID',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            )))),
                                GridColumn(
                                    columnName: 'type',
                                    label: Container(
                                        padding: EdgeInsets.all(6),
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        child: Text('Type',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                              fontSize: 12,
                                            )))),
                                GridColumn(
                                    columnName: 'lokasi',
                                    label: Container(
                                        padding: EdgeInsets.all(6),
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        child: Text('Lokasi',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                              fontSize: 12,
                                            )))),
                                GridColumn(
                                    columnName: 'alamat',
                                    label: Container(
                                        padding: EdgeInsets.all(6),
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        child: Text('Alamat',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                              fontSize: 12,
                                            )))),
                                GridColumn(
                                    columnName: 'keterangan',
                                    label: Container(
                                        padding: EdgeInsets.all(6),
                                        color: colorPrimary,
                                        alignment: Alignment.center,
                                        child: Text('Keterangan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                              fontSize: 12,
                                            )))),
                                GridColumn(
                                    width: 80,
                                    columnName: 'aksi',
                                    label: Container(
                                        color: colorPrimary,
                                        padding: EdgeInsets.all(6),
                                        alignment: Alignment.center,
                                        child: Text('Aksi',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            )))),
                              ],
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      // value.getUsersAksesPoint();
                      value.simpanAkses();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(UserAksesPointNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listUsers);
  }

  UserAksesPointNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<UserAksesPointModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'no_akses', value: data.noAkses),
                DataGridCell(columnName: 'akses_id', value: data.aksesId),
                DataGridCell(columnName: 'type', value: data.type),
                DataGridCell(columnName: 'lokasi', value: data.lokasi),
                DataGridCell(columnName: 'alamat', value: data.lokasi),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
                DataGridCell(columnName: 'aksi', value: data.id.toString()),
              ],
            ))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'aksi') {
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

class DetailDataSources extends DataGridSource {
  DetailDataSources(UserAksesPointNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listData);
  }

  UserAksesPointNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<AksesPointModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no_akses', value: data.noAkses),
                DataGridCell(columnName: 'akses_id', value: data.aksesId),
                DataGridCell(columnName: 'type', value: data.type),
                DataGridCell(columnName: 'lokasi', value: data.lokasi),
                DataGridCell(columnName: 'alamat', value: data.lokasi),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
                DataGridCell(columnName: 'aksi', value: data.id.toString()),
              ],
            ))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'aksi') {
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Checkbox(
                  activeColor: colorPrimary,
                  value: tindakanNotifier!.listTmpAskes.isEmpty
                      ? false
                      : tindakanNotifier!.listTmpAskes
                              .where((f) => f.id == int.parse(e.value))
                              .isNotEmpty
                          ? true
                          : false,
                  onChanged: (f) {
                    tindakanNotifier!.addAkses(e.value);
                  }));
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
