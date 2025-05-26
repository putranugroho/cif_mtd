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
                            onTap: () => value.confirmotorisasi(),
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
                                frozenColumnsCount: 2,

                                // controller: value.dataGridController,
                                gridLinesVisibility: GridLinesVisibility.both,
                                headerGridLinesVisibility:
                                    GridLinesVisibility.both,
                                selectionMode: SelectionMode.single,

                                source: DetailDataSource(value),
                                columns: <GridColumn>[
                                  GridColumn(
                                      width: 40,
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
                                      width: 120,
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
                                      width: 120,
                                      columnName: 'no_coa',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('No. COA',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 200,
                                      columnName: 'header',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Header',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 200,
                                      columnName: 'bukubesar',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Buku Besar',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 200,
                                      columnName: 'subbukubesar',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Sub Buku Besar',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 60,
                                      columnName: 'posting',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Posting',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 60,
                                      columnName: 'hutang',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Hutang',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 60,
                                      columnName: 'piutang',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Piutang',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 70,
                                      columnName: 'perantara',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Perantara',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      width: 80,
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
                                      width: 80,
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

                              // SfDataGrid(
                              //   headerRowHeight: 40,
                              //   defaultColumnWidth: 180,
                              //   frozenColumnsCount: 2,

                              //   // controller: value.dataGridController,
                              //   gridLinesVisibility: GridLinesVisibility.both,
                              //   headerGridLinesVisibility:
                              //       GridLinesVisibility.both,
                              //   selectionMode: SelectionMode.single,

                              //   source: DetailDataSource(value),
                              //   columns: <GridColumn>[
                              //     GridColumn(
                              //         width: 40,
                              //         columnName: 'no',
                              //         label: Container(
                              //             padding: EdgeInsets.all(6),
                              //             color: colorPrimary,
                              //             alignment: Alignment.center,
                              //             child: Text('No',
                              //                 style: TextStyle(
                              //                   fontWeight: FontWeight.w300,
                              //                   fontSize: 12,
                              //                   color: Colors.white,
                              //                 )))),
                              //     GridColumn(
                              //         columnName: 'gol_acc',
                              //         label: Container(
                              //             padding: EdgeInsets.all(6),
                              //             color: colorPrimary,
                              //             alignment: Alignment.center,
                              //             child: Text('Gol. Akun',
                              //                 style: TextStyle(
                              //                   fontWeight: FontWeight.w300,
                              //                   color: Colors.white,
                              //                   fontSize: 12,
                              //                 )))),
                              //     GridColumn(
                              //         width: 120,
                              //         columnName: 'jns_acc',
                              //         label: Container(
                              //             color: colorPrimary,
                              //             alignment: Alignment.center,
                              //             padding: EdgeInsets.all(6),
                              //             child: Text('Jenis Akun',
                              //                 style: TextStyle(
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.w300,
                              //                   color: Colors.white,
                              //                 )))),
                              //     GridColumn(
                              //         columnName: 'nobb',
                              //         label: Container(
                              //             padding: EdgeInsets.all(6),
                              //             color: colorPrimary,
                              //             alignment: Alignment.center,
                              //             child: Text('No. Buku Besar',
                              //                 style: TextStyle(
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.w300,
                              //                   color: Colors.white,
                              //                 )))),
                              //     GridColumn(
                              //         columnName: 'nosbb',
                              //         label: Container(
                              //             padding: EdgeInsets.all(6),
                              //             color: colorPrimary,
                              //             alignment: Alignment.center,
                              //             child: Text('No. Sub Buku Besar',
                              //                 style: TextStyle(
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.w300,
                              //                   color: Colors.white,
                              //                 )))),
                              //     GridColumn(
                              //         columnName: 'nama_sbb',
                              //         label: Container(
                              //             padding: EdgeInsets.all(6),
                              //             color: colorPrimary,
                              //             alignment: Alignment.center,
                              //             child: Text('Nama SBB',
                              //                 style: TextStyle(
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.w300,
                              //                   color: Colors.white,
                              //                 )))),
                              //     GridColumn(
                              //         width: 80,
                              //         columnName: 'sbb_khusus',
                              //         label: Container(
                              //             padding: EdgeInsets.all(6),
                              //             color: colorPrimary,
                              //             alignment: Alignment.center,
                              //             child: Text('SBB Khusus',
                              //                 style: TextStyle(
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.w300,
                              //                   color: Colors.white,
                              //                 )))),
                              //     GridColumn(
                              //         width: 60,
                              //         columnName: 'type_posting',
                              //         label: Container(
                              //             padding: EdgeInsets.all(6),
                              //             color: colorPrimary,
                              //             alignment: Alignment.center,
                              //             child: Text('Posting',
                              //                 style: TextStyle(
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.w300,
                              //                   color: Colors.white,
                              //                 )))),
                              //     GridColumn(
                              //         columnName: 'action',
                              //         width: 80,
                              //         label: Container(
                              //             color: colorPrimary,
                              //             padding: EdgeInsets.all(6),
                              //             alignment: Alignment.center,
                              //             child: Text('Action',
                              //                 style: TextStyle(
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.w300,
                              //                   color: Colors.white,
                              //                 )))),
                              //   ],
                              // ),
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
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Wajib diisi';
                                        }
                                        return null;
                                      },
                                      enabled: !value.editData,
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
                                          filled: value.editData,
                                          fillColor: Colors.grey[200],
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
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Wajib diisi';
                                        }
                                        return null;
                                      },
                                      enabled: !value.editData,
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
                                          filled: value.editData,
                                          fillColor: Colors.grey[200],
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
                                                      readOnly: value.editData,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      controller:
                                                          value.noHeader,
                                                      maxLines: 1,
                                                      maxLength: 3,
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
                                                      decoration:
                                                          InputDecoration(
                                                        filled: value.editData,
                                                        fillColor:
                                                            Colors.grey[200],
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
                                                          validator: (value) {
                                                            if (value == null) {
                                                              return 'Wajib diisi';
                                                            }
                                                            return null;
                                                          },
                                                          enabled:
                                                              !value.editData,
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
                                                              filled: value
                                                                  .editData,
                                                              fillColor: Colors
                                                                  .grey[200],
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
                                                          readOnly:
                                                              value.editData,
                                                          onChanged: (e) {
                                                            if (e.length == 3) {
                                                              value.updatebb();
                                                            }
                                                          },
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
                                                          decoration:
                                                              InputDecoration(
                                                            filled:
                                                                value.editData,
                                                            fillColor: Colors
                                                                .grey[200],
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
                                                          "Hutang atau Piutang "),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          value
                                                              .gantiHutangPiutang(
                                                                  "HUTANG");
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 16,
                                                              height: 16,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border.all(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .grey)),
                                                              child: value.hutangPiutang ==
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
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          value
                                                              .gantiHutangPiutang(
                                                                  "PIUTANG");
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 16,
                                                              height: 16,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border.all(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .grey)),
                                                              child: value.hutangPiutang ==
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
                                                      const SizedBox(
                                                        width: 32,
                                                      ),
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
                                                  // Row(
                                                  //   children: [
                                                  //     Text(
                                                  //         "Hutang atau Piutang "),
                                                  //     SizedBox(
                                                  //       width: 8,
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // SizedBox(
                                                  //   height: 8,
                                                  // ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     value.gantiHutangPiutang(
                                                  //         "HUTANG");
                                                  //   },
                                                  //   child: Row(
                                                  //     children: [
                                                  //       Container(
                                                  //         width: 16,
                                                  //         height: 16,
                                                  //         padding:
                                                  //             EdgeInsets.all(2),
                                                  //         decoration: BoxDecoration(
                                                  //             shape: BoxShape
                                                  //                 .circle,
                                                  //             color:
                                                  //                 Colors.white,
                                                  //             border: Border.all(
                                                  //                 width: 2,
                                                  //                 color: Colors
                                                  //                     .grey)),
                                                  //         child:
                                                  //             value.hutangPiutang ==
                                                  //                     "HUTANG"
                                                  //                 ? Container(
                                                  //                     decoration: BoxDecoration(
                                                  //                         shape: BoxShape
                                                  //                             .circle,
                                                  //                         color:
                                                  //                             colorPrimary),
                                                  //                   )
                                                  //                 : SizedBox(),
                                                  //       ),
                                                  //       SizedBox(
                                                  //         width: 8,
                                                  //       ),
                                                  //       Text("Hutang"),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                  // SizedBox(
                                                  //   height: 4,
                                                  // ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     value.gantiHutangPiutang(
                                                  //         "PIUTANG");
                                                  //   },
                                                  //   child: Row(
                                                  //     children: [
                                                  //       Container(
                                                  //         width: 16,
                                                  //         height: 16,
                                                  //         padding:
                                                  //             EdgeInsets.all(2),
                                                  //         decoration: BoxDecoration(
                                                  //             shape: BoxShape
                                                  //                 .circle,
                                                  //             color:
                                                  //                 Colors.white,
                                                  //             border: Border.all(
                                                  //                 width: 2,
                                                  //                 color: Colors
                                                  //                     .grey)),
                                                  //         child:
                                                  //             value.hutangPiutang ==
                                                  //                     "PIUTANG"
                                                  //                 ? Container(
                                                  //                     decoration: BoxDecoration(
                                                  //                         shape: BoxShape
                                                  //                             .circle,
                                                  //                         color:
                                                  //                             colorPrimary),
                                                  //                   )
                                                  //                 : SizedBox(),
                                                  //       ),
                                                  //       SizedBox(
                                                  //         width: 8,
                                                  //       ),
                                                  //       Text("Piutang"),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                  // SizedBox(
                                                  //   height: 16,
                                                  // ),
                                                  // Row(
                                                  //   children: [
                                                  //     Text("Akun Perantara "),
                                                  //     SizedBox(
                                                  //       width: 8,
                                                  //     ),
                                                  //     Checkbox(
                                                  //         activeColor:
                                                  //             colorPrimary,
                                                  //         value:
                                                  //             value.perantara,
                                                  //         onChanged: (e) {
                                                  //           value
                                                  //               .gantiperantara();
                                                  //         })
                                                  //   ],
                                                  // ),
                                                  // SizedBox(
                                                  //   height: 16,
                                                  // ),
                                                ],
                                              )
                                            : value.jnsAcc == "Sub Buku Besar"
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
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
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                    null) {
                                                                  return 'Wajib diisi';
                                                                }
                                                                return null;
                                                              },
                                                              enabled: !value
                                                                  .editData,
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
                                                                  filled: value
                                                                      .editData,
                                                                  fillColor:
                                                                      Colors.grey[
                                                                          200],
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
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly
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
                                                                filled: true,
                                                                fillColor:
                                                                    Colors.grey[
                                                                        200],
                                                                hintText:
                                                                    "Buku Besar",
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
                                                              readOnly: value
                                                                  .editData,
                                                              onChanged: (e) {
                                                                if (e.length ==
                                                                    6) {
                                                                  value
                                                                      .updateSbb();
                                                                }
                                                              },
                                                              maxLength: 6,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly
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
                                                                filled: value
                                                                    .editData,
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
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly
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
                                                                    "Nomor Sub Buku Besar",
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
                                                            "Pilih Type Posting",
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
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Radio(
                                                            activeColor:
                                                                colorPrimary,
                                                            value: "Y",
                                                            groupValue: value
                                                                .typePosting,
                                                            onChanged: (e) =>
                                                                value
                                                                    .gantiPosting(
                                                                        "Y"),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text("Yes"),
                                                          SizedBox(
                                                            width: 32,
                                                          ),
                                                          Radio(
                                                            activeColor:
                                                                colorPrimary,
                                                            value: "N",
                                                            groupValue: value
                                                                .typePosting,
                                                            onChanged: (e) =>
                                                                value
                                                                    .gantiPosting(
                                                                        "N"),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text("No"),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
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
                                                          Text(
                                                              "Hutang atau Piutang "),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Container(
                                                            width: 16,
                                                            height: 16,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    width: 2,
                                                                    color: Colors
                                                                        .grey)),
                                                            child:
                                                                value.hutangPiutang ==
                                                                        "HUTANG"
                                                                    ? Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: colorPrimary),
                                                                      )
                                                                    : SizedBox(),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text("Hutang"),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Container(
                                                            width: 16,
                                                            height: 16,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    width: 2,
                                                                    color: Colors
                                                                        .grey)),
                                                            child:
                                                                value.hutangPiutang ==
                                                                        "PIUTANG"
                                                                    ? Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: colorPrimary),
                                                                      )
                                                                    : SizedBox(),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text("Piutang"),
                                                          const SizedBox(
                                                            width: 32,
                                                          ),
                                                          Text(
                                                              "Akun Perantara "),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Checkbox(
                                                              activeColor:
                                                                  colorPrimary,
                                                              value: value
                                                                  .perantara,
                                                              onChanged: (e) {})
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     Expanded(
                                                      //         child: Column(
                                                      //       crossAxisAlignment:
                                                      //           CrossAxisAlignment
                                                      //               .stretch,
                                                      //       children: [
                                                      //         Row(
                                                      //           children: [
                                                      //             Text(
                                                      //               "Limit Debet",
                                                      //               style: const TextStyle(
                                                      //                   fontSize:
                                                      //                       12),
                                                      //             ),
                                                      //           ],
                                                      //         ),
                                                      //         const SizedBox(
                                                      //           height: 8,
                                                      //         ),
                                                      //         TextFormField(
                                                      //           textInputAction:
                                                      //               TextInputAction
                                                      //                   .done,
                                                      //           controller: value
                                                      //               .limitdebet,
                                                      //           maxLines: 1,
                                                      //           inputFormatters: [
                                                      //             FilteringTextInputFormatter
                                                      //                 .digitsOnly,
                                                      //             CurrencyInputFormatter(),
                                                      //           ],
                                                      //           decoration:
                                                      //               InputDecoration(
                                                      //             hintText:
                                                      //                 "Limit Debet",
                                                      //             border:
                                                      //                 OutlineInputBorder(
                                                      //               borderRadius:
                                                      //                   BorderRadius
                                                      //                       .circular(6),
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //         const SizedBox(
                                                      //             height: 16),
                                                      //       ],
                                                      //     )),
                                                      //     SizedBox(
                                                      //       width: 16,
                                                      //     ),
                                                      //     Expanded(
                                                      //         child: Column(
                                                      //       crossAxisAlignment:
                                                      //           CrossAxisAlignment
                                                      //               .stretch,
                                                      //       children: [
                                                      //         Row(
                                                      //           children: [
                                                      //             Text(
                                                      //               "Limit Kredit",
                                                      //               style: const TextStyle(
                                                      //                   fontSize:
                                                      //                       12),
                                                      //             ),
                                                      //           ],
                                                      //         ),
                                                      //         const SizedBox(
                                                      //           height: 8,
                                                      //         ),
                                                      //         TextFormField(
                                                      //           textInputAction:
                                                      //               TextInputAction
                                                      //                   .done,
                                                      //           controller: value
                                                      //               .limitkredit,
                                                      //           maxLines: 1,
                                                      //           inputFormatters: [
                                                      //             FilteringTextInputFormatter
                                                      //                 .digitsOnly,
                                                      //             CurrencyInputFormatter(),
                                                      //           ],
                                                      //           decoration:
                                                      //               InputDecoration(
                                                      //             hintText:
                                                      //                 "Limit Kredit",
                                                      //             border:
                                                      //                 OutlineInputBorder(
                                                      //               borderRadius:
                                                      //                   BorderRadius
                                                      //                       .circular(6),
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //         const SizedBox(
                                                      //             height: 16),
                                                      //       ],
                                                      //     )),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  )
                                                : SizedBox(),
                                    value.jnsAcc == null
                                        ? SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              ButtonPrimary(
                                                onTap: () {
                                                  value.cek();
                                                },
                                                name: value.editData
                                                    ? "Simpan Perubahan"
                                                    : "Simpan",
                                              ),
                                              value.editData
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        const SizedBox(
                                                            height: 16),
                                                        ButtonSecondary(
                                                          onTap: () {
                                                            value.cek();
                                                          },
                                                          name: "Tutup Akun",
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
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
    buildRowsFromJson(value.listJson);
  }

  CoaNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowsFromJson(List<dynamic> data) {
    int index = 0;
    List<DataGridRow> rows = [];

    void traverse(Map<String, dynamic> node, int level,
        {String? rootHeader, String? bukuBesar, String? subBukuBesar}) {
      String namaSbb = node['nama_sbb'];
      String golAcc = node['gol_acc'];
      String posting = node['type_posting'];
      String akun_perantara = node['akun_perantara'];
      String nosbb = node['nosbb'];
      String jnsAcc = node['jns_acc'];
      String hutang = node['hutang'];
      String piutang = node['piutang'];

      final currentHeader = rootHeader ?? namaSbb;

      String? currentBukuBesar = jnsAcc == 'B' ? namaSbb : bukuBesar;
      String? currentSubBukuBesar = jnsAcc == 'C' ? namaSbb : subBukuBesar;

      rows.add(DataGridRow(cells: [
        DataGridCell(columnName: 'no', value: (++index).toString()),
        DataGridCell(
          columnName: 'gol_acc',
          value: golAcc == "1"
              ? "Aktiva"
              : golAcc == "2"
                  ? "Pasiva"
                  : golAcc == "3"
                      ? "Pendapatan"
                      : "Biaya",
        ),
        DataGridCell(columnName: 'no_coa', value: nosbb),
        DataGridCell(columnName: 'header', value: currentHeader),
        DataGridCell(columnName: 'bukubesar', value: currentBukuBesar ?? ''),
        DataGridCell(
            columnName: 'subbukubesar', value: currentSubBukuBesar ?? ''),
        DataGridCell(columnName: 'posting', value: posting),
        DataGridCell(columnName: 'hutang', value: hutang),
        DataGridCell(columnName: 'piutang', value: piutang),
        DataGridCell(columnName: 'perantara', value: akun_perantara),
        DataGridCell(columnName: 'sbb_khusus', value: ''),
        DataGridCell(columnName: 'action', value: nosbb),
      ]));

      // Rekursif ke anak-anak
      if (node['children'] != null && node['children'].isNotEmpty) {
        for (var child in node['children']) {
          traverse(child, level + 1,
              rootHeader: currentHeader,
              bukuBesar: currentBukuBesar,
              subBukuBesar: currentSubBukuBesar);
        }
      }
    }

    for (var root in data) {
      traverse(root, 0);
    }

    // Sort by gol_acc ascending, then no_coa descending
    rows.sort((a, b) {
      // final golAccA =
      //     a.getCells().firstWhere((c) => c.columnName == 'gol_acc').value;
      // final golAccB =
      //     b.getCells().firstWhere((c) => c.columnName == 'gol_acc').value;
      // final cmp = golAccA.compareTo(golAccB);
      // if (cmp != 0) return cmp;

      final coaA =
          a.getCells().firstWhere((c) => c.columnName == 'no_coa').value;
      final coaB =
          b.getCells().firstWhere((c) => c.columnName == 'no_coa').value;
      return coaA.compareTo(coaB);
    });

    _laporanData = rows;
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
        } else if (e.columnName == 'posting' ||
            e.columnName == 'hutang' ||
            e.columnName == 'piutang' ||
            e.columnName == 'perantara') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
