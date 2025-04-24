import 'package:accounting/models/index.dart';

import 'package:accounting/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';
import 'aktivasi_notifier.dart';

class AktivasiPage extends StatelessWidget {
  const AktivasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AktivasiNotifier(context: context),
      child: Consumer<AktivasiNotifier>(
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
                              "Hari Kerja",
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
                                "Tambah Hari Kerja",
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
                                columnName: 'kd_aktivasi',
                                label: Container(
                                    padding: EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: Text('Kode Aktivasi',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                columnName: 'nm_aktivasi',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Nama Kelompok',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'hari',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Hari',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'jam_mulai',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Jam Berangkat',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'jam_selesai',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Jam Selesai',
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
                    ? Container(
                        padding: EdgeInsets.all(20),
                        width: 600,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Tambah Aktivasi",
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
                                  "Kode Aktivasi",
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
                              controller: value.kode,
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
                                hintText: "Kode Aktivasi",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  "Nama Kelompok",
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
                                hintText: "Nama Kelompok",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  "Hari",
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
                            ListView(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              children: value.listHari
                                  .map((e) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                  activeColor: colorPrimary,
                                                  value: value
                                                          .listHariAdd.isEmpty
                                                      ? false
                                                      : value.listHariAdd
                                                              .where(
                                                                  (f) => f == e)
                                                              .isNotEmpty
                                                          ? true
                                                          : false,
                                                  onChanged: (g) =>
                                                      value.pilihHari(e)),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "$e",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          )
                                        ],
                                      ))
                                  .toList(),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Jam Masuk",
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
                                    InkWell(
                                      onTap: () {
                                        value.pilihJamMulai();
                                      },
                                      child: TextFormField(
                                        enabled: false,
                                        controller: value.jamMulai,
                                        textInputAction: TextInputAction.done,

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
                                          hintText: "jam Masuk",
                                          fillColor: Colors.grey[200],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                )),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Jam Pulang",
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
                                    InkWell(
                                      onTap: () {
                                        value.pilihJamSelesai();
                                      },
                                      child: TextFormField(
                                        enabled: false,
                                        textInputAction: TextInputAction.done,
                                        controller: value.jamSelesai,
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
                                          hintText: "Jam Pulang",
                                          fillColor: Colors.grey[200],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                )),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ButtonPrimary(
                              onTap: () {},
                              name: "Simpan",
                            )
                          ],
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
  DetailDataSource(AktivasiNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  AktivasiNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<AktivasiModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'kd_aktivasi', value: data.kdAktivasi),
                DataGridCell(columnName: 'nm_aktivasi', value: data.nmAktivasi),
                DataGridCell(
                    columnName: 'hari',
                    value: data.hari
                        .replaceAll("[", '')
                        .replaceAll(",", ", ")
                        .replaceAll("]", "")
                        .replaceAll("'", "")),
                DataGridCell(columnName: 'jam_mulai', value: data.jamMulai),
                DataGridCell(columnName: 'jam_selesai', value: data.jamSelesai),
                DataGridCell(columnName: 'action', value: data.kdAktivasi),
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
