import 'package:accounting/models/index.dart';
import 'package:accounting/module/inventaris/jual_beli/jual_beli_notifier.dart';

import 'package:accounting/utils/button_custom.dart';

import 'package:accounting/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';
import '../../../utils/currency_formatted.dart';

class JualBeliPage extends StatelessWidget {
  const JualBeliPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JualBeliNotifier(context: context),
      child: Consumer<JualBeliNotifier>(
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
                              "Jual/ Hapus",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        Stepper(
                            connectorColor:
                                const WidgetStatePropertyAll(colorPrimary),
                            currentStep: value.currentStep,
                            onStepContinue: () {
                              value.onStepContinue();
                            },
                            onStepCancel: () {
                              value.onStepBack();
                            },
                            controlsBuilder: (context, detail) => Container(
                                margin: const EdgeInsets.only(top: 16.0),
                                child: value.currentStep == 1
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              value.onStepBack();
                                            },
                                            child: const Text('Kembali'),
                                          ),
                                        ],
                                      )
                                    : value.currentStep == 0
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  value.onStepContinue();
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(colorPrimary),
                                                ),
                                                child: const Text(
                                                  'Lanjut',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  value.onStepBack();
                                                },
                                                child: const Text('Kembali'),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton(
                                                onPressed: () {
                                                  value.onStepContinue();
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(colorPrimary),
                                                ),
                                                child: const Text(
                                                  'Lanjut',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )),
                            steps: [
                              Step(
                                  title: Text("Inquery Data Inventaris"),
                                  content: Form(
                                      key: value.formStep[0],
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Pilih Aset / Inventaris",
                                                style: const TextStyle(
                                                    fontSize: 12),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: DropdownSearch<
                                                    InventarisModel>(
                                                  popupProps:
                                                      const PopupPropsMultiSelection
                                                          .menu(
                                                    showSearchBox:
                                                        true, // Aktifkan fitur pencarian
                                                  ),
                                                  selectedItem:
                                                      value.inventarisModel,
                                                  items: value.list,
                                                  itemAsString: (e) =>
                                                      "${e.ket}",
                                                  onChanged: (e) {
                                                    value.pilihInventory(e!);
                                                  },
                                                  dropdownDecoratorProps:
                                                      DropDownDecoratorProps(
                                                    baseStyle:
                                                        TextStyle(fontSize: 16),
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      hintText:
                                                          "Pilih Inventaris",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
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
                                                width: 370,
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller: value.kdAset,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[200],
                                                    filled: true,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          value.inventarisModel != null
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
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
                                                                    "Kelompok",
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
                                                                controller: value
                                                                    .kelompok,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                maxLines: 1,
                                                                readOnly: true,
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
                                                                      "Kelompok Aset",
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
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
                                                                    "Golongan",
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
                                                                controller: value
                                                                    .golongan,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                maxLines: 1,
                                                                readOnly: true,
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
                                                                      "Golongan Aset",
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
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
                                                              controller:
                                                                  value.satuans,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              maxLines: 1,
                                                              readOnly: true,
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
                                                                    "Satuan",
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
                                                        )),
                                                      ],
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
                                                                    "Nomor Dokumen Pembelian",
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
                                                                controller:
                                                                    value.noDok,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                maxLines: 1,
                                                                readOnly: true,
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
                                                                      "Nomor Dokumen Pembelian",
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 16),
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
                                                                  value.tglbeli,
                                                              maxLines: 1,
                                                              readOnly: true,
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
                                                              controller: value
                                                                  .tglterima,
                                                              maxLines: 1,
                                                              readOnly: true,
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
                                                          ],
                                                        )),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Keterangan",
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
                                                                  fontSize: 8),
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
                                                              value.keterangan,
                                                          maxLines: 1,
                                                          readOnly: true,
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
                                                                "Keterangan",
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
                                                    ),
                                                  ],
                                                )
                                              : SizedBox()
                                        ],
                                      ))),
                              Step(
                                  title: Text(
                                    "Jual / Hapus",
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
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Jual / Hapus",
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
                                                        value.pilihModel,
                                                    items: value.listPilih,
                                                    itemAsString: (e) => "${e}",
                                                    onChanged: (e) {
                                                      value.pilihPilih(e!);
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
                                                            "Pilih Jual / Hapus",
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
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                children: [],
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                children: [],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        value.pilihModel == "Jual"
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "Cari Transaksi",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Tanggal Valuta",
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
                                                              controller: value
                                                                  .tglTrans,
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
                                                                hintText:
                                                                    "Tanggal Valuta",
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
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "No. Dokumen",
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
                                                              controller: value
                                                                  .noDokTrans,
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
                                                                hintText:
                                                                    "No. Dokumen",
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
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      InkWell(
                                                        // onTap: () =>
                                                        //     value.tutup(),
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color:
                                                                      Colors.grey[
                                                                          200],
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child:
                                                              Icon(Icons.close),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Nilai Transaksi",
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
                                                              controller: value
                                                                  .nilaiTrans,
                                                              maxLines: 1,
                                                              readOnly: true,
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
                                                                  if (int.tryParse(
                                                                          e) ==
                                                                      0) {
                                                                    return "Wajib diisi";
                                                                  }
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
                                                                    "Nilai Transaksi",
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
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Keterangan Transaksi",
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
                                                              controller: value
                                                                  .keteranganTrans,
                                                              maxLines: 1,
                                                              readOnly: true,
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
                                                                  if (int.tryParse(
                                                                          e) ==
                                                                      0) {
                                                                    return "Wajib diisi";
                                                                  }
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
                                                                    "Keterangan Transaksi",
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
                                                        ),
                                                      ),
                                                    ],
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
                                                          const Text(
                                                            "Nilai Buku",
                                                            style: TextStyle(
                                                                fontSize: 12),
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
                                                            validator: (e) {
                                                              if (e!.isEmpty) {
                                                                return "Wajib diisi";
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            controller:
                                                                value.hargaBuku,
                                                            decoration:
                                                                InputDecoration(
                                                              fillColor: Colors
                                                                  .grey[200],
                                                              filled: true,
                                                              hintText:
                                                                  "Nilai Buku",
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
                                                      )),
                                                      const SizedBox(
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
                                                                  "Tanggal Beli",
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
                                                                  value.tglbeli,
                                                              maxLines: 1,
                                                              readOnly: true,
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
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Column(
                                                          children: [],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Nilai Jual",
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
                                                              controller: value
                                                                  .nilaijual,
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
                                                                hintText:
                                                                    "Nilai Jual",
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
                                                        ),
                                                      ),
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
                                                                  "Tanggal Jual",
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
                                                            InkWell(
                                                              onTap: () => value
                                                                  .piihTanggalJualHapus(),
                                                              child:
                                                                  TextFormField(
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                controller: value
                                                                    .tgljualhapus,
                                                                enabled: false,
                                                                maxLines: 1,
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
                                                                  hintText:
                                                                      "Tanggal Jual",
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
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Alasan Jual",
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
                                                              controller: value
                                                                  .alasanjualhapus,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Alasan Jual",
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
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                ],
                                              )
                                            : Column(
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
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Nilai Buku",
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
                                                              validator: (e) {
                                                                if (e!
                                                                    .isEmpty) {
                                                                  return "Wajib diisi";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              controller: value
                                                                  .hargaBuku,
                                                              decoration:
                                                                  InputDecoration(
                                                                fillColor:
                                                                    Colors.grey[
                                                                        200],
                                                                filled: true,
                                                                hintText:
                                                                    "Nilai Buku",
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
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Tanggal Hapus",
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
                                                            InkWell(
                                                              onTap: () => value
                                                                  .piihTanggalJualHapus(),
                                                              child:
                                                                  TextFormField(
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                controller: value
                                                                    .tgljualhapus,
                                                                enabled: false,
                                                                maxLines: 1,
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
                                                                  hintText:
                                                                      "Tanggal Hapus",
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
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Alasan Hapus",
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
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Alasan Hapus",
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
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                        const SizedBox(height: 16),
                                        ButtonPrimary(
                                          onTap: () {
                                            value.cek();
                                          },
                                          name: "Simpan",
                                        )
                                      ],
                                    ),
                                  )),
                            ])
                      ],
                    ))
                  ],
                )),
              )),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(JualBeliNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  JualBeliNotifier? tindakanNotifier;

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
