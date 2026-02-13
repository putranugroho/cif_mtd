import 'package:cif/models/index.dart';
import 'package:cif/models/perantara_model.dart';
import 'package:cif/module/perantara/perantara_aktiva_notifier.dart';
import 'package:cif/utils/button_custom.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart' as a;
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "Penyelesaian Transaksi Perantara",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
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
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text("Debet"),
                                      const SizedBox(
                                        width: 32,
                                      ),
                                      Radio(
                                          value: "PASIVA",
                                          activeColor: colorPrimary,
                                          groupValue: value.jenis,
                                          onChanged: (e) {
                                            value.gantijenis("PASIVA");
                                          }),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text("Kredit"),
                                      const SizedBox(
                                        width: 32,
                                      ),
                                      const Text("Cari SBB"),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      SizedBox(
                                          width: 400,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TypeAheadField<InqueryGlModel>(
                                                  controller: value.nossbcre,
                                                  suggestionsCallback: (search) => value.getInquery(search),
                                                  builder: (context, controller, focusNode) {
                                                    return TextField(
                                                        controller: controller,
                                                        focusNode: focusNode,
                                                        autofocus: true,
                                                        decoration: const InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: 'Cari SBB',
                                                        ));
                                                  },
                                                  itemBuilder: (context, city) {
                                                    return ListTile(
                                                      title: Text(city.nosbb),
                                                      subtitle: Text(city.namaSbb),
                                                    );
                                                  },
                                                  onSelected: (city) {
                                                    // value.selectInvoice(city);
                                                    value.pilihAkunCre(city);
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              SizedBox(
                                                width: 150,
                                                child: TextFormField(
                                                  // enabled: false,
                                                  readOnly: true,
                                                  textInputAction: TextInputAction.done,
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
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              value.cari();
                                            },
                                            child: Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: colorPrimary,
                                                border: Border.all(
                                                  width: 2,
                                                  color: colorPrimary,
                                                ),
                                              ),
                                              child: const Text(
                                                "Cari",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
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
                                    SizedBox(width: 50, child: Text("${i + 1}")),
                                    SizedBox(width: 180, child: const Text("")),
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
                                    return const Row(
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
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 1,
                        color: Colors.grey,
                      ),
                      value.jenis == "AKTIVA"
                          ? Expanded(
                              child: ListView.builder(
                                  itemCount: value.listTransaksiAllAdd.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    final a = value.listTransaksiAllAdd[i];
                                    var saldoAwal = double.parse(a.nominal);
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 360,
                                                margin: const EdgeInsets.only(right: 16),
                                                child: Text(
                                                  "(${a.dracc}) - ${a.namaDr}",
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(right: 16),
                                                  child: Text(
                                                    "",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                margin: const EdgeInsets.only(right: 16),
                                                child: const Text(
                                                  "",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                margin: const EdgeInsets.only(right: 16),
                                                child: Text(
                                                  FormatCurrency.oCcyDecimal.format(double.parse(a.nominal).toInt()),
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
                                                  FormatCurrency.oCcyDecimal.format(double.parse(a.nominal).toInt()),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  value.tambah(a);
                                                },
                                                child: Container(
                                                    width: 120,
                                                    margin: const EdgeInsets.only(right: 16),
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius: BorderRadius.circular(16),
                                                      ),
                                                      child: const Text(
                                                        "Tambah Trans.",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        a.transaksi.isNotEmpty
                                            ? ListView.builder(
                                                itemCount: a.transaksi.length,
                                                shrinkWrap: true,
                                                physics: const ClampingScrollPhysics(),
                                                itemBuilder: (context, c) {
                                                  final d = a.transaksi[c];

                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 360,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: Text(
                                                                "(${d.cracc}) - ${d.namaCr}",
                                                                textAlign: TextAlign.start,
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                margin: const EdgeInsets.only(right: 16),
                                                                child: const Text(
                                                                  "",
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: Text(
                                                                FormatCurrency.oCcyDecimal.format(double.parse(d.nominal).toInt()),
                                                                textAlign: TextAlign.end,
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: const Text(
                                                                "",
                                                                textAlign: TextAlign.end,
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 120,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: Text(
                                                                FormatCurrency.oCcyDecimal.format(d.sisaSaldo),
                                                                textAlign: TextAlign.end,
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 136,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                })
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 16,
                                        )
                                      ],
                                    );
                                  }),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: value.listTransaksiAllAdd.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    final a = value.listTransaksiAllAdd[i];
                                    var saldoAwal = double.parse(a.nominal);
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 360,
                                                margin: const EdgeInsets.only(right: 16),
                                                child: Text(
                                                  "(${a.cracc}) - ${a.namaCr}",
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(right: 16),
                                                  child: Text(
                                                    "",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                margin: const EdgeInsets.only(right: 16),
                                                child: const Text(
                                                  "",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                margin: const EdgeInsets.only(right: 16),
                                                child: Text(
                                                  FormatCurrency.oCcyDecimal.format(double.parse(a.nominal).toInt()),
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
                                                  FormatCurrency.oCcyDecimal.format(double.parse(a.nominal).toInt()),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  value.tambah(a);
                                                },
                                                child: Container(
                                                    width: 120,
                                                    margin: const EdgeInsets.only(right: 16),
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                                      decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius: BorderRadius.circular(16),
                                                      ),
                                                      child: const Text(
                                                        "Tambah Trans.",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        a.transaksi.isNotEmpty
                                            ? ListView.builder(
                                                itemCount: a.transaksi.length,
                                                shrinkWrap: true,
                                                physics: const ClampingScrollPhysics(),
                                                itemBuilder: (context, c) {
                                                  final d = a.transaksi[c];

                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 360,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: Text(
                                                                "(${d.cracc}) - ${d.namaCr}",
                                                                textAlign: TextAlign.start,
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                margin: const EdgeInsets.only(right: 16),
                                                                child: const Text(
                                                                  "",
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: Text(
                                                                FormatCurrency.oCcyDecimal.format(double.parse(d.nominal).toInt()),
                                                                textAlign: TextAlign.end,
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: const Text(
                                                                "",
                                                                textAlign: TextAlign.end,
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 120,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: Text(
                                                                FormatCurrency.oCcyDecimal.format(d.sisaSaldo),
                                                                textAlign: TextAlign.end,
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 136,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                })
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 16,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                      const SizedBox(
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
                  child: value.dialog || value.dialogtrans
                      ? Container(
                          color: Colors.black.withOpacity(0.5),
                        )
                      : const SizedBox(),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: value.dialogtrans
                      ? Container(
                          width: 600,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Pilih Transaksi",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  InkWell(
                                    onTap: () {
                                      value.tutupTransaksi();
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
                                      child: Icon(Icons.close),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  height: MediaQuery.of(context).size.height,
                                  child: SfDataGrid(
                                    headerRowHeight: 40,
                                    defaultColumnWidth: 180,
                                    frozenColumnsCount: 1,
                                    gridLinesVisibility: GridLinesVisibility.both,
                                    headerGridLinesVisibility: GridLinesVisibility.both,
                                    selectionMode: SelectionMode.single,
                                    source: DetailDataTransaksi(value),
                                    columns: <GridColumn>[
                                      GridColumn(
                                          width: 80,
                                          columnName: 'action',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('Aksi',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'tgltranstrans',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('Tanggal Valuta',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'nilaitrans',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('Nilai',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'sisasaldof',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('Sisa',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'nodoktrans',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('No. Dokumen',
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
                                              padding: const EdgeInsets.all(6),
                                              alignment: Alignment.center,
                                              child: const Text('Keterangan',
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
                        )
                      : value.dialog
                          ? value.jenis == "AKTIVA"
                              ? Container(
                                  width: 600,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              "Penyelesaian Transaksi",
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
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
                                              child: const Icon(Icons.close),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      Expanded(
                                          child: Form(
                                        key: value.keyForm,
                                        child: ListView(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Tanggal Valuta",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: TextFormField(
                                                    textInputAction: TextInputAction.done,
                                                    controller: value.tglBackDatetext,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      // Make text bigger and black
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    validator: (e) {
                                                      if (e!.isEmpty && value.backDate) {
                                                        return "Wajib diisi";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      filled: !value.backDate,
                                                      fillColor: Colors.grey[200],
                                                      hintText: "Tanggal Valuta",
                                                      hintStyle: const TextStyle(color: Colors.grey),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                      disabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.grey.shade600),
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            const Row(
                                              children: [
                                                Text(
                                                  "Pilih Kredit Akun",
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
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    // enabled: false,
                                                    readOnly: true,
                                                    textInputAction: TextInputAction.done,
                                                    controller: value.nossbcretrans,
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
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  child: TextFormField(
                                                    // enabled: false,
                                                    readOnly: true,
                                                    textInputAction: TextInputAction.done,
                                                    controller: value.namaSbbCreTrans,
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
                                                        borderRadius: BorderRadius.circular(6),
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
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            const Row(
                                              children: [
                                                Text(
                                                  "Nilai Transaksi",
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
                                                hintText: "Nilai Transaksi",
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
                                            const Row(
                                              children: [
                                                Text(
                                                  "Pilih Debet Akun",
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
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TypeAheadField<InqueryGlModel>(
                                                    controller: value.namaSbbDebit,
                                                    suggestionsCallback: (search) => value.getInqueryTrans(search),
                                                    builder: (context, controller, focusNode) {
                                                      return TextField(
                                                          controller: controller,
                                                          focusNode: focusNode,
                                                          autofocus: true,
                                                          decoration: const InputDecoration(
                                                            border: OutlineInputBorder(),
                                                            labelText: 'Cari Akun',
                                                          ));
                                                    },
                                                    itemBuilder: (context, city) {
                                                      return ListTile(
                                                        title: Text(city.nosbb),
                                                        subtitle: Text(city.namaSbb),
                                                      );
                                                    },
                                                    onSelected: (city) {
                                                      // value.selectInvoice(city);
                                                      value.pilihAkunDebTrans(city);
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                SizedBox(
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
                                                      hintText: "Nomor Kredit",
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                )
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
                                              onChanged: (e) => value.onchange(),
                                              textInputAction: TextInputAction.done,
                                              controller: value.nominal,
                                              maxLines: 1,
                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: [
                                                a.CurrencyInputFormatter(
                                                  useSymbolPadding: true,
                                                  thousandSeparator: a.ThousandSeparator.Period,
                                                  mantissaLength: 2, // jumlah angka desimal
                                                  // decimalSeparator: DecimalSeparator.Comma,
                                                ),
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
                                            const Row(
                                              children: [
                                                Text(
                                                  "Selisih",
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
                                              readOnly: true,
                                              textInputAction: TextInputAction.done,
                                              controller: value.selisihText,
                                              maxLines: 1,
                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: [
                                                a.CurrencyInputFormatter(
                                                  useSymbolPadding: true,
                                                  thousandSeparator: a.ThousandSeparator.Period,
                                                  mantissaLength: 2, // jumlah angka desimal
                                                  // decimalSeparator: DecimalSeparator.Comma,
                                                ),
                                              ],
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                fillColor: Colors.grey[200],
                                                filled: true,
                                                hintText: "Selisih Transaksi",
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
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          "Nomor Dokumen",
                                                          style: TextStyle(fontSize: 12),
                                                        ),
                                                        SizedBox(width: 5),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    TextFormField(
                                                      textInputAction: TextInputAction.done,
                                                      controller: value.nomorDok,
                                                      maxLines: 1,
                                                      readOnly: true,
                                                      validator: (e) {
                                                        if (e!.isEmpty) {
                                                          return "Wajib diisi";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: InputDecoration(
                                                        hintText: "Nomor Dok",
                                                        filled: true,
                                                        fillColor: Colors.grey[300],
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(6),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          "Nomor Reference",
                                                          style: TextStyle(fontSize: 12),
                                                        ),
                                                        SizedBox(width: 5),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    TextFormField(
                                                      textInputAction: TextInputAction.done,
                                                      controller: value.nomorRef,
                                                      maxLines: 1,
                                                      validator: (e) {
                                                        if (e!.isEmpty) {
                                                          return "Wajib diisi";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: InputDecoration(
                                                        hintText: "Nomor Referensi",
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(6),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            const Row(
                                              children: [
                                                Text(
                                                  "Keterangan",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                SizedBox(width: 5),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextFormField(
                                              controller: value.keteranganTrans,
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              textInputAction: TextInputAction.done,
                                              decoration: InputDecoration(
                                                hintText: "Keterangan Transaksi",
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            value.selisih > 0
                                                ? Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Text("Terjadi selisih transaksi, apakah yakin akan menlanjutkan transaksi ini?"),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: ButtonDanger(
                                                                  name: "Tidak",
                                                                  onTap: () {
                                                                    value.tomboltidak();
                                                                  })),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                              child: ButtonPrimary(
                                                            onTap: () {
                                                              value.cek();
                                                            },
                                                            name: "Simpan",
                                                          ))
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                : ButtonPrimary(
                                                    onTap: () {
                                                      value.cek();
                                                    },
                                                    name: "Simpan",
                                                  )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                              : Container(
                                  width: 600,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              "Penyelesaian Transaksi",
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
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
                                              child: const Icon(Icons.close),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      Expanded(
                                          child: Form(
                                        key: value.keyForm,
                                        child: ListView(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Tanggal Valuta",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: TextFormField(
                                                    textInputAction: TextInputAction.done,
                                                    controller: value.tglBackDatetext,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      // Make text bigger and black
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    validator: (e) {
                                                      if (e!.isEmpty && value.backDate) {
                                                        return "Wajib diisi";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      filled: !value.backDate,
                                                      fillColor: Colors.grey[200],
                                                      hintText: "Tanggal Valuta",
                                                      hintStyle: const TextStyle(color: Colors.grey),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                      disabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.grey.shade600),
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            const Row(
                                              children: [
                                                Text(
                                                  "Pilih Debet Akun",
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
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                SizedBox(
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
                                                        borderRadius: BorderRadius.circular(6),
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
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            const Row(
                                              children: [
                                                Text(
                                                  "Nilai Transaksi",
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
                                                hintText: "Nilai Transaksi",
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
                                            const Row(
                                              children: [
                                                Text(
                                                  "Pilih Kredit Akun",
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
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TypeAheadField<InqueryGlModel>(
                                                    controller: value.nossbcretrans,
                                                    suggestionsCallback: (search) => value.getInqueryTrans(search),
                                                    builder: (context, controller, focusNode) {
                                                      return TextField(
                                                          controller: controller,
                                                          focusNode: focusNode,
                                                          autofocus: true,
                                                          decoration: const InputDecoration(
                                                            border: OutlineInputBorder(),
                                                            labelText: 'Cari Akun',
                                                          ));
                                                    },
                                                    itemBuilder: (context, city) {
                                                      return ListTile(
                                                        title: Text(city.nosbb),
                                                        subtitle: Text(city.namaSbb),
                                                      );
                                                    },
                                                    onSelected: (city) {
                                                      // value.selectInvoice(city);
                                                      value.pilihAkunCreTrans(city);
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  child: TextFormField(
                                                    // enabled: false,
                                                    readOnly: true,
                                                    textInputAction: TextInputAction.done,
                                                    controller: value.namaSbbCreTrans,
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
                                                      hintText: "Nomor Kredit",
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                )
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
                                              onChanged: (e) => value.onchange(),
                                              textInputAction: TextInputAction.done,
                                              controller: value.nominal,
                                              maxLines: 1,
                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: [
                                                a.CurrencyInputFormatter(
                                                  useSymbolPadding: true,
                                                  thousandSeparator: a.ThousandSeparator.Period,
                                                  mantissaLength: 2, // jumlah angka desimal
                                                  // decimalSeparator: DecimalSeparator.Comma,
                                                ),
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
                                            const Row(
                                              children: [
                                                Text(
                                                  "Selisih",
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
                                              readOnly: true,
                                              textInputAction: TextInputAction.done,
                                              controller: value.selisihText,
                                              maxLines: 1,
                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: [
                                                a.CurrencyInputFormatter(
                                                  useSymbolPadding: true,
                                                  thousandSeparator: a.ThousandSeparator.Period,
                                                  mantissaLength: 2, // jumlah angka desimal
                                                  // decimalSeparator: DecimalSeparator.Comma,
                                                ),
                                              ],
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                fillColor: Colors.grey[200],
                                                filled: true,
                                                hintText: "Selisih Transaksi",
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
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          "Nomor Dokumen",
                                                          style: TextStyle(fontSize: 12),
                                                        ),
                                                        SizedBox(width: 5),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    TextFormField(
                                                      textInputAction: TextInputAction.done,
                                                      controller: value.nomorDok,
                                                      maxLines: 1,
                                                      readOnly: true,
                                                      validator: (e) {
                                                        if (e!.isEmpty) {
                                                          return "Wajib diisi";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: InputDecoration(
                                                        hintText: "Nomor Dok",
                                                        filled: true,
                                                        fillColor: Colors.grey[300],
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(6),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          "Nomor Reference",
                                                          style: TextStyle(fontSize: 12),
                                                        ),
                                                        SizedBox(width: 5),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    TextFormField(
                                                      textInputAction: TextInputAction.done,
                                                      controller: value.nomorRef,
                                                      maxLines: 1,
                                                      validator: (e) {
                                                        if (e!.isEmpty) {
                                                          return "Wajib diisi";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: InputDecoration(
                                                        hintText: "Nomor Referensi",
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(6),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            const Row(
                                              children: [
                                                Text(
                                                  "Keterangan",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                SizedBox(width: 5),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextFormField(
                                              controller: value.keteranganTrans,
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              textInputAction: TextInputAction.done,
                                              decoration: InputDecoration(
                                                hintText: "Keterangan Transaksi",
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            value.selisih > 0
                                                ? Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Text("Terjadi selisih transaksi, apakah yakin akan menlanjutkan transaksi ini?"),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: ButtonDanger(
                                                                  name: "Tidak",
                                                                  onTap: () {
                                                                    value.tomboltidak();
                                                                  })),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                              child: ButtonPrimary(
                                                            onTap: () {
                                                              value.cek();
                                                            },
                                                            name: "Simpan",
                                                          ))
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                : ButtonPrimary(
                                                    onTap: () {
                                                      value.cek();
                                                    },
                                                    name: "Simpan",
                                                  )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                          : const SizedBox(),
                )
              ],
            ),
          )),
        ));
  }
}

Widget headerText(String label) => Container(
      padding: const EdgeInsets.all(8),
      color: colorPrimary,
      child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
    );

Widget headerCell(String label, double width) => Container(
      width: width,
      padding: const EdgeInsets.all(8),
      color: colorPrimary,
      child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
    );

Widget cell(String content, double width) => Container(
      width: width,
      padding: const EdgeInsets.all(8),
      child: Text(content, style: const TextStyle(fontSize: 12)),
    );

class DetailDataTransaksi extends DataGridSource {
  DetailDataTransaksi(PerantaraAktivaNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listTransaksiAdd);
  }

  PerantaraAktivaNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<PerantaraModel> list) {
    var no = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'action', value: data.rrn),
                DataGridCell(columnName: 'tgltranstrans', value: data.tglValuta),
                DataGridCell(columnName: 'nilaitrans', value: FormatCurrency.oCcy.format(int.parse(data.nominal))),
                DataGridCell(columnName: 'sisa', value: FormatCurrency.oCcy.format(data.sisaSaldo)),
                DataGridCell(columnName: 'nodoktrans', value: data.noDokumen),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
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
                tindakanNotifier!.pilihTransaksi(e.value);
              },
              child: Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorPrimary,
                  border: Border.all(
                    width: 2,
                    color: colorPrimary,
                  ),
                ),
                child: const Text(
                  "Pilih",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
