import 'package:accounting/models/index.dart';
import 'package:accounting/module/transaksi/bayar_dimuka/bayar_dimuka_notifier.dart';

import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:accounting/utils/format_currency.dart';

import 'package:accounting/utils/images_path.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';

class BayarDimukaPage extends StatelessWidget {
  const BayarDimukaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BayarDimukaNotifier(context: context),
      child: Consumer<BayarDimukaNotifier>(
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
                              "Bayar/Pendapatan Dimuka",
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
                                columnName: 'keterangan',
                                width: 240,
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
                                width: 100,
                                columnName: 'tgl_trans',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Tanggal Trans.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 130,
                                columnName: 'nomor_dok',
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
                                width: 130,
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
                                width: 80,
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
                child: value.dialog || value.referensi
                    ? Container(
                        color: Colors.black.withOpacity(0.5),
                      )
                    : const SizedBox(),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: value.referensi
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
                                    "Pilih Transaksi Referensi",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => value.kembali(),
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
                                ListView.builder(
                                    itemCount: value.listTransaksiAdd.length,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, i) {
                                      final data = value.listTransaksiAdd[i];
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              value.pilihTransaksi(data);
                                            },
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 16),
                                                        width: 150,
                                                        child: const Text(
                                                          "Nomor Referensi",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          margin: const EdgeInsets.only(right: 16),
                                                          child: const Text(
                                                            "Akun",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 150,
                                                        margin: const EdgeInsets.only(right: 16),
                                                        child: const Text(
                                                          "Nominal",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 16),
                                                        width: 150,
                                                        child: Text(
                                                          data.noRef,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 150,
                                                        margin: const EdgeInsets.only(right: 16),
                                                        child: Text(
                                                          value.jenis == "BAYAR DIMUKA" ? "(${data.cracc}) ${data.namaCr}" : "(${data.dracc}) ${data.namaDr}",
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 150,
                                                        margin: const EdgeInsets.only(right: 16),
                                                        child: Text(
                                                          FormatCurrency.oCcy.format(int.parse(data.nominal)),
                                                          textAlign: TextAlign.end,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    })
                              ],
                            ))
                          ],
                        ),
                      )
                    : value.dialogEdit
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
                                        "Edit Transaksi",
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
                                    child: FocusTraversalGroup(
                                  child: Form(
                                    key: value.keyForm,
                                    child: ListView(
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
                                                      "Debet Akun",
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
                                                  // enabled: false,
                                                  readOnly: true,
                                                  textInputAction: TextInputAction.done,
                                                  controller: value.namaakun,
                                                  maxLines: 1,

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
                                                const SizedBox(height: 16),
                                              ],
                                            )),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            SizedBox(
                                                width: 150,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          "No. Akun Debet",
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
                                                      // enabled: false,
                                                      readOnly: true,
                                                      textInputAction: TextInputAction.done,
                                                      controller: value.noakun,
                                                      maxLines: 1,

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
                                                    const SizedBox(height: 16),
                                                  ],
                                                )),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              "Nominal Transaksi",
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
                                          // enabled: false,
                                          readOnly: true,
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
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Nominal",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
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
                                                      "Berapa Kali Pengakuan?",
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
                                                  // enabled: false,
                                                  onChanged: (e) => value.onchange(),
                                                  textInputAction: TextInputAction.done,
                                                  controller: value.berapakali,
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
                                                    hintText: "Berapa kali pengakuan",
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
                                                      "Bulan Mulai Pengakuan",
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
                                                    value.showDate();
                                                  },
                                                  child: TextFormField(
                                                    enabled: false,
                                                    textInputAction: TextInputAction.done,
                                                    controller: value.tglPenyusutan,
                                                    maxLines: 1,
                                                    validator: (e) {
                                                      if (e!.isEmpty) {
                                                        return "Wajib diisi";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: "Bulan Mulai Pengakuan",
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
                                        const Row(
                                          children: [
                                            Text(
                                              "Nilai Pengakuan",
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
                                          controller: value.nilaiPengakuan,
                                          readOnly: true,
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
                                            hintText: "Nilai Pengakuan",
                                            filled: true,
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
                                              "Pilih Biaya Akun",
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
                                                controller: value.nosbbdeb,
                                                suggestionsCallback: (search) => value.getInquery(search),
                                                builder: (context, controller, focusNode) {
                                                  return TextField(
                                                      controller: controller,
                                                      focusNode: focusNode,
                                                      autofocus: true,
                                                      decoration: const InputDecoration(
                                                        border: OutlineInputBorder(),
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
                                                controller: value.namaSbbDeb,
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
                                                  hintText: "Nomor Debet",
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
                                          // enabled: false,

                                          textInputAction: TextInputAction.done,
                                          controller: value.keteranganBaru,
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
                                            hintText: "Keterangan",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        ButtonPrimary(
                                          onTap: () {
                                            value.cek();
                                          },
                                          name: "Simpan",
                                        ),
                                        const SizedBox(height: 16),
                                        ButtonDanger(
                                          onTap: () {
                                            value.confirm();
                                          },
                                          name: "Hapus",
                                        )
                                      ],
                                    ),
                                  ),
                                ))
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
                                        child: FocusTraversalGroup(
                                      child: Form(
                                        key: value.keyForm,
                                        child: ListView(
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
                                                          "Jenis Transaksi",
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
                                                    SizedBox(
                                                      height: 40,
                                                      child: DropdownSearch<String>(
                                                        popupProps: const PopupPropsMultiSelection.menu(
                                                          showSearchBox: true, // Aktifkan fitur pencarian
                                                        ),
                                                        selectedItem: value.jenis,
                                                        items: value.listJenis,
                                                        itemAsString: (e) => e,
                                                        onChanged: (e) {
                                                          value.pilihjenis(e!);
                                                        },
                                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                                          baseStyle: const TextStyle(fontSize: 12),
                                                          textAlignVertical: TextAlignVertical.center,
                                                          dropdownSearchDecoration: InputDecoration(
                                                            hintText: "Pilih Jenis Transaksi",
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
                                                      height: 16,
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
                                                          "Pilih Akun Pencarian",
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
                                                    SizedBox(
                                                      height: 40,
                                                      child: TypeAheadField<InqueryGlModel>(
                                                        controller: value.nosbb,
                                                        suggestionsCallback: (search) => value.getIn(search),
                                                        builder: (context, controller, focusNode) {
                                                          return TextField(
                                                              controller: controller,
                                                              focusNode: focusNode,
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                              autofocus: true,
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
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
                                                          value.pilihAkun(city);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                  ],
                                                )),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    const Text(
                                                      "",
                                                      style: TextStyle(fontSize: 12),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      alignment: Alignment.centerLeft,
                                                      child: Row(
                                                        children: [
                                                          Checkbox(
                                                              value: value.semua,
                                                              activeColor: colorPrimary,
                                                              onChanged: (e) {
                                                                value.gantisemua();
                                                              }),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          const Text(
                                                            "Semua",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const Text(
                                              "Tanggal Pencarian",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: true,
                                                  groupValue: value.cariTrans,
                                                  activeColor: colorPrimary,
                                                  onChanged: (e) => value.pilihCariTransaksi(true),
                                                ),
                                                const Text("Input Hari Ini"),
                                                const SizedBox(width: 16),
                                                Radio(
                                                  value: false,
                                                  groupValue: value.cariTrans,
                                                  activeColor: colorPrimary,
                                                  onChanged: (e) => value.pilihCariTransaksi(false),
                                                ),
                                                const Text("Tgl Valuta"),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 130,
                                                        child: TextFormField(
                                                          enabled: !value.cariTrans,
                                                          readOnly: true,
                                                          onTap: () => value.pilihTanggalAwal(),
                                                          controller: value.tanggalAwal,
                                                          decoration: InputDecoration(
                                                            filled: value.cariTrans,
                                                            fillColor: Colors.grey[200],
                                                            hintText: "Tanggal Awal",
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(6),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      const Text("s/d"),
                                                      const SizedBox(width: 8),
                                                      SizedBox(
                                                        width: 130,
                                                        child: TextFormField(
                                                          enabled: !value.cariTrans,
                                                          readOnly: true,
                                                          onTap: () => value.pilihTanggalAkhir(),
                                                          controller: value.tanggalAkhir,
                                                          decoration: InputDecoration(
                                                            filled: value.cariTrans,
                                                            fillColor: Colors.grey[200],
                                                            hintText: "Tanggal Akhir",
                                                            border: OutlineInputBorder(
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
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            value.transaksiModel == null
                                                ? Row(
                                                    children: [
                                                      const Text(
                                                        "Pilih Transaksi",
                                                        style: TextStyle(fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(fontSize: 8),
                                                      ),
                                                      const Spacer(),
                                                      InkWell(
                                                        onTap: () {
                                                          value.pilihReferensi();
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                          decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(16)),
                                                          child: const Text(
                                                            "Pilih",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            value.transaksiModel == null
                                                ? SizedBox(
                                                    height: 300,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset(
                                                          ImageAssets.report,
                                                          height: 80,
                                                          color: colorPrimary,
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        const Text(
                                                          "Pilih Transaksi",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Text(
                                                          "Pilih transaksi yang akan digunakan sebagai referensi",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Column(
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
                                                                readOnly: true,
                                                                textInputAction: TextInputAction.done,
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
                                                                  filled: true,
                                                                  fillColor: Colors.grey[200],
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
                                                                readOnly: true,
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
                                                                  filled: true,
                                                                  fillColor: Colors.grey[200],
                                                                  hintText: "Nomor Referensi",
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
                                                          InkWell(
                                                            onTap: () {
                                                              value.clear();
                                                            },
                                                            child: Container(
                                                              width: 30,
                                                              height: 30,
                                                              alignment: Alignment.center,
                                                              decoration: const BoxDecoration(
                                                                color: colorPrimary,
                                                                shape: BoxShape.circle,
                                                              ),
                                                              child: const Icon(
                                                                Icons.close,
                                                                size: 12,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          )
                                                        ],
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
                                                                    "Nama Akun Debet",
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
                                                                // enabled: false,
                                                                readOnly: true,
                                                                textInputAction: TextInputAction.done,
                                                                controller: value.namaakundebet,
                                                                maxLines: 1,

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
                                                              const SizedBox(height: 16),
                                                            ],
                                                          )),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          SizedBox(
                                                              width: 150,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                children: [
                                                                  const Row(
                                                                    children: [
                                                                      Text(
                                                                        "No. Akun Debet",
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
                                                                    // enabled: false,
                                                                    readOnly: true,
                                                                    textInputAction: TextInputAction.done,
                                                                    controller: value.noakundebet,
                                                                    maxLines: 1,

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
                                                                  const SizedBox(height: 16),
                                                                ],
                                                              )),
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
                                                                    "Nama Akun Kredit",
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
                                                                // enabled: false,
                                                                readOnly: true,
                                                                textInputAction: TextInputAction.done,
                                                                controller: value.namaakun,
                                                                maxLines: 1,

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
                                                              const SizedBox(height: 16),
                                                            ],
                                                          )),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          SizedBox(
                                                              width: 150,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                children: [
                                                                  const Row(
                                                                    children: [
                                                                      Text(
                                                                        "No. Akun Kredit",
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
                                                                    // enabled: false,
                                                                    readOnly: true,
                                                                    textInputAction: TextInputAction.done,
                                                                    controller: value.noakun,
                                                                    maxLines: 1,

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
                                                                  const SizedBox(height: 16),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Nominal Transaksi",
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
                                                        // enabled: false,
                                                        readOnly: true,
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
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          hintText: "Nominal",
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
                                                        // enabled: false,
                                                        readOnly: true,
                                                        textInputAction: TextInputAction.done,
                                                        controller: value.keterangan,
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
                                                          hintText: "Keterangan",
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                        ),
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
                                                                    "Berapa Kali Pengakuan?",
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
                                                                // enabled: false,
                                                                onChanged: (e) => value.onchange(),
                                                                textInputAction: TextInputAction.done,
                                                                controller: value.berapakali,
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
                                                                  hintText: "Berapa kali pengakuan",
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
                                                                    "Bulan Mulai Pengakuan",
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
                                                                  value.showDate();
                                                                },
                                                                child: TextFormField(
                                                                  enabled: false,
                                                                  textInputAction: TextInputAction.done,
                                                                  controller: value.tglPenyusutan,
                                                                  maxLines: 1,
                                                                  validator: (e) {
                                                                    if (e!.isEmpty) {
                                                                      return "Wajib diisi";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    hintText: "Bulan Mulai Pengakuan",
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
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Nilai Pengakuan",
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
                                                        controller: value.nilaiPengakuan,
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
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          hintText: "Nilai Pengakuan",
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      const Row(
                                                        children: [
                                                          Text(
                                                            "Pilih Biaya Akun",
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
                                                              controller: value.nosbbdeb,
                                                              suggestionsCallback: (search) => value.getInquery(search),
                                                              builder: (context, controller, focusNode) {
                                                                return TextField(
                                                                    controller: controller,
                                                                    focusNode: focusNode,
                                                                    autofocus: true,
                                                                    decoration: const InputDecoration(
                                                                      border: OutlineInputBorder(),
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
                                                              controller: value.namaSbbDeb,
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
                                                                hintText: "Nomor Debet",
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
                                                        // enabled: false,

                                                        textInputAction: TextInputAction.done,
                                                        controller: value.keteranganBaru,
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
                                                          hintText: "Keterangan",
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                        ),
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
                                          ],
                                        ),
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
  DetailDataSource(BayarDimukaNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  BayarDimukaNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<TransaksiBayarDimukaModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'status', value: data.status),
                DataGridCell(columnName: 'nominal', value: data.nominal == "" ? "" : FormatCurrency.oCcy.format(int.parse(data.nominal))),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
                DataGridCell(columnName: 'tgl_trans', value: data.createddate),
                DataGridCell(columnName: 'nomor_dok', value: data.nomorDok),
                DataGridCell(columnName: 'nomor_ref', value: data.nomorRef),
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
            child: Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: e.value == "CREATED"
                    ? colorPrimary
                    : e.value == "HAPUS"
                        ? Colors.red[800]
                        : e.value == "MACET"
                            ? Colors.orange[800]
                            : Colors.green[800],
              ),
              child: Text(
                e.value == "CREATED"
                    ? "Aktif"
                    : e.value == "HAPUS"
                        ? "Hapus"
                        : e.value == "MACET"
                            ? "Macet"
                            : "Lunas",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (e.columnName == 'nominal') {
          return Container(
            alignment: Alignment.centerRight,
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
