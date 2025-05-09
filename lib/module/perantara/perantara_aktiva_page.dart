import 'package:accounting/models/index.dart';
import 'package:accounting/module/perantara/perantara_aktiva_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/currency_formatted.dart';
import '../../utils/format_currency.dart';

class PerantaraAktivaPage extends StatelessWidget {
  const PerantaraAktivaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PerantaraAktivaNotifier(context: context),
        child: Consumer<PerantaraAktivaNotifier>(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Perantara",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: "AKTIVA",
                                          activeColor: colorPrimary,
                                          groupValue: value.jenis,
                                          onChanged: (e) {
                                            value.gantijenis("AKTIVA");
                                          }),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Aktiva"),
                                      SizedBox(
                                        width: 32,
                                      ),
                                      Radio(
                                          value: "PASIVA",
                                          activeColor: colorPrimary,
                                          groupValue: value.jenis,
                                          onChanged: (e) {
                                            value.gantijenis("PASIVA");
                                          }),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Pasiva"),
                                      SizedBox(
                                        width: 32,
                                      ),
                                      Container(
                                          width: 400,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TypeAheadField<
                                                    InqueryGlModel>(
                                                  controller: value.nossbcre,
                                                  suggestionsCallback:
                                                      (search) => value
                                                          .getInquery(search),
                                                  builder: (context, controller,
                                                      focusNode) {
                                                    return TextField(
                                                        controller: controller,
                                                        focusNode: focusNode,
                                                        autofocus: true,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText: 'Cari SBB',
                                                        ));
                                                  },
                                                  itemBuilder: (context, city) {
                                                    return ListTile(
                                                      title: Text(city.nosbb),
                                                      subtitle:
                                                          Text(city.namaSbb),
                                                    );
                                                  },
                                                  onSelected: (city) {
                                                    // value.selectInvoice(city);
                                                    value.pilihAkunCre(city);
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
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  controller: value.namaSbbCre,
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
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                    hintText: "No. SBB",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bagian kiri: tetap statis
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  headerCell("No.", 50),
                                  headerCell("Tgl. Trans", 180),
                                ],
                              ),
                              ...List.generate(value.list.length, (i) {
                                final data = value.list[i];
                                return Column(
                                  children: [
                                    Container(
                                        width: 50, child: Text("${i + 1}")),
                                    Container(width: 180, child: Text("")),
                                  ],
                                );
                              }),
                            ],
                          ),

                          // Bagian kanan: bisa discroll horizontal
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      headerCell("No Dokumen", 180),
                                      headerCell("No. Referensi", 180),
                                      headerCell("Nominal", 180),
                                      headerCell("Akun Debet", 180),
                                      headerCell("Akun Kredit", 180),
                                      headerCell("Keterangan", 300),
                                      headerCell("Action", 150),
                                    ],
                                  ),
                                  ...List.generate(value.list.length, (i) {
                                    final data = value.list[i];
                                    return Row(
                                      children: [
                                        // cell(data.noDokumen, 180),
                                        // cell(data.noRef, 180),
                                        // cell("${data.nominal}", 180),
                                        // cell(data.akunDebet, 180),
                                        // cell(data.akunKredit, 180),
                                        // cell(data.keterangan, 300),
                                        // cell("Edit | Delete", 150),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        height: 1,
                        color: Colors.grey,
                      ),
                      value.jenis == "AKTIVA"
                          ? Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListView.builder(
                                      itemCount: value.list.length,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        final data = value.list[i];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            data.sbbItem.isNotEmpty
                                                ? ListView.builder(
                                                    itemCount:
                                                        data.sbbItem.length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemBuilder: (context, b) {
                                                      final a = data.sbbItem[b];
                                                      double saldoAwal =
                                                          a.saldo;

                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 360,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              16),
                                                                  child: Text(
                                                                    "(${a.nosbb}) - ${a.namaSbb}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            16),
                                                                    child: Text(
                                                                      "${a.typePosting}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              16),
                                                                  child: Text(
                                                                    "${FormatCurrency.oCcyDecimal.format(a.saldo)}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              16),
                                                                  child: Text(
                                                                    "",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 120,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              16),
                                                                  child: Text(
                                                                    "${FormatCurrency.oCcyDecimal.format(a.saldo)}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    value
                                                                        .tambah(
                                                                            a);
                                                                  },
                                                                  child: Container(
                                                                      width: 120,
                                                                      margin: EdgeInsets.only(right: 16),
                                                                      child: Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                16,
                                                                            vertical:
                                                                                4),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              colorPrimary,
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "Tambah Trans.",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          a.itemTransaksi
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                      itemCount: a
                                                                          .itemTransaksi
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          ClampingScrollPhysics(),
                                                                      itemBuilder:
                                                                          (context,
                                                                              c) {
                                                                        final d =
                                                                            a.itemTransaksi[c];

                                                                        double
                                                                            totalPengurangan =
                                                                            d.nominal;

                                                                        var sisaSaldo =
                                                                            saldoAwal -
                                                                                totalPengurangan;
                                                                        return Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.stretch,
                                                                          children: [
                                                                            Container(
                                                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    width: 360,
                                                                                    margin: EdgeInsets.only(right: 16),
                                                                                    child: Text(
                                                                                      "(${d.creditAcc}) - ${d.namaCredit}",
                                                                                      textAlign: TextAlign.end,
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      margin: EdgeInsets.only(right: 16),
                                                                                      child: Text(
                                                                                        "",
                                                                                        style: TextStyle(
                                                                                          fontSize: 12,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 150,
                                                                                    margin: EdgeInsets.only(right: 16),
                                                                                    child: Text(
                                                                                      "${FormatCurrency.oCcyDecimal.format(d.nominal)}",
                                                                                      textAlign: TextAlign.end,
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 120,
                                                                                    margin: EdgeInsets.only(right: 16),
                                                                                    child: Text(
                                                                                      "${FormatCurrency.oCcyDecimal.format(d.sisaSaldo)}",
                                                                                      textAlign: TextAlign.end,
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 136,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      })
                                                              : SizedBox(),
                                                          Container(),
                                                          SizedBox(
                                                            height: 16,
                                                          )
                                                        ],
                                                      );
                                                    })
                                                : SizedBox(),
                                            SizedBox(
                                              height: 16,
                                            )
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            )
                          : Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListView.builder(
                                      itemCount: value.listPasive.length,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        final data = value.listPasive[i];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            data.sbbItem.isNotEmpty
                                                ? ListView.builder(
                                                    itemCount:
                                                        data.sbbItem.length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemBuilder: (context, b) {
                                                      final a = data.sbbItem[b];
                                                      double saldoAwal =
                                                          a.saldo;

                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 360,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              16),
                                                                  child: Text(
                                                                    "(${a.nosbb}) - ${a.namaSbb}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            16),
                                                                    child: Text(
                                                                      "${a.typePosting}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              16),
                                                                  child: Text(
                                                                    "",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              16),
                                                                  child: Text(
                                                                    "${FormatCurrency.oCcyDecimal.format(a.saldo)}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 120,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              16),
                                                                  child: Text(
                                                                    "${FormatCurrency.oCcyDecimal.format(a.saldo)}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    value
                                                                        .tambah(
                                                                            a);
                                                                  },
                                                                  child: Container(
                                                                      width: 120,
                                                                      margin: EdgeInsets.only(right: 16),
                                                                      child: Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                16,
                                                                            vertical:
                                                                                4),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              colorPrimary,
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "Tambah Trans.",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          a.itemTransaksi
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                      itemCount: a
                                                                          .itemTransaksi
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          ClampingScrollPhysics(),
                                                                      itemBuilder:
                                                                          (context,
                                                                              c) {
                                                                        final d =
                                                                            a.itemTransaksi[c];

                                                                        double
                                                                            totalPengurangan =
                                                                            d.nominal;

                                                                        var sisaSaldo =
                                                                            saldoAwal -
                                                                                totalPengurangan;
                                                                        return Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.stretch,
                                                                          children: [
                                                                            Container(
                                                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    width: 360,
                                                                                    margin: EdgeInsets.only(right: 16),
                                                                                    child: Text(
                                                                                      "(${d.creditAcc}) - ${d.namaCredit}",
                                                                                      textAlign: TextAlign.start,
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      margin: EdgeInsets.only(right: 16),
                                                                                      child: Text(
                                                                                        "",
                                                                                        style: TextStyle(
                                                                                          fontSize: 12,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 150,
                                                                                    margin: EdgeInsets.only(right: 16),
                                                                                    child: Text(
                                                                                      "${FormatCurrency.oCcyDecimal.format(d.nominal)}",
                                                                                      textAlign: TextAlign.end,
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 150,
                                                                                    margin: EdgeInsets.only(right: 16),
                                                                                    child: Text(
                                                                                      "",
                                                                                      textAlign: TextAlign.end,
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 120,
                                                                                    margin: EdgeInsets.only(right: 16),
                                                                                    child: Text(
                                                                                      "${FormatCurrency.oCcyDecimal.format(d.sisaSaldo)}",
                                                                                      textAlign: TextAlign.end,
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 136,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      })
                                                              : SizedBox(),
                                                          Container(),
                                                          SizedBox(
                                                            height: 16,
                                                          )
                                                        ],
                                                      );
                                                    })
                                                : SizedBox(),
                                            SizedBox(
                                              height: 16,
                                            )
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 80,
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
                      ? value.jenis == "AKTIVA"
                          ? Container(
                              width: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Tambah Transaksi",
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
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Nomor Dokumen",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: value.nomorDok,
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
                                              hintText: "Nomor Dok",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Nomor Reference",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: value.nomorRef,
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
                                            decoration: InputDecoration(
                                              hintText: "Nomor Referensi",
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(
                                        "Pilih Debet Akun",
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
                                        child: DropdownSearch<CoaModel>(
                                          popupProps:
                                              const PopupPropsMultiSelection
                                                  .menu(
                                            showSearchBox:
                                                true, // Aktifkan fitur pencarian
                                          ),
                                          selectedItem: value.sbbAset,
                                          items: value.listCoaDebet
                                              .where((e) => e.jnsAcc == "C")
                                              .toList(),
                                          itemAsString: (e) => "${e.namaSbb}",
                                          onChanged: (e) {
                                            value.pilihSbbAset(e!);
                                          },
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            baseStyle: TextStyle(fontSize: 16),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              hintText: "Pilih Debet Akun",
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
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbAset,
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
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nomor SBB",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(
                                        "Pilih Kredit Akun",
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
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbKredit,
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
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nama SBB",
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
                                      Container(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbpenyusutan,
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
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nomor SBB",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    readOnly: true,
                                    controller: value.keterangan,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      hintText: "Sumber Keterangan",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Sisa Saldo",
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
                                    readOnly: true,
                                    textInputAction: TextInputAction.done,
                                    controller: value.sisaSaldo,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CurrencyInputFormatter(),
                                    ],
                                    validator: (e) {
                                      if (e!.isEmpty) {
                                        return "Wajib diisi";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Sisa Saldo",
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Nominal",
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
                                    controller: value.nominal,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CurrencyInputFormatter(),
                                    ],
                                    validator: (e) {
                                      if (e!.isEmpty) {
                                        return "Wajib diisi";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Nilai Transaksi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Keterangan",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintText: "Keterangan Transaksi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  ButtonPrimary(
                                    onTap: () {},
                                    name: "Simpan",
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Tambah Transaksi",
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
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Nomor Dokumen",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: value.nomorDok,
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
                                              hintText: "Nomor Dok",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Nomor Reference",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: value.nomorRef,
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
                                            decoration: InputDecoration(
                                              hintText: "Nomor Referensi",
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(
                                        "Pilih Debet Akun",
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
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbDebit,
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
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nama SBB",
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
                                      Container(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbAset,
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
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nomor SBB",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    readOnly: true,
                                    controller: value.keterangan,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      hintText: "Sumber Keterangan",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Pilih Kredit Akun",
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
                                        child: DropdownSearch<CoaModel>(
                                          popupProps:
                                              const PopupPropsMultiSelection
                                                  .menu(
                                            showSearchBox:
                                                true, // Aktifkan fitur pencarian
                                          ),
                                          selectedItem: value.sbbAset,
                                          items: value.listCoaDebet
                                              .where((e) => e.jnsAcc == "C")
                                              .toList(),
                                          itemAsString: (e) => "${e.namaSbb}",
                                          onChanged: (e) {
                                            value.pilihSbbAset(e!);
                                          },
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            baseStyle: TextStyle(fontSize: 16),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              hintText: "Pilih Debet Akun",
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
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbpenyusutan,
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
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nomor SBB",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(
                                        "Sisa Saldo",
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
                                    readOnly: true,
                                    textInputAction: TextInputAction.done,
                                    controller: value.sisaSaldo,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CurrencyInputFormatter(),
                                    ],
                                    validator: (e) {
                                      if (e!.isEmpty) {
                                        return "Wajib diisi";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Sisa Saldo",
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Nominal",
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
                                    controller: value.nominal,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CurrencyInputFormatter(),
                                    ],
                                    validator: (e) {
                                      if (e!.isEmpty) {
                                        return "Wajib diisi";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Nilai Transaksi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Keterangan",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintText: "Keterangan Transaksi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  ButtonPrimary(
                                    onTap: () {},
                                    name: "Simpan",
                                  )
                                ],
                              ),
                            )
                      : SizedBox(),
                )
              ],
            ),
          )),
        ));
  }
}

Widget headerText(String label) => Container(
      padding: EdgeInsets.all(8),
      color: colorPrimary,
      child: Text(label, style: TextStyle(fontSize: 12, color: Colors.white)),
    );

Widget headerCell(String label, double width) => Container(
      width: width,
      padding: EdgeInsets.all(8),
      color: colorPrimary,
      child: Text(label, style: TextStyle(fontSize: 12, color: Colors.white)),
    );

Widget cell(String content, double width) => Container(
      width: width,
      padding: EdgeInsets.all(8),
      child: Text(content, style: TextStyle(fontSize: 12)),
    );
