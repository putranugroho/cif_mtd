import 'package:accounting/models/index.dart';
import 'package:accounting/module/akses_point/akses_point_notifier.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/button_custom.dart';
import '../../utils/colors.dart';
import '../../utils/pro_shimmer.dart';

class AksesPointPage extends StatelessWidget {
  const AksesPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AksesPointNotifier(context: context),
      child: Consumer<AksesPointNotifier>(
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
                              "Akses Point",
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
                                "Tambah Akses Point",
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
                                      columnName: 'no_akses',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Kode AP',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12,
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
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Type',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
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
                                      width: 300,
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
                                      width: 200,
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
                    ? Container(
                        padding: EdgeInsets.all(20),
                        width: 700,
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
                                          ? "Ubah / Hapus Akses Point"
                                          : "Tambah Akses Point",
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
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Kantor"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: DropdownSearch<KantorModel>(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Wajib diisi';
                                            }
                                            return null;
                                          },
                                          popupProps:
                                              const PopupPropsMultiSelection
                                                  .menu(
                                            showSearchBox:
                                                true, // Aktifkan fitur pencarian
                                          ),
                                          selectedItem: value.kantor,
                                          items: value.list,
                                          itemAsString: (e) =>
                                              "${e.namaKantor}",
                                          onChanged: (e) {
                                            value.pilihKantor(e!);
                                          },
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            baseStyle: TextStyle(fontSize: 16),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              hintText: "Pilih Kantor",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Kode Akses Point"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        controller: value.noAkses,
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return "Wajib diisi";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Akses ID"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        controller: value.aksesId,
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return "Wajib diisi";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Lokasi"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Radio(
                                              value: "Kantor",
                                              activeColor: colorPrimary,
                                              groupValue: value.lokasi,
                                              onChanged: (e) {
                                                value.pilihlokasi(e!);
                                              }),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Kantor"),
                                          SizedBox(
                                            width: 32,
                                          ),
                                          Radio(
                                              value: "Luar Kantor",
                                              activeColor: colorPrimary,
                                              groupValue: value.lokasi,
                                              onChanged: (e) {
                                                value.pilihlokasi(e!);
                                              }),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Luar Kantor"),
                                          SizedBox(
                                            width: 32,
                                          ),
                                          Radio(
                                              value: "Karyawan",
                                              activeColor: colorPrimary,
                                              groupValue: value.lokasi,
                                              onChanged: (e) {
                                                value.pilihlokasi(e!);
                                              }),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Rumah Karyawan"),
                                        ],
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Alamat"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        controller: value.alamat,
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return "Wajib diisi";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Keterangan"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        controller: value.keterangan,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Tipe Akses"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Radio(
                                              value: "LAN",
                                              groupValue: value.akses,
                                              activeColor: colorPrimary,
                                              onChanged: (e) {
                                                value.pilihAkses(e!);
                                              }),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("LAN"),
                                          SizedBox(
                                            width: 32,
                                          ),
                                          Radio(
                                              value: "WIFI",
                                              groupValue: value.akses,
                                              activeColor: colorPrimary,
                                              onChanged: (e) {
                                                value.pilihAkses(e!);
                                              }),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("WIFI"),
                                        ],
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 8,
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
                                        ButtonDanger(
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
  DetailDataSource(AksesPointNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listData);
  }

  AksesPointNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<AksesPointModel> list) {
    // int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no_akses', value: data.noAkses),
                DataGridCell(columnName: 'akses_id', value: data.aksesId),
                DataGridCell(columnName: 'type', value: data.type),
                DataGridCell(columnName: 'lokasi', value: data.lokasi),
                DataGridCell(columnName: 'alamat', value: data.alamat),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
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
