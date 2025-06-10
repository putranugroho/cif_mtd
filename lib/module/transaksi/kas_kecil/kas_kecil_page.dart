import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/golongan_aset/golongan_aset_notifier.dart';
import 'package:accounting/module/transaksi/kas_kecil/kas_kecil_notifier.dart';
import 'package:accounting/module/transaksi/satu_transaksi/satu_transaksi_notifier.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart' as a;
import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';

class KasKecilPage extends StatelessWidget {
  const KasKecilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KasKecilNotifier(context: context),
      child: Consumer<KasKecilNotifier>(
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
                          const Expanded(
                            child: Text(
                              "Kas Kecil",
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
                              child: const Text(
                                "Tambah Transaksi",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
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
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('No',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 100,
                                columnName: 'status',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Status',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                width: 100,
                                columnName: 'tgl_val',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Tanggal Valuta',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                width: 100,
                                columnName: 'tgl_trans',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Tanggal Input',
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
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nomor Dokumen',
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
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nomor Referensi',
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
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nominal',
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
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nama Akun Debet',
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
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nama Akun Kredit',
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
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Keterangan',
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
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Akun Debet',
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
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Akun Kredit',
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
                        padding: const EdgeInsets.all(20),
                        width: 600,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                const Expanded(
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
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.close),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Expanded(
                              child: FocusTraversalGroup(
                                child: Form(
                                  key: value.keyForm,
                                  child: ListView(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Transaksi Back Date",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                          const SizedBox(width: 16),
                                          Checkbox(
                                            activeColor: colorPrimary,
                                            value: value.backDate,
                                            onChanged: (e) =>
                                                value.gantibackDate(),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () =>
                                                  value.tanggalBackDate(),
                                              child: TextFormField(
                                                enabled: !value.backDate,
                                                textInputAction:
                                                    TextInputAction.done,
                                                controller:
                                                    value.tglBackDatetext,
                                                maxLines: 1,
                                                readOnly: !value.backDate,
                                                style: const TextStyle(
                                                  // Make text bigger and black
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                validator: (e) {
                                                  if (e!.isEmpty &&
                                                      value.backDate) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  filled: !value.backDate,
                                                  fillColor: Colors.grey[200],
                                                  hintText: "Tanggal Valuta",
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade600),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
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
                                            "Kode Transaksi",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child:
                                                DropdownSearch<SetupTransModel>(
                                              popupProps:
                                                  const PopupPropsMultiSelection
                                                      .menu(
                                                showSearchBox:
                                                    true, // Aktifkan fitur pencarian
                                              ),
                                              selectedItem:
                                                  value.setupTransModel,
                                              items: value.listData,
                                              itemAsString: (e) => e.namaTrans,
                                              onChanged: (e) {
                                                value.pilihTransModel(e!);
                                              },
                                              dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                baseStyle: const TextStyle(
                                                    fontSize: 16),
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintText:
                                                      "Pilih Kode Transaksi",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 1,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: TextFormField(
                                              // enabled: false,
                                              readOnly: true,
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.namaTransaksi,
                                              maxLines: 1,
                                              // inputFormatters: [
                                              //   FilteringTextInputFormatter.digitsOnly
                                              // ],

                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.grey[200],
                                                hintText: "Kode Transaksi",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              value.cancelKode();
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: colorPrimary),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      value.setupTransModel != null
                                          ? const SizedBox()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Pilih Metode Kas Kecil",
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
                                                  height: 16,
                                                ),
                                                DropdownSearch<String>(
                                                  popupProps:
                                                      const PopupPropsMultiSelection
                                                          .menu(
                                                    showSearchBox:
                                                        true, // Aktifkan fitur pencarian
                                                  ),
                                                  selectedItem: value.metode,
                                                  items: value.listMetodeKas,
                                                  itemAsString: (e) => e,
                                                  onChanged: (e) {
                                                    value.pilihMetode(e!);
                                                  },
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    baseStyle: const TextStyle(
                                                        fontSize: 16),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      hintText: "Pilih Metode",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            ),
                                      value.metode == "Pengeluaran"
                                          ? const SizedBox()
                                          : Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          "Pilih Debet Akun",
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
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: TextField(
                                                                readOnly: true,
                                                                controller: value
                                                                    .nosbbdeb,
                                                                enabled: value
                                                                    .cancel,
                                                                autofocus: true,
                                                                decoration:
                                                                    InputDecoration(
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors.grey[
                                                                          200],
                                                                  border:
                                                                      const OutlineInputBorder(),
                                                                  labelText:
                                                                      'Cari Akun',
                                                                ))),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        SizedBox(
                                                          width: 150,
                                                          child: TextFormField(
                                                            // enabled: false,
                                                            readOnly: true,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            controller: value
                                                                .namaSbbDeb,
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
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[200],
                                                              hintText:
                                                                  "Nomor Debet",
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
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          "Pilih Kredit Akun",
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
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: TypeAheadField<
                                                              InqueryGlModel>(
                                                            controller:
                                                                value.nossbcre,
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
                                                                  enabled: value
                                                                      .cancel,
                                                                  autofocus:
                                                                      true,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    labelText:
                                                                        'Cari Akun',
                                                                  ));
                                                            },
                                                            itemBuilder:
                                                                (context,
                                                                    city) {
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
                                                                  .pilihAkunCre(
                                                                      city);
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
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            controller: value
                                                                .namaSbbCre,
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
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[200],
                                                              hintText:
                                                                  "Nomor Kredit",
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                      value.metode == "Pemasukan"
                                          ? const SizedBox()
                                          : Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          "Pilih Kredit Akun",
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
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: TextField(
                                                                controller: value
                                                                    .nossbcre,
                                                                enabled: value
                                                                    .cancel,
                                                                autofocus: true,
                                                                decoration:
                                                                    InputDecoration(
                                                                  fillColor:
                                                                      Colors.grey[
                                                                          200],
                                                                  filled: true,
                                                                  border:
                                                                      const OutlineInputBorder(),
                                                                  labelText:
                                                                      'Cari Akun',
                                                                ))),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        SizedBox(
                                                          width: 150,
                                                          child: TextFormField(
                                                            // enabled: false,
                                                            readOnly: true,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            controller: value
                                                                .namaSbbCre,
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
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[200],
                                                              hintText:
                                                                  "Nomor Kredit",
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
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          "Pilih Debet Akun",
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
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: TypeAheadField<
                                                              InqueryGlModel>(
                                                            controller:
                                                                value.nosbbdeb,
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
                                                                  enabled: value
                                                                      .cancel,
                                                                  autofocus:
                                                                      true,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    labelText:
                                                                        'Cari Akun',
                                                                  ));
                                                            },
                                                            itemBuilder:
                                                                (context,
                                                                    city) {
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
                                                                  .pilihAkunDeb(
                                                                      city);
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
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            controller: value
                                                                .namaSbbDeb,
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
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[200],
                                                              hintText:
                                                                  "Nomor Debet",
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Row(
                                                children: [
                                                  Text(
                                                    "Nomor Dokumen",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  SizedBox(width: 5),
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
                                                        BorderRadius.circular(
                                                            6),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Row(
                                                children: [
                                                  Text(
                                                    "Nomor Reference",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  SizedBox(width: 5),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
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
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        inputFormatters: [
                                          a.CurrencyInputFormatter(
                                            leadingSymbol: 'Rp ',
                                            useSymbolPadding: true,
                                            thousandSeparator:
                                                a.ThousandSeparator.Period,
                                            mantissaLength:
                                                2, // jumlah angka desimal
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
                                        controller: value.keterangan,
                                        textInputAction: TextInputAction.done,
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return "Wajib diisi";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Keterangan Transaksi",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ButtonPrimary(
                                        onTap: () {
                                          value.cek();
                                        },
                                        name: "Simpan",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(KasKecilNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listTransaksiAdd);
  }

  KasKecilNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<TransaksiPendModel> list) {
    int index = 1;

    // 🔽 Sort data terlebih dahulu
    list.sort((a, b) {
      final tglA = DateTime.tryParse(a.tglValuta) ?? DateTime(1900);
      final tglB = DateTime.tryParse(b.tglValuta) ?? DateTime(1900);

      if (tglA.compareTo(tglB) != 0) {
        return tglA.compareTo(tglB); // urut berdasarkan tanggal dulu
      }

      return a.noDokumen
          .compareTo(b.noDokumen); // lalu urut berdasarkan nomor dokumen
    });

    // 🧱 Bangun data grid setelah data diurutkan
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'status', value: data.status),
                DataGridCell(columnName: 'tgl_val', value: data.tglValuta),
                DataGridCell(columnName: 'tgl_trans', value: data.tglTransaksi),
                DataGridCell(columnName: 'nomor_dok', value: data.noDokumen),
                DataGridCell(columnName: 'nomor_ref', value: data.noRef),
                DataGridCell(
                    columnName: 'nominal',
                    value: FormatCurrency.oCcyDecimal
                        .format(double.parse(data.nominal))),
                DataGridCell(columnName: 'nama_debet', value: data.namaDr),
                DataGridCell(columnName: 'nama_credit', value: data.namaCr),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
                DataGridCell(columnName: 'debet_acc', value: data.dracc),
                DataGridCell(columnName: 'credit_acc', value: data.cracc),
              ],
            ))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'nominal') {
          return Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        } else if (e.columnName == 'status') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: e.value == "PENDING"
                      ? Colors.orange
                      : e.value == "CANCEL"
                          ? Colors.red
                          : Colors.green),
              child: Text(
                e.value,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
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
