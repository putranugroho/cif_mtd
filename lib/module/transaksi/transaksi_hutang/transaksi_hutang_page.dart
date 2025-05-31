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
                padding: const EdgeInsets.all(20),
                child: const Row(
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
              const SizedBox(
                height: 24,
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 300,
                              child: const Text("No Invoice "),
                            ),
                            SizedBox(
                              width: 16,
                              child: const Text(": "),
                            ),
                            Expanded(
                              child: TypeAheadField<PiutangHutangModel>(
                                controller: value.noInvoice,
                                suggestionsCallback: (search) => value.cariInvoice(search),
                                builder: (context, controller, focusNode) {
                                  return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      autofocus: true,
                                      decoration: const InputDecoration(
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
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 300,
                              child: const Text("Customer / Supplier"),
                            ),
                            SizedBox(
                              width: 16,
                              child: const Text(": "),
                            ),
                            Expanded(
                              child: TypeAheadField<CustomerSupplierModel>(
                                controller: value.customer,
                                suggestionsCallback: (search) => value.caricustomer(search),
                                builder: (context, controller, focusNode) {
                                  return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      autofocus: true,
                                      decoration: const InputDecoration(
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
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          height: 1,
                          color: Colors.grey,
                        ),
                        value.pencarianInvoice
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: const Text("Jenis Invoice "),
                                      ),
                                      SizedBox(
                                        width: 16,
                                        child: const Text(": "),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        readOnly: true,
                                        controller: value.jenis,
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey[300],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: const Text("Tanggal Invoice "),
                                      ),
                                      SizedBox(
                                        width: 16,
                                        child: const Text(": "),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        readOnly: true,
                                        controller: value.tglInvoice,
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey[300],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      )),
                                      const SizedBox(
                                        width: 32,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: const Text("Tanggal Pembayaran "),
                                      ),
                                      SizedBox(
                                        width: 16,
                                        child: const Text(": "),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  value.piutangHutangModel != null
                                      ? value.piutangHutangModel!.bertahap == "Y"
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  width: 300,
                                                  child: const Text("Nominal Tagihan"),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                  child: const Text(": "),
                                                ),
                                                Expanded(
                                                    child: TextFormField(
                                                  readOnly: true,
                                                  controller: value.tagihan,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[300],
                                                    filled: true,
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                )),
                                                const SizedBox(
                                                  width: 32,
                                                ),
                                                SizedBox(
                                                  width: 300,
                                                  child: const Text("Tahapan Ke"),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                  child: const Text(": "),
                                                ),
                                                Expanded(
                                                    child: TextFormField(
                                                  readOnly: true,
                                                  controller: value.tahap,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[300],
                                                    filled: true,
                                                    suffixIcon: value.piutangHutangModel != null
                                                        ? value.piutangHutangModel!.bertahap == "Y"
                                                            ? IconButton(
                                                                onPressed: () {
                                                                  value.rincianBertahap();
                                                                },
                                                                icon: const Icon(Icons.visibility))
                                                            : const SizedBox()
                                                        : const SizedBox(),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                SizedBox(
                                                  width: 300,
                                                  child: const Text("Nominal Tagihan"),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                  child: const Text(": "),
                                                ),
                                                Expanded(
                                                    child: TextFormField(
                                                  readOnly: true,
                                                  controller: value.tagihan,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[300],
                                                    filled: true,
                                                    suffixIcon: value.piutangHutangModel != null
                                                        ? value.piutangHutangModel!.bertahap == "Y"
                                                            ? IconButton(
                                                                onPressed: () {
                                                                  value.rincianBertahap();
                                                                },
                                                                icon: const Icon(Icons.visibility))
                                                            : const SizedBox()
                                                        : const SizedBox(),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            )
                                      : Row(
                                          children: [
                                            SizedBox(
                                              width: 300,
                                              child: const Text("Nominal Tagihan"),
                                            ),
                                            SizedBox(
                                              width: 16,
                                              child: const Text(": "),
                                            ),
                                            Expanded(
                                                child: TextFormField(
                                              readOnly: true,
                                              controller: value.tagihan,
                                              decoration: InputDecoration(
                                                fillColor: Colors.grey[300],
                                                filled: true,
                                                suffixIcon: value.piutangHutangModel != null
                                                    ? value.piutangHutangModel!.bertahap == "Y"
                                                        ? IconButton(
                                                            onPressed: () {
                                                              value.rincianBertahap();
                                                            },
                                                            icon: const Icon(Icons.visibility))
                                                        : const SizedBox()
                                                    : const SizedBox(),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                              ),
                                            )),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: const Text("Nominal Pembayaran"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                        child: const Text(": "),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        onChanged: (e) {
                                          value.gantinominal();
                                        },
                                        controller: value.nominal,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          CurrencyInputFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: const Text("Sisa Pembayaran"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                        child: const Text(": "),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        readOnly: true,
                                        controller: value.sisa,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          CurrencyInputFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey[300],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 16),
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: const Text("Akun Debet"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                        child: const Text(": "),
                                      ),
                                      Expanded(
                                        child: TypeAheadField<NeracaItemModel>(
                                          controller: value.namaSbbDebet,
                                          suggestionsCallback: (search) => value.cariAkun(search),
                                          builder: (context, controller, focusNode) {
                                            return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                autofocus: true,
                                                decoration: const InputDecoration(
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
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            controller: value.noSbbDebet,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: const Text("Akun Kredit"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                        child: const Text(": "),
                                      ),
                                      Expanded(
                                        child: TypeAheadField<NeracaItemModel>(
                                          controller: value.namaSbbKredit,
                                          suggestionsCallback: (search) => value.cariAkun(search),
                                          builder: (context, controller, focusNode) {
                                            return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                autofocus: true,
                                                decoration: const InputDecoration(
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
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            controller: value.noSbbKredit,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: const Text("Akun Sisa Pembayaran"),
                                      ),
                                      SizedBox(
                                        width: 16,
                                        child: const Text(": "),
                                      ),
                                      Expanded(
                                        child: TypeAheadField<NeracaItemModel>(
                                          controller: value.namaSbbDebet,
                                          suggestionsCallback: (search) => value.cariAkun(search),
                                          builder: (context, controller, focusNode) {
                                            return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                autofocus: true,
                                                decoration: const InputDecoration(
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
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            controller: value.noSbbDebet,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    )),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const Text(
                                          "Hutang",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 26,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "No. ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Status",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "No. Invoice",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Tgl. Invoice",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Nominal Tagihan",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Nominal Bayar",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Sisa",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Bertahap",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Tgl. Jatuh Tempo",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(vertical: 8),
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: const ClampingScrollPhysics(),
                                            itemCount: value.list.where((e) => e.nmSif.toLowerCase().contains(value.customerSupplierModel!.nmSif.toLowerCase()) && e.jnsInvoice == "1").length,
                                            itemBuilder: (context, b) {
                                              final data = value.list.where((e) => e.nmSif.toLowerCase().contains(value.customerSupplierModel!.nmSif.toLowerCase()) && e.jnsInvoice == "1").toList()[b];
                                              var no = b + 1;
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      value.pilihInvoice(data);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 26,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            "$no. ",
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 80,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            data.statusInvoice == "A" ? "Aktif" : "Macet",
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            data.noInvoice,
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 100,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            DateFormat('dd MMM y').format(DateTime.parse(data.tglInvoice)),
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            FormatCurrency.oCcy.format(int.parse(data.nilaiInvoice)),
                                                            textAlign: TextAlign.end,
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            FormatCurrency.oCcy.format(int.parse(data.nilaiBayar)),
                                                            textAlign: TextAlign.end,
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            FormatCurrency.oCcy.format(int.parse(data.nilaiInvoice) - int.parse(data.nilaiBayar)),
                                                            textAlign: TextAlign.end,
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 80,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            data.bertahap,
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            data.bertahap == "N" ? DateFormat('dd MM y').format(DateTime.parse(data.tglJtTempo)) : "",
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  )
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    )),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const Text(
                                          "Piutang",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 26,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "No. ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Status",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "No. Invoice",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Tgl. Invoice",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Nominal Tagihan",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Nominal Bayar",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Sisa",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Bertahap",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 120,
                                              margin: const EdgeInsets.only(right: 16),
                                              child: const Text(
                                                "Tgl. Jatuh Tempo",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(vertical: 8),
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: const ClampingScrollPhysics(),
                                            itemCount: value.list.where((e) => e.nmSif.toLowerCase().contains(value.customerSupplierModel!.nmSif.toLowerCase()) && e.jnsInvoice == "2").length,
                                            itemBuilder: (context, b) {
                                              final data = value.list.where((e) => e.nmSif.toLowerCase().contains(value.customerSupplierModel!.nmSif.toLowerCase()) && e.jnsInvoice == "2").toList()[b];
                                              var no = b + 1;
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      value.pilihInvoice(data);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 26,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            "$no. ",
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 80,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            data.statusInvoice == "A" ? "Aktif" : "Macet",
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            data.noInvoice,
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 100,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            DateFormat('dd MMM y').format(DateTime.parse(data.tglInvoice)),
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            FormatCurrency.oCcy.format(int.parse(data.nilaiInvoice)),
                                                            textAlign: TextAlign.end,
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            FormatCurrency.oCcy.format(int.parse(data.nilaiBayar)),
                                                            textAlign: TextAlign.end,
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            FormatCurrency.oCcy.format(int.parse(data.nilaiInvoice) - int.parse(data.nilaiBayar)),
                                                            textAlign: TextAlign.end,
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 80,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            data.bertahap,
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: Text(
                                                            data.bertahap == "N" ? DateFormat('dd MM y').format(DateTime.parse(data.tglJtTempo)) : "",
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  )
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
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
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(border: Border(top: BorderSide(width: 1, color: Colors.grey))),
                child: Row(
                  children: [
                    const Spacer(),
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
