import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/golongan_aset/golongan_aset_notifier.dart';

import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';

class GolonganAsetPage extends StatelessWidget {
  const GolonganAsetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GolonganAsetNotifier(context: context),
      child: Consumer<GolonganAsetNotifier>(
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
                              "Golongan Aset",
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
                                "Tambah Golongan Aset",
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
                                width: 100,
                                columnName: 'kode',
                                label: Container(
                                    padding: EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: Text('Kode golongan',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                columnName: 'nama',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Nama Golongan',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'metode',
                                width: 110,
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Metode',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 50,
                                columnName: 'nilaiakhir',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Nilai Akhir',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 50,
                                columnName: 'masasusut',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Masa Susut',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 50,
                                columnName: 'nilai',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Nilai Declining',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'sbbAset',
                                width: 240,
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('SBB Aset',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'sbbPenyusutan',
                                width: 240,
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('SBB Penyusutan',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'sbbRugiJual',
                                width: 240,
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('SBB Rugi Jual',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'sbbLabaJual',
                                width: 240,
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('SBB Laba Jual',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 80,
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
                    ? Form(
                        key: value.keyForm,
                        child: Container(
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
                                      value.editData
                                          ? "Ubah / Hapus Golongan Aset"
                                          : "Tambah Golongan Aset",
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
                              Expanded(
                                  child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Kode Golongan",
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
                                      hintText: "Kode Golongan",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(
                                        "Nama Golongan",
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
                                      hintText: "Nama Golongan",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  value.metode == 1
                                      ? Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Masa Susut (Bulan)",
                                                  style: const TextStyle(
                                                      fontSize: 12),
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
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.masasusut,
                                              maxLines: 1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Masa Susut",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Nilai Declining",
                                                  style: const TextStyle(
                                                      fontSize: 12),
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
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.nilai,
                                              maxLines: 1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^\d+\.?\d{0,2}')),
                                              ],
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Nilai Declining",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        ),
                                  Row(
                                    children: [
                                      Text(
                                        "SBB Aset",
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TypeAheadField<InqueryGlModel>(
                                          controller: value.namasbbaset,
                                          suggestionsCallback: (search) =>
                                              value.getInquerySbbAset(search),
                                          builder:
                                              (context, controller, focusNode) {
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
                                              title: Text(city.nosbb),
                                              subtitle: Text(city.namaSbb),
                                            );
                                          },
                                          onSelected: (city) {
                                            // value.selectInvoice(city);
                                            value.pilihSbbAset(city);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.nosbbaset,
                                          maxLines: 1,
                                          // inputFormatters: [
                                          //   FilteringTextInputFormatter.digitsOnly
                                          // ],
                                          // validator: (e) {
                                          //   if (e!.isEmpty) {
                                          //     return "Wajib diisi";
                                          //   } else {
                                          //     return null;
                                          //   }
                                          // },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nomor Debet",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "SBB Penyusutan",
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TypeAheadField<InqueryGlModel>(
                                          controller: value.namasbbpenyusutan,
                                          suggestionsCallback: (search) => value
                                              .getInquerySbbPenyusutan(search),
                                          builder:
                                              (context, controller, focusNode) {
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
                                              title: Text(city.nosbb),
                                              subtitle: Text(city.namaSbb),
                                            );
                                          },
                                          onSelected: (city) {
                                            // value.selectInvoice(city);
                                            value.pilihSbbPenyusutan(city);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.nossbpenyusutan,
                                          maxLines: 1,
                                          // inputFormatters: [
                                          //   FilteringTextInputFormatter.digitsOnly
                                          // ],
                                          // validator: (e) {
                                          //   if (e!.isEmpty) {
                                          //     return "Wajib diisi";
                                          //   } else {
                                          //     return null;
                                          //   }
                                          // },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nomor Debet",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "SBB Rugi Jual",
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TypeAheadField<InqueryGlModel>(
                                          controller: value.namasbbrugijual,
                                          suggestionsCallback: (search) => value
                                              .getInquerySbbPenyusutan(search),
                                          builder:
                                              (context, controller, focusNode) {
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
                                              title: Text(city.nosbb),
                                              subtitle: Text(city.namaSbb),
                                            );
                                          },
                                          onSelected: (city) {
                                            // value.selectInvoice(city);
                                            value.pilihSbbRugiJual(city);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.nosbbrugijual,
                                          maxLines: 1,
                                          // inputFormatters: [
                                          //   FilteringTextInputFormatter.digitsOnly
                                          // ],

                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nomor Debet",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "SBB Laba Jual",
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TypeAheadField<InqueryGlModel>(
                                          controller: value.namasbblabajual,
                                          suggestionsCallback: (search) => value
                                              .getInquerySbbLabaJual(search),
                                          builder:
                                              (context, controller, focusNode) {
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
                                              title: Text(city.nosbb),
                                              subtitle: Text(city.namaSbb),
                                            );
                                          },
                                          onSelected: (city) {
                                            // value.selectInvoice(city);
                                            value.pilihSbbLabaJual(city);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.nosbblabajual,
                                          maxLines: 1,
                                          // inputFormatters: [
                                          //   FilteringTextInputFormatter.digitsOnly
                                          // ],

                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nomor Debet",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
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
                                            SizedBox(
                                              height: 16,
                                            ),
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
                              ))
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
  DetailDataSource(GolonganAsetNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listData);
  }

  GolonganAsetNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<GolonganAsetModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'kode', value: data.kodeGolongan),
                DataGridCell(columnName: 'nama', value: data.namaGolongan),
                DataGridCell(columnName: 'metode', value: "Double Declining"),
                DataGridCell(columnName: 'nilaiakhir', value: "1"),
                DataGridCell(columnName: 'masasusut', value: data.masaSusut),
                DataGridCell(columnName: 'nilai', value: data.nilaiDeclining),
                DataGridCell(
                    columnName: 'sbbAset',
                    value: data.sbbAset == null ? "" : data.sbbAset),
                DataGridCell(
                    columnName: 'sbbPenyusutan',
                    value:
                        data.sbbPenyusutan == null ? "" : data.sbbPenyusutan),
                DataGridCell(
                    columnName: 'sbbRugiJual',
                    value: data.sbbRugiJual == null ? "" : data.sbbRugiJual),
                DataGridCell(
                    columnName: 'sbbLabaJual',
                    value: data.sbbLabaJual == null ? "" : data.sbbLabaJual),
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
        } else if (e.columnName == 'masasusut' ||
            e.columnName == 'nilai' ||
            e.columnName == 'nilaiakhir') {
          return Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
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
              style: TextStyle(
                fontSize: 12,
              ),
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
