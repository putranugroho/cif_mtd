import 'package:accounting/models/index.dart';
import 'package:accounting/module/transaksi/transaksi_hutang/transaksi_hutang_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/colors.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
                                  Row(
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
                                        decoration: InputDecoration(
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
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          width: 30,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Checkbox(
                                              activeColor: colorPrimary,
                                              value: value.semua,
                                              onChanged: (e) {
                                                value.pilihSemua();
                                              })),
                                      Container(
                                        width: 26,
                                        margin: EdgeInsets.only(right: 16),
                                        child: Text(
                                          "No. ",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        margin: EdgeInsets.only(right: 16),
                                        child: Text(
                                          "Status",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        margin: EdgeInsets.only(right: 16),
                                        child: Text(
                                          "No. Invoice",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        margin: EdgeInsets.only(right: 16),
                                        child: Text(
                                          "Nominal Tagihan",
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
                                          "Tgl. Invoice",
                                          style: TextStyle(
                                            fontSize: 12,
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
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: value.list
                                          .where((e) => e.nmSif
                                              .toLowerCase()
                                              .contains(value
                                                  .customerSupplierModel!.nmSif
                                                  .toLowerCase()))
                                          .length,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        final data = value.list
                                            .where((e) => e.nmSif
                                                .toLowerCase()
                                                .contains(value
                                                    .customerSupplierModel!
                                                    .nmSif
                                                    .toLowerCase()))
                                            .toList()[i];
                                        var no = i + 1;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    width: 30,
                                                    margin: EdgeInsets.only(
                                                        right: 16),
                                                    child: Checkbox(
                                                        activeColor:
                                                            colorPrimary,
                                                        value: value
                                                            .listCustomerInvoice[i],
                                                        onChanged: (e) {
                                                          value
                                                              .pilihCustomerInvoice(
                                                                  i);
                                                        })),
                                                Container(
                                                  width: 26,
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  child: Text(
                                                    "${no}. ",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 150,
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  child: Text(
                                                    "${data.statusInvoice == "A" ? "Aktif" : data.statusInvoice == "M" ? "Macet" : "Lunas"}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 150,
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  child: Text(
                                                    "${data.noInvoice}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 200,
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  child: Text(
                                                    "${FormatCurrency.oCcy.format(int.parse(data.nilaiInvoice))}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                                Container(
                                                  width: 150,
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  child: Text(
                                                    "${DateFormat('dd MMM y').format(DateTime.parse(data.tglInvoice))}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16,
                                            )
                                          ],
                                        );
                                      })
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
