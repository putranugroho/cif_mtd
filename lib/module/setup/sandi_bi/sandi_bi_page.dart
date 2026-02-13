import 'package:cif/models/index.dart';
import 'package:cif/module/setup/sandi_bi/sandi_bi_notifier.dart';
import 'package:cif/utils/button_custom.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/pro_shimmer.dart';

class SandiBiPage extends StatelessWidget {
  const SandiBiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SandiBiNotifier(context: context),
      child: Consumer<SandiBiNotifier>(
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
                              "Sandi BI",
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
                                "Tambah Kantor",
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
                                      width: 100,
                                      columnName: 'kode_induk',
                                      label: Container(
                                          padding: const EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: const Text('Kode Induk',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'alamat',
                                      width: 300,
                                      label: Container(
                                          padding: const EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: const Text('Alamat',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'status_kantor',
                                      label: Container(
                                          color: colorPrimary,
                                          padding: const EdgeInsets.all(6),
                                          alignment: Alignment.center,
                                          child: const Text('Status Kantor',
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
                    ),
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
                                          value.editData ? "Ubah / Hapus Kantor" : "Tambah Kantor",
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
                                    height: 16,
                                  ),
                                  Expanded(
                                    child: ListView(children: [
                                      const Row(
                                        children: [
                                          Text(
                                            "Status Kantor",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(width: 5),
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
                                        selectedItem: value.status,
                                        items: value.listStatus,
                                        itemAsString: (e) => e,
                                        onChanged: (e) {
                                          value.pilihStatus(e!);
                                        },
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          baseStyle: const TextStyle(fontSize: 16),
                                          textAlignVertical: TextAlignVertical.center,
                                          dropdownSearchDecoration: InputDecoration(
                                            hintText: "Pilih Status",
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
                                            "Pilih Kantor Induk",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownSearch<KantorModel>(
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
                                              items: value.status == null
                                                  ? []
                                                  : value.status == "Cabang"
                                                      ? value.list.where((e) => e.statusKantor == "P").toList()
                                                      : value.status == "Anak Cabang"
                                                          ? value.list.where((e) => e.statusKantor == "C" || e.statusKantor == "P").toList()
                                                          : value.list
                                                              .where((e) => e.statusKantor == "D" || e.statusKantor == "C" || e.statusKantor == "P")
                                                              .toList(),
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
                                          ),
                                          const SizedBox(height: 16),
                                          SizedBox(
                                            width: 150,
                                            child: TextFormField(
                                              // enabled: false,
                                              readOnly: true,
                                              textInputAction: TextInputAction.done,
                                              controller: value.noKantor,
                                              maxLines: 1,
                                              // inputFormatters: [
                                              //   FilteringTextInputFormatter.digitsOnly
                                              // ],
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.grey[200],
                                                hintText: "Nomor Kantor",
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Kode Kantor",
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
                                                  controller: value.kode,
                                                  readOnly: value.editData ? true : false,
                                                  maxLines: 1,
                                                  maxLength: value.status == "Cabang"
                                                      ? 3
                                                      : value.status == "Anak Cabang"
                                                          ? 4
                                                          : 4,
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  validator: (e) {
                                                    if (e!.isEmpty) {
                                                      return "Wajib diisi";
                                                    } else {
                                                      if (value.status == "Cabang" && e.length != 3) {
                                                        return "Wajib 3 digit";
                                                      } else if (e.length != 4) {
                                                        return "Wajib 4 digit";
                                                      } else {
                                                        return null;
                                                      }
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Kode Kantor",
                                                    filled: value.editData ? true : false,
                                                    fillColor: Colors.grey[200],
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
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Nama Kantor",
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
                                                  controller: value.nama,
                                                  maxLines: 1,
                                                  validator: (e) {
                                                    if (e!.isEmpty) {
                                                      return "Wajib diisi";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Nama Kantor",
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 24,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          const Text(
                                            "Provinsi",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          DropdownSearch<ProvinsiModel>(
                                            popupProps: const PopupPropsMultiSelection.menu(
                                              showSearchBox: true, // Aktifkan fitur pencarian
                                            ),
                                            selectedItem: value.provinsiModel,
                                            items: value.listProvinsi,
                                            itemAsString: (e) => e.name,
                                            onChanged: (e) {
                                              value.pilihProvinsi(e!);
                                            },
                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                              baseStyle: const TextStyle(fontSize: 16),
                                              textAlignVertical: TextAlignVertical.center,
                                              dropdownSearchDecoration: InputDecoration(
                                                hintText: "Pilih Provinsi",
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
                                      ),
                                      const SizedBox(height: 16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          const Text(
                                            "Kota",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          DropdownSearch<KotaModel>(
                                            popupProps: const PopupPropsMultiSelection.menu(
                                              showSearchBox: true, // Aktifkan fitur pencarian
                                            ),
                                            enabled: value.listKota.isNotEmpty ? true : false,
                                            selectedItem: value.kotaModal,
                                            items: value.listKota,
                                            itemAsString: (e) => e.name,
                                            onChanged: (e) {
                                              value.pilihKota(e!);
                                            },
                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                              baseStyle: const TextStyle(fontSize: 16),
                                              textAlignVertical: TextAlignVertical.center,
                                              dropdownSearchDecoration: InputDecoration(
                                                hintText: "Pilih Kota",
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
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const Text(
                                                  "Kecamatan",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                DropdownSearch<KecamatanModel>(
                                                  popupProps: const PopupPropsMultiSelection.menu(
                                                    showSearchBox: true, // Aktifkan fitur pencarian
                                                  ),
                                                  enabled: value.listKecamatan.isNotEmpty ? true : false,
                                                  selectedItem: value.kecamatanModel,
                                                  items: value.listKecamatan,
                                                  itemAsString: (e) => e.name,
                                                  onChanged: (e) {
                                                    value.pilihKecamatan(e!);
                                                  },
                                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                                    baseStyle: const TextStyle(fontSize: 16),
                                                    textAlignVertical: TextAlignVertical.center,
                                                    dropdownSearchDecoration: InputDecoration(
                                                      hintText: "Pilih Kecamatan",
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
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const Text(
                                                  "Kelurahan",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                DropdownSearch<KelurahanModel>(
                                                  popupProps: const PopupPropsMultiSelection.menu(
                                                    showSearchBox: true, // Aktifkan fitur pencarian
                                                  ),
                                                  enabled: value.listKelurahan.isNotEmpty ? true : false,
                                                  selectedItem: value.kelurahanModel,
                                                  items: value.listKelurahan,
                                                  itemAsString: (e) => e.name,
                                                  onChanged: (e) {
                                                    value.pilihKelurahan(e!);
                                                  },
                                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                                    baseStyle: const TextStyle(fontSize: 16),
                                                    textAlignVertical: TextAlignVertical.center,
                                                    dropdownSearchDecoration: InputDecoration(
                                                      hintText: "Pilih Kelurahan",
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
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          SizedBox(
                                              width: 120,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        "Kode Pos",
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
                                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                                            "Alamat",
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
                                          hintText: "Alamat",
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
                                                    "No. Telp",
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
                                                controller: value.notelp,
                                                maxLines: 1,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "No. Telp",
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
                                                    "No. Fax",
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
                                                controller: value.fax,
                                                maxLines: 1,
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                decoration: InputDecoration(
                                                  hintText: "No. Fax",
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
                                                ButtonDanger(
                                                  onTap: () {
                                                    value.confirm();
                                                  },
                                                  name: "Hapus",
                                                ),
                                              ],
                                            )
                                          : const SizedBox()
                                    ]),
                                  ),
                                ],
                              ),
                            ),
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
  DetailDataSource(SandiBiNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  SandiBiNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<KantorModel> list) {
    list.sort((a, b) {
      int cmp = a.kodeKantor.compareTo(b.kodeKantor);
      if (cmp != 0) return cmp;
      return a.kodeInduk.compareTo(b.kodeInduk);
    });

    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'nama_kantor', value: data.namaKantor),
                DataGridCell(columnName: 'kode_kantor', value: data.kodeKantor),
                DataGridCell(columnName: 'kode_induk', value: data.kodeInduk),
                DataGridCell(columnName: 'alamat', value: data.alamat),
                DataGridCell(
                    columnName: 'status_kantor',
                    value: data.statusKantor == "P"
                        ? "Pusat"
                        : data.statusKantor == "C"
                            ? "Cabang"
                            : data.statusKantor == "D"
                                ? "Anak Cabang"
                                : "Gudang"),
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
