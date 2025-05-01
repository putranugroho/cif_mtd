import 'package:accounting/module/setup/pajak/setup_pajak_notifier.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/decimal_format_input.dart';
import '../../../utils/pro_shimmer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../utils/colors.dart';

class SetupPajakPage extends StatelessWidget {
  const SetupPajakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetupPajakNotifier(context: context),
      child: Consumer<SetupPajakNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
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
                          child: Form(
                            key: value.keyForm,
                            child: value.rincianData
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: SfDataGrid(
                                            headerRowHeight: 40,
                                            defaultColumnWidth: 180,
                                            frozenColumnsCount: 1,

                                            // controller: value.dataGridController,
                                            gridLinesVisibility:
                                                GridLinesVisibility.both,
                                            headerGridLinesVisibility:
                                                GridLinesVisibility.both,
                                            selectionMode: SelectionMode.single,

                                            source: EmptyDataGridSource(),
                                            columns: <GridColumn>[
                                              GridColumn(
                                                  width: 50,
                                                  columnName: 'no',
                                                  label: Container(
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      color: colorPrimary,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('No',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          )))),
                                              GridColumn(
                                                  columnName: 'invoice',
                                                  label: Container(
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      color: colorPrimary,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('No. Invoice',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          )))),
                                              GridColumn(
                                                  columnName: 'nilaitagihan',
                                                  label: Container(
                                                      color: colorPrimary,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      child: Text(
                                                          'Nilai Tagihan',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.white,
                                                          )))),
                                              GridColumn(
                                                  columnName: 'bayartagihan',
                                                  label: Container(
                                                      color: colorPrimary,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      child: Text(
                                                          'Bayar Tagihan',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.white,
                                                          )))),
                                              GridColumn(
                                                  columnName: 'ppn',
                                                  label: Container(
                                                      color: colorPrimary,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      child: Text('Tag PPN',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.white,
                                                          )))),
                                              GridColumn(
                                                  columnName: 'bayarppn',
                                                  label: Container(
                                                      color: colorPrimary,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      child: Text('Bayar PPN',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.white,
                                                          )))),
                                              GridColumn(
                                                  columnName: 'pph',
                                                  label: Container(
                                                      color: colorPrimary,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      child: Text('Tag PPH',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.white,
                                                          )))),
                                              GridColumn(
                                                  columnName: 'bayarpph',
                                                  label: Container(
                                                      color: colorPrimary,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      child: Text('Bayar PPH',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.white,
                                                          )))),
                                              GridColumn(
                                                  columnName: 'keterangan',
                                                  label: Container(
                                                      color: colorPrimary,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      child: Text('Keterangan',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.white,
                                                          )))),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "",
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Radio(
                                              value: false,
                                              groupValue: value.akun,
                                              onChanged: (e) =>
                                                  value.gantiakun(false)),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Debet"),
                                          SizedBox(
                                            width: 24,
                                          ),
                                          Radio(
                                              value: true,
                                              groupValue: value.akun,
                                              onChanged: (e) =>
                                                  value.gantiakun(true)),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Credit"),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Customer / Supplier",
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(width: 5),
                                              const Text(
                                                "*",
                                                style: TextStyle(fontSize: 8),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Nomor Aset",
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
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Nomor Aset",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "No Kontrak",
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(width: 5),
                                              const Text(
                                                "*",
                                                style: TextStyle(fontSize: 8),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Nomor Aset",
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
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            "Nilai",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Nomor Aset",
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
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            "Tgl Kontrak",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Nomor Aset",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Keterangan",
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(width: 5),
                                              const Text(
                                                "*",
                                                style: TextStyle(fontSize: 8),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Nomor Aset",
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
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 16),
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "No Kontrak",
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(width: 5),
                                              const Text(
                                                "*",
                                                style: TextStyle(fontSize: 8),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Radio(
                                              value: false,
                                              groupValue: value.akun,
                                              onChanged: (e) =>
                                                  value.gantiakun(false)),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Debet"),
                                          SizedBox(
                                            width: 24,
                                          ),
                                          Radio(
                                              value: true,
                                              groupValue: value.akun,
                                              onChanged: (e) =>
                                                  value.gantiakun(true)),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text("Credit"),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Sub Buku Besar",
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(width: 5),
                                              const Text(
                                                "*",
                                                style: TextStyle(fontSize: 8),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Nomor Aset",
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
                                          SizedBox(
                                            width: 16,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Nilai Pembayaran",
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(width: 5),
                                              const Text(
                                                "*",
                                                style: TextStyle(fontSize: 8),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Nomor Aset",
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
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            "Tgl Bayar",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Nomor Aset",
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
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            "No Doc",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 1,
                                                validator: (e) {
                                                  if (e!.isEmpty) {
                                                    return "Wajib diisi";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Nomor Aset",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      value.rincianData
                                          ? Expanded(
                                              child: Row(
                                                children: [
                                                  ButtonPrimary(
                                                    onTap: () {
                                                      value.cek();
                                                    },
                                                    name: "Simpan",
                                                  ),
                                                  const SizedBox(height: 16),
                                                  ButtonDanger(
                                                    onTap: () {
                                                      value.edit();
                                                    },
                                                    name: "Cancel",
                                                  ),
                                                  const SizedBox(height: 16),
                                                ],
                                              ),
                                            )
                                          : Row(
                                              children: [
                                                ButtonPrimary(
                                                  onTap: () {
                                                    value.rincian();
                                                  },
                                                  name: "Hitung Rincian Bayar",
                                                ),
                                              ],
                                            )
                                    ],
                                  ),
                          ),
                        ))
            ],
          ),
        )),
      ),
    );
  }
}

class EmptyDataGridSource extends DataGridSource {
  @override
  List<DataGridRow> get rows => [];

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return null;
  }
}
