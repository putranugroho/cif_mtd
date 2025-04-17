import 'package:accounting/models/index.dart';
import 'package:accounting/module/transaksi/transaksi_hutang/transaksi_hutang_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/colors.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../utils/currency_formatted.dart';

class TransaksiHutangPage extends StatelessWidget {
  const TransaksiHutangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransaksiHutangNotifier(context: context),
      child: Consumer<TransaksiHutangNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Pembayaran Hutang/Piutang",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 300,
                              child: Text("No Invoice "),
                            ),
                            Container(
                              width: 16,
                              child: Text(": "),
                            ),
                            Expanded(
                              child: TypeAheadField<PiutangHutangModel>(
                                controller: value.noInvoice,
                                suggestionsCallback: (search) =>
                                    value.cariInvoice(search),
                                builder: (context, controller, focusNode) {
                                  return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Cari Nomor Invoice',
                                      ));
                                },
                                itemBuilder: (context, city) {
                                  return ListTile(
                                    title: Text(city.noInvoice),
                                    subtitle: Text(city.nmSif),
                                  );
                                },
                                onSelected: (city) {
                                  value.pilihInvoice(city);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 300,
                              child: Text("Customer / Supplier"),
                            ),
                            Container(
                              width: 16,
                              child: Text(": "),
                            ),
                            Expanded(
                              child: TypeAheadField<CustomerSupplierModel>(
                                controller: value.customer,
                                suggestionsCallback: (search) =>
                                    value.caricustomer(search),
                                builder: (context, controller, focusNode) {
                                  return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Cari Customer / Supplier',
                                      ));
                                },
                                itemBuilder: (context, city) {
                                  return ListTile(
                                    title: Text(city.nmSif),
                                  );
                                },
                                onSelected: (city) {
                                  value.pilihCustomer(city);
                                },
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          height: 1,
                          color: Colors.grey,
                        ),
                        value.pencarianInvoice
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        child: Text("Jenis Invoice "),
                                      ),
                                      Container(
                                        width: 16,
                                        child: Text(": "),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        readOnly: true,
                                        controller: value.jenis,
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey[300],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        child: Text("Tanggal Invoice "),
                                      ),
                                      Container(
                                        width: 16,
                                        child: Text(": "),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        readOnly: true,
                                        controller: value.tglInvoice,
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey[300],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      )),
                                      SizedBox(
                                        width: 32,
                                      ),
                                      Container(
                                        width: 300,
                                        child: Text("Tanggal Pembayaran "),
                                      ),
                                      Container(
                                        width: 16,
                                        child: Text(": "),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  value.piutangHutangModel != null
                                      ? value.piutangHutangModel!.bertahap ==
                                              "Y"
                                          ? Row(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  child:
                                                      Text("Nominal Tagihan"),
                                                ),
                                                Container(
                                                  width: 16,
                                                  child: Text(": "),
                                                ),
                                                Expanded(
                                                    child: TextFormField(
                                                  readOnly: true,
                                                  controller: value.tagihan,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[300],
                                                    filled: true,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                )),
                                                SizedBox(
                                                  width: 32,
                                                ),
                                                Container(
                                                  width: 300,
                                                  child: Text("Tahapan Ke"),
                                                ),
                                                Container(
                                                  width: 16,
                                                  child: Text(": "),
                                                ),
                                                Expanded(
                                                    child: TextFormField(
                                                  readOnly: true,
                                                  controller: value.tahap,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[300],
                                                    filled: true,
                                                    suffixIcon: value
                                                                .piutangHutangModel !=
                                                            null
                                                        ? value.piutangHutangModel!
                                                                    .bertahap ==
                                                                "Y"
                                                            ? IconButton(
                                                                onPressed: () {
                                                                  value
                                                                      .rincianBertahap();
                                                                },
                                                                icon: Icon(Icons
                                                                    .visibility))
                                                            : SizedBox()
                                                        : SizedBox(),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Container(
                                                  width: 300,
                                                  child:
                                                      Text("Nominal Tagihan"),
                                                ),
                                                Container(
                                                  width: 16,
                                                  child: Text(": "),
                                                ),
                                                Expanded(
                                                    child: TextFormField(
                                                  readOnly: true,
                                                  controller: value.tagihan,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[300],
                                                    filled: true,
                                                    suffixIcon: value
                                                                .piutangHutangModel !=
                                                            null
                                                        ? value.piutangHutangModel!
                                                                    .bertahap ==
                                                                "Y"
                                                            ? IconButton(
                                                                onPressed: () {
                                                                  value
                                                                      .rincianBertahap();
                                                                },
                                                                icon: Icon(Icons
                                                                    .visibility))
                                                            : SizedBox()
                                                        : SizedBox(),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            )
                                      : Row(
                                          children: [
                                            Container(
                                              width: 300,
                                              child: Text("Nominal Tagihan"),
                                            ),
                                            Container(
                                              width: 16,
                                              child: Text(": "),
                                            ),
                                            Expanded(
                                                child: TextFormField(
                                              readOnly: true,
                                              controller: value.tagihan,
                                              decoration: InputDecoration(
                                                fillColor: Colors.grey[300],
                                                filled: true,
                                                suffixIcon: value
                                                            .piutangHutangModel !=
                                                        null
                                                    ? value.piutangHutangModel!
                                                                .bertahap ==
                                                            "Y"
                                                        ? IconButton(
                                                            onPressed: () {
                                                              value
                                                                  .rincianBertahap();
                                                            },
                                                            icon: Icon(Icons
                                                                .visibility))
                                                        : SizedBox()
                                                    : SizedBox(),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            )),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        child: Text("Nominal Pembayaran"),
                                      ),
                                      Container(
                                        width: 16,
                                        child: Text(": "),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        onChanged: (e) {
                                          value.gantinominal();
                                        },
                                        controller: value.nominal,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CurrencyInputFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        child: Text("Sisa Pembayaran"),
                                      ),
                                      Container(
                                        width: 16,
                                        child: Text(": "),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        readOnly: true,
                                        controller: value.sisa,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CurrencyInputFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey[300],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 16),
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        child: Text("Akun Debet"),
                                      ),
                                      Container(
                                        width: 16,
                                        child: Text(": "),
                                      ),
                                      Expanded(
                                        child: TypeAheadField<NeracaItemModel>(
                                          controller: value.namaSbbDebet,
                                          suggestionsCallback: (search) =>
                                              value.cariAkun(search),
                                          builder:
                                              (context, controller, focusNode) {
                                            return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Cari Akun Debet',
                                                ));
                                          },
                                          itemBuilder: (context, city) {
                                            return ListTile(
                                              title: Text(city.namaSbb),
                                              // subtitle: Text(city.nmSif),
                                            );
                                          },
                                          onSelected: (city) {
                                            value.pilihCoaDebet(city);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                          width: 150,
                                          child: TextFormField(
                                            controller: value.noSbbDebet,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        child: Text("Akun Kredit"),
                                      ),
                                      Container(
                                        width: 16,
                                        child: Text(": "),
                                      ),
                                      Expanded(
                                        child: TypeAheadField<NeracaItemModel>(
                                          controller: value.namaSbbKredit,
                                          suggestionsCallback: (search) =>
                                              value.cariAkun(search),
                                          builder:
                                              (context, controller, focusNode) {
                                            return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Cari Akun Kredit',
                                                ));
                                          },
                                          itemBuilder: (context, city) {
                                            return ListTile(
                                              title: Text(city.namaSbb),
                                              // subtitle: Text(city.nmSif),
                                            );
                                          },
                                          onSelected: (city) {
                                            value.pilihCoaKredit(city);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                          width: 150,
                                          child: TextFormField(
                                            controller: value.noSbbKredit,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        child: Text("Akun Sisa Pembayaran"),
                                      ),
                                      Container(
                                        width: 16,
                                        child: Text(": "),
                                      ),
                                      Expanded(
                                        child: TypeAheadField<NeracaItemModel>(
                                          controller: value.namaSbbDebet,
                                          suggestionsCallback: (search) =>
                                              value.cariAkun(search),
                                          builder:
                                              (context, controller, focusNode) {
                                            return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Cari Akun Sisa Pembayaran',
                                                ));
                                          },
                                          itemBuilder: (context, city) {
                                            return ListTile(
                                              title: Text(city.namaSbb),
                                              // subtitle: Text(city.nmSif),
                                            );
                                          },
                                          onSelected: (city) {
                                            value.pilihCoaDebet(city);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                          width: 150,
                                          child: TextFormField(
                                            controller: value.noSbbDebet,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Hutang",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 26,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "No. ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Status",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "No. Invoice",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Tgl. Invoice",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Nominal Tagihan",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Nominal Bayar",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Sisa",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Bertahap",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Tgl. Jatuh Tempo",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemCount: value.list
                                                .where((e) =>
                                                    e.nmSif
                                                        .toLowerCase()
                                                        .contains(value
                                                            .customerSupplierModel!
                                                            .nmSif
                                                            .toLowerCase()) &&
                                                    e.jnsInvoice == "1")
                                                .length,
                                            itemBuilder: (context, b) {
                                              final data = value.list
                                                  .where((e) =>
                                                      e.nmSif
                                                          .toLowerCase()
                                                          .contains(value
                                                              .customerSupplierModel!
                                                              .nmSif
                                                              .toLowerCase()) &&
                                                      e.jnsInvoice == "1")
                                                  .toList()[b];
                                              var no = b + 1;
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      value.pilihInvoice(data);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 26,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${no}. ",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 80,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${data.statusInvoice == "A" ? "Aktif" : "Macet"}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${data.noInvoice}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 100,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${DateFormat('dd MMM y').format(DateTime.parse(data.tglInvoice))}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${FormatCurrency.oCcy.format(int.parse(data.nilaiInvoice))}",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${FormatCurrency.oCcy.format(int.parse(data.nilaiBayar))}",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${FormatCurrency.oCcy.format(int.parse(data.nilaiInvoice) - int.parse(data.nilaiBayar))}",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 80,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${data.bertahap}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            data.bertahap == "N"
                                                                ? "${DateFormat('dd MM y').format(DateTime.parse(data.tglJtTempo))}"
                                                                : "",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  )
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Piutang",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 26,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "No. ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Status",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "No. Invoice",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Tgl. Invoice",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Nominal Tagihan",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Nominal Bayar",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Sisa",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Bertahap",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Text(
                                                "Tgl. Jatuh Tempo",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemCount: value.list
                                                .where((e) =>
                                                    e.nmSif
                                                        .toLowerCase()
                                                        .contains(value
                                                            .customerSupplierModel!
                                                            .nmSif
                                                            .toLowerCase()) &&
                                                    e.jnsInvoice == "2")
                                                .length,
                                            itemBuilder: (context, b) {
                                              final data = value.list
                                                  .where((e) =>
                                                      e.nmSif
                                                          .toLowerCase()
                                                          .contains(value
                                                              .customerSupplierModel!
                                                              .nmSif
                                                              .toLowerCase()) &&
                                                      e.jnsInvoice == "2")
                                                  .toList()[b];
                                              var no = b + 1;
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      value.pilihInvoice(data);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 26,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${no}. ",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 80,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${data.statusInvoice == "A" ? "Aktif" : "Macet"}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${data.noInvoice}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 100,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${DateFormat('dd MMM y').format(DateTime.parse(data.tglInvoice))}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${FormatCurrency.oCcy.format(int.parse(data.nilaiInvoice))}",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${FormatCurrency.oCcy.format(int.parse(data.nilaiBayar))}",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${FormatCurrency.oCcy.format(int.parse(data.nilaiInvoice) - int.parse(data.nilaiBayar))}",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 80,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            "${data.bertahap}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 16),
                                                          child: Text(
                                                            data.bertahap == "N"
                                                                ? "${DateFormat('dd MM y').format(DateTime.parse(data.tglJtTempo))}"
                                                                : "",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  )
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                ],
              )),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: Colors.grey))),
                child: Row(
                  children: [
                    Spacer(),
                    ButtonPrimary(
                      onTap: () {},
                      name: "Simpan",
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
