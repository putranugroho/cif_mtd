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
                        child: Row(
                          children: [
                            Text(
                              "Pembatalan Transaksi",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white),
                        child: FocusTraversalGroup(
                          child: Form(
                            key: value.searchForm,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Label + Radio + Tanggal Valuta
                                Flexible(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Cari Transaksi",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 16),
                                      Radio(
                                        value: true,
                                        groupValue: value.cariTrans,
                                        activeColor: colorPrimary,
                                        onChanged: (e) =>
                                            value.pilihCariTransaksi(true),
                                      ),
                                      const Text("Input Hari Ini"),
                                      const SizedBox(width: 16),
                                      Radio(
                                        value: false,
                                        groupValue: value.cariTrans,
                                        activeColor: colorPrimary,
                                        onChanged: (e) =>
                                            value.pilihCariTransaksi(false),
                                      ),
                                      const Text("Tgl Valuta"),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                        width: 180,
                                        child: TextFormField(
                                          enabled: !value.cariTrans,
                                          readOnly: true,
                                          onTap: () => value.tanggalTransaksi(),
                                          controller: value.tglTransaksi,
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
                                            hintText: "Tanggal Valuta",
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

                                const SizedBox(width: 24),

                                // Checkbox + No. Dokumen
                                Flexible(
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        activeColor: colorPrimary,
                                        value: value.cariDok,
                                        onChanged: (e) => value.gantiCariDok(),
                                      ),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: 180,
                                        child: TextFormField(
                                          readOnly: !value.cariDok,
                                          validator: (e) =>
                                              e!.isEmpty ? "Wajib diisi" : null,
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

                                const SizedBox(width: 24),

                                // Tombol Cari
                                ElevatedButton(
                                  onPressed: () => value.cariSekarang(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorPrimary,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text("Cari",
                                      style: TextStyle(color: Colors.white)),
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
                                  columnName: 'tgl_val',
                                  label: Container(
                                      padding: EdgeInsets.all(6),
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      child: Text('Tanggal Valuta',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                            fontSize: 12,
                                          )))),
                              GridColumn(
                                  width: 100,
                                  columnName: 'tgl_trans',
                                  label: Container(
                                      padding: EdgeInsets.all(6),
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      child: Text('Tanggal Input',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                            fontSize: 12,
                                          )))),
                              GridColumn(
                                  width: 120,
                                  columnName: 'nomor_dok',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(6),
                                      child: Text('Nomor Dokumen',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  width: 120,
                                  columnName: 'nomor_ref',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(6),
                                      child: Text('Nomor Referensi',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  width: 150,
                                  columnName: 'nominal',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(6),
                                      child: Text('Nominal',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  width: 200,
                                  columnName: 'nama_debet',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(6),
                                      child: Text('Nama Akun Debet',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  width: 200,
                                  columnName: 'nama_credit',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(6),
                                      child: Text('Nama Akun Kredit',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  width: 200,
                                  columnName: 'keterangan',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(6),
                                      child: Text('Keterangan',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  width: 120,
                                  columnName: 'debet_acc',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(6),
                                      child: Text('Akun Debet',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          )))),
                              GridColumn(
                                  width: 120,
                                  columnName: 'credit_acc',
                                  label: Container(
                                      color: colorPrimary,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(6),
                                      child: Text('Akun Kredit',
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
                                            "Tanggal Valuta",
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
                                        controller: value.tglTransaksi,
                                        decoration: InputDecoration(
                                          hintText: "Tgl Valuta",
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

                                                  // inputFormatters: [
                                                  //   FilteringTextInputFormatter.digitsOnly
                                                  // ],
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

                                                  // inputFormatters: [
                                                  //   FilteringTextInputFormatter.digitsOnly
                                                  // ],
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

                                                  // inputFormatters: [
                                                  //   FilteringTextInputFormatter.digitsOnly
                                                  // ],
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

                                                  // inputFormatters: [
                                                  //   FilteringTextInputFormatter.digitsOnly
                                                  // ],
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

                                        // inputFormatters: [
                                        //   FilteringTextInputFormatter.digitsOnly
                                        // ],
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

                                        // inputFormatters: [
                                        //   FilteringTextInputFormatter.digitsOnly
                                        // ],
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

                                                  // inputFormatters: [
                                                  //   FilteringTextInputFormatter.digitsOnly
                                                  // ],
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

                                                  // inputFormatters: [
                                                  //   FilteringTextInputFormatter.digitsOnly
                                                  // ],
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
                                      Row(
                                        children: [
                                          Text(
                                            "Tanggal Pembatalan",
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
                                      InkWell(
                                        onTap: () => value.tanggalPenjualan(),
                                        child: TextFormField(
                                          textInputAction: TextInputAction.done,
                                          enabled: false,
                                          controller: value.tglPenjualan,
                                          style: const TextStyle(
                                            // Make text bigger and black
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          validator: (e) {
                                            if (e!.isEmpty)
                                              return "Wajib diisi";
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Tgl Pembatalan",
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade600),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
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
  DetailDataSource(PembatalanTransaksiNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listTransaksi);
  }

  PembatalanTransaksiNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<TransaksiModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'tgl_val', value: data.tglVal),
                DataGridCell(columnName: 'tgl_trans', value: data.tglTrans),
                DataGridCell(columnName: 'nomor_dok', value: data.nomorDok),
                DataGridCell(columnName: 'nomor_ref', value: data.nomorRef),
                DataGridCell(
                    columnName: 'nominal',
                    value: FormatCurrency.oCcyDecimal
                        .format(double.parse(data.nominal))),
                DataGridCell(columnName: 'nama_debet', value: data.namaDebet),
                DataGridCell(columnName: 'nama_credit', value: data.namaCredit),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
                DataGridCell(columnName: 'debet_acc', value: data.debetAcc),
                DataGridCell(columnName: 'credit_acc', value: data.creditAcc),
                DataGridCell(columnName: 'action', value: data.nomorDok),
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
              onTap: () {},
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
        } else if (e.columnName == 'nominal') {
          return Container(
            alignment: Alignment.centerRight,
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
