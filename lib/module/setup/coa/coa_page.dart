import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/coa/coa_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:dropdown_search/dropdown_search.dart';
import '../../../utils/colors.dart';
import '../../../utils/pro_shimmer.dart';
import '../../../utils/currency_formatted.dart';

class CoaPage extends StatelessWidget {
  const CoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoaNotifier(context: context),
      child: Consumer<CoaNotifier>(
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
                              "Chart of Account",
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
                                "Tambah COA",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            onTap: () => value.otorisasi(),
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
                                "Otorisasi",
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
                                      columnName: 'gol_acc',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Gol. Akun',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'jns_acc',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Jenis Akun',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'nobb',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('No. Buku Besar',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'nosbb',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('ANo. Sub Buku Besar',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'nama_sbb',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Nama SBB',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'type_posting',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Type Posting',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'sbb_khusus',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('SBB Khusus',
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
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: value.dialog || value.dialogotorisasi
                    ? Container(
                        color: Colors.black.withOpacity(0.5),
                      )
                    : SizedBox(),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: value.dialogotorisasi
                      ? Container(
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
                                      "Otorisasi Rekening",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                    InkWell(
                                      onTap: () {
                                        value.tutup();
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            shape: BoxShape.circle),
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  height: 1,
                                  color: Colors.grey[200],
                                ),
                                Row(
                                  children: [
                                    Text("Kode Kantor "),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      width: 150,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        controller: value.noKantor,
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
                                          hintText: "Nomor Kantor",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Checkbox(
                                      value: value.seluruhKantor,
                                      onChanged: (e) => value.gantiseluruh(),
                                      activeColor: colorPrimary,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Seluruh Kantor",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Spacer(),
                                    Container(
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
                                        "Proses",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  height: 1,
                                  color: Colors.grey[200],
                                ),
                                // Row(
                                //   children: [
                                //     Container(
                                //       width: 50,
                                //       child: Text(
                                //         "Flag",
                                //         style: TextStyle(
                                //           fontSize: 12,
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 8,
                                //     ),
                                //     Container(
                                //       width: 50,
                                //       child: Text(
                                //         "Type",
                                //         style: TextStyle(
                                //           fontSize: 12,
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 8,
                                //     ),
                                //     Container(
                                //       width: 100,
                                //       child: Text(
                                //         "No SBB",
                                //         style: TextStyle(
                                //           fontSize: 12,
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 8,
                                //     ),
                                //     Container(
                                //       width: 100,
                                //       child: Text(
                                //         "No BB",
                                //         style: TextStyle(
                                //           fontSize: 12,
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 8,
                                //     ),
                                //     Container(
                                //       width: 50,
                                //       child: Text(
                                //         "CC",
                                //         style: TextStyle(
                                //           fontSize: 12,
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 8,
                                //     ),
                                //     Expanded(child: Text("Keterangan"))
                                //   ],
                                // ),
                                // Container(
                                //   margin: EdgeInsets.symmetric(vertical: 16),
                                //   height: 1,
                                //   color: Colors.grey[200],
                                // ),
                                // SizedBox(
                                //   height: 8,
                                // ),
                                // Expanded(
                                //     child: ListView.builder(
                                //         itemCount: value.list.length,
                                //         shrinkWrap: true,
                                //         physics: ClampingScrollPhysics(),
                                //         itemBuilder: (context, i) {
                                //           final data = value.list[i];
                                //           return Column(
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //             children: [
                                //               Row(
                                //                 children: [
                                //                   Container(
                                //                     width: 50,
                                //                     child: Checkbox(
                                //                         activeColor: colorPrimary,
                                //                         value: value
                                //                                 .listAdd.isEmpty
                                //                             ? false
                                //                             : value.listAdd
                                //                                     .where((e) =>
                                //                                         e == data)
                                //                                     .isNotEmpty
                                //                                 ? true
                                //                                 : false,
                                //                         onChanged: (e) =>
                                //                             value.pilihCoa(data)),
                                //                   ),
                                //                   SizedBox(
                                //                     width: 8,
                                //                   ),
                                //                   Container(
                                //                     width: 50,
                                //                     child: Text(
                                //                       "${data.typePosting}",
                                //                       style: TextStyle(
                                //                         fontSize: 12,
                                //                       ),
                                //                     ),
                                //                   ),
                                //                   SizedBox(
                                //                     width: 8,
                                //                   ),
                                //                   Container(
                                //                     width: 100,
                                //                     child: Text(
                                //                       "${data.nosbb}",
                                //                       style: TextStyle(
                                //                         fontSize: 12,
                                //                       ),
                                //                     ),
                                //                   ),
                                //                   SizedBox(
                                //                     width: 8,
                                //                   ),
                                //                   Container(
                                //                     width: 100,
                                //                     child: Text(
                                //                       "${data.nobb}",
                                //                       style: TextStyle(
                                //                         fontSize: 12,
                                //                       ),
                                //                     ),
                                //                   ),
                                //                   SizedBox(
                                //                     width: 8,
                                //                   ),
                                //                   Container(
                                //                     width: 50,
                                //                     child: Text(
                                //                       "",
                                //                       style: TextStyle(
                                //                         fontSize: 12,
                                //                       ),
                                //                     ),
                                //                   ),
                                //                   SizedBox(
                                //                     width: 8,
                                //                   ),
                                //                   Expanded(
                                //                       child:
                                //                           Text("${data.namaSbb}"))
                                //                 ],
                                //               ),
                                //               SizedBox(
                                //                 height: 8,
                                //               ),
                                //             ],
                                //           );
                                //         })),
                                // SizedBox(
                                //   height: 8,
                                // ),
                                // Container(
                                //   margin: EdgeInsets.symmetric(vertical: 16),
                                //   height: 1,
                                //   color: Colors.grey[200],
                                // ),
                                // Row(
                                //   children: [
                                //     Checkbox(
                                //       value: value.seluruhKantor,
                                //       onChanged: (e) => value.gantiseluruh(),
                                //       activeColor: colorPrimary,
                                //     ),
                                //     SizedBox(
                                //       width: 8,
                                //     ),
                                //     Text(
                                //       "Pilih Semua",
                                //       style: TextStyle(fontSize: 12),
                                //     ),
                                //     Spacer(),
                                //     Container(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 12, vertical: 8),
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(8),
                                //         color: colorPrimary,
                                //         border: Border.all(
                                //           width: 2,
                                //           color: colorPrimary,
                                //         ),
                                //       ),
                                //       child: Text(
                                //         "Filter",
                                //         textAlign: TextAlign.center,
                                //         style: const TextStyle(
                                //           color: Colors.white,
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 8,
                                //     ),
                                //     Container(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 12, vertical: 8),
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(8),
                                //         color: colorPrimary,
                                //         border: Border.all(
                                //           width: 2,
                                //           color: colorPrimary,
                                //         ),
                                //       ),
                                //       child: Text(
                                //         "Proses",
                                //         textAlign: TextAlign.center,
                                //         style: const TextStyle(
                                //           color: Colors.white,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Container(
                                //   margin: EdgeInsets.symmetric(vertical: 16),
                                //   height: 1,
                                //   color: Colors.grey[200],
                                // ),
                                // SizedBox(
                                //   height: 8,
                                // ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox()),
              Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: value.dialog
                      ? Container(
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
                                            ? "Ubah / Hapus Chart of Account"
                                            : "Tambah Chart of Account",
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
                                  height: 16,
                                ),
                                Expanded(
                                    child: ListView(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Golongan Akun",
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
                                    DropdownSearch<String>(
                                      popupProps:
                                          const PopupPropsMultiSelection.menu(
                                        showSearchBox:
                                            true, // Aktifkan fitur pencarian
                                      ),
                                      selectedItem: value.golongan,
                                      items: value.listGol,
                                      itemAsString: (e) => "${e}",
                                      onChanged: (e) {
                                        value.pilihGolongan(e!);
                                      },
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        baseStyle: TextStyle(fontSize: 16),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: "Pilih Golongan Akun",
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
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Text(
                                          "Jenis Akun",
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
                                    DropdownSearch<String>(
                                      popupProps:
                                          const PopupPropsMultiSelection.menu(
                                        showSearchBox:
                                            true, // Aktifkan fitur pencarian
                                      ),
                                      selectedItem: value.jnsAcc,
                                      items: value.listJns,
                                      itemAsString: (e) => "${e}",
                                      onChanged: (e) {
                                        value.pilihJenis(e!);
                                      },
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        baseStyle: TextStyle(fontSize: 16),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: "Pilih Jenis Akun",
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
                                    const SizedBox(height: 16),
                                    value.jnsAcc == "Header"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "No. Header",
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "*",
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    child: TextFormField(
                                                      onChanged: (e) {
                                                        if (e.length == 3) {
                                                          value.updateHeader();
                                                        }
                                                      },
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      controller:
                                                          value.noHeader,
                                                      maxLines: 1,
                                                      maxLength: 3,
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
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Nomor Header",
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 16,
                                                  ),
                                                  Expanded(
                                                    child: TextFormField(
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      controller:
                                                          value.resulttext,
                                                      maxLines: 1,
                                                      readOnly: true,
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
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Nomor Header",
                                                        filled: true,
                                                        fillColor:
                                                            Colors.grey[200],
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Nama Header",
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "*",
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                controller: value.namaSbb,
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
                                                  hintText: "Nama Header",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                            ],
                                          )
                                        : value.jnsAcc == "Buku Besar"
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Pilih Header",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            fontSize: 8),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: DropdownSearch<
                                                            CoaModel>(
                                                          popupProps:
                                                              const PopupPropsMultiSelection
                                                                  .menu(
                                                            showSearchBox:
                                                                true, // Aktifkan fitur pencarian
                                                          ),
                                                          selectedItem:
                                                              value.header,
                                                          items: value.list
                                                              .where((e) =>
                                                                  e.jnsAcc ==
                                                                  "A")
                                                              .toList(),
                                                          itemAsString: (e) =>
                                                              "${e.namaSbb}",
                                                          onChanged: (e) {
                                                            value.pilihHeader(
                                                                e!);
                                                          },
                                                          dropdownDecoratorProps:
                                                              DropDownDecoratorProps(
                                                            baseStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        16),
                                                            textAlignVertical:
                                                                TextAlignVertical
                                                                    .center,
                                                            dropdownSearchDecoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Pilih Header",
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
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
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          controller:
                                                              value.noHeader,
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
                                                          decoration:
                                                              InputDecoration(
                                                            filled: true,
                                                            fillColor: Colors
                                                                .grey[200],
                                                            hintText:
                                                                "Nomor Header",
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
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
                                                        "No. Buku Besar",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            fontSize: 8),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        child: TextFormField(
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          controller:
                                                              value.noBb,
                                                          maxLength: 3,
                                                          maxLines: 1,
                                                          onChanged: (e) {
                                                            if (e.length == 3) {
                                                              value.updatebb();
                                                            }
                                                          },
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
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Nomor Buku Besar",
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Expanded(
                                                        child: TextFormField(
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          controller:
                                                              value.resulttext,
                                                          readOnly: true,
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
                                                          decoration:
                                                              InputDecoration(
                                                            fillColor: Colors
                                                                .grey[200],
                                                            filled: true,
                                                            hintText:
                                                                "Nomor Buku Besar",
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Nama Buku Besar",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            fontSize: 8),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  TextFormField(
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    controller: value.namaSbb,
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
                                                      hintText: "Nama SBB",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "Hutang dan Piutang "),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      value.gantiHutangPiutang(
                                                          "HUTANG");
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 16,
                                                          height: 16,
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .grey)),
                                                          child:
                                                              value.hutangPiutang ==
                                                                      "HUTANG"
                                                                  ? Container(
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color:
                                                                              colorPrimary),
                                                                    )
                                                                  : SizedBox(),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text("Hutang"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      value.gantiHutangPiutang(
                                                          "PIUTANG");
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 16,
                                                          height: 16,
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .grey)),
                                                          child:
                                                              value.hutangPiutang ==
                                                                      "PIUTANG"
                                                                  ? Container(
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color:
                                                                              colorPrimary),
                                                                    )
                                                                  : SizedBox(),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text("Piutang"),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Akun Perantara "),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Checkbox(
                                                          activeColor:
                                                              colorPrimary,
                                                          value:
                                                              value.perantara,
                                                          onChanged: (e) {
                                                            value
                                                                .gantiperantara();
                                                          })
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                ],
                                              )
                                            : value.jnsAcc == "Sub Buku Besar"
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      // Row(
                                                      //   children: [
                                                      //     Text(
                                                      //       "Pilih Header",
                                                      //       style:
                                                      //           const TextStyle(
                                                      //               fontSize:
                                                      //                   12),
                                                      //     ),
                                                      //     const SizedBox(
                                                      //         width: 5),
                                                      //     const Text(
                                                      //       "*",
                                                      //       style: TextStyle(
                                                      //           fontSize: 8),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      // const SizedBox(
                                                      //   height: 8,
                                                      // ),
                                                      // Row(
                                                      //   children: [
                                                      //     Expanded(
                                                      //       child:
                                                      //           DropdownSearch<
                                                      //               CoaModel>(
                                                      //         popupProps:
                                                      //             const PopupPropsMultiSelection
                                                      //                 .menu(
                                                      //           showSearchBox:
                                                      //               true, // Aktifkan fitur pencarian
                                                      //         ),
                                                      //         selectedItem:
                                                      //             value.header,
                                                      //         items: value.list
                                                      //             .where((e) =>
                                                      //                 e.jnsAcc ==
                                                      //                 "A")
                                                      //             .toList(),
                                                      //         itemAsString: (e) =>
                                                      //             "${e.namaSbb}",
                                                      //         onChanged: (e) {
                                                      //           value
                                                      //               .pilihHeader(
                                                      //                   e!);
                                                      //         },
                                                      //         dropdownDecoratorProps:
                                                      //             DropDownDecoratorProps(
                                                      //           baseStyle:
                                                      //               TextStyle(
                                                      //                   fontSize:
                                                      //                       16),
                                                      //           textAlignVertical:
                                                      //               TextAlignVertical
                                                      //                   .center,
                                                      //           dropdownSearchDecoration:
                                                      //               InputDecoration(
                                                      //             hintText:
                                                      //                 "Pilih Header",
                                                      //             border:
                                                      //                 OutlineInputBorder(
                                                      //               borderRadius:
                                                      //                   BorderRadius
                                                      //                       .circular(8),
                                                      //               borderSide:
                                                      //                   BorderSide(
                                                      //                 width: 1,
                                                      //                 color: Colors
                                                      //                     .grey,
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //     SizedBox(
                                                      //       width: 16,
                                                      //     ),
                                                      //     Container(
                                                      //       width: 150,
                                                      //       child:
                                                      //           TextFormField(
                                                      //         readOnly: true,
                                                      //         textInputAction:
                                                      //             TextInputAction
                                                      //                 .done,
                                                      //         controller: value
                                                      //             .noHeader,
                                                      //         maxLines: 1,
                                                      //         validator: (e) {
                                                      //           if (e!
                                                      //               .isEmpty) {
                                                      //             return "Wajib diisi";
                                                      //           } else {
                                                      //             return null;
                                                      //           }
                                                      //         },
                                                      //         decoration:
                                                      //             InputDecoration(
                                                      //           filled: true,
                                                      //           fillColor:
                                                      //               Colors.grey[
                                                      //                   200],
                                                      //           hintText:
                                                      //               "Nomor Header",
                                                      //           border:
                                                      //               OutlineInputBorder(
                                                      //             borderRadius:
                                                      //                 BorderRadius
                                                      //                     .circular(
                                                      //                         6),
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     )
                                                      //   ],
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 16,
                                                      // ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Pilih Buku Besar",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          const Text(
                                                            "*",
                                                            style: TextStyle(
                                                                fontSize: 8),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                DropdownSearch<
                                                                    CoaModel>(
                                                              popupProps:
                                                                  const PopupPropsMultiSelection
                                                                      .menu(
                                                                showSearchBox:
                                                                    true, // Aktifkan fitur pencarian
                                                              ),
                                                              selectedItem: value
                                                                  .bukuBesar,
                                                              items: value.list
                                                                  .where((e) =>
                                                                      e.jnsAcc ==
                                                                      "B")
                                                                  .toList(),
                                                              itemAsString: (e) =>
                                                                  "${e.namaSbb}",
                                                              onChanged: (e) {
                                                                value.pilihBB(
                                                                    e!);
                                                              },
                                                              dropdownDecoratorProps:
                                                                  DropDownDecoratorProps(
                                                                baseStyle:
                                                                    TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                textAlignVertical:
                                                                    TextAlignVertical
                                                                        .center,
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "Pilih Buku Besar",
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    borderSide:
                                                                        BorderSide(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Container(
                                                            width: 150,
                                                            child:
                                                                TextFormField(
                                                              // enabled: false,
                                                              readOnly: true,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              controller:
                                                                  value.noBb,
                                                              maxLines: 1,
                                                              // inputFormatters: [
                                                              //   FilteringTextInputFormatter.digitsOnly
                                                              // ],
                                                              validator: (e) {
                                                                if (e!
                                                                    .isEmpty) {
                                                                  return "Wajib diisi";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                filled: true,
                                                                fillColor:
                                                                    Colors.grey[
                                                                        200],
                                                                hintText:
                                                                    "Nomor Sub Buku Besar",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
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
                                                            "No. Sub Buku Besar",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          const Text(
                                                            "*",
                                                            style: TextStyle(
                                                                fontSize: 8),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child:
                                                                TextFormField(
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              controller:
                                                                  value.noSbb,
                                                              maxLines: 1,
                                                              onChanged: (e) {
                                                                if (e.length ==
                                                                    6) {
                                                                  value
                                                                      .updateSbb();
                                                                }
                                                              },
                                                              maxLength: 6,
                                                              // inputFormatters: [
                                                              //   FilteringTextInputFormatter.digitsOnly
                                                              // ],
                                                              validator: (e) {
                                                                if (e!
                                                                    .isEmpty) {
                                                                  return "Wajib diisi";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Nomor Sub Buku Besar",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                TextFormField(
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              controller: value
                                                                  .resulttext,
                                                              maxLines: 1,
                                                              readOnly: true,
                                                              // inputFormatters: [
                                                              //   FilteringTextInputFormatter.digitsOnly
                                                              // ],
                                                              validator: (e) {
                                                                if (e!
                                                                    .isEmpty) {
                                                                  return "Wajib diisi";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Nomor Header",
                                                                filled: true,
                                                                fillColor:
                                                                    Colors.grey[
                                                                        200],
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Nama Sub Buku Besar",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          const Text(
                                                            "*",
                                                            style: TextStyle(
                                                                fontSize: 8),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      TextFormField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        controller:
                                                            value.namaSbb,
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
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: "Nama SBB",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Limit Debet",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  const Text(
                                                                    "*",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            8),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              TextFormField(
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                controller: value
                                                                    .limitdebet,
                                                                maxLines: 1,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .digitsOnly,
                                                                  CurrencyInputFormatter(),
                                                                ],
                                                                validator: (e) {
                                                                  if (e!
                                                                      .isEmpty) {
                                                                    return "Wajib diisi";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "Limit Debet",
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 16),
                                                            ],
                                                          )),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                              child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Limit Kredit",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  const Text(
                                                                    "*",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            8),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              TextFormField(
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                controller: value
                                                                    .limitkredit,
                                                                maxLines: 1,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .digitsOnly,
                                                                  CurrencyInputFormatter(),
                                                                ],
                                                                validator: (e) {
                                                                  if (e!
                                                                      .isEmpty) {
                                                                    return "Wajib diisi";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "Limit Kredit",
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 16),
                                                            ],
                                                          )),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(),
                                    ButtonPrimary(
                                      onTap: () {
                                        value.cek();
                                      },
                                      name: "Simpan",
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        )
                      : SizedBox())
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(CoaNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  CoaNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<CoaModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(
                    columnName: 'gol_acc',
                    value: data.golAcc == "1"
                        ? "Aktiva"
                        : data.golAcc == "2"
                            ? "Pasiva"
                            : data.golAcc == "3"
                                ? "Pendapatan"
                                : "Biaya"),
                DataGridCell(
                    columnName: 'jns_acc',
                    value: data.jnsAcc == 'A'
                        ? "Header"
                        : data.jnsAcc == 'B'
                            ? "Buku Besar"
                            : "Sub Buku Besar"),
                DataGridCell(columnName: 'nobb', value: data.nobb),
                DataGridCell(columnName: 'nosbb', value: data.nosbb),
                DataGridCell(columnName: 'nama_sbb', value: data.namaSbb),
                DataGridCell(
                    columnName: 'type_posting', value: data.typePosting),
                DataGridCell(columnName: 'sbb_khusus', value: data.sbbKhusus),
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
