import 'package:cif/models/index.dart';
import 'package:cif/module/master/terminal/user_akses_notifier.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart' as a;

import 'package:cif/utils/button_custom.dart';
import 'package:cif/utils/currency_formatted.dart';
// import 'package:cif/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';
import '../../../utils/format_currency.dart';

class UserAksesPage extends StatelessWidget {
  const UserAksesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserAksesNotifier(context: context),
      child: Consumer<UserAksesNotifier>(
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
                        child: const Expanded(
                          child: Text(
                            "User Akses",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: FocusTraversalGroup(
                          child: Form(
                            key: value.keyForm,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Label + Radio Buttons
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Cari User",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: TextFormField(
                                          textInputAction: TextInputAction.done,
                                          validator: (e) {
                                            if (e!.isEmpty) {
                                              return "Wajib diisi";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[200],
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 16),
                                // Label + Radio Buttons
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "User ID",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: TextFormField(
                                          textInputAction: TextInputAction.done,
                                          readOnly: true,
                                          validator: (e) {
                                            if (e!.isEmpty) {
                                              return "Wajib diisi";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: "User ID",
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          textInputAction: TextInputAction.done,
                                          readOnly: true,
                                          validator: (e) {
                                            if (e!.isEmpty) {
                                              return "Wajib diisi";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Kantor",
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 16),

                                const SizedBox(width: 16),

                                // Tombol Cari
                                InkWell(
                                  onTap: () => value.tambah(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: colorPrimary,
                                      border: Border.all(width: 2, color: colorPrimary),
                                    ),
                                    child: const Text(
                                      "Tambah Akses",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                  width: 50,
                                  columnName: 'no',
                                  label: Container(
                                      color: colorPrimary,
                                      padding: const EdgeInsets.all(6),
                                      alignment: Alignment.center,
                                      child: const Text('no',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
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
                          color: Colors.grey.withOpacity(0.8),
                        )
                      : const SizedBox(),
                ),
                Positioned(
                  top: 50,
                  left: 50,
                  right: 50,
                  bottom: 50,
                  child: value.dialog
                      ? Container(
                          padding: const EdgeInsets.all(20),
                          width: 600,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: FocusTraversalGroup(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "User Akses Point",
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
                                height: 16,
                              ),
                              Expanded(
                                  child: ListView(children: [
                                Container(
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
                                ButtonPrimary(
                                  onTap: () {
                                    value.cek();
                                  },
                                  name: "Simpan",
                                ),
                              ])),
                            ]),
                          ),
                        )
                      : const SizedBox(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(value) {
    // tindakanNotifier = "";
    // buildRowData(value.listData);
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    throw UnimplementedError();
  }
}
