import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/sbb_khsus/sbb_khusus_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../models/coa_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/pro_shimmer.dart';

class SbbKhususPage extends StatelessWidget {
  const SbbKhususPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SbbKhususNotifier(context: context),
      child: Consumer<SbbKhususNotifier>(
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
                              "SBB Khusus",
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
                                "Tambah SBB Khusus",
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
                                      columnName: 'kode',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Kode Golongan',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
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
                                      columnName: 'items',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Akun',
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
                right: 0,
                bottom: 0,
                child: value.dialog
                    ? Container(
                        width: 600,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Tambah SBB Khusus",
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
                                  "Pilih SBB Khusus",
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
                                  child: DropdownSearch<GolonganSbbKhususModel>(
                                    popupProps:
                                        const PopupPropsMultiSelection.menu(
                                      showSearchBox:
                                          true, // Aktifkan fitur pencarian
                                    ),
                                    selectedItem: value.golonganSbbKhususModel,
                                    items: value.listGolongan,
                                    itemAsString: (e) =>
                                        "(${e.kodeGolongan}) ${e.namaGolongan}",
                                    onChanged: (e) {
                                      value.pilihGolongan(e!);
                                    },
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                      baseStyle: TextStyle(fontSize: 16),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      dropdownSearchDecoration: InputDecoration(
                                        hintText: "Pilih Golongan",
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
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            value.golonganSbbKhususModel != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child:
                                                  Text("Pilih Sub Buku Besar")),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      ListView.builder(
                                          itemCount: value.listGl.length,
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            final data = value.listGl[i];
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  "${data.namaSbb}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                value.golonganSbbKhususModel!
                                                            .lebihSatuAkun ==
                                                        "Y"
                                                    ? ListView.builder(
                                                        itemCount:
                                                            data.items.length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        itemBuilder:
                                                            (context, b) {
                                                          final a =
                                                              data.items[b];
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Checkbox(
                                                                      activeColor:
                                                                          colorPrimary,
                                                                      value: value
                                                                              .listGlAdd
                                                                              .isNotEmpty
                                                                          ? value.listGlAdd.where((e) => e == a).isNotEmpty
                                                                              ? true
                                                                              : false
                                                                          : false,
                                                                      onChanged: (e) {
                                                                        value.pilihCoa(
                                                                            a);
                                                                      }),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Expanded(
                                                                      child: Text(
                                                                          "(${a.nosbb}) ${a.namaSbb}")),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              )
                                                            ],
                                                          );
                                                        })
                                                    : ListView.builder(
                                                        itemCount:
                                                            data.items.length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        itemBuilder:
                                                            (context, b) {
                                                          final a =
                                                              data.items[b];
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Radio(
                                                                      activeColor:
                                                                          colorPrimary,
                                                                      value: a,
                                                                      groupValue:
                                                                          value
                                                                              .inqueryGlModel,
                                                                      onChanged:
                                                                          (e) {
                                                                        value.pilihSbbSatu(
                                                                            a);
                                                                      }),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Expanded(
                                                                      child: Text(
                                                                          "(${a.nosbb}) ${a.namaSbb}")),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              )
                                                            ],
                                                          );
                                                        })
                                              ],
                                            );
                                          }),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          ButtonPrimary(
                                            onTap: () {
                                              value.cek();
                                            },
                                            name: "Simpan",
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : SizedBox()
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
  DetailDataSource(SbbKhususNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  SbbKhususNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<SbbKhususModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'kode', value: data.kodeGolongan),
                DataGridCell(columnName: 'nama', value: data.namaGolongan),
                DataGridCell(
                    columnName: 'items',
                    value: "${data.items.length} Akun Terdaftar"),
                DataGridCell(columnName: 'action', value: data.kodeGolongan),
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
