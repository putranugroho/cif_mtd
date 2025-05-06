import 'package:accounting/models/index.dart';
import 'package:accounting/module/hutang_piutang/hutang_piutang_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart' as a;

import '../../utils/colors.dart';

class HutangPiutangPage extends StatelessWidget {
  final int tipe;
  final int jenis;
  const HutangPiutangPage({super.key, required this.tipe, required this.jenis});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          HutangPiutangNotifier(context: context, tipe: tipe, jenis: jenis),
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
                                jenis == 1 ? "Kelola Hutang" : "Kelola Piutang",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                tipe == 1
                                    ? "Bayar Sekaligus"
                                    : "Bayar Berjangka",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                jenis == 1 ? "Tambah Hutang" : "Tambah Piutang",
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
                                          ? "Ubah / Hapus ${tipe == 1 ? "${jenis == 1 ? "Hutang" : "Piutang"} Sekaligus" : "${jenis == 1 ? "Hutang" : "Piutang"} Berjangka"}"
                                          : "Tambah ${tipe == 1 ? "${jenis == 1 ? "Hutang" : "Piutang"} Sekaligus" : "${jenis == 1 ? "Hutang" : "Piutang"} Berjangka"}",
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
                                              child: Text(
                                                  "Pilih ${jenis == 1 ? "Customer" : "Supplier"}"),
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
                                              child: Text("Cara Bayar"),
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
                                              child: Text("Transaksi"),
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
                                              child: Text("Jangka Waktu"),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  "Tanggal Jatuh Tempo Pertama"),
                                            ),
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
                                                                    'Cari ${jenis == 1 ? "Customer" : "Supplier"}',
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
                                                    Expanded(
                                                        child: Row(
                                                      children: [
                                                        Radio(
                                                            value: true,
                                                            groupValue:
                                                                value.carabayar,
                                                            onChanged: (e) {
                                                              value
                                                                  .ganticarabayar();
                                                            }),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text("Auto"),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        Radio(
                                                            value: false,
                                                            groupValue:
                                                                value.carabayar,
                                                            onChanged: (e) {
                                                              value
                                                                  .ganticarabayar();
                                                            }),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text("Tagihan"),
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
                                                                  "No. Invoice",
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
                                                    )),
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
                                                            child:
                                                                TextFormField(
                                                              controller: value
                                                                  .tglkontrak,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Tanggal Kontrak",
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
                                            Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
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
                                            Container(
                                                height: 40,
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      child: TextFormField(
                                                        controller:
                                                            value.jangkawaktu,
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
                                                      width: 32,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              "Tagihan Bulanan"),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Radio(
                                                              value: true,
                                                              groupValue: value
                                                                  .tagihanbulanan,
                                                              onChanged: (e) {
                                                                value
                                                                    .gantitagitahnbulanan();
                                                              }),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text("Ya"),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Radio(
                                                              value: false,
                                                              groupValue: value
                                                                  .tagihanbulanan,
                                                              onChanged: (e) {
                                                                value
                                                                    .gantitagitahnbulanan();
                                                              }),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text("Tidak"),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 32,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text("PPN/PPH"),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Radio(
                                                              value: true,
                                                              groupValue:
                                                                  value.pphppn,
                                                              onChanged: (e) {
                                                                value
                                                                    .gantipphppn();
                                                              }),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text("Proposional"),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Radio(
                                                              value: false,
                                                              groupValue:
                                                                  value.pphppn,
                                                              onChanged: (e) {
                                                                value
                                                                    .gantipphppn();
                                                              }),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text("Diakhir"),
                                                          SizedBox(
                                                            width: 32,
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
                                              child: InkWell(
                                                onTap: () {
                                                  value
                                                      .pilihTanggalJatuhTempoPertama();
                                                },
                                                child: TextFormField(
                                                  enabled: false,
                                                  controller: value
                                                      .tglJatuhTempoPertama,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                                    readOnly:
                                                        value.tagihanbulanan
                                                            ? true
                                                            : false,
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
                                                        filled:
                                                            value.tagihanbulanan
                                                                ? true
                                                                : false,
                                                        fillColor:
                                                            Colors.grey[200],
                                                        hintText:
                                                            "Jatuh Tempo"),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: value
                                                        .listNilaiTransaksi[i],
                                                    readOnly:
                                                        value.tagihanbulanan
                                                            ? true
                                                            : false,
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
                                                        filled:
                                                            value.tagihanbulanan
                                                                ? true
                                                                : false,
                                                        fillColor:
                                                            Colors.grey[200],
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
                                                    readOnly:
                                                        value.tagihanbulanan
                                                            ? true
                                                            : false,
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
                                                        filled:
                                                            value.tagihanbulanan
                                                                ? true
                                                                : false,
                                                        fillColor:
                                                            Colors.grey[200],
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
                                                    readOnly:
                                                        value.tagihanbulanan
                                                            ? true
                                                            : false,
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
                                                        filled:
                                                            value.tagihanbulanan
                                                                ? true
                                                                : false,
                                                        fillColor:
                                                            Colors.grey[200],
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
                                  ButtonPrimary(
                                    onTap: () {},
                                    name: "Simpan",
                                  )
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
