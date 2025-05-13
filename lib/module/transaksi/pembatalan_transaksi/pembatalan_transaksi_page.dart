import 'package:accounting/models/index.dart';
import 'package:accounting/module/transaksi/pembatalan_transaksi/pembatalan_transaksi_notifier.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart' as a;

import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/currency_formatted.dart';
// import 'package:accounting/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';
import '../../../utils/format_currency.dart';

class PembatalanTransaksiPage extends StatelessWidget {
  const PembatalanTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PembatalanTransaksiNotifier(context: context),
      child: Consumer<PembatalanTransaksiNotifier>(
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
                        child: Text(
                          "Pembatalan Transaksi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
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
                                      Text(
                                        "Cari Transaksi",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 16),
                                      Row(
                                        children: [
                                          Radio(
                                            value: true,
                                            groupValue: value.cariTrans,
                                            activeColor: colorPrimary,
                                            onChanged: (e) =>
                                                value.pilihCariTransaksi(true),
                                          ),
                                          const Text("Hari Ini"),
                                          const SizedBox(width: 16),
                                          Radio(
                                            value: false,
                                            groupValue: value.cariTrans,
                                            activeColor: colorPrimary,
                                            onChanged: (e) =>
                                                value.pilihCariTransaksi(false),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => value.tanggalTransaksi(),
                                          child: TextFormField(
                                            enabled: false,
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: value.tglTransaksi,
                                            maxLines: 1,
                                            readOnly: value.cariTrans,
                                            validator: (e) {
                                              if (e!.isEmpty) {
                                                return "Wajib diisi";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              filled: value.cariTrans,
                                              fillColor: Colors.grey[200],
                                              hintText: "Tanggal Transaksi",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 16),

                                // TextField Tanggal
                                // Expanded(
                                //   flex: 4,
                                //   child:
                                // ),

                                const SizedBox(width: 16),

                                // Checkbox + No Dokumen
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        activeColor: colorPrimary,
                                        value: value.cariDok,
                                        onChanged: (e) => value.gantiCariDok(),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: TextFormField(
                                          textInputAction: TextInputAction.done,
                                          readOnly: !value.cariDok,
                                          validator: (e) {
                                            if (e!.isEmpty)
                                              return "Wajib diisi";
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: "No. Dokumen",
                                            filled: !value.cariDok,
                                            fillColor: Colors.grey[200],
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 16),

                                // Tombol Cari
                                InkWell(
                                  onTap: () => value.tambah(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: colorPrimary,
                                      border: Border.all(
                                          width: 2, color: colorPrimary),
                                    ),
                                    child: const Text(
                                      "Cari",
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
                                  columnName: 'tgl_trans',
                                  label: Container(
                                      padding: const EdgeInsets.all(6),
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      child: const Text('Tanggal',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  columnName: 'nomor_dok',
                                  label: Container(
                                      padding: const EdgeInsets.all(6),
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      child: const Text('No Dokumen',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                            fontSize: 12,
                                          )))),
                              GridColumn(
                                  columnName: 'nomor_ref',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(6),
                                      child: const Text('No Referensi',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  columnName: 'nominal',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(6),
                                      child: const Text('Nominal',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  columnName: 'debet_acc',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(6),
                                      child: const Text('Akun Debet',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  columnName: 'credit_acc',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(6),
                                      child: const Text('Akun Kredit',
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
                                      child: const Text('keterangan',
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
                          padding: EdgeInsets.all(20),
                          width: 600,
                          decoration: BoxDecoration(color: Colors.white),
                          child: FocusTraversalGroup(
                            child: Form(
                              key: value.keyForm,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Pembatalan Transaksi",
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
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              shape: BoxShape.circle),
                                          child: Icon(Icons.close),
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
                                            "Tanggal Transaksi",
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
                                        readOnly: true,
                                        validator: (e) {
                                          if (e!.isEmpty) return "Wajib diisi";
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Tgl Transaksi",
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "No. Dokumen",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
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
                                                  controller: value.noDok,
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
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                    hintText: "No. Dokumen",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "No. Referensi",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
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
                                                  controller: value.noRef,
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
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                    hintText: "No. Referensi",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Akun Debet",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
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
                                                  controller: value.akunDebit,
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  obscureText: true,
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
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                    hintText: "Akun Debet",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Akun Kredit",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
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
                                                  controller: value.akunKredit,
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  obscureText: true,
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
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                    hintText: "Akun Kredit",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "SBB Debet",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
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
                                                  controller: value.sbbDebit,
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  obscureText: true,
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
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                    hintText: "SBB Debet",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "SBB Kredit",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
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
                                                  controller: value.sbbKredit,
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  obscureText: true,
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
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                    hintText: "SBB Kredit",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            "Nominal",
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
                                        controller: value.nominal,
                                        maxLines: 1,
                                        readOnly: true,
                                        obscureText: true,
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
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          hintText: "Nominal",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            "Keterangan",
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
                                        controller: value.keterangan,
                                        maxLines: 1,
                                        readOnly: true,
                                        obscureText: true,
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
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          hintText: "Keterangan",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "AO Debet",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
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
                                                  controller: value.aoDebit,
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  obscureText: true,
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
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                    hintText: "AO Debet",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "AO Kredit",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
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
                                                  controller: value.aoKredit,
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  obscureText: true,
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
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                    hintText: "AO Kredit",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            "Alasan Pembatalan",
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
                                        controller: value.alasan,
                                        maxLines: 1,
                                        obscureText: true,
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
                                          hintText: "Alasan Pembatalan",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          const SizedBox(height: 16),
                                          ButtonDanger(
                                            onTap: () {
                                              value.confirm();
                                            },
                                            name: "Proses Pembatalan",
                                          ),
                                        ],
                                      ),
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
