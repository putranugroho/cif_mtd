import 'package:accounting/models/index.dart';
import 'package:accounting/module/master/bank/bank_notifier.dart';
import 'package:accounting/module/master/customer/customer_notifier.dart';
import 'package:accounting/module/master/users/users_notifier.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/colors.dart';
import '../../../utils/currency_formatted.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomerNotifier(context: context),
      child: Consumer<CustomerNotifier>(
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
                              "Customer / Supplier",
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
                                "Tambah Customer / Supplier",
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
                                columnName: 'no_sif',
                                label: Container(
                                    padding: EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: Text('No Sif',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                columnName: 'nm_sif',
                                label: Container(
                                    padding: EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: Text('Nama Sif',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                columnName: 'gol_cust',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Golongan Customer',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'bidang_usaha',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Bidang Usaha',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'alamat',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Alamat',
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
                        child: FocusTraversalGroup(
                          child: Form(
                            key: value.keyForm,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Tambah Customer / Supplier",
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
                                    child: ListView(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Kode Customer / Supplier",
                                          style: const TextStyle(fontSize: 12),
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
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.noSif,
                                      maxLines: 1,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z0-9]'))
                                      ],
                                      validator: (e) {
                                        if (e!.isEmpty) {
                                          return "Wajib diisi";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Kode Customer / Supplier  ",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Nama Customer / Supplier",
                                          style: const TextStyle(fontSize: 12),
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
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.namaSif,
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
                                        hintText: "Nama Customer / Supplier  ",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Golongan Customer",
                                          style: const TextStyle(fontSize: 12),
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
                                    DropdownSearch<String>(
                                      popupProps:
                                          const PopupPropsMultiSelection.menu(
                                        showSearchBox:
                                            true, // Aktifkan fitur pencarian
                                      ),
                                      selectedItem: value.golCust,
                                      items: value.listGolCust,
                                      itemAsString: (e) => "${e}",
                                      onChanged: (e) {
                                        value.pilihGolCust(e!);
                                      },
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        baseStyle: TextStyle(fontSize: 16),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: "Pilih Golongan Customer",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
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
                                          "Bidang Usaha",
                                          style: const TextStyle(fontSize: 12),
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
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.bidangUsaha,
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
                                        hintText: "Bidang Usaha  ",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Provinsi",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        DropdownSearch<ProvinsiModel>(
                                          popupProps:
                                              const PopupPropsMultiSelection
                                                  .menu(
                                            showSearchBox:
                                                true, // Aktifkan fitur pencarian
                                          ),
                                          selectedItem: value.provinsiModel,
                                          items: value.listProvinsi,
                                          itemAsString: (e) => "${e.name}",
                                          onChanged: (e) {
                                            value.pilihProvinsi(e!);
                                          },
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            baseStyle: TextStyle(fontSize: 16),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              hintText: "Pilih Provinsi",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Kota",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        DropdownSearch<KotaModel>(
                                          popupProps:
                                              const PopupPropsMultiSelection
                                                  .menu(
                                            showSearchBox:
                                                true, // Aktifkan fitur pencarian
                                          ),
                                          enabled: value.listKota.isNotEmpty
                                              ? true
                                              : false,
                                          selectedItem: value.kotaModal,
                                          items: value.listKota,
                                          itemAsString: (e) => "${e.name}",
                                          onChanged: (e) {
                                            value.pilihKota(e!);
                                          },
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            baseStyle: TextStyle(fontSize: 16),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              hintText: "Pilih Kota",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                "Kecamatan",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              DropdownSearch<KecamatanModel>(
                                                popupProps:
                                                    const PopupPropsMultiSelection
                                                        .menu(
                                                  showSearchBox:
                                                      true, // Aktifkan fitur pencarian
                                                ),
                                                enabled: value.listKecamatan
                                                        .isNotEmpty
                                                    ? true
                                                    : false,
                                                selectedItem:
                                                    value.kecamatanModel,
                                                items: value.listKecamatan,
                                                itemAsString: (e) =>
                                                    "${e.name}",
                                                onChanged: (e) {
                                                  value.pilihKecamatan(e!);
                                                },
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                  baseStyle:
                                                      TextStyle(fontSize: 16),
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    hintText: "Pilih Kecamatan",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
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
                                        const SizedBox(
                                          width: 32,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                "Kelurahan",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              DropdownSearch<KelurahanModel>(
                                                popupProps:
                                                    const PopupPropsMultiSelection
                                                        .menu(
                                                  showSearchBox:
                                                      true, // Aktifkan fitur pencarian
                                                ),
                                                enabled: value.listKelurahan
                                                        .isNotEmpty
                                                    ? true
                                                    : false,
                                                selectedItem:
                                                    value.kelurahanModel,
                                                items: value.listKelurahan,
                                                itemAsString: (e) =>
                                                    "${e.name}",
                                                onChanged: (e) {
                                                  value.pilihKelurahan(e!);
                                                },
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                  baseStyle:
                                                      TextStyle(fontSize: 16),
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    hintText: "Pilih Kelurahan",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
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
                                        const SizedBox(
                                          width: 32,
                                        ),
                                        SizedBox(
                                            width: 140,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Kode Pos",
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
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  maxLength: 5,
                                                  controller: value.kodepos,
                                                  validator: (e) {
                                                    if (e!.isEmpty) {
                                                      return "Wajib diisi";
                                                    } else {
                                                      if (e.length < 5) {
                                                        return "Wajib 5 digit";
                                                      } else {
                                                        return null;
                                                      }
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Kode Pos",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Text(
                                          "Alamat",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.newline,
                                      controller: value.alamat,
                                      maxLines: 3,
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
                                        hintText: "Input Alamat",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Text(
                                          "PKP",
                                          style: const TextStyle(fontSize: 12),
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
                                      children: [
                                        Radio(
                                            activeColor: colorPrimary,
                                            value: true,
                                            groupValue: value.pkp,
                                            onChanged: (e) {
                                              value.pilihPkp(true);
                                            }),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text("PKP"),
                                        SizedBox(
                                          width: 24,
                                        ),
                                        Radio(
                                            activeColor: colorPrimary,
                                            value: false,
                                            groupValue: value.pkp,
                                            onChanged: (e) {
                                              value.pilihPkp(false);
                                            }),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text("Non - PKP"),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    value.pkp
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "NPWP",
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "*",
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                controller: value.npwp,
                                                maxLines: 1,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "NPWP",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                            ],
                                          )
                                        : SizedBox(),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Telp. Customer / Supplier",
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
                                            TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.notelp,
                                              maxLines: 1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Telp. Customer / Supplier",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        )),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Email Customer / Supplier",
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(width: 5),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.email,
                                              maxLines: 1,
                                              // inputFormatters: [
                                              //   FilteringTextInputFormatter.digitsOnly
                                              // ],
                                              // validator: (e) {
                                              //   if (e!.isEmpty) {
                                              //     return "Wajib diisi";
                                              //   } else {
                                              //     return null;
                                              //   }
                                              // },
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Email Customer / Supplier",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        )),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 16),
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Kontak 1")),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 16),
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Nama Kontak 1",
                                          style: const TextStyle(fontSize: 12),
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
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.kontak1,
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
                                        hintText: "Nama Kontak 1",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "No HP 1",
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
                                            TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.hp1,
                                              maxLines: 1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: "HP Kontak 1",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        )),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Email 1",
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(width: 5),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.email1,
                                              maxLines: 1,
                                              // inputFormatters: [
                                              //   FilteringTextInputFormatter.digitsOnly
                                              // ],
                                              // validator: (e) {
                                              //   if (e!.isEmpty) {
                                              //     return "Wajib diisi";
                                              //   } else {
                                              //     return null;
                                              //   }
                                              // },
                                              decoration: InputDecoration(
                                                hintText: "Email 1",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
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
                                        Text(
                                          "Keterangan",
                                          style: const TextStyle(fontSize: 12),
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
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.keterangan1,
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 16),
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Kontak 2")),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 16),
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Nama Kontak 2",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.kontak2,
                                      maxLines: 1,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],

                                      decoration: InputDecoration(
                                        hintText: "Nama Kontak 2",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "No HP 2",
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(width: 5),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.hp2,
                                              maxLines: 1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: InputDecoration(
                                                hintText: "HP Kontak 2",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        )),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Email 2",
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(width: 5),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.email2,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                hintText: "Email 2",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
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
                                        Text(
                                          "Keterangan",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.keterangan2,
                                      maxLines: 1,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],

                                      decoration: InputDecoration(
                                        hintText: "Keterangan",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 16),
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Text("Kontak 3")),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 16),
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Nama Kontak 3",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.kontak3,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: "Nama Kontak 3",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "No HP 3",
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(width: 5),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.hp3,
                                              maxLines: 1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: InputDecoration(
                                                hintText: "HP Kontak 3",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        )),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Email 3",
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(width: 5),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.email3,
                                              maxLines: 1,
                                              // inputFormatters: [
                                              //   FilteringTextInputFormatter.digitsOnly
                                              // ],

                                              decoration: InputDecoration(
                                                hintText: "Email 3",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
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
                                        Text(
                                          "Keterangan",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: value.keterangan3,
                                      maxLines: 1,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],

                                      decoration: InputDecoration(
                                        hintText: "Keterangan",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    value.golCust != "Customer dan Supplier"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "AO ${value.golCust}",
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 5),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              DropdownSearch<AoModel>(
                                                popupProps:
                                                    const PopupPropsMultiSelection
                                                        .menu(
                                                  showSearchBox:
                                                      true, // Aktifkan fitur pencarian
                                                ),
                                                selectedItem:
                                                    value.golCust == "Customer"
                                                        ? value.aoModel
                                                        : value.aoModelKRedit,
                                                items: value.listAoModel
                                                    .where((e) =>
                                                        e.golCust ==
                                                            "${value.golCust == "Customer" ? "1" : "2"}" ||
                                                        e.golCust == "3")
                                                    .toList(),
                                                itemAsString: (e) =>
                                                    "${e.nama}",
                                                onChanged: (e) {
                                                  value.golCust == "Customer"
                                                      ? value
                                                          .pilihAoModelDebet(e!)
                                                      : value
                                                          .pilihAoModelKredit(
                                                              e!);
                                                },
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                  baseStyle:
                                                      TextStyle(fontSize: 16),
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    hintText:
                                                        "Pilih AO ${value.golCust}",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "AO Customer",
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 5),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              DropdownSearch<AoModel>(
                                                popupProps:
                                                    const PopupPropsMultiSelection
                                                        .menu(
                                                  showSearchBox:
                                                      true, // Aktifkan fitur pencarian
                                                ),
                                                selectedItem: value.aoModel,
                                                items: value.listAoModel
                                                    .where((e) =>
                                                        e.golCust == "1" ||
                                                        e.golCust == "3")
                                                    .toList(),
                                                itemAsString: (e) =>
                                                    "${e.nama}",
                                                onChanged: (e) {
                                                  value.pilihAoModelDebet(e!);
                                                },
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                  baseStyle:
                                                      TextStyle(fontSize: 16),
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    hintText:
                                                        "Pilih AO Customer",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                children: [
                                                  Text(
                                                    "AO Supplier",
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 5),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              DropdownSearch<AoModel>(
                                                popupProps:
                                                    const PopupPropsMultiSelection
                                                        .menu(
                                                  showSearchBox:
                                                      true, // Aktifkan fitur pencarian
                                                ),
                                                selectedItem:
                                                    value.aoModelKRedit,
                                                items: value.listAoModel
                                                    .where((e) =>
                                                        e.golCust == "2" ||
                                                        e.golCust == "3")
                                                    .toList(),
                                                itemAsString: (e) =>
                                                    "${e.nama}",
                                                onChanged: (e) {
                                                  value.pilihAoModelKredit(e!);
                                                },
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                  baseStyle:
                                                      TextStyle(fontSize: 16),
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    hintText:
                                                        "Pilih AO Supplier",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
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
                                    ButtonPrimary(
                                      onTap: () {
                                        value.cek();
                                      },
                                      name: "Simpan",
                                    ),
                                    value.editData
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const SizedBox(height: 16),
                                              ButtonDanger(
                                                onTap: () {
                                                  value.confirm();
                                                },
                                                name: "Hapus",
                                              ),
                                            ],
                                          )
                                        : SizedBox()
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "User ID",
                                    //       style: const TextStyle(fontSize: 12),
                                    //     ),
                                    //     const SizedBox(width: 5),
                                    //     const Text(
                                    //       "*",
                                    //       style: TextStyle(fontSize: 8),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    // TextFormField(
                                    //   textInputAction: TextInputAction.done,
                                    //   controller: value.userid,
                                    //   maxLines: 1,
                                    //   // inputFormatters: [
                                    //   //   FilteringTextInputFormatter.digitsOnly
                                    //   // ],
                                    //   validator: (e) {
                                    //     if (e!.isEmpty) {
                                    //       return "Wajib diisi";
                                    //     } else {
                                    //       return null;
                                    //     }
                                    //   },
                                    //   decoration: InputDecoration(
                                    //     hintText: "User ID  ",
                                    //     border: OutlineInputBorder(
                                    //       borderRadius: BorderRadius.circular(6),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 16,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Password",
                                    //       style: const TextStyle(fontSize: 12),
                                    //     ),
                                    //     const SizedBox(width: 5),
                                    //     const Text(
                                    //       "*",
                                    //       style: TextStyle(fontSize: 8),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    // TextFormField(
                                    //   textInputAction: TextInputAction.done,
                                    //   controller: value.userid,
                                    //   maxLines: 1,
                                    //   obscureText: true,
                                    //   // inputFormatters: [
                                    //   //   FilteringTextInputFormatter.digitsOnly
                                    //   // ],
                                    //   validator: (e) {
                                    //     if (e!.isEmpty) {
                                    //       return "Wajib diisi";
                                    //     } else {
                                    //       return null;
                                    //     }
                                    //   },
                                    //   decoration: InputDecoration(
                                    //     hintText: "Password  ",
                                    //     border: OutlineInputBorder(
                                    //       borderRadius: BorderRadius.circular(6),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 16,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Level User",
                                    //       style: const TextStyle(fontSize: 12),
                                    //     ),
                                    //     const SizedBox(width: 5),
                                    //     const Text(
                                    //       "*",
                                    //       style: TextStyle(fontSize: 8),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    // DropdownSearch<String>(
                                    //   popupProps:
                                    //       const PopupPropsMultiSelection.menu(
                                    //     showSearchBox:
                                    //         true, // Aktifkan fitur pencarian
                                    //   ),
                                    //   selectedItem: value.levelUser,
                                    //   items: value.listLevelUsers,
                                    //   itemAsString: (e) => "${e}",
                                    //   onChanged: (e) {
                                    //     value.pilihLevel(e!);
                                    //   },
                                    //   dropdownDecoratorProps:
                                    //       DropDownDecoratorProps(
                                    //     baseStyle: TextStyle(fontSize: 16),
                                    //     textAlignVertical: TextAlignVertical.center,
                                    //     dropdownSearchDecoration: InputDecoration(
                                    //       hintText: "Pilih Level User",
                                    //       border: OutlineInputBorder(
                                    //         borderRadius: BorderRadius.circular(8),
                                    //         borderSide: BorderSide(
                                    //           width: 1,
                                    //           color: Colors.grey,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 16,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Terminal ID",
                                    //       style: const TextStyle(fontSize: 12),
                                    //     ),
                                    //     const SizedBox(width: 5),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    // TextFormField(
                                    //   textInputAction: TextInputAction.done,
                                    //   maxLines: 1,
                                    //   decoration: InputDecoration(
                                    //     hintText: "Input Terminal ID",
                                    //     suffixIcon: InkWell(
                                    //         onTap: () {},
                                    //         child: Icon(Icons.search)),
                                    //     border: OutlineInputBorder(
                                    //       borderRadius: BorderRadius.circular(6),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 16,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Level Otorisasi",
                                    //       style: const TextStyle(fontSize: 12),
                                    //     ),
                                    //     const SizedBox(width: 5),
                                    //     const Text(
                                    //       "*",
                                    //       style: TextStyle(fontSize: 8),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    // DropdownSearch<String>(
                                    //   popupProps:
                                    //       const PopupPropsMultiSelection.menu(
                                    //     showSearchBox:
                                    //         true, // Aktifkan fitur pencarian
                                    //   ),
                                    //   selectedItem: value.levelOtor,
                                    //   items: value.listLevelOtor,
                                    //   itemAsString: (e) => "${e}",
                                    //   onChanged: (e) {
                                    //     value.pilihLevelOtor(e!);
                                    //   },
                                    //   dropdownDecoratorProps:
                                    //       DropDownDecoratorProps(
                                    //     baseStyle: TextStyle(fontSize: 16),
                                    //     textAlignVertical: TextAlignVertical.center,
                                    //     dropdownSearchDecoration: InputDecoration(
                                    //       hintText: "Pilih Level Otor",
                                    //       border: OutlineInputBorder(
                                    //         borderRadius: BorderRadius.circular(8),
                                    //         borderSide: BorderSide(
                                    //           width: 1,
                                    //           color: Colors.grey,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 16,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //         child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.stretch,
                                    //       children: [
                                    //         Row(
                                    //           children: [
                                    //             Text(
                                    //               "Minimal Otorisasi",
                                    //               style:
                                    //                   const TextStyle(fontSize: 12),
                                    //             ),
                                    //             const SizedBox(width: 5),
                                    //             const Text(
                                    //               "*",
                                    //               style: TextStyle(fontSize: 8),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //         const SizedBox(
                                    //           height: 8,
                                    //         ),
                                    //         TextFormField(
                                    //           textInputAction: TextInputAction.done,
                                    //           maxLines: 1,
                                    //           inputFormatters: [
                                    //             FilteringTextInputFormatter
                                    //                 .digitsOnly,
                                    //             CurrencyInputFormatter(),
                                    //           ],
                                    //           validator: (e) {
                                    //             if (e!.isEmpty) {
                                    //               return "Wajib diisi";
                                    //             } else {
                                    //               return null;
                                    //             }
                                    //           },
                                    //           decoration: InputDecoration(
                                    //             hintText: "Minimal Otorisasi",
                                    //             border: OutlineInputBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(6),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         const SizedBox(height: 16),
                                    //       ],
                                    //     )),
                                    //     SizedBox(
                                    //       width: 16,
                                    //     ),
                                    //     Expanded(
                                    //         child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.stretch,
                                    //       children: [
                                    //         Row(
                                    //           children: [
                                    //             Text(
                                    //               "Maksimal Otorisasi",
                                    //               style:
                                    //                   const TextStyle(fontSize: 12),
                                    //             ),
                                    //             const SizedBox(width: 5),
                                    //             const Text(
                                    //               "*",
                                    //               style: TextStyle(fontSize: 8),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //         const SizedBox(
                                    //           height: 8,
                                    //         ),
                                    //         TextFormField(
                                    //           textInputAction: TextInputAction.done,
                                    //           maxLines: 1,
                                    //           inputFormatters: [
                                    //             FilteringTextInputFormatter
                                    //                 .digitsOnly,
                                    //             CurrencyInputFormatter(),
                                    //           ],
                                    //           validator: (e) {
                                    //             if (e!.isEmpty) {
                                    //               return "Wajib diisi";
                                    //             } else {
                                    //               return null;
                                    //             }
                                    //           },
                                    //           decoration: InputDecoration(
                                    //             hintText: "Maksimal Otorisasi",
                                    //             border: OutlineInputBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(6),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         const SizedBox(height: 16),
                                    //       ],
                                    //     ))
                                    //   ],
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Beda Kantor",
                                    //       style: const TextStyle(fontSize: 12),
                                    //     ),
                                    //     const SizedBox(width: 5),
                                    //     const Text(
                                    //       "*",
                                    //       style: TextStyle(fontSize: 8),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Radio(
                                    //         value: false,
                                    //         activeColor: colorPrimary,
                                    //         groupValue: value.bedaKantor,
                                    //         onChanged: (e) =>
                                    //             value.pilihBedaKantor(false)),
                                    //     SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     Text("Sesama Kantor"),
                                    //     SizedBox(
                                    //       width: 24,
                                    //     ),
                                    //     Radio(
                                    //         value: true,
                                    //         activeColor: colorPrimary,
                                    //         groupValue: value.bedaKantor,
                                    //         onChanged: (e) =>
                                    //             value.pilihBedaKantor(true)),
                                    //     SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     Text("Beda Kantor"),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 16,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Akses Kasir",
                                    //       style: const TextStyle(fontSize: 12),
                                    //     ),
                                    //     const SizedBox(width: 5),
                                    //     const Text(
                                    //       "*",
                                    //       style: TextStyle(fontSize: 8),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Radio(
                                    //         value: false,
                                    //         activeColor: colorPrimary,
                                    //         groupValue: value.aksesKasir,
                                    //         onChanged: (e) =>
                                    //             value.pilihAksesKasir(false)),
                                    //     SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     Text("Tidak"),
                                    //     SizedBox(
                                    //       width: 24,
                                    //     ),
                                    //     Radio(
                                    //         value: true,
                                    //         activeColor: colorPrimary,
                                    //         groupValue: value.aksesKasir,
                                    //         onChanged: (e) =>
                                    //             value.pilihAksesKasir(true)),
                                    //     SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     Text("Ya"),
                                    //   ],
                                    // ),
                                    // const SizedBox(
                                    //   height: 16,
                                    // ),
                                    // value.aksesKasir
                                    //     ? Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.stretch,
                                    //         children: [
                                    //           Row(
                                    //             children: [
                                    //               Text(
                                    //                 "Pilih SBB ",
                                    //                 style: const TextStyle(
                                    //                     fontSize: 12),
                                    //               ),
                                    //               const SizedBox(width: 5),
                                    //               const Text(
                                    //                 "*",
                                    //                 style: TextStyle(fontSize: 8),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //           const SizedBox(
                                    //             height: 8,
                                    //           ),
                                    //           Row(
                                    //             children: [
                                    //               Expanded(
                                    //                 child: DropdownSearch<CoaModel>(
                                    //                   popupProps:
                                    //                       const PopupPropsMultiSelection
                                    //                           .menu(
                                    //                     showSearchBox:
                                    //                         true, // Aktifkan fitur pencarian
                                    //                   ),
                                    //                   selectedItem: value.sbbAset,
                                    //                   items: value.listCoa
                                    //                       .where((e) =>
                                    //                           e.jnsAcc == "C")
                                    //                       .toList(),
                                    //                   itemAsString: (e) =>
                                    //                       "${e.namaSbb}",
                                    //                   onChanged: (e) {
                                    //                     value.pilihSbbAset(e!);
                                    //                   },
                                    //                   dropdownDecoratorProps:
                                    //                       DropDownDecoratorProps(
                                    //                     baseStyle:
                                    //                         TextStyle(fontSize: 16),
                                    //                     textAlignVertical:
                                    //                         TextAlignVertical
                                    //                             .center,
                                    //                     dropdownSearchDecoration:
                                    //                         InputDecoration(
                                    //                       hintText:
                                    //                           "Pilih SBB Aset",
                                    //                       border:
                                    //                           OutlineInputBorder(
                                    //                         borderRadius:
                                    //                             BorderRadius
                                    //                                 .circular(8),
                                    //                         borderSide: BorderSide(
                                    //                           width: 1,
                                    //                           color: Colors.grey,
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               SizedBox(
                                    //                 width: 16,
                                    //               ),
                                    //               Container(
                                    //                 width: 150,
                                    //                 child: TextFormField(
                                    //                   // enabled: false,
                                    //                   readOnly: true,
                                    //                   textInputAction:
                                    //                       TextInputAction.done,
                                    //                   controller: value.namaSbbAset,
                                    //                   maxLines: 1,
                                    //                   // inputFormatters: [
                                    //                   //   FilteringTextInputFormatter.digitsOnly
                                    //                   // ],
                                    //                   validator: (e) {
                                    //                     if (e!.isEmpty) {
                                    //                       return "Wajib diisi";
                                    //                     } else {
                                    //                       return null;
                                    //                     }
                                    //                   },
                                    //                   decoration: InputDecoration(
                                    //                     filled: true,
                                    //                     fillColor: Colors.grey[200],
                                    //                     hintText: "Nomor SBB",
                                    //                     border: OutlineInputBorder(
                                    //                       borderRadius:
                                    //                           BorderRadius.circular(
                                    //                               6),
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //           const SizedBox(height: 16),
                                    //         ],
                                    //       )
                                    //     : SizedBox(),
                                    // Container(
                                    //   margin: EdgeInsets.symmetric(vertical: 16),
                                    //   height: 1,
                                    //   color: Colors.grey[300],
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Expanded(child: Text("MODUL USER")),
                                    //     Checkbox(
                                    //         activeColor: colorPrimary,
                                    //         value: value.semua,
                                    //         onChanged: (e) => value.pilihSemua()),
                                    //     SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     Text(
                                    //       "Pilih Semua",
                                    //       style: TextStyle(
                                    //         fontSize: 12,
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                    // Container(
                                    //   margin: EdgeInsets.symmetric(vertical: 16),
                                    //   height: 1,
                                    //   color: Colors.grey[300],
                                    // ),
                                    // ListView.builder(
                                    //     itemCount: value.listMenu.length,
                                    //     shrinkWrap: true,
                                    //     physics: ClampingScrollPhysics(),
                                    //     itemBuilder: (context, i) {
                                    //       final data = value.listMenu[i];
                                    //       return Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.stretch,
                                    //         children: [
                                    //           Row(
                                    //             children: [
                                    //               Checkbox(
                                    //                   activeColor: colorPrimary,
                                    //                   value:
                                    //                       value.listMenuAdd.isEmpty
                                    //                           ? false
                                    //                           : value.listMenuAdd
                                    //                                   .where((e) =>
                                    //                                       e == data)
                                    //                                   .isNotEmpty
                                    //                               ? true
                                    //                               : false,
                                    //                   onChanged: (e) =>
                                    //                       value.pilihMenu(data)),
                                    //               SizedBox(
                                    //                 width: 8,
                                    //               ),
                                    //               Expanded(
                                    //                   child: Text("${data.menu}")),
                                    //               Expanded(
                                    //                   child:
                                    //                       Text("${data.submenu}"))
                                    //             ],
                                    //           ),
                                    //           SizedBox(
                                    //             height: 8,
                                    //           )
                                    //         ],
                                    //       );
                                    //     }),
                                    // SizedBox(
                                    //   height: 16,
                                    // ),
                                    // ButtonPrimary(
                                    //   onTap: () {},
                                    //   name: "Simpan",
                                    // )
                                  ],
                                ))
                              ],
                            ),
                          ),
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
  DetailDataSource(CustomerNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  CustomerNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<CustomerSupplierModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'no_sif', value: data.noSif),
                DataGridCell(columnName: 'nm_sif', value: data.nmSif),
                DataGridCell(
                    columnName: 'gol_cust',
                    value: data.golCust == "1"
                        ? "Customer"
                        : data.golCust == "2"
                            ? "Supplier"
                            : "Customer / Supplier"),
                DataGridCell(
                    columnName: 'bidang_usaha', value: data.bidangUsaha),
                DataGridCell(columnName: 'alamat', value: data.alamat),
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
