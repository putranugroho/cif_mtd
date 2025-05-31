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
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const Expanded(
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
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: colorPrimary,
                                border: Border.all(
                                  width: 2,
                                  color: colorPrimary,
                                ),
                              ),
                              child: const Text(
                                "Tambah Akses Point",
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                                      columnName: 'no_akses',
                                      label: Container(
                                          padding: const EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: const Text('Kode AP',
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
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Akses ID',
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
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Type',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'lokasi',
                                      label: Container(
                                          padding: const EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: const Text('Lokasi',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'alamat',
                                      width: 300,
                                      label: Container(
                                          padding: const EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: const Text('Alamat',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'keterangan',
                                      width: 200,
                                      label: Container(
                                          padding: const EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: const Text('Keterangan',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'action',
                                      width: 80,
                                      label: Container(
                                          color: colorPrimary,
                                          padding: const EdgeInsets.all(6),
                                          alignment: Alignment.center,
                                          child: const Text('Action',
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
                bottom: 0,
                right: 0,
                child: value.dialog
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        width: 700,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Form(
                          key: value.keyForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      value.editData ? "Ubah / Hapus Akses Point" : "Tambah Akses Point",
                                      style: const TextStyle(
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
                              SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: const Text("Kantor"),
                                      ),
                                      const SizedBox(
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
                                          popupProps: const PopupPropsMultiSelection.menu(
                                            showSearchBox: true, // Aktifkan fitur pencarian
                                          ),
                                          selectedItem: value.kantor,
                                          items: value.list,
                                          itemAsString: (e) => e.namaKantor,
                                          onChanged: (e) {
                                            value.pilihKantor(e!);
                                          },
                                          dropdownDecoratorProps: DropDownDecoratorProps(
                                            baseStyle: const TextStyle(fontSize: 16),
                                            textAlignVertical: TextAlignVertical.center,
                                            dropdownSearchDecoration: InputDecoration(
                                              hintText: "Pilih Kantor",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
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
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: const Text("Kode Akses Point"),
                                      ),
                                      const SizedBox(
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
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: const Text("Akses ID"),
                                      ),
                                      const SizedBox(
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
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: const Text("Lokasi"),
                                      ),
                                      const SizedBox(
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
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text("Kantor"),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          Radio(
                                              value: "Luar Kantor",
                                              activeColor: colorPrimary,
                                              groupValue: value.lokasi,
                                              onChanged: (e) {
                                                value.pilihlokasi(e!);
                                              }),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text("Luar Kantor"),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          Radio(
                                              value: "Karyawan",
                                              activeColor: colorPrimary,
                                              groupValue: value.lokasi,
                                              onChanged: (e) {
                                                value.pilihlokasi(e!);
                                              }),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text("Rumah Karyawan"),
                                        ],
                                      ))
                                    ],
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: const Text("Alamat"),
                                      ),
                                      const SizedBox(
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
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: const Text("Keterangan"),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        controller: value.keterangan,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: const Text("Tipe Akses"),
                                      ),
                                      const SizedBox(
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
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text("LAN"),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          Radio(
                                              value: "WIFI",
                                              groupValue: value.akses,
                                              activeColor: colorPrimary,
                                              onChanged: (e) {
                                                value.pilihAkses(e!);
                                              }),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text("WIFI"),
                                        ],
                                      ))
                                    ],
                                  )),
                              const SizedBox(
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
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  : const SizedBox()
                            ],
                          ),
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
