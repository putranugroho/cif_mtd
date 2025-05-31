import 'package:accounting/models/index.dart';
import 'package:accounting/module/transaksi/back_date/back_date_notifier.dart';

import 'package:accounting/module/transaksi/satu_transaksi/satu_transaksi_notifier.dart';

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

class BackDatePage extends StatelessWidget {
  const BackDatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BackDateNotifier(context: context),
      child: Consumer<BackDateNotifier>(
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
                              "Back date",
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
                                columnName: 'tgl_trans',
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
                                columnName: 'kode_trans',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Kode Transaksi',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
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
                            GridColumn(
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
                                columnName: 'action',
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
                                child: ListView(
                              children: [
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
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownSearch<SetupTransModel>(
                                        popupProps: const PopupPropsMultiSelection.menu(
                                          showSearchBox: true, // Aktifkan fitur pencarian
                                        ),
                                        selectedItem: value.setupTransModel,
                                        items: value.listKodeTransaksi,
                                        itemAsString: (e) => e.namaTrans,
                                        onChanged: (e) {
                                          value.pilihTransModel(e!);
                                        },
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          baseStyle: const TextStyle(fontSize: 16),
                                          textAlignVertical: TextAlignVertical.center,
                                          dropdownSearchDecoration: InputDecoration(
                                            hintText: "Pilih Kode Transaksi",
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
                                      width: 200,
                                      child: TextFormField(
                                        // enabled: false,
                                        readOnly: true,
                                        textInputAction: TextInputAction.done,
                                        controller: value.namaTransaksi,
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
                                          hintText: "Kode Transaksi",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Row(
                                  children: [
                                    Text(
                                      "Tanggal Valuta (Back date)",
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

                                    controller: value.namaTransaksi,

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
                                      hintText: "Tanggal Valuta",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
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
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly
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
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly
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
                                      child: DropdownSearch<CoaModel>(
                                        popupProps: const PopupPropsMultiSelection.menu(
                                          showSearchBox: true, // Aktifkan fitur pencarian
                                        ),
                                        selectedItem: value.sbbAset,
                                        items: value.listCoa.where((e) => e.jnsAcc == "C").toList(),
                                        itemAsString: (e) => e.namaSbb,
                                        onChanged: (e) {
                                          value.pilihSbbAset(e!);
                                        },
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          baseStyle: const TextStyle(fontSize: 16),
                                          textAlignVertical: TextAlignVertical.center,
                                          dropdownSearchDecoration: InputDecoration(
                                            hintText: "Pilih Debet Akun",
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
                                      child: DropdownSearch<CoaModel>(
                                        popupProps: const PopupPropsMultiSelection.menu(
                                          showSearchBox: true, // Aktifkan fitur pencarian
                                        ),
                                        selectedItem: value.sbbpenyusutan,
                                        items: value.listCoa.where((e) => e.jnsAcc == "C").toList(),
                                        itemAsString: (e) => e.namaSbb,
                                        onChanged: (e) {
                                          value.pilihSbbpenyusutan(e!);
                                        },
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          baseStyle: const TextStyle(fontSize: 16),
                                          textAlignVertical: TextAlignVertical.center,
                                          dropdownSearchDecoration: InputDecoration(
                                            hintText: "Pilih Kredit Akun",
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
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hintText: "Keterangan Transaksi",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 16),
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                                const Text("AO / Marketing"),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 16),
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      "AO / Marketing Debet",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                DropdownSearch<AoModel>(
                                  popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: true, // Aktifkan fitur pencarian
                                  ),
                                  selectedItem: value.aoModel,
                                  items: value.listAo,
                                  itemAsString: (e) => e.nama,
                                  onChanged: (e) {
                                    value.pilihAoModelDebet(e!);
                                  },
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle: const TextStyle(fontSize: 16),
                                    textAlignVertical: TextAlignVertical.center,
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Pilih AO / Marketing",
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
                                const SizedBox(height: 16),
                                const Row(
                                  children: [
                                    Text(
                                      "AO / Marketing Kredit",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                DropdownSearch<AoModel>(
                                  popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: true, // Aktifkan fitur pencarian
                                  ),
                                  selectedItem: value.aoModelKRedit,
                                  items: value.listAo,
                                  itemAsString: (e) => e.nama,
                                  onChanged: (e) {
                                    value.pilihAoModelKredit(e!);
                                  },
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle: const TextStyle(fontSize: 16),
                                    textAlignVertical: TextAlignVertical.center,
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Pilih AO / Marketing",
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
                                const SizedBox(height: 16),
                                ButtonPrimary(
                                  onTap: () {},
                                  name: "Simpan",
                                )
                              ],
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
  DetailDataSource(BackDateNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listData);
  }

  BackDateNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<TransaksiModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'tgl_trans', value: data.tglTrans),
                DataGridCell(columnName: 'kode_trans', value: data.kodeTrans),
                DataGridCell(columnName: 'debet_acc', value: data.debetAcc),
                DataGridCell(columnName: 'nama_debet', value: data.namaDebet),
                DataGridCell(columnName: 'credit_acc', value: data.creditAcc),
                DataGridCell(columnName: 'nama_credit', value: data.namaCredit),
                DataGridCell(columnName: 'nomor_dok', value: data.nomorDok),
                DataGridCell(columnName: 'nomor_ref', value: data.nomorRef),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
                DataGridCell(columnName: 'nominal', value: FormatCurrency.oCcy.format(int.parse(data.nominal))),
                DataGridCell(columnName: 'action', value: data.kodeTrans),
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
