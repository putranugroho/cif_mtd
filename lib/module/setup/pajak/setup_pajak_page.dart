import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/pajak/setup_pajak_notifier.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/colors.dart';
import '../../../utils/decimal_format_input.dart';
import '../../../utils/pro_shimmer.dart';

class SetupPajakPage extends StatelessWidget {
  const SetupPajakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetupPajakNotifier(context: context),
      child: Consumer<SetupPajakNotifier>(
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
                              "Setup Pajak",
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
                                "Tambah Pajak",
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
                    SizedBox(
                      height: 16,
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
                              padding: EdgeInsets.all(20),
                              height: MediaQuery.of(context).size.height,
                              child: SfDataGrid(
                                headerRowHeight: 40,
                                defaultColumnWidth: 180,
                                frozenColumnsCount: 1,

                                // controller: value.dataGridController,
                                gridLinesVisibility: GridLinesVisibility.both,
                                headerGridLinesVisibility:
                                    GridLinesVisibility.both,
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
                                      width: 100,
                                      columnName: 'tipe',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Tipe Pajak',
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
                                          padding: EdgeInsets.all(6),
                                          child: Text('Nilai',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'batas',
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text(
                                              'Batasan Minimal Kena Pajak (PPN)',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      width: 80,
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
                  right: 0,
                  bottom: 0,
                  child: value.dialog
                      ? Container(
                          width: 600,
                          decoration: BoxDecoration(color: Colors.white),
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: value.keyForm,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        value.editData
                                            ? "Ubah / Hapus Setup Pajak"
                                            : "Tambah Setup Pajak",
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
                                Row(
                                  children: [
                                    Text(
                                      "Jenis Pajak",
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
                                        value: false,
                                        groupValue: value.tipepajak,
                                        onChanged: (e) {
                                          value.gantitipe();
                                        }),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("PPN"),
                                    SizedBox(
                                      width: 32,
                                    ),
                                    Radio(
                                        value: true,
                                        groupValue: value.tipepajak,
                                        onChanged: (e) {
                                          value.gantitipe();
                                        }),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("PPH"),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                value.tipepajak
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "PPH 23 (%)",
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
                                            controller: value.pph23,
                                            maxLines: 1,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r'^(100(\.00?)?|([1-9]\d?|0)(\.\d{0,2})?)$'),
                                              ),
                                            ],
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                              decimal: true,
                                              signed: false,
                                            ),
                                            validator: (e) {
                                              if (e == null || e.isEmpty) {
                                                return "Wajib diisi";
                                              }

                                              final valueAsDouble =
                                                  double.tryParse(
                                                      e.replaceAll(",", "."));
                                              if (valueAsDouble == null) {
                                                return "Format tidak valid";
                                              }

                                              if (valueAsDouble < 0 ||
                                                  valueAsDouble > 100) {
                                                return "Nilai harus antara 0 dan 100";
                                              }

                                              // Ensure only 2 decimal places max
                                              if (e.contains(".")) {
                                                final decimalPart =
                                                    e.split(".")[1];
                                                if (decimalPart.length > 2) {
                                                  return "Maksimal 2 angka di belakang koma";
                                                }
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              filled: !value.editData,
                                              fillColor: Colors.grey[200],
                                              hintText: "PPH",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
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
                                          value.editData
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    SizedBox(
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
                                              : SizedBox()
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "PPN (%)",
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
                                            controller: value.ppn,
                                            maxLines: 1,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r'^(100(\.00?)?|([1-9]\d?|0)(\.\d{0,2})?)$'),
                                              ),
                                            ],
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                              decimal: true,
                                              signed: false,
                                            ),
                                            validator: (e) {
                                              if (e == null || e.isEmpty) {
                                                return "Wajib diisi";
                                              }

                                              final valueAsDouble =
                                                  double.tryParse(
                                                      e.replaceAll(",", "."));
                                              if (valueAsDouble == null) {
                                                return "Format tidak valid";
                                              }

                                              if (valueAsDouble < 0 ||
                                                  valueAsDouble > 100) {
                                                return "Nilai harus antara 0 dan 100";
                                              }

                                              // Ensure only 2 decimal places max
                                              if (e.contains(".")) {
                                                final decimalPart =
                                                    e.split(".")[1];
                                                if (decimalPart.length > 2) {
                                                  return "Maksimal 2 angka di belakang koma";
                                                }
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              filled: !value.editData,
                                              fillColor: Colors.grey[200],
                                              hintText: "PPN",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Nilai minimal tidak kena PPN",
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
                                            controller: value.maksPpn,
                                            maxLines: 1,
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
                                              filled: !value.editData,
                                              fillColor: Colors.grey[200],
                                              hintText: "Nilai Maks",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
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
                                          value.editData
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    SizedBox(
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
                                              : SizedBox()
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox())
            ],
          ),
        )),
      ),
    );
  }
}

class DetailDataSource extends DataGridSource {
  DetailDataSource(SetupPajakNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  SetupPajakNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<SetupPajakModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(
                    columnName: 'tipe',
                    value: "${data.tipe == "Y" ? "PPH" : "PPN"}"),
                DataGridCell(
                    columnName: 'nilai',
                    value: "${data.tipe == "Y" ? data.pph23 : data.ppn}%"),
                DataGridCell(
                    columnName: 'batas',
                    value: data.maksKenaPpn == ""
                        ? ""
                        : FormatCurrency.oCcy
                            .format(int.parse(data.maksKenaPpn))),
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
