import 'package:cif/models/index.dart';
import 'package:cif/module/transaksi/hutang/hutang_notifier.dart';
import 'package:cif/module/transaksi/piutang/piutang_notifier.dart';
import 'package:cif/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/colors.dart';
import '../../../utils/currency_formatted.dart';

class HutangPage extends StatelessWidget {
  const HutangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HutangNotifier(context: context),
      child: Consumer<HutangNotifier>(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Hutang",
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
                                "Tambah Data Hutang",
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
                                columnName: 'tanggal',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Tanggal Invoice',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'invoice',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('No. Invoice',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'nilai',
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
                                columnName: 'customer',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Customer',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'tgl_bayar',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Tanggal Bayar',
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
                right: 0,
                bottom: 0,
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
                                Expanded(
                                  child: Text(
                                    value.editData ? "Ubah / Hapus Data Hutang" : "Tambah Data Hutang",
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
                              child: Form(
                                key: value.keyForm,
                                child: ListView(
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          "Nomor Invoice",
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
                                      controller: value.noInvoice,
                                      maxLines: 1,
                                      validator: (e) {
                                        if (e!.isEmpty) {
                                          return "Wajib diisi";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Nomor Invoice",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: value.jenis,
                                          onChanged: (e) {
                                            value.gantijenis();
                                          },
                                          activeColor: colorPrimary,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text(
                                          "Hutang Berjangka",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 5),
                                        const Spacer(),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            const Row(
                                              children: [
                                                Text(
                                                  "Tanggal Invoice",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                SizedBox(width: 5),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                value.pilihTanggalInvoice();
                                              },
                                              child: TextFormField(
                                                enabled: false,
                                                controller: value.tglInvoice,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Tanggal Invoice",
                                                  filled: true,
                                                  fillColor: Colors.grey[300],
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        )),
                                        value.jenis
                                            ? const SizedBox()
                                            : const SizedBox(
                                                width: 16,
                                              ),
                                        value.jenis
                                            ? const SizedBox()
                                            : Expanded(
                                                child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        "Tanggal Jatuh Tempo",
                                                        style: TextStyle(fontSize: 12),
                                                      ),
                                                      SizedBox(width: 5),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      value.pilihTanggalJatuhTempo();
                                                    },
                                                    child: TextFormField(
                                                      enabled: false,
                                                      controller: value.tglJtTempo,
                                                      validator: (e) {
                                                        if (e!.isEmpty) {
                                                          return "Wajib diisi";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: InputDecoration(
                                                        hintText: "Tanggal Jatuh Tempo",
                                                        filled: true,
                                                        fillColor: Colors.grey[300],
                                                        border: OutlineInputBorder(
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
                                    value.jenis
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
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
                                                controller: value.nilaiInvoice,
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
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Jatuh Tempo",
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      value.addJatuhTempo();
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                                      decoration: BoxDecoration(
                                                        color: colorPrimary,
                                                        borderRadius: BorderRadius.circular(16),
                                                      ),
                                                      child: const Text(
                                                        "Tambah Jatuh Tempo",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              ListView.builder(
                                                  itemCount: value.listTglJatuhTempo.length,
                                                  shrinkWrap: true,
                                                  physics: const ClampingScrollPhysics(),
                                                  itemBuilder: (context, i) {
                                                    final data = value.listTglJatuhTempo[i];
                                                    var no = 1 + i;
                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 26,
                                                              child: Text("$no. "),
                                                            ),
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  value.pilihJthTempo(i);
                                                                },
                                                                child: TextFormField(
                                                                  enabled: false,
                                                                  controller: value.listTglJatuhTempo[i],
                                                                  decoration: const InputDecoration(
                                                                      border: OutlineInputBorder(), hintText: "Tanggal Jatuh Tempo"),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 16,
                                                            ),
                                                            Expanded(
                                                                child: TextFormField(
                                                              onChanged: (e) {
                                                                value.changeCalculate();
                                                              },
                                                              controller: value.listNominal[i],
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter.digitsOnly,
                                                                CurrencyInputFormatter(),
                                                              ],
                                                              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Nominal"),
                                                            )),
                                                            const SizedBox(
                                                              width: 16,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                value.remove(i);
                                                              },
                                                              child: Container(
                                                                width: 30,
                                                                height: 30,
                                                                decoration: const BoxDecoration(color: colorPrimary, shape: BoxShape.circle),
                                                                child: const Icon(
                                                                  Icons.close,
                                                                  size: 20,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 26,
                                                  ),
                                                  const Expanded(
                                                      child: Text(
                                                    "Selisih",
                                                    textAlign: TextAlign.end,
                                                  )),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    "Rp. ${FormatCurrency.oCcy.format(value.selisih)}",
                                                    textAlign: TextAlign.start,
                                                  )),
                                                  const SizedBox(
                                                    width: 16,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const Row(
                                      children: [
                                        Text(
                                          "Supplier",
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
                                          child: DropdownSearch<CustomerSupplierModel>(
                                            popupProps: const PopupPropsMultiSelection.menu(
                                              showSearchBox: true, // Aktifkan fitur pencarian
                                            ),
                                            selectedItem: value.customerSupplierModel,
                                            items: value.listCustomer,
                                            itemAsString: (e) => e.nmSif,
                                            onChanged: (e) {
                                              value.pilihCustomer(e!);
                                            },
                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                              baseStyle: const TextStyle(fontSize: 16),
                                              textAlignVertical: TextAlignVertical.center,
                                              dropdownSearchDecoration: InputDecoration(
                                                hintText: "Pilih Supplier",
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
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    value.jenis
                                        ? const SizedBox()
                                        : Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
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
                                                controller: value.nilaiInvoice,
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
                                                textInputAction: TextInputAction.done,
                                                controller: value.ppn,
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
                                                  hintText: "Pajak",
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
                                                textInputAction: TextInputAction.done,
                                                controller: value.pph,
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
                                                  hintText: "PPH",
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ],
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
                                            controller: value.nosbb,
                                            suggestionsCallback: (search) => value.getInquery(search),
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
                                              value.pilihAkunDeb(city);
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
                                            controller: value.namasbb,
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
                                              hintText: "Nama Akun",
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
                                      controller: value.keterangan,
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
                                    ButtonPrimary(
                                      onTap: () {
                                        value.cek();
                                      },
                                      name: "Simpan",
                                    ),
                                    value.editData
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              ButtonDanger(
                                                onTap: () {
                                                  value.confirm();
                                                },
                                                name: "Hapus",
                                              ),
                                            ],
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            ))
                          ],
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(HutangNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  HutangNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<PiutangHutangModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'status', value: data.statusInvoice),
                DataGridCell(columnName: 'tanggal', value: data.tglInvoice),
                DataGridCell(columnName: 'invoice', value: data.noInvoice),
                DataGridCell(columnName: 'nilai', value: FormatCurrency.oCcy.format(int.parse(data.nilaiInvoice))),
                DataGridCell(columnName: 'supplier', value: data.nmSif),
                DataGridCell(columnName: 'tgl_bayar', value: data.tglBayar),
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
              onTap: () {
                tindakanNotifier!.edit(e.value);
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
                  "Aksi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        } else if (e.columnName == 'status') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // tindakanNotifier!.edit(e.value);
              },
              child: Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: e.value == "A"
                      ? colorPrimary
                      : e.value == "H"
                          ? Colors.red[800]
                          : e.value == "M"
                              ? Colors.orange[800]
                              : Colors.green[800],
                ),
                child: Text(
                  e.value == "A"
                      ? "Aktif"
                      : e.value == "H"
                          ? "Hapus"
                          : e.value == "M"
                              ? "Macet"
                              : "Lunas",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        } else if (e.columnName == "") {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value,
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
