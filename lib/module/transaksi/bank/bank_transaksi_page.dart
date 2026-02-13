import 'package:cif/models/index.dart';
import 'package:cif/module/master/bank/bank_notifier.dart';
import 'package:cif/module/transaksi/bank/bank_transaksi_notifier.dart';
import 'package:cif/utils/format_currency.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/colors.dart';
import '../../../utils/currency_formatted.dart';

class BankTransaksiPage extends StatelessWidget {
  const BankTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BankTransaksiNotifier(context: context),
      child: Consumer<BankTransaksiNotifier>(
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
                              "Rekonsiliasi Saldo Bank",
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
                                "Inquery Bank",
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
                          defaultColumnWidth: 150,
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
                                width: 200,
                                columnName: 'nmBank',
                                label: Container(
                                    padding: const EdgeInsets.all(6),
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    child: const Text('Nama Bank',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                          fontSize: 12,
                                        )))),
                            GridColumn(
                                width: 200,
                                columnName: 'ktrBank',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Kantor Bank',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'noRek',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('No Rekening',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'nmRek',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nama Rekening',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'saldoBank',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Saldo Bank',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'saldoSbb',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Saldo SBB',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'namaSbb',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('Nama SBB',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        )))),
                            GridColumn(
                                columnName: 'nosbb',
                                label: Container(
                                    color: colorPrimary,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(6),
                                    child: const Text('No. SBB',
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
                        width: 1000,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Rekonsiliasi Saldo Bank",
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
                                child: ListView(
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "Bank",
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
                                      child: DropdownSearch<BankModel>(
                                        popupProps: const PopupPropsMultiSelection.menu(
                                          showSearchBox: true, // Aktifkan fitur pencarian
                                        ),
                                        selectedItem: value.bankModel,
                                        items: value.list.toList(),
                                        itemAsString: (e) => e.nmBank,
                                        onChanged: (e) {
                                          value.pilihBank(e!);
                                        },
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          baseStyle: const TextStyle(fontSize: 16),
                                          textAlignVertical: TextAlignVertical.center,
                                          dropdownSearchDecoration: InputDecoration(
                                            hintText: "Pilih Sandi Bank",
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
                                    SizedBox(
                                      width: 100,
                                      child: TextFormField(
                                        // enabled: false,
                                        readOnly: true,
                                        textInputAction: TextInputAction.done,
                                        controller: value.kodeBank,
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
                                          hintText: "Kode Bank",
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
                                    Expanded(child: Text("Bank")),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    SizedBox(width: 150, child: Text("Akun SBB")),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    SizedBox(width: 150, child: Text("Nominal SBB")),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    SizedBox(width: 150, child: Text("Saldo")),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    SizedBox(width: 150, child: Text("Selisih")),
                                  ],
                                ),
                                value.sandiBankModel != null
                                    ? ListView.builder(
                                        itemCount: value.list.where((e) => e.kodeBank == value.sandiBankModel!.sandi).length,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: TextField(
                                                    readOnly: true,
                                                    controller: value.listBankController[i],
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.grey[200],
                                                      hintText: "Kode Bank",
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  )),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 150,
                                                    child: TextField(
                                                      readOnly: true,
                                                      controller: value.listNoSBB[i],
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.grey[200],
                                                        hintText: "Akun SBB",
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
                                                    width: 150,
                                                    child: TextField(
                                                      readOnly: true,
                                                      controller: value.listSaldo[i],
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.grey[200],
                                                        hintText: "Nominal GL",
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
                                                    width: 150,
                                                    child: TextField(
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.digitsOnly,
                                                        CurrencyInputFormatter(),
                                                      ],
                                                      onChanged: (e) => value.onChangeTotal(i),
                                                      controller: value.listAmount[i],
                                                      decoration: InputDecoration(
                                                        hintText: "Nominal Saldo",
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
                                                    width: 150,
                                                    child: TextField(
                                                      readOnly: true,
                                                      controller: value.listSelisih[i],
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.grey[200],
                                                        hintText: "Selisih",
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(6),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              )
                                            ],
                                          );
                                        })
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    ButtonPrimary(
                                      onTap: () {},
                                      name: "Cetak",
                                    ),
                                  ],
                                )
                              ],
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
  DetailDataSource(BankTransaksiNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.list);
  }

  BankTransaksiNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<BankModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                // DataGridCell(columnName: 'kodeBank', value: data.kodeBank),
                DataGridCell(columnName: 'nmBank', value: data.nmBank),
                DataGridCell(columnName: 'ktrBank', value: data.cabang),
                DataGridCell(columnName: 'noRek', value: data.noRek),
                DataGridCell(columnName: 'nmRek', value: data.nmRek),
                // DataGridCell(
                //     columnName: 'kdRek',
                //     value: data.kdRek == "10"
                //         ? "Tabungan"
                //         : data.kdRek == "20"
                //             ? "Giro"
                //             : "Deposito"),
                DataGridCell(columnName: 'saldoBank', value: data.nominal == "" ? "" : FormatCurrency.oCcy.format(int.parse(data.nominal))),
                DataGridCell(columnName: 'saldoSbb', value: data.saldoeom == "" ? "" : FormatCurrency.oCcy.format(int.parse(data.saldoeom))),
                DataGridCell(columnName: 'namaSbb', value: data.namaSbb),
                DataGridCell(columnName: 'nosbb', value: data.nosbb),
                DataGridCell(columnName: 'action', value: data.noRek),
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
          );
        } else if (e.columnName == 'saldoBank' || e.columnName == 'saldoSbb') {
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
