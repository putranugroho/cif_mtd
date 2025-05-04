import 'package:accounting/models/index.dart';
import 'package:accounting/module/inventaris/pengadaan/pengadaan_notifier.dart';
import 'package:accounting/module/setup/golongan_aset/golongan_aset_notifier.dart';

import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';

class PengadaanPage extends StatelessWidget {
  const PengadaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PengadaanNotifier(context: context),
      child: Consumer<PengadaanNotifier>(
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
                            child: Text(
                              "Pengadaan",
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
                              child: Text(
                                "Tambah Pengadaan",
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
                                columnName: 'kdaset',
                                label: Container(
                                    padding: EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: Text('No. Aset',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                columnName: 'keterangan',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Nama Aset',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'kelompok',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Kelompok',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'golongan',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Golongan',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'harga',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Harga',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'diskon',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Diskon',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'biaya',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Biaya',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'ppn',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('PPN',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'total',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Total',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'action',
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
                    : SizedBox(),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Tambah Pengadaan",
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
                                child: FocusTraversalGroup(
                              child: ListView(
                                children: [
                                  Stepper(
                                    key: ValueKey("1"),
                                    connectorColor:
                                        const WidgetStatePropertyAll(
                                            colorPrimary),
                                    currentStep: value.currentStep,
                                    onStepContinue: () {
                                      value.onStepContinue();
                                    },
                                    onStepCancel: () {
                                      value.onStepBack();
                                    },
                                    controlsBuilder: (context, detail) =>
                                        Container(
                                            margin: const EdgeInsets.only(
                                                top: 16.0),
                                            child: value.currentStep == 3
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          value.onStepBack();
                                                        },
                                                        child: const Text(
                                                            'Kembali'),
                                                      ),
                                                    ],
                                                  )
                                                : value.currentStep == 0
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              value
                                                                  .onStepContinue();
                                                            },
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      colorPrimary),
                                                            ),
                                                            child: const Text(
                                                              'Lanjut',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              value
                                                                  .onStepBack();
                                                            },
                                                            child: const Text(
                                                                'Kembali'),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              value
                                                                  .onStepContinue();
                                                            },
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      colorPrimary),
                                                            ),
                                                            child: const Text(
                                                              'Lanjut',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                    steps: [
                                      Step(
                                          title: Text("Data Inventaris",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          content: Form(
                                              key: value.formStep[0],
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Kelompok",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            fontSize: 8),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  DropdownSearch<
                                                      KelompokAsetModel>(
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'Wajib diisi';
                                                      }
                                                      return null;
                                                    },
                                                    popupProps:
                                                        const PopupPropsMultiSelection
                                                            .menu(
                                                      showSearchBox:
                                                          true, // Aktifkan fitur pencarian
                                                    ),
                                                    selectedItem:
                                                        value.kelompokAsetModel,
                                                    items: value.listKelompok,
                                                    itemAsString: (e) =>
                                                        "${e.namaKelompokn}",
                                                    onChanged: (e) {
                                                      value.pilihKelompok(e!);
                                                    },
                                                    dropdownDecoratorProps:
                                                        DropDownDecoratorProps(
                                                      baseStyle: TextStyle(
                                                          fontSize: 16),
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Pilih Kelompok Aset",
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
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Golongan",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            fontSize: 8),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  DropdownSearch<
                                                      GolonganAsetModel>(
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'Wajib diisi';
                                                      }
                                                      return null;
                                                    },
                                                    popupProps:
                                                        const PopupPropsMultiSelection
                                                            .menu(
                                                      showSearchBox:
                                                          true, // Aktifkan fitur pencarian
                                                    ),
                                                    selectedItem:
                                                        value.golonganAsetModel,
                                                    items: value.listGolongan,
                                                    itemAsString: (e) =>
                                                        "${e.namaGolongan}",
                                                    onChanged: (e) {
                                                      value.pilihGolongan(e!);
                                                    },
                                                    dropdownDecoratorProps:
                                                        DropDownDecoratorProps(
                                                      baseStyle: TextStyle(
                                                          fontSize: 16),
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Pilih Golongan Aset",
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
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Nomor Aset",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              const Text(
                                                                "*",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        8),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          TextFormField(
                                                            controller:
                                                                value.noaset,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            maxLines: 1,
                                                            validator: (e) {
                                                              if (e!.isEmpty) {
                                                                return "Wajib diisi";
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Nomor Aset",
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 16),
                                                        ],
                                                      )),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Satuan",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              const Text(
                                                                "*",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        8),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          DropdownSearch<
                                                              String>(
                                                            validator: (value) {
                                                              if (value ==
                                                                  null) {
                                                                return 'Wajib diisi';
                                                              }
                                                              return null;
                                                            },
                                                            popupProps:
                                                                const PopupPropsMultiSelection
                                                                    .menu(
                                                              showSearchBox:
                                                                  true, // Aktifkan fitur pencarian
                                                            ),
                                                            selectedItem: value
                                                                .satuanModel,
                                                            items: value
                                                                .listSatuan,
                                                            itemAsString: (e) =>
                                                                "${e}",
                                                            onChanged: (e) {
                                                              value.pilihSatuan(
                                                                  e!);
                                                            },
                                                            dropdownDecoratorProps:
                                                                DropDownDecoratorProps(
                                                              baseStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          16),
                                                              textAlignVertical:
                                                                  TextAlignVertical
                                                                      .center,
                                                              dropdownSearchDecoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Pilih Satuan",
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
                                                          const SizedBox(
                                                            height: 16,
                                                          ),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Nama Aset",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
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
                                                    controller: value.namaaset,
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
                                                      hintText: "Nama Aset",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Keterangan",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
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
                                                    controller:
                                                        value.keterangan,
                                                    maxLines: 1,
                                                    validator: (e) {
                                                      if (e!.isEmpty) {
                                                        return "Wajib diisi";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: "Keterangan",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Nomor Dokumen Pembelian",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
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
                                                    controller: value.noDok,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    maxLines: 1,
                                                    validator: (e) {
                                                      if (e!.isEmpty) {
                                                        return "Wajib diisi";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Nomor Dokumen Pembelian",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Tanggal Beli",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              const Text(
                                                                "*",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        8),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          InkWell(
                                                            onTap: () => value
                                                                .pilihTanggalBuka(),
                                                            child:
                                                                TextFormField(
                                                              enabled: false,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              controller:
                                                                  value.tglbeli,
                                                              maxLines: 1,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Tanggal Beli",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 16),
                                                        ],
                                                      )),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Tanggal Terima",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              const Text(
                                                                "*",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        8),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          InkWell(
                                                            onTap: () => value
                                                                .pilihTanggalTerima(),
                                                            child:
                                                                TextFormField(
                                                              enabled: false,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              controller: value
                                                                  .tglterima,
                                                              maxLines: 1,
                                                              // validator: (e) {
                                                              //   if (e!.isEmpty) {
                                                              //     return "Wajib diisi";
                                                              //   } else {
                                                              //     return null;
                                                              //   }
                                                              // },
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Tanggal Terima",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 16),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                ],
                                              ))),
                                      Step(
                                          title: Text(
                                            "Penempatan",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: Form(
                                              key: value.formStep[1],
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Kantor / Karyawan",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            fontSize: 8),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  DropdownSearch<String>(
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'Wajib diisi';
                                                      }
                                                      return null;
                                                    },
                                                    popupProps:
                                                        const PopupPropsMultiSelection
                                                            .menu(
                                                      showSearchBox:
                                                          true, // Aktifkan fitur pencarian
                                                    ),
                                                    selectedItem:
                                                        value.penempatanModel,
                                                    items: value.listPenempatan,
                                                    itemAsString: (e) => "${e}",
                                                    onChanged: (e) {
                                                      value.pilihPenempatan(e!);
                                                    },
                                                    dropdownDecoratorProps:
                                                        DropDownDecoratorProps(
                                                      baseStyle: TextStyle(
                                                          fontSize: 16),
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Pilih Kantor / Karyawan",
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
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  value.penempatanModel ==
                                                          "Kantor"
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Text(
                                                              "Kantor",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            DropdownSearch<
                                                                KantorModel>(
                                                              popupProps:
                                                                  const PopupPropsMultiSelection
                                                                      .menu(
                                                                showSearchBox:
                                                                    true, // Aktifkan fitur pencarian
                                                              ),
                                                              selectedItem:
                                                                  value.kantor,
                                                              items: value
                                                                  .listKantor,
                                                              itemAsString: (e) =>
                                                                  "${e.namaKantor}",
                                                              onChanged: (e) {
                                                                value
                                                                    .pilihKantor(
                                                                        e!);
                                                              },
                                                              dropdownDecoratorProps:
                                                                  DropDownDecoratorProps(
                                                                baseStyle:
                                                                    TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                textAlignVertical:
                                                                    TextAlignVertical
                                                                        .center,
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "Pilih Kantor",
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
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
                                                            const SizedBox(
                                                              height: 16,
                                                            ),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                    child:
                                                                        Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  children: [
                                                                    Text(
                                                                      "Lokasi",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 8,
                                                                    ),
                                                                    TextFormField(
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .done,
                                                                      maxLines:
                                                                          1,
                                                                      validator:
                                                                          (e) {
                                                                        if (e!
                                                                            .isEmpty) {
                                                                          return "Wajib diisi";
                                                                        } else {
                                                                          return null;
                                                                        }
                                                                      },
                                                                      controller:
                                                                          value
                                                                              .lokasi,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            "Lokasi",
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(6),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            16),
                                                                  ],
                                                                )),
                                                                SizedBox(
                                                                  width: 16,
                                                                ),
                                                                Expanded(
                                                                    child:
                                                                        Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  children: [
                                                                    Text(
                                                                      "Kota",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 8,
                                                                    ),
                                                                    TextFormField(
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .done,
                                                                      maxLines:
                                                                          1,
                                                                      controller:
                                                                          value
                                                                              .kota,
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
                                                                        hintText:
                                                                            "Kota",
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(6),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            16),
                                                                  ],
                                                                ))
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      : Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Text(
                                                              "Nama Karyawan",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            TextFormField(
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              maxLines: 1,
                                                              decoration:
                                                                  InputDecoration(
                                                                suffixIcon: IconButton(
                                                                    onPressed:
                                                                        () {},
                                                                    icon: Icon(Icons
                                                                        .search)),
                                                                hintText:
                                                                    "Silahkan Masukkan Nama Karyawan",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 16),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "NIP Karyawan",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                const Text(
                                                                  "*",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            TextFormField(
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              maxLines: 1,
                                                              readOnly: true,
                                                              // inputFormatters: [
                                                              //   FilteringTextInputFormatter.digitsOnly
                                                              // ],
                                                              validator: (e) {
                                                                if (e!
                                                                    .isEmpty) {
                                                                  return "Wajib diisi";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                filled: true,
                                                                fillColor:
                                                                    Colors.grey[
                                                                        200],
                                                                hintText:
                                                                    "NIP Karyawan",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 16),
                                                          ],
                                                        ),
                                                ],
                                              ))),
                                      Step(
                                          title: Text(
                                            "Penyusutan",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Form(
                                              key: value.formStep[2],
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Text(
                                                            "Nilai Akhir",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          TextFormField(
                                                            controller: value
                                                                .nilaiPenyusutan,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            maxLines: 1,
                                                            validator: (e) {
                                                              if (e!.isEmpty) {
                                                                return "Wajib diisi";
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly,
                                                            ],
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Nilai Akhir",
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 16),
                                                        ],
                                                      )),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      value.metode == 1
                                                          ? Expanded(
                                                              child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .stretch,
                                                              children: [
                                                                Text(
                                                                  "Masa Susut",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                TextFormField(
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .done,
                                                                  maxLines: 1,
                                                                  validator:
                                                                      (e) {
                                                                    if (e!
                                                                        .isEmpty) {
                                                                      return "Wajib diisi";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly,
                                                                  ],
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Masa Susut",
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 16),
                                                              ],
                                                            ))
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Bulan Mulai Penyusutan",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            fontSize: 8),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  InkWell(
                                                    onTap: () =>
                                                        value.showDate(),
                                                    child: TextFormField(
                                                      enabled: false,
                                                      controller:
                                                          value.blnPenyusutan,
                                                      // validator: (e) {
                                                      //   if (e!.isEmpty) {
                                                      //     return "Wajib diisi";
                                                      //   } else {
                                                      //     return null;
                                                      //   }
                                                      // },
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Bulan Mulai Penyusutan",
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                ],
                                              ))),
                                      Step(
                                          title: Text(
                                            "Rincian Harga Perolehan",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Form(
                                              key: value.formStep[3],
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Harga Beli",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
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
                                                    controller: value.hargaBeli,
                                                    maxLines: 1,
                                                    onChanged: (e) =>
                                                        value.onChange(),
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    validator: (e) {
                                                      if (e!.isEmpty) {
                                                        return "Wajib diisi";
                                                      } else {
                                                        if (e == "0") {
                                                          return "Wajib diisi";
                                                        }
                                                        return null;
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: "Harga Beli",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Diskon",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
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
                                                    controller: value.discount,
                                                    maxLines: 1,
                                                    onChanged: (e) =>
                                                        value.onChange(),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
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
                                                      hintText: "Diskon",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Biaya",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
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
                                                    controller: value.biaya,
                                                    maxLines: 1,
                                                    onChanged: (e) =>
                                                        value.onChange(),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
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
                                                      hintText: "Biaya",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Pajak",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
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
                                                      Radio(
                                                          value: false,
                                                          groupValue:
                                                              value.pajak,
                                                          onChanged: (e) =>
                                                              value.gantipajak(
                                                                  false)),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text("Tidak Pajak"),
                                                      SizedBox(
                                                        width: 24,
                                                      ),
                                                      Radio(
                                                          value: true,
                                                          groupValue:
                                                              value.pajak,
                                                          onChanged: (e) =>
                                                              value.gantipajak(
                                                                  true)),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text("Pajak"),
                                                    ],
                                                  ),
                                                  value.pajak
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            SizedBox(
                                                              height: 16,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "PPN",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                const Text(
                                                                  "*",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            TextFormField(
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              controller:
                                                                  value.ppn,
                                                              maxLines: 1,
                                                              onChanged: (e) =>
                                                                  value
                                                                      .onChange(),
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                                CurrencyInputFormatter(),
                                                              ],
                                                              validator: (e) {
                                                                if (e!
                                                                    .isEmpty) {
                                                                  return "Wajib diisi";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText: "PPN",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 16),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "PPH",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                const Text(
                                                                  "*",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            TextFormField(
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              controller:
                                                                  value.pph,
                                                              maxLines: 1,
                                                              onChanged: (e) =>
                                                                  value
                                                                      .onChange(),
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                                CurrencyInputFormatter(),
                                                              ],
                                                              validator: (e) {
                                                                if (e!
                                                                    .isEmpty) {
                                                                  return "Wajib diisi";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText: "PPH",
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox(),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 16),
                                                    height: 1,
                                                    color: Colors.grey[300],
                                                  ),
                                                  value.pajak
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    "Sub Total",
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "${FormatCurrency.oCcy.format(value.subtotal)}",
                                                                  style:
                                                                      TextStyle(),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    "Pajak",
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "${FormatCurrency.oCcy.format(int.parse(value.ppn.text.replaceAll(",", "")))}",
                                                                  style:
                                                                      TextStyle(),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    "PPH",
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "(${FormatCurrency.oCcy.format(int.parse(value.pph.text.replaceAll(",", "")))})",
                                                                  style:
                                                                      TextStyle(),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    "Total",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "${FormatCurrency.oCcy.format(value.total)}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "Total",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              "${FormatCurrency.oCcy.format(value.total)}",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  ButtonPrimary(
                                                    onTap: () {
                                                      value.cek();
                                                    },
                                                    name: "Simpan",
                                                  )
                                                ],
                                              )))
                                    ],
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      )
                    : SizedBox(),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(PengadaanNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  PengadaanNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<InventarisModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'kdaset', value: data.kdaset),
                DataGridCell(columnName: 'Keterangan', value: data.ket),
                DataGridCell(columnName: 'kelompok', value: data.namaKelompok),
                DataGridCell(columnName: 'golongan', value: data.namaGolongan),
                DataGridCell(
                    columnName: 'harga',
                    value: FormatCurrency.oCcy.format(int.parse(data.habeli))),
                DataGridCell(
                    columnName: 'diskon',
                    value: FormatCurrency.oCcy.format(int.parse(data.disc))),
                DataGridCell(
                    columnName: 'biaya',
                    value: FormatCurrency.oCcy.format(int.parse(data.habeli))),
                DataGridCell(
                    columnName: 'ppn',
                    value: FormatCurrency.oCcy.format(int.parse(data.ppnBeli))),
                DataGridCell(
                    columnName: 'total',
                    value: FormatCurrency.oCcy.format(int.parse(data.haper))),
                DataGridCell(columnName: 'action', value: data.kdaset),
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
          );
        } else if (e.columnName == 'harga' ||
            e.columnName == 'diskon' ||
            e.columnName == 'ppn' ||
            e.columnName == 'biaya' ||
            e.columnName == 'total') {
          return Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value.toString(),
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
