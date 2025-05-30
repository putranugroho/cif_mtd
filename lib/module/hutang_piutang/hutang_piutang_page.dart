import 'package:accounting/models/index.dart';
import 'package:accounting/module/hutang_piutang/hutang_piutang_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart' as a;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/colors.dart';
import '../../utils/pro_shimmer.dart';

class HutangPiutangPage extends StatelessWidget {
  final int tipe;

  const HutangPiutangPage({
    super.key,
    required this.tipe,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HutangPiutangNotifier(
        context: context,
        tipe: tipe,
      ),
      child: Consumer<HutangPiutangNotifier>(
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
                              child: Row(
                            children: [
                              Text(
                                "Kelola Hutang / Piutang",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                            ],
                          )),
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
                                "Tambah Hutang/Piutang",
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
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: FocusTraversalGroup(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Label + Radio Buttons
                            Expanded(
                              flex: 5,
                              child: Row(
                                children: [
                                  Text(
                                    "Jenis Transaksi",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 16),
                                  Row(
                                    children: [
                                      Radio(
                                        value: true,
                                        groupValue: value.jenisTrans,
                                        activeColor: colorPrimary,
                                        onChanged: (e) =>
                                            value.pilihJenisTransaksi(true),
                                      ),
                                      const Text(
                                        "Hutang",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(width: 16),
                                      Radio(
                                        value: false,
                                        groupValue: value.jenisTrans,
                                        activeColor: colorPrimary,
                                        onChanged: (e) =>
                                            value.pilihJenisTransaksi(false),
                                      ),
                                      const Text(
                                        "Piutang",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                                      columnName: 'cussup',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Customer/Supplier',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'kontrak',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('No. Kontrak',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'invoice',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('No. Invoice',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'transaksi',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Nilai Transaksi',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'kewajiban',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Sisa Kewajiban',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  // Cust/Supp	No Kontrak	No Invoice	Nilai Transaksi	Sisa Kewajiban	cara bayar	Jk Waktu
                                  GridColumn(
                                      columnName: 'carabayar',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Cara Bayar',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'jangkawaktu',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Jangka Waktu',
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
                                          child: Text('Lihat',
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
                  left: 0,
                  child: value.dialog
                      ? Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      value.editData
                                          ? "Ubah / Hapus Hutang/Piutang"
                                          : "Tambah Hutang/Piutang",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child:
                                                  Text("Pilih Jenis Transaksi"),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  "Pilih ${value.jenis == 1 ? "Customer" : "Supplier"}"),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text("Alamat"),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text("Nomor"),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text("No Referensi"),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text("Nilai Transaksi"),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text("SBB"),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text("Cara Pembayaran"),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            value.caraPembayaran == "BERTAHAP"
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child:
                                                            Text("Cara Bayar"),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            "Jangka Waktu"),
                                                      ),
                                                    ],
                                                  )
                                                : SizedBox(),
                                            SizedBox(
                                              height: 24,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 32,
                                      ),
                                      Expanded(
                                          child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                        value: 1,
                                                        activeColor:
                                                            colorPrimary,
                                                        groupValue: value.jenis,
                                                        onChanged: (e) {
                                                          value.gantijenis(1);
                                                        }),
                                                    Text("Piutang"),
                                                    SizedBox(
                                                      width: 32,
                                                    ),
                                                    Radio(
                                                        value: 2,
                                                        groupValue: value.jenis,
                                                        activeColor:
                                                            colorPrimary,
                                                        onChanged: (e) {
                                                          value.gantijenis(2);
                                                        }),
                                                    Text("Hutang"),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TypeAheadField<
                                                          CustomerSupplierModel>(
                                                        controller: value
                                                            .customersupplier,
                                                        suggestionsCallback:
                                                            (search) => value
                                                                .getCustomerSupplierQuery(
                                                                    search),
                                                        builder: (context,
                                                            controller,
                                                            focusNode) {
                                                          return TextField(
                                                              controller:
                                                                  controller,
                                                              focusNode:
                                                                  focusNode,
                                                              autofocus: true,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                labelText:
                                                                    'Cari ${value.jenis == 1 ? "Customer" : "Supplier"}',
                                                              ));
                                                        },
                                                        itemBuilder:
                                                            (context, city) {
                                                          return ListTile(
                                                            title: Text(
                                                                city.nmSif),
                                                            subtitle: Text(
                                                                city.noSif),
                                                          );
                                                        },
                                                        onSelected: (city) {
                                                          // value.selectInvoice(city);
                                                          value
                                                              .pilihCustomerSupplier(
                                                                  city);
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller: value.ao,
                                                        readOnly: true,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "AO Marketing",
                                                          filled: true,
                                                          fillColor:
                                                              Colors.grey[200],
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            value.alamat,
                                                        readOnly: true,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: "Alamat",
                                                          filled: true,
                                                          fillColor:
                                                              Colors.grey[200],
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Text("Invoice"),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            value.noinvoice,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "No Invoice",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 32,
                                                    ),
                                                    Text("Kontrak"),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                TextFormField(
                                                              controller: value
                                                                  .nokontrak,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "No Kontrak",
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
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () => value
                                                                  .pilihTanggalKontrak(),
                                                              child:
                                                                  TextFormField(
                                                                enabled: false,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                controller: value
                                                                    .tanggalKontrak,
                                                                style:
                                                                    const TextStyle(
                                                                  // Make text bigger and black
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "Tanggal Kontrak",
                                                                  hintStyle: const TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                  disabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            value.noreferensi,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text("Keterangan"),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                TextFormField(
                                                              controller: value
                                                                  .keterangan,
                                                              decoration:
                                                                  InputDecoration(
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
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        onChanged: (e) {
                                                          value.changeTotal();
                                                        },
                                                        controller: value
                                                            .nilaitransaksi,
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        inputFormatters: [
                                                          a.CurrencyInputFormatter(
                                                            leadingSymbol:
                                                                'Rp ',
                                                            useSymbolPadding:
                                                                true,
                                                            thousandSeparator: a
                                                                .ThousandSeparator
                                                                .Period,
                                                            mantissaLength:
                                                                2, // jumlah angka desimal
                                                            // decimalSeparator: DecimalSeparator.Comma,
                                                          ),
                                                        ],
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            value.nilaippn,
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        inputFormatters: [
                                                          a.CurrencyInputFormatter(
                                                            leadingSymbol:
                                                                'Rp ',
                                                            useSymbolPadding:
                                                                true,
                                                            thousandSeparator: a
                                                                .ThousandSeparator
                                                                .Period,
                                                            mantissaLength:
                                                                2, // jumlah angka desimal
                                                            // decimalSeparator: DecimalSeparator.Comma,
                                                          ),
                                                        ],
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            value.nilaipph,
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        inputFormatters: [
                                                          a.CurrencyInputFormatter(
                                                            leadingSymbol:
                                                                'Rp ',
                                                            useSymbolPadding:
                                                                true,
                                                            thousandSeparator: a
                                                                .ThousandSeparator
                                                                .Period,
                                                            mantissaLength:
                                                                2, // jumlah angka desimal
                                                            // decimalSeparator: DecimalSeparator.Comma,
                                                          ),
                                                        ],
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),

                                            // ambil SBB
                                            Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TypeAheadField<
                                                          InqueryGlModel>(
                                                        controller: value
                                                            .namaakuntransaksi,
                                                        suggestionsCallback:
                                                            (search) => value
                                                                .getInquery(
                                                                    search),
                                                        builder: (context,
                                                            controller,
                                                            focusNode) {
                                                          return TextField(
                                                              controller:
                                                                  controller,
                                                              focusNode:
                                                                  focusNode,
                                                              autofocus: true,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                labelText:
                                                                    'Cari Akun',
                                                              ));
                                                        },
                                                        itemBuilder:
                                                            (context, city) {
                                                          return ListTile(
                                                            title: Text(
                                                                city.nosbb),
                                                            subtitle: Text(
                                                                city.namaSbb),
                                                          );
                                                        },
                                                        onSelected: (city) {
                                                          // value.selectInvoice(city);
                                                          value
                                                              .pilihAkunTransaksi(
                                                                  city);
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: TypeAheadField<
                                                          InqueryGlModel>(
                                                        controller:
                                                            value.namaakunpajak,
                                                        suggestionsCallback:
                                                            (search) => value
                                                                .getInquery(
                                                                    search),
                                                        builder: (context,
                                                            controller,
                                                            focusNode) {
                                                          return TextField(
                                                              controller:
                                                                  controller,
                                                              focusNode:
                                                                  focusNode,
                                                              autofocus: true,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                labelText:
                                                                    'Cari Akun PPN',
                                                              ));
                                                        },
                                                        itemBuilder:
                                                            (context, city) {
                                                          return ListTile(
                                                            title: Text(
                                                                city.nosbb),
                                                            subtitle: Text(
                                                                city.namaSbb),
                                                          );
                                                        },
                                                        onSelected: (city) {
                                                          // value.selectInvoice(city);
                                                          value.pilihAkunPajak(
                                                              city);
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: TypeAheadField<
                                                          InqueryGlModel>(
                                                        controller:
                                                            value.namaakunpph,
                                                        suggestionsCallback:
                                                            (search) => value
                                                                .getInquery(
                                                                    search),
                                                        builder: (context,
                                                            controller,
                                                            focusNode) {
                                                          return TextField(
                                                              controller:
                                                                  controller,
                                                              focusNode:
                                                                  focusNode,
                                                              autofocus: true,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                labelText:
                                                                    'Cari Akun PPH',
                                                              ));
                                                        },
                                                        itemBuilder:
                                                            (context, city) {
                                                          return ListTile(
                                                            title: Text(
                                                                city.nosbb),
                                                            subtitle: Text(
                                                                city.namaSbb),
                                                          );
                                                        },
                                                        onSelected: (city) {
                                                          // value.selectInvoice(city);
                                                          value.pilihAkunPph(
                                                              city);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Row(
                                                      children: [
                                                        Radio(
                                                            value: "BERTAHAP",
                                                            groupValue: value
                                                                .caraPembayaran,
                                                            onChanged: (e) {
                                                              value.ganticaraPembayaran(
                                                                  "BERTAHAP");
                                                            }),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text("Bertahap"),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        Radio(
                                                            value: "SELURUHNYA",
                                                            groupValue: value
                                                                .caraPembayaran,
                                                            onChanged: (e) {
                                                              value.ganticaraPembayaran(
                                                                  "SELURUHNYA");
                                                            }),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text("Seluruhnya"),
                                                        SizedBox(
                                                          width: 32,
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  "Tanggal Jatuh Tempo"),
                                                              SizedBox(
                                                                width: 16,
                                                              ),
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: () => value
                                                                      .pilihJatuhTempo(),
                                                                  child:
                                                                      TextFormField(
                                                                    enabled: value.caraPembayaran ==
                                                                            "BERTAHAP"
                                                                        ? true
                                                                        : false,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .done,
                                                                    controller:
                                                                        value
                                                                            .tanggalJatuhTempoText,
                                                                    maxLines: 1,
                                                                    readOnly: value.caraPembayaran ==
                                                                            "BERTAHAP"
                                                                        ? true
                                                                        : false,
                                                                    style:
                                                                        const TextStyle(
                                                                      // Make text bigger and black
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                    validator:
                                                                        (e) {
                                                                      if (e!
                                                                          .isEmpty) {
                                                                        return "Wajib diisi";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      filled: value.caraPembayaran ==
                                                                              "BERTAHAP"
                                                                          ? true
                                                                          : false,
                                                                      fillColor:
                                                                          Colors
                                                                              .grey[200],
                                                                      hintText:
                                                                          "Tanggal Jatuh Tempo",
                                                                      hintStyle:
                                                                          const TextStyle(
                                                                              color: Colors.grey),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(6),
                                                                      ),
                                                                      disabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.grey.shade600),
                                                                        borderRadius:
                                                                            BorderRadius.circular(6),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            value.caraPembayaran == "BERTAHAP"
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Baris pertama: radio-radio
                                                      Container(
                                                        height: 40,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Row(
                                                          children: [
                                                            // Radio Auto / Tagihan
                                                            Row(
                                                              children: [
                                                                Radio(
                                                                  value: true,
                                                                  groupValue: value
                                                                      .carabayar,
                                                                  onChanged:
                                                                      (e) => value
                                                                          .ganticarabayar(),
                                                                ),
                                                                const SizedBox(
                                                                    width: 8),
                                                                const Text(
                                                                    "Auto"),
                                                                const SizedBox(
                                                                    width: 16),
                                                                Radio(
                                                                  value: false,
                                                                  groupValue: value
                                                                      .carabayar,
                                                                  onChanged:
                                                                      (e) => value
                                                                          .ganticarabayar(),
                                                                ),
                                                                const SizedBox(
                                                                    width: 8),
                                                                const Text(
                                                                    "Tagihan"),
                                                              ],
                                                            ),

                                                            const SizedBox(
                                                                width: 32),

                                                            // Tagihan Bulanan
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  const Text(
                                                                      "Tagihan Bulanan"),
                                                                  const SizedBox(
                                                                      width:
                                                                          16),
                                                                  Radio(
                                                                    value: true,
                                                                    groupValue:
                                                                        value
                                                                            .tagihanbulanan,
                                                                    onChanged:
                                                                        (e) => value
                                                                            .gantitagitahnbulanan(),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  const Text(
                                                                      "Ya"),
                                                                  const SizedBox(
                                                                      width:
                                                                          16),
                                                                  Radio(
                                                                    value:
                                                                        false,
                                                                    groupValue:
                                                                        value
                                                                            .tagihanbulanan,
                                                                    onChanged:
                                                                        (e) => value
                                                                            .gantitagitahnbulanan(),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  const Text(
                                                                      "Tidak"),
                                                                ],
                                                              ),
                                                            ),

                                                            const SizedBox(
                                                                width: 32),

                                                            // PPH/PPN
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  const Text(
                                                                      "PPN/PPH"),
                                                                  const SizedBox(
                                                                      width:
                                                                          16),
                                                                  Radio(
                                                                    value: true,
                                                                    groupValue:
                                                                        value
                                                                            .pphppn,
                                                                    onChanged:
                                                                        (e) => value
                                                                            .gantipphppn(),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  const Text(
                                                                      "Proporsional"),
                                                                  const SizedBox(
                                                                      width:
                                                                          16),
                                                                  Radio(
                                                                    value:
                                                                        false,
                                                                    groupValue:
                                                                        value
                                                                            .pphppn,
                                                                    onChanged:
                                                                        (e) => value
                                                                            .gantipphppn(),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  const Text(
                                                                      "Diakhir"),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                          height: 16),

                                                      // Baris kedua: jangka waktu dan tanggal jatuh tempo
                                                      Container(
                                                        height: 40,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Row(
                                                          children: [
                                                            // Jangka Waktu
                                                            SizedBox(
                                                              width: 100,
                                                              child:
                                                                  TextFormField(
                                                                controller: value
                                                                    .jangkawaktu,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    borderSide: const BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            const SizedBox(
                                                                width: 32),

                                                            // Tanggal Jatuh Tempo Pertama
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  value
                                                                      .pilihTanggalJatuhTempoPertama();
                                                                },
                                                                child:
                                                                    TextFormField(
                                                                  enabled:
                                                                      false,
                                                                  controller: value
                                                                      .tglJatuhTempoPertama,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      borderSide: const BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            SizedBox(
                                              height: 24,
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ButtonPrimary(
                                        onTap: () {
                                          value.hitungPembayaran();
                                        },
                                        name: "Bentuk Jadwal Pembayaran",
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  ListView.builder(
                                      itemCount:
                                          value.listNilaiTransaksi.length,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        var no = i + 1;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 32,
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  child: Text("$no. "),
                                                ),
                                                Container(
                                                  width: 150,
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  child: TextFormField(
                                                    controller: value
                                                        .listTglJthTempo[i],
                                                    // readOnly:
                                                    //     value.tagihanbulanan
                                                    //         ? true
                                                    //         : false,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        // filled:
                                                        //     value.tagihanbulanan
                                                        //         ? true
                                                        //         : false,
                                                        // fillColor:
                                                        //     Colors.grey[200],
                                                        hintText:
                                                            "Jatuh Tempo"),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: value
                                                        .listOutstanding[i],
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true),
                                                    inputFormatters: [
                                                      a.CurrencyInputFormatter(
                                                        leadingSymbol: '',
                                                        useSymbolPadding: true,
                                                        thousandSeparator: a
                                                            .ThousandSeparator
                                                            .Period,
                                                        mantissaLength:
                                                            2, // jumlah angka desimal
                                                        // decimalSeparator: DecimalSeparator.Comma,
                                                      ),
                                                    ],
                                                    // readOnly:
                                                    //     value.tagihanbulanan
                                                    //         ? true
                                                    //         : false,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        // filled:
                                                        //     value.tagihanbulanan
                                                        //         ? true
                                                        //         : false,
                                                        // fillColor:
                                                        //     Colors.grey[200],
                                                        hintText:
                                                            "Outstanding"),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: value
                                                        .listNilaiTransaksi[i],
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true),
                                                    inputFormatters: [
                                                      a.CurrencyInputFormatter(
                                                        leadingSymbol: '',
                                                        useSymbolPadding: true,
                                                        thousandSeparator: a
                                                            .ThousandSeparator
                                                            .Period,
                                                        mantissaLength:
                                                            2, // jumlah angka desimal
                                                        // decimalSeparator: DecimalSeparator.Comma,
                                                      ),
                                                    ],
                                                    // readOnly:
                                                    //     value.tagihanbulanan
                                                    //         ? true
                                                    //         : false,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        // filled:
                                                        //     value.tagihanbulanan
                                                        //         ? true
                                                        //         : false,
                                                        // fillColor:
                                                        //     Colors.grey[200],
                                                        hintText:
                                                            "Nilai Transaksi"),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        value.listNilaiPPN[i],
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true),
                                                    inputFormatters: [
                                                      a.CurrencyInputFormatter(
                                                        leadingSymbol: '',
                                                        useSymbolPadding: true,
                                                        thousandSeparator: a
                                                            .ThousandSeparator
                                                            .Period,
                                                        mantissaLength:
                                                            2, // jumlah angka desimal
                                                        // decimalSeparator: DecimalSeparator.Comma,
                                                      ),
                                                    ],
                                                    // readOnly:
                                                    //     value.tagihanbulanan
                                                    //         ? true
                                                    //         : false,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        // filled:
                                                        //     value.tagihanbulanan
                                                        //         ? true
                                                        //         : false,
                                                        // fillColor:
                                                        //     Colors.grey[200],
                                                        hintText: "Nilai PPN"),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        value.listNilaiPPH[i],
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true),
                                                    inputFormatters: [
                                                      a.CurrencyInputFormatter(
                                                        leadingSymbol: '',
                                                        useSymbolPadding: true,
                                                        thousandSeparator: a
                                                            .ThousandSeparator
                                                            .Period,
                                                        mantissaLength:
                                                            2, // jumlah angka desimal
                                                        // decimalSeparator: DecimalSeparator.Comma,
                                                      ),
                                                    ],
                                                    // readOnly:
                                                    //     value.tagihanbulanan
                                                    //         ? true
                                                    //         : false,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        // filled:
                                                        //     value.tagihanbulanan
                                                        //         ? true
                                                        //         : false,
                                                        // fillColor:
                                                        //     Colors.grey[200],
                                                        hintText: "Nilai PPH"),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            )
                                          ],
                                        );
                                      }),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  value.buttonSimpan
                                      ? ButtonPrimary(
                                          onTap: () {},
                                          name: "Simpan",
                                        )
                                      : SizedBox(),
                                ],
                              ))
                            ],
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
  DetailDataSource(HutangPiutangNotifier value) {}

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    throw UnimplementedError();
  }
}
