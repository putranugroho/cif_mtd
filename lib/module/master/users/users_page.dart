import 'package:accounting/models/index.dart';

import 'package:accounting/module/master/users/users_notifier.dart';
import 'package:accounting/utils/format_currency.dart';
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

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UsersNotifier(context: context),
      child: Consumer<UsersNotifier>(
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
                              "Users",
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
                                "Tambah Users",
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
                                columnName: 'userid',
                                label: Container(
                                    padding: EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: Text('User ID',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                columnName: 'namauser',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Nama User',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'tglexp',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Tanggal Kadaluarsa',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'lvluser',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Level User',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'level_otor',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Level Otorisasi',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 50,
                                columnName: 'beda_kantor',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Akses Beda Kantor',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'min_otor',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Minimal Otorisasi',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'max_otor',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(6),
                                    child: Text('Maksimal Otorisasi',
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
                                        "Tambah User",
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
                                          "Nama User",
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
                                      controller: value.namauser,
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
                                        hintText: "Nama User",
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
                                          "User ID",
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
                                      controller: value.userid,
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
                                        hintText: "User ID  ",
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
                                          "Password",
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
                                      controller: value.pass,
                                      maxLines: 1,
                                      obscureText: true,
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
                                        hintText: "Password",
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
                                          "Tanggal Masa Berlaku",
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
                                    InkWell(
                                      onTap: () => value.pilihTanggalBuka(),
                                      child: TextFormField(
                                        enabled: false,
                                        textInputAction: TextInputAction.done,
                                        controller: value.tglexp,
                                        maxLines: 1,
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return "Wajib diisi";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Tanggal Masa Berlaku",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Text(
                                          "Group Hari Kerja",
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
                                    DropdownSearch<AktivasiModel>(
                                      popupProps:
                                          const PopupPropsMultiSelection.menu(
                                        showSearchBox:
                                            true, // Aktifkan fitur pencarian
                                      ),
                                      selectedItem: value.aktivasiModel,
                                      items: value.listHariKerja,
                                      itemAsString: (e) =>
                                          "(${e.kdAktivasi}) - ${e.nmAktivasi}",
                                      onChanged: (e) {
                                        value.pilihHariKerja(e!);
                                      },
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        baseStyle: TextStyle(fontSize: 16),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: "Pilih Group Hari Kerja",
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
                                          "Level User",
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
                                    DropdownSearch<LevelUser>(
                                      popupProps:
                                          const PopupPropsMultiSelection.menu(
                                        showSearchBox:
                                            true, // Aktifkan fitur pencarian
                                      ),
                                      selectedItem: value.levelUser,
                                      items: value.listUsers,
                                      itemAsString: (e) => "${e.levelUser}",
                                      onChanged: (e) {
                                        value.pilihLevel(e!);
                                      },
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        baseStyle: TextStyle(fontSize: 16),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: "Pilih Level User",
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
                                    Row(
                                      children: [
                                        Text(
                                          "Level Otorisasi",
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
                                      key: value.dropdownKey,
                                      popupProps: const PopupProps.menu(
                                        showSearchBox: true,
                                      ),
                                      selectedItem: value.levelSelected
                                          ? value.levelOtor
                                          : null,
                                      items: value.listLevelOtor,
                                      itemAsString: (e) => "${e}",
                                      onChanged: (e) {
                                        value.pilihLevelOtor(e!);
                                      },
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        baseStyle: TextStyle(fontSize: 16),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: "Pilih Level Otorisasi",
                                          suffixIcon: value.levelSelected
                                              ? IconButton(
                                                  onPressed: () {
                                                    value.clearOtor();
                                                  },
                                                  icon: Icon(Icons.close),
                                                )
                                              : SizedBox(),
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
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Minimal Otorisasi",
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
                                              maxLines: 1,
                                              readOnly: !value.levelSelected,
                                              controller: value.minotor,
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
                                                filled: !value.levelSelected
                                                    ? true
                                                    : false,
                                                fillColor: Colors.grey[200],
                                                hintText: "Minimal Otorisasi",
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
                                                  "Maksimal Otorisasi",
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
                                              maxLines: 1,
                                              readOnly: !value.levelSelected,
                                              controller: value.maxotor,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                CurrencyInputFormatter(),
                                              ],
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  if (int.parse(e.replaceAll(
                                                          ",", "")) <=
                                                      int.parse(value
                                                          .minotor.text
                                                          .replaceAll(
                                                              ",", ""))) {
                                                    return "Nilai maksimal otorisasi tidak boleh lebih kecil dari minimal otorisasi";
                                                  } else {
                                                    return null;
                                                  }
                                                }
                                              },
                                              decoration: InputDecoration(
                                                filled: !value.levelSelected
                                                    ? true
                                                    : false,
                                                fillColor: Colors.grey[200],
                                                hintText: "Maksimal Otorisasi",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
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
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Akses Beda Kantor",
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
                                              children: [
                                                Radio(
                                                    value: false,
                                                    activeColor: colorPrimary,
                                                    groupValue:
                                                        value.bedaKantor,
                                                    onChanged: (e) =>
                                                        value.pilihBedaKantor(
                                                            false)),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text("Tidak"),
                                                SizedBox(
                                                  width: 24,
                                                ),
                                                Radio(
                                                    value: true,
                                                    activeColor: colorPrimary,
                                                    groupValue:
                                                        value.bedaKantor,
                                                    onChanged: (e) => value
                                                        .pilihBedaKantor(true)),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text("Ya"),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
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
                                                  "Akses Kasir",
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
                                              children: [
                                                Radio(
                                                    value: false,
                                                    activeColor: colorPrimary,
                                                    groupValue:
                                                        value.aksesKasir,
                                                    onChanged: (e) =>
                                                        value.pilihAksesKasir(
                                                            false)),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text("Tidak"),
                                                SizedBox(
                                                  width: 24,
                                                ),
                                                Radio(
                                                    value: true,
                                                    activeColor: colorPrimary,
                                                    groupValue:
                                                        value.aksesKasir,
                                                    onChanged: (e) => value
                                                        .pilihAksesKasir(true)),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text("Ya"),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                    value.aksesKasir
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Pilih SBB ",
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
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TypeAheadField<
                                                        InqueryGlModel>(
                                                      controller: value.nossbb,
                                                      suggestionsCallback:
                                                          (search) =>
                                                              value.getInquery(
                                                                  search),
                                                      builder: (context,
                                                          controller,
                                                          focusNode) {
                                                        return TextField(
                                                            controller:
                                                                controller,
                                                            focusNode:
                                                                focusNode,
                                                            autofocus: true,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              labelText:
                                                                  'Cari Akun',
                                                            ));
                                                      },
                                                      itemBuilder:
                                                          (context, city) {
                                                        return ListTile(
                                                          title:
                                                              Text(city.nosbb),
                                                          subtitle: Text(
                                                              city.namaSbb),
                                                        );
                                                      },
                                                      onSelected: (city) {
                                                        // value.selectInvoice(city);
                                                        value
                                                            .pilihSbbAset(city);
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 16,
                                                  ),
                                                  Container(
                                                    width: 150,
                                                    child: TextFormField(
                                                      // enabled: false,
                                                      readOnly: true,
                                                      textInputAction:
                                                          TextInputAction.done,
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
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            Colors.grey[200],
                                                        hintText: "Nomor Akun",
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          )
                                        : SizedBox(),

                                    ButtonPrimary(
                                      onTap: () {
                                        value.cek();
                                      },
                                      name: "Simpan",
                                    )
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
  DetailDataSource(UsersNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listData);
  }

  UsersNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<UsersModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'userid', value: data.userid),
                DataGridCell(columnName: 'namauser', value: data.namauser),
                DataGridCell(columnName: 'tglexp', value: data.tglexp),
                DataGridCell(
                    columnName: 'lvluser',
                    value: data.lvluser == "A"
                        ? "Administrator"
                        : data.lvluser == "S"
                            ? "Supervisor"
                            : "User"),
                DataGridCell(columnName: 'level_otor', value: data.levelOtor),
                DataGridCell(columnName: 'beda_kantor', value: data.bedaKantor),
                DataGridCell(
                    columnName: 'min_otor',
                    value: FormatCurrency.oCcy.format(int.parse(data.minOtor))),
                DataGridCell(
                    columnName: 'max_otor',
                    value: FormatCurrency.oCcy.format(int.parse(data.maxOtor))),
                DataGridCell(columnName: 'action', value: data.userid),
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
