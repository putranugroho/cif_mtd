import 'package:accounting/models/index.dart';
import 'package:accounting/module/master/terminal/akses_point_notifier.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/colors.dart';
import '../../../utils/currency_formatted.dart';

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
                                columnName: 'noAkses',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('No Akses',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'aksesId',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Akses ID',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                columnName: 'type',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Type',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                columnName: 'lokasi',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Lokasi',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'alamat',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Alamat',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'keterangan',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Keterangan',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
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
                        child: FocusTraversalGroup(
                          child: Form(
                            key: value.keyForm,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "Tambah Akses Point",
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
                                Expanded(
                                    child: ListView(
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          "No. Akses",
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
                                      controller: value.noAkses,
                                      maxLines: 1,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
                                      ],
                                      validator: (e) {
                                        if (e!.isEmpty) {
                                          return "Wajib diisi";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Nomor Akses",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Row(
                                      children: [
                                        Text(
                                          "Akses ID",
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
                                      controller: value.aksesId,
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
                                        hintText: "Akses ID",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Row(
                                      children: [
                                        Text(
                                          "Lokasi",
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
                                    Row(
                                      children: [
                                        Radio(
                                            activeColor: colorPrimary,
                                            value: true,
                                            groupValue: value.lokasi,
                                            onChanged: (e) {
                                              value.pilihLokasi(true);
                                            }),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text("Kantor"),
                                        const SizedBox(
                                          width: 24,
                                        ),
                                        Radio(
                                            activeColor: colorPrimary,
                                            value: false,
                                            groupValue: value.lokasi,
                                            onChanged: (e) {
                                              value.pilihLokasi(false);
                                            }),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text("Luar Kantor"),
                                        const SizedBox(
                                          width: 24,
                                        ),
                                        Radio(
                                            activeColor: colorPrimary,
                                            value: false,
                                            groupValue: value.lokasi,
                                            onChanged: (e) {
                                              value.pilihLokasi(false);
                                            }),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text("Karyawan"),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    value.lokasi
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              const Row(
                                                children: [
                                                  Text(
                                                    "Kantor",
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                  SizedBox(width: 5),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              DropdownSearch<AoModel>(
                                                popupProps: const PopupPropsMultiSelection.menu(
                                                  showSearchBox: true, // Aktifkan fitur pencarian
                                                ),
                                                selectedItem: value.aoModel,
                                                items: value.listAoModel.where((e) => e.golCust == "3").toList(),
                                                itemAsString: (e) => e.nama,
                                                onChanged: (e) {
                                                  value.pilihAoModelDebet(e!);
                                                },
                                                dropdownDecoratorProps: DropDownDecoratorProps(
                                                  baseStyle: const TextStyle(fontSize: 16),
                                                  textAlignVertical: TextAlignVertical.center,
                                                  dropdownSearchDecoration: InputDecoration(
                                                    hintText: "Cari Kantor",
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
                                            ],
                                          )
                                        : const SizedBox(),
                                    const Row(
                                      children: [
                                        Text(
                                          "Alamat",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.alamat,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: "Alamat",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Row(
                                      children: [
                                        Text(
                                          "Keterangan",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.keterangan3,
                                      maxLines: 1,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],

                                      decoration: InputDecoration(
                                        hintText: "Keterangan",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Row(
                                      children: [
                                        Text(
                                          "Type Akses",
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
                                    Row(
                                      children: [
                                        Radio(
                                            activeColor: colorPrimary,
                                            value: true,
                                            groupValue: value.typeAkses,
                                            onChanged: (e) {
                                              value.pilihTypeAkses(true);
                                            }),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text("LAN"),
                                        const SizedBox(
                                          width: 24,
                                        ),
                                        Radio(
                                            activeColor: colorPrimary,
                                            value: false,
                                            groupValue: value.typeAkses,
                                            onChanged: (e) {
                                              value.pilihTypeAkses(false);
                                            }),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text("WIFI"),
                                      ],
                                    ),
                                    const SizedBox(
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
                                ))
                              ],
                            ),
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
    buildRowData(value.list);
  }

  AksesPointNotifier? tindakanNotifier;

  final List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<CustomerSupplierModel> list) {}

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
