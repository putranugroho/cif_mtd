import 'package:cif/models/index.dart';
import 'package:cif/module/setup/jabatan/jabatan_notifier.dart';
import 'package:cif/module/setup/level/level_notifier.dart';
import 'package:cif/utils/button_custom.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';
import '../../../utils/pro_shimmer.dart';

class JabatanPage extends StatelessWidget {
  const JabatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JabatanNotifier(context: context),
      child: Consumer<JabatanNotifier>(
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
                              "Jabatan",
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
                                "Tambah Jabatan",
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
                                      width: 50,
                                      columnName: 'no',
                                      label: Container(
                                          padding: const EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: const Text('No',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 100,
                                      columnName: 'kode',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Kode jabatan',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 250,
                                      columnName: 'jabatan',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Jabatan',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 250,
                                      columnName: 'level',
                                      label: Container(
                                          padding: const EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: const Text('Level Jabatan',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      width: 80,
                                      columnName: 'action',
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
                        width: 600,
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
                                      value.editData ? "Ubah / Hapus Jabatan" : "Tambah  Jabatan",
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
                              const Row(
                                children: [
                                  Text(
                                    "Level",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "*",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              DropdownSearch<LevelModel>(
                                popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: true, // Aktifkan fitur pencarian
                                ),
                                selectedItem: value.levelModel,
                                items: value.list,
                                itemAsString: (e) => e.kelJabatan,
                                onChanged: (e) {
                                  value.pilihLevel(e!);
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  baseStyle: const TextStyle(fontSize: 16),
                                  textAlignVertical: TextAlignVertical.center,
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: "Pilih Level",
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
                              const SizedBox(height: 16),
                              const Row(
                                children: [
                                  Text(
                                    "Kode Jabatan",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
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
                                controller: value.kode,
                                maxLines: 1,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
                                validator: (e) {
                                  if (e!.isEmpty) {
                                    return "Wajib diisi";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Level Jabatan",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Row(
                                children: [
                                  Text(
                                    "Jabatan",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
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
                                controller: value.nama,
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
                                  hintText: "Jabatan",
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
  DetailDataSource(JabatanNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listJabatan);
  }

  JabatanNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<JabatanModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'kode', value: data.kodeJabatan),
                DataGridCell(columnName: 'jabatan', value: data.namaJabatan),
                DataGridCell(columnName: 'level', value: data.kelJabatan),
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
