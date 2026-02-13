import 'package:cif/models/index.dart';
import 'package:cif/module/inventaris/pengadaan/pengadaan_notifier.dart';
import 'package:cif/module/setup/golongan_aset/golongan_aset_notifier.dart';

import 'package:cif/utils/button_custom.dart';
import 'package:cif/utils/currency_formatted.dart';
// import 'package:cif/utils/format_baru.dart';
import 'package:cif/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';
import '../../../utils/pro_shimmer.dart';

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
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const Expanded(
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
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: colorPrimary,
                                border: Border.all(
                                  width: 2,
                                  color: colorPrimary,
                                ),
                              ),
                              child: const Text(
                                "Tambah Pengadaan",
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
                      child: value.isLoading
                          ? Container(
                              padding: const EdgeInsets.all(16),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProShimmer(height: 10, width: 200),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ProShimmer(height: 10, width: 120),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ProShimmer(height: 10, width: 100),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            )
                          : Container(
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
                                      columnName: 'kdaset',
                                      label: Container(
                                          padding: const EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: const Text('No. Aset',
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
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Nama Aset',
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
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Kelompok',
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
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Golongan',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'harga',
                                      width: 130,
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Harga',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'diskon',
                                      width: 130,
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Diskon',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'biaya',
                                      width: 130,
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Biaya',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'ppn',
                                      width: 130,
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('PPN',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'pph',
                                      width: 130,
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('PPH',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'total',
                                      width: 130,
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Total',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'action',
                                      width: 80,
                                      label: Container(
                                          color: colorPrimary,
                                          padding: const EdgeInsets.all(6),
                                          alignment: Alignment.center,
                                          child: const Text('Action',
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
                child: value.dialogTransaksi
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
                                  "Pilih Transaksi",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                InkWell(
                                  onTap: () => value.tutupDialogTransaksi(),
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
                              height: 24,
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: value.listTransaksiAdd.length,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, i) {
                                      final data = value.listTransaksiAdd[i];
                                      var no = i + 1;
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              value.pilihTransaksi(data);
                                            },
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 30,
                                                  child: Text("$no. "),
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Text(
                                                      "(${data.dracc}) ${data.namaDr}",
                                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(data.keterangan)
                                                  ],
                                                )),
                                                Text(
                                                  "Rp ${FormatCurrency.oCcyDecimal.format(double.parse(data.nominal))}",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          )
                                        ],
                                      );
                                    }))
                          ],
                        ),
                      )
                    : value.dialog
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            width: 600,
                            decoration: const BoxDecoration(color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        value.editData ? "Ubah Pengadaan" : "Tambah Pengadaan",
                                        style: const TextStyle(
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
                                    child: FocusTraversalGroup(
                                  child: ListView(
                                    children: [
                                      Stepper(
                                        key: const ValueKey("1"),
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
                                            child: value.currentStep == 3
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
                                              title: const Text("Data Inventaris", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                              content: Form(
                                                  key: value.formStep[0],
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
                                                      DropdownSearch<KelompokAsetModel>(
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Wajib diisi';
                                                          }
                                                          return null;
                                                        },
                                                        popupProps: const PopupPropsMultiSelection.menu(
                                                          showSearchBox: true, // Aktifkan fitur pencarian
                                                        ),
                                                        selectedItem: value.kelompokAsetModel,
                                                        items: value.listKelompok,
                                                        itemAsString: (e) => e.namaKelompokn,
                                                        onChanged: (e) {
                                                          value.pilihKelompok(e!);
                                                        },
                                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                                          baseStyle: const TextStyle(fontSize: 16),
                                                          textAlignVertical: TextAlignVertical.center,
                                                          dropdownSearchDecoration: InputDecoration(
                                                            hintText: "Pilih Kelompok Aset",
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
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      value.editData
                                                          ? Column(
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
                                                                  readOnly: true,
                                                                  decoration: InputDecoration(
                                                                      filled: true,
                                                                      fillColor: Colors.grey[200],
                                                                      border: OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                          width: 1,
                                                                          color: Colors.grey,
                                                                        ),
                                                                        borderRadius: BorderRadius.circular(8),
                                                                      )),
                                                                ),
                                                                const SizedBox(
                                                                  height: 16,
                                                                ),
                                                              ],
                                                            )
                                                          : Column(
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
                                                                DropdownSearch<GolonganAsetModel>(
                                                                  validator: (value) {
                                                                    if (value == null) {
                                                                      return 'Wajib diisi';
                                                                    }
                                                                    return null;
                                                                  },
                                                                  popupProps: const PopupPropsMultiSelection.menu(
                                                                    showSearchBox: true, // Aktifkan fitur pencarian
                                                                  ),
                                                                  selectedItem: value.golonganAsetModel,
                                                                  items: value.listGolongan,
                                                                  itemAsString: (e) => e.namaGolongan,
                                                                  onChanged: (e) {
                                                                    value.pilihGolongan(e!);
                                                                  },
                                                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                                                    baseStyle: const TextStyle(fontSize: 16),
                                                                    textAlignVertical: TextAlignVertical.center,
                                                                    dropdownSearchDecoration: InputDecoration(
                                                                      hintText: "Pilih Golongan Aset",
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
                                                                const SizedBox(
                                                                  height: 16,
                                                                ),
                                                              ],
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
                                                                    "Nomor Aset",
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
                                                                controller: value.noaset,
                                                                textInputAction: TextInputAction.done,
                                                                maxLines: 1,
                                                                validator: (e) {
                                                                  if (e!.isEmpty) {
                                                                    return "Wajib diisi";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                                decoration: InputDecoration(
                                                                  hintText: "Nomor Aset",
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
                                                              DropdownSearch<String>(
                                                                validator: (value) {
                                                                  if (value == null) {
                                                                    return 'Wajib diisi';
                                                                  }
                                                                  return null;
                                                                },
                                                                popupProps: const PopupPropsMultiSelection.menu(
                                                                  showSearchBox: true, // Aktifkan fitur pencarian
                                                                ),
                                                                selectedItem: value.satuanModel,
                                                                items: value.listSatuan,
                                                                itemAsString: (e) => e,
                                                                onChanged: (e) {
                                                                  value.pilihSatuan(e!);
                                                                },
                                                                dropdownDecoratorProps: DropDownDecoratorProps(
                                                                  baseStyle: const TextStyle(fontSize: 16),
                                                                  textAlignVertical: TextAlignVertical.center,
                                                                  dropdownSearchDecoration: InputDecoration(
                                                                    hintText: "Pilih Satuan",
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
                                                              const SizedBox(
                                                                height: 16,
                                                              ),
                                                            ],
                                                          )),
                                                        ],
                                                      ),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Nama Aset",
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
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 16),
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
                                                        validator: (e) {
                                                          if (e!.isEmpty) {
                                                            return "Wajib diisi";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          hintText: "Keterangan",
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                        ),
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
                                                              InkWell(
                                                                onTap: () => value.pilihTanggalBuka(),
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
                                                                  decoration: InputDecoration(
                                                                    hintText: "Tanggal Beli",
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
                                                              InkWell(
                                                                onTap: () => value.pilihTanggalTerima(),
                                                                child: TextFormField(
                                                                  enabled: false,
                                                                  textInputAction: TextInputAction.done,
                                                                  controller: value.tglterima,
                                                                  maxLines: 1,
                                                                  style: const TextStyle(
                                                                    // Make text bigger and black
                                                                    color: Colors.black,
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                  // validator: (e) {
                                                                  //   if (e!.isEmpty) {
                                                                  //     return "Wajib diisi";
                                                                  //   } else {
                                                                  //     return null;
                                                                  //   }
                                                                  // },
                                                                  decoration: InputDecoration(
                                                                    hintText: "Tanggal Terima",
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
                                                              const SizedBox(height: 16),
                                                            ],
                                                          )),
                                                        ],
                                                      ),
                                                    ],
                                                  ))),
                                          Step(
                                              title: const Text(
                                                "Penempatan",
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
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Kantor / Karyawan",
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
                                                      DropdownSearch<String>(
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Wajib diisi';
                                                          }
                                                          return null;
                                                        },
                                                        popupProps: const PopupPropsMultiSelection.menu(
                                                          showSearchBox: true, // Aktifkan fitur pencarian
                                                        ),
                                                        selectedItem: value.penempatanModel,
                                                        items: value.listPenempatan,
                                                        itemAsString: (e) => e,
                                                        onChanged: (e) {
                                                          value.pilihPenempatan(e!);
                                                        },
                                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                                          baseStyle: const TextStyle(fontSize: 16),
                                                          textAlignVertical: TextAlignVertical.center,
                                                          dropdownSearchDecoration: InputDecoration(
                                                            hintText: "Pilih Kantor / Karyawan",
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
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      value.penempatanModel == "Kantor"
                                                          ? Column(
                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                              children: [
                                                                const Text(
                                                                  "Kantor",
                                                                  style: TextStyle(fontSize: 12),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                DropdownSearch<KantorModel>(
                                                                  popupProps: const PopupPropsMultiSelection.menu(
                                                                    showSearchBox: true, // Aktifkan fitur pencarian
                                                                  ),
                                                                  selectedItem: value.kantor,
                                                                  items: value.listKantor,
                                                                  itemAsString: (e) => e.namaKantor,
                                                                  enabled: value.editData ? false : true,
                                                                  onChanged: (e) {
                                                                    value.pilihKantor(e!);
                                                                  },
                                                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                                                    baseStyle: const TextStyle(fontSize: 16),
                                                                    textAlignVertical: TextAlignVertical.center,
                                                                    dropdownSearchDecoration: InputDecoration(
                                                                      hintText: "Pilih Kantor",
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
                                                                const SizedBox(
                                                                  height: 16,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Expanded(
                                                                        child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                      children: [
                                                                        const Text(
                                                                          "Lokasi",
                                                                          style: TextStyle(fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          height: 8,
                                                                        ),
                                                                        TextFormField(
                                                                          textInputAction: TextInputAction.done,
                                                                          enabled: value.editData ? false : true,
                                                                          maxLines: 1,
                                                                          validator: (e) {
                                                                            if (e!.isEmpty) {
                                                                              return "Wajib diisi";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                          controller: value.lokasi,
                                                                          decoration: InputDecoration(
                                                                            hintText: "Lokasi",
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
                                                                          "Kota",
                                                                          style: TextStyle(fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          height: 8,
                                                                        ),
                                                                        TextFormField(
                                                                          enabled: value.editData ? false : true,
                                                                          textInputAction: TextInputAction.done,
                                                                          maxLines: 1,
                                                                          controller: value.kota,
                                                                          validator: (e) {
                                                                            if (e!.isEmpty) {
                                                                              return "Wajib diisi";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                          decoration: InputDecoration(
                                                                            hintText: "Kota",
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
                                                              ],
                                                            )
                                                          : Column(
                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                              children: [
                                                                const Text(
                                                                  "Nama Karyawan",
                                                                  style: TextStyle(fontSize: 12),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                TypeAheadField<KaryawanModel>(
                                                                  controller: value.namaKaryawan,
                                                                  suggestionsCallback: (search) => value.getInquery(search),
                                                                  builder: (context, controller, focusNode) {
                                                                    return TextField(
                                                                        enabled: value.editData ? false : true,
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
                                                                      title: Text(city.namaLengkap),
                                                                      subtitle: Text(city.nik),
                                                                    );
                                                                  },
                                                                  onSelected: (city) {
                                                                    // value.selectInvoice(city);
                                                                    value.piliAkunKaryawan(city);
                                                                  },
                                                                ),
                                                                const SizedBox(height: 16),
                                                                const Row(
                                                                  children: [
                                                                    Text(
                                                                      "NIP Karyawan",
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
                                                                  enabled: value.editData ? false : true,
                                                                  textInputAction: TextInputAction.done,
                                                                  maxLines: 1,
                                                                  readOnly: true,
                                                                  controller: value.nikKaryawan,
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
                                                                    hintText: "NIP Karyawan",
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(6),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 16),
                                                              ],
                                                            ),
                                                    ],
                                                  ))),
                                          Step(
                                              title: const Text(
                                                "Penyusutan",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              content: Form(
                                                  key: value.formStep[2],
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
                                                                "Nilai Akhir",
                                                                style: TextStyle(fontSize: 12),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              TextFormField(
                                                                readOnly: value.editBlnsusut ? true : false,
                                                                controller: value.nilaiPenyusutan,
                                                                textInputAction: TextInputAction.done,
                                                                maxLines: 1,
                                                                validator: (e) {
                                                                  if (e!.isEmpty) {
                                                                    return "Wajib diisi";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter.digitsOnly,
                                                                ],
                                                                decoration: InputDecoration(
                                                                  hintText: "Nilai Akhir",
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
                                                          value.metode == 1
                                                              ? Expanded(
                                                                  child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                  children: [
                                                                    const Text(
                                                                      "Masa Susut",
                                                                      style: TextStyle(fontSize: 12),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 8,
                                                                    ),
                                                                    TextFormField(
                                                                      readOnly: value.editBlnsusut ? true : false,
                                                                      textInputAction: TextInputAction.done,
                                                                      maxLines: 1,
                                                                      controller: value.masasusut,
                                                                      validator: (e) {
                                                                        if (e!.isEmpty) {
                                                                          return "Wajib diisi";
                                                                        } else {
                                                                          return null;
                                                                        }
                                                                      },
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter.digitsOnly,
                                                                      ],
                                                                      decoration: InputDecoration(
                                                                        hintText: "Masa Susut",
                                                                        border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(6),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(height: 16),
                                                                  ],
                                                                ))
                                                              : const SizedBox(),
                                                        ],
                                                      ),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Bulan Mulai Penyusutan",
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
                                                        onTap: () {
                                                          if (!value.editBlnsusut) {
                                                            value.showDate();
                                                          }
                                                        },
                                                        child: TextFormField(
                                                          enabled: false,
                                                          controller: value.blnPenyusutan,
                                                          style: const TextStyle(
                                                            // Make text bigger and black
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          // validator: (e) {
                                                          //   if (e!.isEmpty) {
                                                          //     return "Wajib diisi";
                                                          //   } else {
                                                          //     return null;
                                                          //   }
                                                          // },
                                                          decoration: InputDecoration(
                                                            hintText: "Bulan Mulai Penyusutan",
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
                                                      const SizedBox(height: 16),
                                                    ],
                                                  ))),
                                          Step(
                                              title: const Text(
                                                "Rincian Harga Perolehan",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              content: Form(
                                                  key: value.formStep[3],
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      value.editData
                                                          ? SizedBox()
                                                          : Column(
                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Column(
                                                                        children: [
                                                                          const Row(
                                                                            children: [
                                                                              Text(
                                                                                "Tanggal Valuta",
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
                                                                            onTap: () => value.pilihTanggalValuta(),
                                                                            child: TextFormField(
                                                                              enabled: false,
                                                                              textInputAction: TextInputAction.done,
                                                                              controller: value.tglTrans,
                                                                              maxLines: 1,
                                                                              style: const TextStyle(
                                                                                // Make text bigger and black
                                                                                color: Colors.black,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                              decoration: InputDecoration(
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
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(width: 16),
                                                                    Expanded(
                                                                      child: Column(
                                                                        children: [
                                                                          const Row(
                                                                            children: [
                                                                              Text(
                                                                                "No. Dokumen",
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
                                                                            controller: value.noDokTrans,
                                                                            maxLines: 1,
                                                                            validator: (e) {
                                                                              if (e!.isEmpty) {
                                                                                return "Wajib diisi";
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                            decoration: InputDecoration(
                                                                              hintText: "No. Dokumen",
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(6),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(width: 16),
                                                                    InkWell(
                                                                      onTap: () {
                                                                        value.bukaTransaksi();
                                                                      },
                                                                      child: Container(
                                                                        height: 50,
                                                                        alignment: Alignment.center,
                                                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                                                        decoration: BoxDecoration(
                                                                          color: colorPrimary,
                                                                          borderRadius: BorderRadius.circular(16),
                                                                        ),
                                                                        child: const Text(
                                                                          "Cari",
                                                                          style: TextStyle(
                                                                            fontSize: 12,
                                                                            color: Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(height: 16),
                                                              ],
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
                                                                readOnly: value.editData ? true : false,
                                                                controller: value.noDok,
                                                                textInputAction: TextInputAction.done,
                                                                maxLines: 1,
                                                                validator: (e) {
                                                                  if (e == null || e.isEmpty) {
                                                                    return "Wajib diisi";
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                                decoration: InputDecoration(
                                                                  fillColor: Colors.grey[200],
                                                                  filled: value.editData ? true : false,
                                                                  hintText: "Nomor Dokumen Pembelian",
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
                                                              const Row(
                                                                children: [
                                                                  Text(
                                                                    "Nomor Referensi",
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
                                                                controller: value.noRef,
                                                                readOnly: true,
                                                                textInputAction: TextInputAction.done,
                                                                maxLines: 1,
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
                                                                  hintText: "Nomor Referensi Pembelian",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(height: 16),
                                                            ],
                                                          )),
                                                        ],
                                                      ),
                                                      value.editData
                                                          ? Column()
                                                          : Column(
                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                              children: [
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
                                                                  textInputAction: TextInputAction.done,
                                                                  controller: value.nilaiTrans,
                                                                  maxLines: 1,
                                                                  readOnly: true,
                                                                  onChanged: (e) => value.onChange(),
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter.digitsOnly,
                                                                    CurrencyInputFormatter(),
                                                                  ],
                                                                  validator: (e) {
                                                                    if (e!.isEmpty) {
                                                                      return "Wajib diisi";
                                                                    } else {
                                                                      if (int.tryParse(e) == 0) {
                                                                        return "Wajib diisi";
                                                                      }
                                                                      return null;
                                                                    }
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    filled: true,
                                                                    fillColor: Colors.grey[200],
                                                                    hintText: "Nilai Transaksi",
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(6),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 16),
                                                                const Row(
                                                                  children: [
                                                                    Text(
                                                                      "Keterangan Transaksi",
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
                                                                  controller: value.keteranganTrans,
                                                                  maxLines: 1,
                                                                  readOnly: true,
                                                                  onChanged: (e) => value.onChange(),
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter.digitsOnly,
                                                                    CurrencyInputFormatter(),
                                                                  ],
                                                                  validator: (e) {
                                                                    if (e!.isEmpty) {
                                                                      return "Wajib diisi";
                                                                    } else {
                                                                      if (int.tryParse(e) == 0) {
                                                                        return "Wajib diisi";
                                                                      }
                                                                      return null;
                                                                    }
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    filled: true,
                                                                    fillColor: Colors.grey[200],
                                                                    hintText: "Keterangan Transaksi",
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(6),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 16),
                                                              ],
                                                            ),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Harga Beli",
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
                                                        readOnly: value.editData ? true : false,
                                                        textInputAction: TextInputAction.done,
                                                        controller: value.hargaBeli,
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
                                                            if (int.tryParse(e) == 0) {
                                                              return "Wajib diisi";
                                                            }
                                                            return null;
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          filled: value.editData ? true : false,
                                                          fillColor: Colors.grey[200],
                                                          hintText: "Harga Beli",
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Diskon",
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
                                                        readOnly: value.editData ? true : false,
                                                        textInputAction: TextInputAction.done,
                                                        controller: value.discount,
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
                                                          hintText: "Diskon",
                                                          filled: value.editData ? true : false,
                                                          fillColor: Colors.grey[200],
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Biaya",
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
                                                        readOnly: value.editData ? true : false,
                                                        textInputAction: TextInputAction.done,
                                                        controller: value.biaya,
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
                                                          hintText: "Biaya",
                                                          filled: value.editData ? true : false,
                                                          fillColor: Colors.grey[200],
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Pajak",
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
                                                          Radio(
                                                              value: false,
                                                              groupValue: value.pajak,
                                                              onChanged: (e) => value.editData ? null : value.gantipajak(false)),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          const Text("Tidak Pajak"),
                                                          const SizedBox(
                                                            width: 24,
                                                          ),
                                                          Radio(
                                                              value: true,
                                                              groupValue: value.pajak,
                                                              onChanged: (e) => value.editData ? null : value.gantipajak(true)),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          const Text("Pajak"),
                                                        ],
                                                      ),
                                                      value.pajak
                                                          ? Column(
                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                              children: [
                                                                const SizedBox(
                                                                  height: 16,
                                                                ),
                                                                const Row(
                                                                  children: [
                                                                    Text(
                                                                      "PPN",
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
                                                                  readOnly: value.editData ? true : false,
                                                                  textInputAction: TextInputAction.done,
                                                                  controller: value.ppn,
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
                                                                    filled: value.editData ? true : false,
                                                                    fillColor: Colors.grey[200],
                                                                    hintText: "PPN",
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(6),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 16),
                                                                const Row(
                                                                  children: [
                                                                    Text(
                                                                      "PPH",
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
                                                                  readOnly: value.editData ? true : false,
                                                                  textInputAction: TextInputAction.done,
                                                                  controller: value.pph,
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
                                                                    filled: value.editData ? true : false,
                                                                    fillColor: Colors.grey[200],
                                                                    hintText: "PPH",
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(6),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox(),
                                                      Container(
                                                        margin: const EdgeInsets.symmetric(vertical: 16),
                                                        height: 1,
                                                        color: Colors.grey[300],
                                                      ),
                                                      value.pajak
                                                          ? Column(
                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    const Expanded(
                                                                      child: Text(
                                                                        "Sub Total",
                                                                        style: TextStyle(),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      FormatCurrency.oCcy.format(value.subtotal),
                                                                      style: const TextStyle(),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Expanded(
                                                                      child: Text(
                                                                        "Pajak",
                                                                        style: TextStyle(),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      FormatCurrency.oCcy.format(int.parse(value.ppn.text.replaceAll(",", ""))),
                                                                      style: const TextStyle(),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Expanded(
                                                                      child: Text(
                                                                        "PPH",
                                                                        style: TextStyle(),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "(${FormatCurrency.oCcy.format(int.parse(value.pph.text.replaceAll(",", "")))})",
                                                                      style: const TextStyle(),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Expanded(
                                                                      child: Text(
                                                                        "Total",
                                                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      FormatCurrency.oCcy.format(value.total),
                                                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                              ],
                                                            )
                                                          : Row(
                                                              children: [
                                                                const Expanded(
                                                                  child: Text(
                                                                    "Total",
                                                                    style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FormatCurrency.oCcy.format(value.total),
                                                                  style: const TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                      value.transaksiPendModel != null
                                                          ? Row(
                                                              children: [
                                                                const Expanded(
                                                                  child: Text(
                                                                    "Selisih",
                                                                    style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FormatCurrency.oCcy
                                                                      .format(int.parse(value.transaksiPendModel!.nominal) - value.total),
                                                                  style: const TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox(),
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
                                                  )))
                                        ],
                                      ),
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
                DataGridCell(columnName: 'Keterangan', value: data.namaaset),
                DataGridCell(columnName: 'kelompok', value: data.namaKelompok),
                DataGridCell(columnName: 'golongan', value: data.namaGolongan),
                DataGridCell(columnName: 'harga', value: FormatCurrency.oCcy.format(int.parse(data.habeli))),
                DataGridCell(columnName: 'diskon', value: FormatCurrency.oCcy.format(int.parse(data.disc))),
                DataGridCell(columnName: 'biaya', value: FormatCurrency.oCcy.format(int.parse(data.biaya))),
                DataGridCell(columnName: 'ppn', value: FormatCurrency.oCcy.format(int.parse(data.ppnBeli))),
                DataGridCell(columnName: 'pph', value: FormatCurrency.oCcy.format(int.parse(data.pph))),
                DataGridCell(
                    columnName: 'total', value: FormatCurrency.oCcy.format(int.parse(data.haper) + (int.parse(data.ppnBeli) - int.parse(data.pph)))),
                DataGridCell(columnName: 'action', value: data.id.toString()),
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
              onTap: () => tindakanNotifier!.edit(e.value),
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
