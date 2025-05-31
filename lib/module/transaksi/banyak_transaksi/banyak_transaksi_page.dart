import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/golongan_aset/golongan_aset_notifier.dart';
import 'package:accounting/module/transaksi/banyak_transaksi/banyak_transaksi_notifier.dart';
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

class BanyakTransaksiPage extends StatelessWidget {
  const BanyakTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BanyakTransaksiNotifier(context: context),
      child: Consumer<BanyakTransaksiNotifier>(
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
                              "Banyak Transaksi",
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
                child: value.dialog
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        width: 1180,
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
                                          SizedBox(
                                              width: 1000,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Pilih Akun",
                                                        style: TextStyle(fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(fontSize: 8),
                                                      ),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      Radio(value: false, groupValue: value.akun, onChanged: (e) => value.gantiakun(false)),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      const Text("Debet"),
                                                      const SizedBox(
                                                        width: 24,
                                                      ),
                                                      Radio(value: true, groupValue: value.akun, onChanged: (e) => value.gantiakun(true)),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      const Text("Credit"),
                                                      const SizedBox(width: 150),
                                                      Checkbox(
                                                        activeColor: colorPrimary,
                                                        value: value.backDate,
                                                        onChanged: (e) => value.gantibackDate(),
                                                      ),
                                                      const Text(
                                                        "Transaksi Back Date",
                                                        style: TextStyle(fontSize: 12),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(fontSize: 8),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () => value.tanggalBackDate(),
                                                          child: TextFormField(
                                                            enabled: !value.backDate,
                                                            textInputAction: TextInputAction.done,
                                                            controller: value.tglBackDatetext,
                                                            maxLines: 1,
                                                            readOnly: !value.backDate,
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
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                ],
                                              )),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 368,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
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
                                                            hintText: "Nomor Akun",
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(6),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                ],
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: 382,
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
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          SizedBox(
                                              width: 300,
                                              child: Column(
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
                                                    textAlign: TextAlign.end,
                                                    textInputAction: TextInputAction.done,
                                                    controller: value.nominal,
                                                    onChanged: (e) {
                                                      value.changeTotal();
                                                    },
                                                    maxLines: 1,
                                                    inputFormatters: [
                                                      a.CurrencyInputFormatter(
                                                        leadingSymbol: 'Rp ',
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
                                                  const SizedBox(height: 16),
                                                ],
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Input Transaksi Lawan",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () => value.tambahTransaksi(),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                              decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(16)),
                                              child: const Text(
                                                "Tambah Akun",
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
                                          itemCount: value.transaksi,
                                          shrinkWrap: true,
                                          physics: const ClampingScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 216,
                                                      child: TypeAheadField<InqueryGlModel>(
                                                        controller: value.listNamaSbbItems[i],
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
                                                          value.pilihAkunItem(city, i);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 150,
                                                      child: TextFormField(
                                                        textInputAction: TextInputAction.done,
                                                        controller: value.listNoDok[i],
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
                                                    ),
                                                    const SizedBox(
                                                      width: 32,
                                                    ),
                                                    SizedBox(
                                                      width: 300,
                                                      child: TextFormField(
                                                        textAlign: TextAlign.end,
                                                        textInputAction: TextInputAction.done,
                                                        maxLines: 1,
                                                        onChanged: (e) {
                                                          value.changeTotal();
                                                        },
                                                        controller: value.listAmount[i],
                                                        inputFormatters: [
                                                          a.CurrencyInputFormatter(
                                                            leadingSymbol: 'Rp ',
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
                                                          hintText: "Nominal",
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
                                                      width: 200,
                                                      child: DropdownSearch<AoModel>(
                                                        popupProps: const PopupPropsMultiSelection.menu(
                                                          showSearchBox: true, // Aktifkan fitur pencarian
                                                        ),
                                                        selectedItem: value.listAoitems[i],
                                                        items: value.listAo,
                                                        itemAsString: (e) => e.nama,
                                                        onChanged: (e) {
                                                          value.pilihAoModelDebet(e!, i);
                                                        },
                                                        dropdownBuilder: (context, selectedItem) {
                                                          return Text(
                                                            selectedItem != null ? selectedItem.nama : "AO",
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(fontSize: 16),
                                                          );
                                                        },
                                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                                          baseStyle: const TextStyle(fontSize: 16),
                                                          textAlignVertical: TextAlignVertical.center,
                                                          dropdownSearchDecoration: InputDecoration(
                                                            hintText: "AO",
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
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller: value.listKeterangan[i],
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
                                                          hintText: "Keterangan",
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        value.remove(i);
                                                      },
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
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
                                                const SizedBox(height: 8),
                                              ],
                                            );
                                          }),
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 16),
                                        height: 1,
                                        color: Colors.grey[300],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 382,
                                              child: const Text(
                                                "Selisih",
                                                textAlign: TextAlign.end,
                                              )),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          SizedBox(
                                            width: 290,
                                            child: Text(
                                              "Rp. ${FormatCurrency.oCcyDecimal.format(value.total)}",
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 432,
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 16),
                                        height: 1,
                                        color: Colors.grey[300],
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
  DetailDataSource(BanyakTransaksiNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listData);
  }

  BanyakTransaksiNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<TransaksiModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'tgl_val', value: data.tglVal),
                DataGridCell(columnName: 'tgl_trans', value: data.tglTrans),
                DataGridCell(columnName: 'nomor_dok', value: data.nomorDok),
                DataGridCell(columnName: 'nomor_ref', value: data.nomorRef),
                DataGridCell(columnName: 'nominal', value: FormatCurrency.oCcyDecimal.format(double.parse(data.nominal))),
                DataGridCell(columnName: 'nama_debet', value: data.namaDebet),
                DataGridCell(columnName: 'nama_credit', value: data.namaCredit),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
                DataGridCell(columnName: 'debet_acc', value: data.debetAcc),
                DataGridCell(columnName: 'credit_acc', value: data.creditAcc),
                DataGridCell(columnName: 'action', value: data.nomorDok),
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
              onTap: () {},
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
