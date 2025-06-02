import 'package:accounting/models/index.dart';
import 'package:accounting/module/hutang_piutang/hutang_piutang_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart' as a;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/colors.dart';
import '../../utils/pro_shimmer.dart';

class HutangPiutangPage extends StatelessWidget {
  final int tipe;

  const HutangPiutangPage({
    super.key,
    required this.tipe,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HutangPiutangNotifier(
        context: context,
        tipe: tipe,
      ),
      child: Consumer<HutangPiutangNotifier>(
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
                              child: Row(
                            children: [
                              Text(
                                "Kelola Hutang / Piutang",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                            ],
                          )),
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
                                "Tambah Hutang/Piutang",
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
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: FocusTraversalGroup(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Label + Radio Buttons
                            Expanded(
                              flex: 5,
                              child: Row(
                                children: [
                                  const Text(
                                    "Tipe Transaksi",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 16),
                                  Row(
                                    children: [
                                      Radio(
                                        value: true,
                                        groupValue: value.jenisTrans,
                                        activeColor: colorPrimary,
                                        onChanged: (e) => value.pilihJenisTransaksi(true),
                                      ),
                                      const Text(
                                        "Hutang",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(width: 16),
                                      Radio(
                                        value: false,
                                        groupValue: value.jenisTrans,
                                        activeColor: colorPrimary,
                                        onChanged: (e) => value.pilihJenisTransaksi(false),
                                      ),
                                      const Text(
                                        "Piutang",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                                      columnName: 'cussup',
                                      label: Container(
                                          padding: const EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Nama ${value.jenisTrans ? "Supplier" : "Customer"}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'kontrak',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('No. Kontrak',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'tgl_kontrak',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Tanggal Kontrak',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'transaksi',
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
                                      columnName: 'os',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Sisa Kewajiban',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  // Cust/Supp	No Kontrak	No Invoice	Nominal	Sisa Kewajiban	cara bayar	Jk Waktu
                                  GridColumn(
                                      columnName: 'carapenagihan',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Cara Penagihan',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'jangkawaktu',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(6),
                                          child: const Text('Jangka Waktu',
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
                                          child: const Text('Lihat',
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
                  left: 0,
                  child: value.dialog
                      ? Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      value.editData ? "Ubah / Hapus Hutang/Piutang" : "Tambah Hutang/Piutang",
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
                                      height: 50,
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 140,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  alignment: Alignment.centerLeft,
                                                  child: const Text("Pilih Tipe Transaksi"),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 50,
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("Pilih ${value.jenis == 1 ? "Customer" : "Supplier"}"),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 50,
                                                  alignment: Alignment.centerLeft,
                                                  child: const Text("Alamat"),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 50,
                                                  alignment: Alignment.centerLeft,
                                                  child: const Text("Jenis Transaksi"),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 50,
                                                  alignment: Alignment.centerLeft,
                                                  child: const Text("Cara Pembayaran"),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                value.caraPembayaran == "BERTAHAP"
                                                    ? Column(
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            alignment: Alignment.centerLeft,
                                                            child: const Text("Cara Penagihan"),
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox(),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 50,
                                                  alignment: Alignment.centerLeft,
                                                  child: const Text("Kontrak / Invoice"),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 50,
                                                  alignment: Alignment.centerLeft,
                                                  child: const Text("Nominal"),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 50,
                                                  alignment: Alignment.centerLeft,
                                                  child: const Text("No. Dok / Ref"),
                                                ),
                                                const SizedBox(
                                                  height: 24,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          Expanded(
                                              child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                    height: 50,
                                                    alignment: Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                            value: 1,
                                                            activeColor: colorPrimary,
                                                            groupValue: value.jenis,
                                                            onChanged: (e) {
                                                              value.gantijenis(1);
                                                            }),
                                                        const Text("Piutang"),
                                                        const SizedBox(
                                                          width: 32,
                                                        ),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: value.jenis,
                                                            activeColor: colorPrimary,
                                                            onChanged: (e) {
                                                              value.gantijenis(2);
                                                            }),
                                                        const Text("Hutang"),
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                    height: 50,
                                                    alignment: Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: TypeAheadField<CustomerSupplierModel>(
                                                            controller: value.customersupplier,
                                                            suggestionsCallback: (search) => value.getCustomerSupplierQuery(search),
                                                            builder: (context, controller, focusNode) {
                                                              return TextField(
                                                                  controller: controller,
                                                                  focusNode: focusNode,
                                                                  autofocus: true,
                                                                  decoration: InputDecoration(
                                                                    border: const OutlineInputBorder(),
                                                                    labelText: 'Cari ${value.jenis == 1 ? "Customer" : "Supplier"}',
                                                                  ));
                                                            },
                                                            itemBuilder: (context, city) {
                                                              return ListTile(
                                                                title: Text(city.nmSif),
                                                                subtitle: Text(city.noSif),
                                                              );
                                                            },
                                                            onSelected: (city) {
                                                              // value.selectInvoice(city);
                                                              value.pilihCustomerSupplier(city);
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Expanded(
                                                          child: TextFormField(
                                                            controller: value.ao,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              hintText: "AO Marketing",
                                                              filled: true,
                                                              fillColor: Colors.grey[200],
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
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                    height: 50,
                                                    alignment: Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            controller: value.alamat,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              hintText: "Alamat",
                                                              filled: true,
                                                              fillColor: Colors.grey[200],
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
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                    height: 50,
                                                    alignment: Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          child: DropdownSearch<String>(
                                                            popupProps: const PopupPropsMultiSelection.menu(
                                                              showSearchBox: true, // Aktifkan fitur pencarian
                                                            ),
                                                            selectedItem: value.tipePiutang,
                                                            items: value.listTipePiutang,
                                                            itemAsString: (e) => e,
                                                            onChanged: (e) {
                                                              value.pilihTipePiutang(e!);
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
                                                          width: 24,
                                                        ),
                                                        value.jenis == 1 && value.tipePiutang == "Barang"
                                                            ? Container(
                                                                width: 400,
                                                                child: Row(
                                                                  children: [
                                                                    const Text("Nilai HPP Produk"),
                                                                    const SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Expanded(
                                                                      child: TextFormField(
                                                                        controller: value.nilaihpp,
                                                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                                        inputFormatters: [
                                                                          a.CurrencyInputFormatter(
                                                                            leadingSymbol: 'Rp ',
                                                                            useSymbolPadding: true,
                                                                            thousandSeparator: a.ThousandSeparator.Period,
                                                                            mantissaLength: 2, // jumlah angka desimal
                                                                            // decimalSeparator: DecimalSeparator.Comma,
                                                                          ),
                                                                        ],
                                                                        decoration: InputDecoration(
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
                                                                      width: 16,
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                        const Text("Keterangan"),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Expanded(
                                                          child: TextFormField(
                                                            controller: value.keterangan,
                                                            validator: (e) {
                                                              if (e!.isEmpty) {
                                                                return "Wajib diisi";
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(8),
                                                                borderSide: const BorderSide(
                                                                  width: 1,
                                                                  color: Colors.grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                    height: 50,
                                                    alignment: Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Row(
                                                          children: [
                                                            Radio(
                                                                value: "BERTAHAP",
                                                                groupValue: value.caraPembayaran,
                                                                onChanged: (e) {
                                                                  value.ganticaraPembayaran("BERTAHAP");
                                                                }),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            const Text("Bertahap"),
                                                            const SizedBox(
                                                              width: 32,
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  const Text("Jangka Waktu"),
                                                                  const SizedBox(
                                                                    width: 16,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 60,
                                                                    child: TextFormField(
                                                                      validator: (e) {
                                                                        if (value.caraPembayaran == "SELURUHNYA") {
                                                                          return null;
                                                                        } else {
                                                                          if (e!.isEmpty) {
                                                                            return "Wajib diisi";
                                                                          } else {
                                                                            return null;
                                                                          }
                                                                        }
                                                                      },
                                                                      enabled: value.caraPembayaran == "BERTAHAP" ? true : false,
                                                                      controller: value.jangkawaktu,
                                                                      readOnly: value.caraPembayaran == "BERTAHAP" ? false : true,
                                                                      decoration: InputDecoration(
                                                                        filled: value.caraPembayaran == "BERTAHAP" ? false : true,
                                                                        fillColor: Colors.grey[200],
                                                                        border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  const SizedBox(width: 8),

                                                                  // Tanggal Jatuh Tempo Pertama
                                                                  Expanded(
                                                                    child: TextFormField(
                                                                      validator: (e) {
                                                                        if (value.caraPembayaran == "SELURUHNYA") {
                                                                          return null;
                                                                        } else {
                                                                          if (e!.isEmpty) {
                                                                            return "Wajib diisi";
                                                                          } else {
                                                                            return null;
                                                                          }
                                                                        }
                                                                      },
                                                                      controller: value.tglJatuhTempoPertama,
                                                                      enabled: value.caraPembayaran == "BERTAHAP" ? true : false,
                                                                      readOnly: value.caraPembayaran == "BERTAHAP" ? true : false,
                                                                      onTap: () {
                                                                        value.pilihTanggalJatuhTempoPertama();
                                                                      },
                                                                      decoration: InputDecoration(
                                                                        hintText: "Tanggal Bayar Pertama",
                                                                        filled: value.caraPembayaran == "BERTAHAP" ? false : true,
                                                                        fillColor: Colors.grey[200],
                                                                        border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(width: 16),
                                                            Radio(
                                                                value: "SELURUHNYA",
                                                                groupValue: value.caraPembayaran,
                                                                onChanged: (e) {
                                                                  value.ganticaraPembayaran("SELURUHNYA");
                                                                }),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            const Text("Seluruhnya"),
                                                            const SizedBox(
                                                              width: 32,
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  const Text("Tanggal Jatuh Tempo"),
                                                                  const SizedBox(
                                                                    width: 16,
                                                                  ),
                                                                  Expanded(
                                                                    child: InkWell(
                                                                      onTap: () => value.pilihJatuhTempo(),
                                                                      child: Expanded(
                                                                        child: TextFormField(
                                                                          validator: (e) {
                                                                            if (value.caraPembayaran == "BERTAHAP") {
                                                                              return null;
                                                                            } else {
                                                                              if (e!.isEmpty) {
                                                                                return "Wajib diisi";
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            }
                                                                          },
                                                                          enabled: value.caraPembayaran == "BERTAHAP" ? true : false,
                                                                          textInputAction: TextInputAction.done,
                                                                          controller: value.tanggalJatuhTempoText,
                                                                          maxLines: 1,
                                                                          readOnly: value.caraPembayaran == "BERTAHAP" ? true : false,
                                                                          style: const TextStyle(
                                                                            // Make text bigger and black
                                                                            color: Colors.black,
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                          decoration: InputDecoration(
                                                                            filled: value.caraPembayaran == "SELURUHNYA" ? false : true,
                                                                            fillColor: Colors.grey[200],
                                                                            hintText: "Tanggal Jatuh Tempo",
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
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                value.caraPembayaran == "BERTAHAP"
                                                    ? Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          // Baris pertama: radio-radio
                                                          Container(
                                                            height: 50,
                                                            alignment: Alignment.centerLeft,
                                                            child: Row(
                                                              children: [
                                                                // Radio Auto / Tagihan
                                                                Row(
                                                                  children: [
                                                                    Radio(
                                                                      value: true,
                                                                      groupValue: value.carabayar,
                                                                      onChanged: (e) => value.ganticarabayar(),
                                                                    ),
                                                                    const SizedBox(width: 8),
                                                                    const Text("Auto"),
                                                                    const SizedBox(width: 16),
                                                                    Radio(
                                                                      value: false,
                                                                      groupValue: value.carabayar,
                                                                      onChanged: (e) => value.ganticarabayar(),
                                                                    ),
                                                                    const SizedBox(width: 8),
                                                                    const Text("Tagihan"),
                                                                  ],
                                                                ),

                                                                const SizedBox(width: 32),

                                                                // Tagihan Bulanan
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      const Text("Tagihan Bulanan"),
                                                                      const SizedBox(width: 16),
                                                                      Radio(
                                                                        value: true,
                                                                        groupValue: value.tagihanbulanan,
                                                                        onChanged: (e) => value.gantitagitahnbulanan(),
                                                                      ),
                                                                      const SizedBox(width: 8),
                                                                      const Text("Ya"),
                                                                      const SizedBox(width: 16),
                                                                      Radio(
                                                                        value: false,
                                                                        groupValue: value.tagihanbulanan,
                                                                        onChanged: (e) => value.gantitagitahnbulanan(),
                                                                      ),
                                                                      const SizedBox(width: 8),
                                                                      const Text("Tidak"),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          const SizedBox(height: 8),
                                                        ],
                                                      )
                                                    : const SizedBox(),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                    height: 50,
                                                    alignment: Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        value.caraPembayaran == "BERTAHAP"
                                                            ? Flexible(
                                                                child: ConstrainedBox(
                                                                  constraints: BoxConstraints(maxWidth: 250),
                                                                  child: TextFormField(
                                                                    controller: value.nokontrak,
                                                                    validator: (e) {
                                                                      if (value.caraPembayaran == "BERTAHAP") {
                                                                        return null;
                                                                      } else {
                                                                        if (e!.isEmpty) {
                                                                          return "Wajib diisi";
                                                                        } else {
                                                                          return null;
                                                                        }
                                                                      }
                                                                    },
                                                                    decoration: InputDecoration(
                                                                      hintText: "No Kontrak",
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
                                                              )
                                                            : const SizedBox(),
                                                        value.carabayar
                                                            ? const SizedBox(
                                                                width: 16,
                                                              )
                                                            : const SizedBox(),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              value.caraPembayaran == "SELURUHNYA" || value.caraPembayaran == "" || value.carabayar
                                                                  ? Flexible(
                                                                      child: ConstrainedBox(
                                                                        constraints: BoxConstraints(maxWidth: 250),
                                                                        child: TextFormField(
                                                                          controller: value.noinvoice,
                                                                          validator: (e) {
                                                                            if (!value.carabayar && value.caraPembayaran == "BERTAHAP") {
                                                                              return null;
                                                                            } else {
                                                                              if (e!.isEmpty) {
                                                                                return "Wajib diisi";
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            }
                                                                          },
                                                                          decoration: InputDecoration(
                                                                            hintText: "No Invoice",
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
                                                                    )
                                                                  : SizedBox(),
                                                              const SizedBox(
                                                                width: 16,
                                                              ),
                                                              Flexible(
                                                                child: ConstrainedBox(
                                                                  constraints: BoxConstraints(maxWidth: 250),
                                                                  child: InkWell(
                                                                    onTap: () => value.pilihTanggalKontrak(),
                                                                    child: TextFormField(
                                                                      validator: (e) {
                                                                        if (e!.isEmpty) {
                                                                          return "Wajib diisi";
                                                                        } else {
                                                                          return null;
                                                                        }
                                                                      },
                                                                      enabled: false,
                                                                      textInputAction: TextInputAction.done,
                                                                      controller: value.tanggalKontrak,
                                                                      style: const TextStyle(
                                                                        // Make text bigger and black
                                                                        color: Colors.black,
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                      decoration: InputDecoration(
                                                                        hintText: "Tanggal",
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
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 50,
                                                  alignment: Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints(maxWidth: 250),
                                                          child: TextFormField(
                                                            validator: (e) {
                                                              if (e!.isEmpty) {
                                                                return "Wajib diisi";
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            onChanged: (e) {
                                                              value.changeTotal();
                                                            },
                                                            controller: value.nilaitransaksi,
                                                            textAlign: TextAlign.right,
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            inputFormatters: [
                                                              a.CurrencyInputFormatter(
                                                                leadingSymbol: 'Rp ',
                                                                useSymbolPadding: true,
                                                                thousandSeparator: a.ThousandSeparator.Period,
                                                                mantissaLength: 2, // jumlah angka desimal
                                                                // decimalSeparator: DecimalSeparator.Comma,
                                                              ),
                                                            ],
                                                            decoration: InputDecoration(
                                                              hintText: "Transaksi",
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
                                                        width: 8,
                                                      ),
                                                      Checkbox(
                                                        value: value.ppn,
                                                        onChanged: (e) {
                                                          value.gantippn();
                                                        },
                                                        activeColor: colorPrimary,
                                                      ),
                                                      const Text(
                                                        "PPN",
                                                        style: TextStyle(fontSize: 12),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Flexible(
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints(maxWidth: 250),
                                                          child: TextFormField(
                                                            validator: (e) {
                                                              if (!value.ppn) {
                                                                return null;
                                                              } else {
                                                                if (e!.isEmpty) {
                                                                  return "Wajib diisi";
                                                                } else {
                                                                  return null;
                                                                }
                                                              }
                                                            },
                                                            controller: value.nilaippn,
                                                            textAlign: TextAlign.right,
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            inputFormatters: [
                                                              a.CurrencyInputFormatter(
                                                                leadingSymbol: 'Rp ',
                                                                useSymbolPadding: true,
                                                                thousandSeparator: a.ThousandSeparator.Period,
                                                                mantissaLength: 2, // jumlah angka desimal
                                                                // decimalSeparator: DecimalSeparator.Comma,
                                                              ),
                                                            ],
                                                            decoration: InputDecoration(
                                                              filled: !value.ppn,
                                                              fillColor: Colors.grey[200],
                                                              hintText: "PPN",
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
                                                        width: 8,
                                                      ),
                                                      Checkbox(
                                                        value: value.pph,
                                                        onChanged: (e) {
                                                          value.gantipph();
                                                        },
                                                        activeColor: colorPrimary,
                                                      ),
                                                      const Text(
                                                        "PPH",
                                                        style: TextStyle(fontSize: 12),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Flexible(
                                                        child: ConstrainedBox(
                                                          constraints: BoxConstraints(maxWidth: 250),
                                                          child: TextFormField(
                                                            validator: (e) {
                                                              if (!value.pph) {
                                                                return null;
                                                              } else {
                                                                if (e!.isEmpty) {
                                                                  return "Wajib diisi";
                                                                } else {
                                                                  return null;
                                                                }
                                                              }
                                                            },
                                                            controller: value.nilaipph,
                                                            textAlign: TextAlign.right,
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            inputFormatters: [
                                                              a.CurrencyInputFormatter(
                                                                leadingSymbol: 'Rp ',
                                                                useSymbolPadding: true,
                                                                thousandSeparator: a.ThousandSeparator.Period,
                                                                mantissaLength: 2, // jumlah angka desimal
                                                                // decimalSeparator: DecimalSeparator.Comma,
                                                              ),
                                                            ],
                                                            decoration: InputDecoration(
                                                              filled: !value.pph,
                                                              fillColor: Colors.grey[200],
                                                              hintText: "PPH",
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
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 40,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              child: ConstrainedBox(
                                                                constraints: BoxConstraints(maxWidth: 250),
                                                                child: TextFormField(
                                                                  controller: value.nodok,
                                                                  validator: (e) {
                                                                    if (e!.isEmpty) {
                                                                      return "Wajib diisi";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    hintText: "Dokumen",
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
                                                            const SizedBox(
                                                              width: 16,
                                                            ),
                                                            Flexible(
                                                              child: ConstrainedBox(
                                                                constraints: BoxConstraints(maxWidth: 250),
                                                                child: TextFormField(
                                                                  controller: value.noreferensi,
                                                                  validator: (e) {
                                                                    if (e!.isEmpty) {
                                                                      return "Wajib diisi";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    hintText: "Referensi",
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
                                                            const Text(
                                                              "PPN/PPH",
                                                            ),
                                                            const SizedBox(
                                                              width: 16,
                                                            ),
                                                            Radio(
                                                              value: true,
                                                              groupValue: value.pphppn,
                                                              onChanged: (e) => value.gantipphppn(),
                                                            ),
                                                            const SizedBox(width: 8),
                                                            const Text(
                                                              "Proporsional",
                                                            ),
                                                            const SizedBox(width: 8),
                                                            Radio(
                                                              value: false,
                                                              groupValue: value.pphppn,
                                                              onChanged: (e) => value.gantipphppn(),
                                                            ),
                                                            const SizedBox(width: 8),
                                                            const Text(
                                                              "Diakhir",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 24,
                                                ),
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                      value.caraPembayaran == "BERTAHAP"
                                          ? Row(
                                              children: [
                                                ButtonPrimary(
                                                  onTap: () {
                                                    value.hitungPembayaran();
                                                  },
                                                  name: "Bentuk Jadwal Pembayaran",
                                                )
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                ButtonPrimary(
                                                  onTap: () {
                                                    value.cek();
                                                  },
                                                  name: "Simpan",
                                                )
                                              ],
                                            ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      value.listNilaiTransaksi.isEmpty
                                          ? const SizedBox()
                                          : const Row(
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  child: Text("No",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 166,
                                                  child: Center(
                                                    child: Text("Jatuh Tempo",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 262,
                                                  child: Text("Outstanding",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 274,
                                                  child: Text("Nominal",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 278,
                                                  child: Text("PPN",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 280,
                                                  child: Text("PPH",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                      )),
                                                ),
                                              ],
                                            ),
                                      ListView.builder(
                                          itemCount: value.listNilaiTransaksi.length,
                                          shrinkWrap: true,
                                          physics: const ClampingScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            var no = i + 1;
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 32,
                                                      margin: const EdgeInsets.only(right: 16),
                                                      child: Text("$no. "),
                                                    ),
                                                    Container(
                                                      width: 150,
                                                      margin: const EdgeInsets.only(right: 16),
                                                      child: TextFormField(
                                                        controller: value.listTglJthTempo[i],
                                                        // readOnly:
                                                        //     value.tagihanbulanan
                                                        //         ? true
                                                        //         : false,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                              borderSide: const BorderSide(
                                                                width: 1,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                            // filled:
                                                            //     value.tagihanbulanan
                                                            //         ? true
                                                            //         : false,
                                                            // fillColor:
                                                            //     Colors.grey[200],
                                                            hintText: "Jatuh Tempo"),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        controller: value.listOutstanding[i],
                                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                        inputFormatters: [
                                                          a.CurrencyInputFormatter(
                                                            leadingSymbol: '',
                                                            useSymbolPadding: true,
                                                            thousandSeparator: a.ThousandSeparator.Period,
                                                            mantissaLength: 2,
                                                          ),
                                                        ],
                                                        // readOnly:
                                                        //     value.tagihanbulanan
                                                        //         ? true
                                                        //         : false,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                              borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                            filled: true,
                                                            fillColor: Colors.grey[200],
                                                            hintText: "Outstanding"),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        readOnly: !value.tagihanbulanan ? false : true,
                                                        controller: value.listNilaiTransaksi[i],
                                                        onChanged: (e) {
                                                          if (!value.tagihanbulanan) {
                                                            value.onNilaiTransaksiChanged(i, e);
                                                          }
                                                        },
                                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                        inputFormatters: [
                                                          a.CurrencyInputFormatter(
                                                            leadingSymbol: '',
                                                            useSymbolPadding: true,
                                                            thousandSeparator: a.ThousandSeparator.Period,
                                                            mantissaLength: 2, // jumlah angka desimal
                                                            // decimalSeparator: DecimalSeparator.Comma,
                                                          ),
                                                        ],
                                                        // readOnly:
                                                        //     value.tagihanbulanan
                                                        //         ? true
                                                        //         : false,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                              borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                            filled: value.tagihanbulanan ? true : false,
                                                            fillColor: Colors.grey[200],
                                                            hintText: "Nilai Transaksi"),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        controller: value.listNilaiPPN[i],
                                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                        inputFormatters: [
                                                          a.CurrencyInputFormatter(
                                                            leadingSymbol: '',
                                                            useSymbolPadding: true,
                                                            thousandSeparator: a.ThousandSeparator.Period,
                                                            mantissaLength: 2, // jumlah angka desimal
                                                            // decimalSeparator: DecimalSeparator.Comma,
                                                          ),
                                                        ],
                                                        // readOnly:
                                                        //     value.tagihanbulanan
                                                        //         ? true
                                                        //         : false,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                              borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                            filled: true,
                                                            fillColor: Colors.grey[200],
                                                            hintText: "Nilai PPN"),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        controller: value.listNilaiPPH[i],
                                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                        inputFormatters: [
                                                          a.CurrencyInputFormatter(
                                                            leadingSymbol: '',
                                                            useSymbolPadding: true,
                                                            thousandSeparator: a.ThousandSeparator.Period,
                                                            mantissaLength: 2, // jumlah angka desimal
                                                            // decimalSeparator: DecimalSeparator.Comma,
                                                          ),
                                                        ],
                                                        // readOnly:
                                                        //     value.tagihanbulanan
                                                        //         ? true
                                                        //         : false,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                              borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                            filled: true,
                                                            fillColor: Colors.grey[200],
                                                            hintText: "Nilai PPH"),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                )
                                              ],
                                            );
                                          }),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      value.buttonSimpan
                                          ? ButtonPrimary(
                                              onTap: () {
                                                value.cek();
                                              },
                                              name: "Simpan",
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        )
                      : const SizedBox())
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(HutangPiutangNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listTransaksiAdd);
  }

  HutangPiutangNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<HutangPiutangTransaksiModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'cussup', value: data.namaSif),
                DataGridCell(columnName: 'kontrak', value: data.nokontrak),
                DataGridCell(columnName: 'tgl_kontrak', value: data.tglKontrak),
                DataGridCell(columnName: 'transaksi', value: FormatCurrency.oCcyDecimal.format(double.parse(data.totalTagPokok))),
                DataGridCell(
                    columnName: 'os',
                    value: FormatCurrency.oCcyDecimal.format((double.parse(data.totalTagPokok) - double.parse(data.totalByrPokok)))),
                DataGridCell(columnName: 'carabayar', value: data.noinv == null ? "Tagihan" : "Auto"),
                DataGridCell(columnName: 'jangkawaktu', value: data.jangkawaktu),
                DataGridCell(columnName: 'action', value: data.nokontrak.toString()),
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
                // tindakanNotifier!.edit(e.value);
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
