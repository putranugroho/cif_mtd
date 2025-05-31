import 'package:accounting/models/index.dart';
import 'package:accounting/module/inventaris/revaluasi/revaluasi_notifier.dart';
import 'package:accounting/module/inventaris/pengadaan/pengadaan_notifier.dart';
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

class RevaluasiPage extends StatelessWidget {
  const RevaluasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RevaluasiNotifier(context: context),
      child: Consumer<RevaluasiNotifier>(
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
                              "Revaluasi",
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
                            connectorColor: const WidgetStatePropertyAll(colorPrimary),
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
                                        mainAxisAlignment: MainAxisAlignment.end,
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
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  value.onStepContinue();
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: WidgetStateProperty.all<Color>(colorPrimary),
                                                ),
                                                child: const Text(
                                                  'Lanjut',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
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
                                                  backgroundColor: WidgetStateProperty.all<Color>(colorPrimary),
                                                ),
                                                child: const Text(
                                                  'Lanjut',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )),
                            steps: [
                              Step(
                                  title: const Text("Inquery Data Inventaris"),
                                  content: Form(
                                      key: value.formStep[0],
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          const Row(
                                            children: [
                                              Text(
                                                "Pilih Aset / Inventaris",
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: DropdownSearch<InventarisModel>(
                                                  popupProps: const PopupPropsMultiSelection.menu(
                                                    showSearchBox: true, // Aktifkan fitur pencarian
                                                  ),
                                                  selectedItem: value.inventarisModel,
                                                  items: value.list,
                                                  itemAsString: (e) => e.ket,
                                                  onChanged: (e) {
                                                    value.pilihInventory(e!);
                                                  },
                                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                                    baseStyle: const TextStyle(fontSize: 16),
                                                    textAlignVertical: TextAlignVertical.center,
                                                    dropdownSearchDecoration: InputDecoration(
                                                      hintText: "Pilih Inventaris",
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: const BorderSide(
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
                                                width: 270,
                                                child: TextFormField(
                                                  readOnly: true,
                                                  controller: value.kdAset,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[200],
                                                    filled: true,
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
                                          value.inventarisModel != null
                                              ? Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                              const Row(
                                                                children: [
                                                                  Text(
                                                                    "Kelompok",
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
                                                                controller: value.kelompok,
                                                                textInputAction: TextInputAction.done,
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
                                                                  filled: true,
                                                                  fillColor: Colors.grey[200],
                                                                  hintText: "Kelompok Aset",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
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
                                                                    "Golongan",
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
                                                                controller: value.golongan,
                                                                textInputAction: TextInputAction.done,
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
                                                                  filled: true,
                                                                  fillColor: Colors.grey[200],
                                                                  hintText: "Golongan Aset",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
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
                                                                  "Satuan",
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
                                                              controller: value.satuans,
                                                              textInputAction: TextInputAction.done,
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
                                                                filled: true,
                                                                fillColor: Colors.grey[200],
                                                                hintText: "Satuan",
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
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                              const Row(
                                                                children: [
                                                                  Text(
                                                                    "Nomor Dokumen Pembelian",
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
                                                                controller: value.noDok,
                                                                textInputAction: TextInputAction.done,
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
                                                                  filled: true,
                                                                  fillColor: Colors.grey[200],
                                                                  hintText: "Nomor Dokumen Pembelian",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(width: 16),
                                                        Expanded(
                                                            child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                                          children: [
                                                            const Row(
                                                              children: [
                                                                Text(
                                                                  "Tanggal Beli",
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
                                                              controller: value.tglbeli,
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
                                                                filled: true,
                                                                fillColor: Colors.grey[200],
                                                                hintText: "Tanggal Beli",
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
                                                                  "Tanggal Terima",
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
                                                              controller: value.tglterima,
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
                                                                filled: true,
                                                                fillColor: Colors.grey[200],
                                                                hintText: "Tanggal Terima",
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
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: [
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
                                                          textInputAction: TextInputAction.done,
                                                          controller: value.keterangan,
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
                                                            filled: true,
                                                            fillColor: Colors.grey[200],
                                                            hintText: "Keterangan",
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(6),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox()
                                        ],
                                      ))),
                              Step(
                                  title: const Text(
                                    "Revaluasi",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Form(
                                    key: value.formStep[1],
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const Text(
                                                  "Nilai Barang",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                TextFormField(
                                                  textInputAction: TextInputAction.done,
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  validator: (e) {
                                                    if (e!.isEmpty) {
                                                      return "Wajib diisi";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  controller: value.hargaBeli,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[200],
                                                    filled: true,
                                                    hintText: "Nilai Barang",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            )),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const Text(
                                                  "Pajak",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                TextFormField(
                                                  textInputAction: TextInputAction.done,
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  controller: value.ppn,
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
                                                    hintText: "Pajak",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            )),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const Text(
                                                  "PPH",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                TextFormField(
                                                  textInputAction: TextInputAction.done,
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  validator: (e) {
                                                    if (e!.isEmpty) {
                                                      return "Wajib diisi";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  controller: value.pph,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[200],
                                                    filled: true,
                                                    hintText: "PPH",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            ))
                                          ],
                                        ),
                                        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Harga Perolehan",
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
                                                  controller: value.haper,
                                                  maxLines: 1,
                                                  onChanged: (e) => value.onChange(),
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
                                                    fillColor: Colors.grey[200],
                                                    filled: true,
                                                    hintText: "Harga Perolehan",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Nilai Buku",
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
                                                  maxLines: 1,
                                                  controller: value.nilaiBuku,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[200],
                                                    hintText: "Nilai Buku",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Nilai Revaluasi",
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
                                                  controller: value.nominal,
                                                  textInputAction: TextInputAction.done,
                                                  maxLines: 1,
                                                  onChanged: (e) => value.onChange(),
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
                                                    hintText: "Nilai Revaluasi",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        "Pihak Revaluasi",
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
                                                    controller: value.picReval,
                                                    maxLines: 1,
                                                    validator: (e) {
                                                      if (e!.isEmpty) {
                                                        return "Wajib diisi";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: "Pihak Revaluasi",
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        "Tanggal Revaluasi",
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
                                                  InkWell(
                                                    onTap: () => value.piihTanggalBeli(),
                                                    child: TextFormField(
                                                      enabled: false,
                                                      textInputAction: TextInputAction.done,
                                                      controller: value.tglbeli,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        // Make text bigger and black
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      validator: (e) {
                                                        if (e!.isEmpty) {
                                                          return "Wajib diisi";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: InputDecoration(
                                                        hintText: "Tanggal Revaluasi",
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
                                                  ),
                                                ],
                                              ),
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
                DataGridCell(columnName: 'harga', value: FormatCurrency.oCcy.format(int.parse(data.habeli))),
                DataGridCell(columnName: 'diskon', value: FormatCurrency.oCcy.format(int.parse(data.disc))),
                DataGridCell(columnName: 'biaya', value: FormatCurrency.oCcy.format(int.parse(data.habeli))),
                DataGridCell(columnName: 'ppn', value: FormatCurrency.oCcy.format(int.parse(data.ppnBeli))),
                DataGridCell(columnName: 'total', value: FormatCurrency.oCcy.format(int.parse(data.haper))),
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
                "Aksi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (e.columnName == 'harga' || e.columnName == 'diskon' || e.columnName == 'ppn' || e.columnName == 'biaya' || e.columnName == 'total') {
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
