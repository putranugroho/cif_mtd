import 'package:cif/models/index.dart';
import 'package:cif/module/master/ao/ao_notifier.dart';
import 'package:cif/module/setup/level/level_notifier.dart';
import 'package:cif/utils/button_custom.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';

class AoPage extends StatelessWidget {
  const AoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AoNotifier(context: context),
      child: Consumer<AoNotifier>(
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
                              "Account Officer / Marketing",
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
                                "Tambah AO / Marketing",
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
                                columnName: 'nm',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nama',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                width: 130,
                                columnName: 'kode',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Kode AO / Mkt',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                width: 100,
                                columnName: 'kode_kantor',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Kode Kantor',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'nama_kantor',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Nama Kantor',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'cs',
                                label: Container(
                                    color: colorPrimary,
                                    padding: const EdgeInsets.all(6),
                                    alignment: Alignment.center,
                                    child: const Text('Customer / Supplier',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'nonaktif',
                                label: Container(
                                    color: colorPrimary,
                                    padding: const EdgeInsets.all(6),
                                    alignment: Alignment.center,
                                    child: const Text('Nonaktif Akun',
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
                                        value.editData ? "Ubah / hapus AO / Marketing" : "Tambah AO / Marketing",
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
                                const Text(
                                  "Kantor",
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                DropdownSearch<KantorModel>(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Wajib diisi';
                                    }
                                    return null;
                                  },
                                  popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: true, // Aktifkan fitur pencarian
                                  ),
                                  selectedItem: value.kantorModel,
                                  items: value.listKantor,
                                  itemAsString: (e) => e.namaKantor,
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
                                const Row(
                                  children: [
                                    Text(
                                      "Kode AO / Marketing",
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
                                  controller: value.kd,
                                  maxLines: 1,
                                  maxLength: 10,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Wajib diisi";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Input Kode ",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Row(
                                  children: [
                                    Text(
                                      "Nama ",
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
                                TypeAheadField<KaryawanModel>(
                                  controller: value.nm,
                                  suggestionsCallback: (search) => value.getInqKaryawan(search),
                                  builder: (context, controller, focusNode) {
                                    return TextField(
                                        controller: controller,
                                        focusNode: focusNode,
                                        readOnly: value.editData,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          filled: value.editData,
                                          fillColor: Colors.grey[200],
                                          border: const OutlineInputBorder(),
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
                                      "Tipe Customer / Supplier",
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
                                          const SizedBox(height: 16),
                                          ButtonSecondary(
                                            onTap: () {
                                              value.confirmnonaktif();
                                            },
                                            name: "Non-aktifkan",
                                          ),
                                          const SizedBox(height: 16),
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
  DetailDataSource(AoNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  AoNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<AoModel> list) {
    list.sort((a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()));
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'nama', value: data.nama),
                DataGridCell(columnName: 'kode', value: data.kode),
                DataGridCell(columnName: 'kode_kantor', value: data.kodeKantor),
                DataGridCell(columnName: 'nama_kantor', value: data.namaKantor),
                DataGridCell(
                    columnName: 'cs',
                    value: data.golCust == "1"
                        ? "Customer"
                        : data.golCust == "2"
                            ? "Supplier"
                            : "Customer / Supplier"),
                DataGridCell(columnName: 'nonaktif', value: data.nonaktif == "Y" ? "Non-aktif" : "Aktif"),
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
