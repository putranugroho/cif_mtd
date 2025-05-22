import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/setup_transaksi/setup_transaksi_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/colors.dart';
import '../../../utils/pro_shimmer.dart';

class SetupTransaksiPage extends StatelessWidget {
  const SetupTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetupTransaksiNotifier(context: context),
      child: Consumer<SetupTransaksiNotifier>(
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
                              "Setup Transaksi",
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
                                "Tambah Setup Trans.",
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
                                frozenColumnsCount: 2,

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
                                      columnName: 'kode',
                                      width: 100,
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Kode Transaksi',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'nama',
                                      label: Container(
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(6),
                                          child: Text('Nama Transaksi',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              )))),
                                  GridColumn(
                                      columnName: 'gl_deb',
                                      width: 270,
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Akun Debet',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'gl_kre',
                                      width: 270,
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Akun Kredit',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'modul',
                                      width: 110,
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Modul',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'hutangpiutang',
                                      width: 80,
                                      label: Container(
                                          padding: EdgeInsets.all(6),
                                          color: colorPrimary,
                                          alignment: Alignment.center,
                                          child: Text('Hutang Piutang',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 12,
                                              )))),
                                  GridColumn(
                                      columnName: 'action',
                                      width: 80,
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
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
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
                                          ? "Ubah / Hapus Setup Transaksi"
                                          : "Tambah Setup Transaksi",
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
                                        "Kode Transaksi",
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
                                    controller: value.kodeTransaksi,
                                    maxLines: 1,
                                    maxLength: 4,
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
                                      hintText: "Kode Transaksi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(
                                        "Nama Transaksi",
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
                                    controller: value.namaTransaksi,
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
                                      hintText: "Nama Transaksi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(
                                        "Pilih Debet Akun",
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
                                      Expanded(
                                        child: TypeAheadField<InqueryGlModel>(
                                          controller: value.nosbbdeb,
                                          suggestionsCallback: (search) =>
                                              value.getInquery(search),
                                          builder:
                                              (context, controller, focusNode) {
                                            return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                autofocus: true,
                                                decoration: InputDecoration(
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
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
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
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Pilih Kredit Akun",
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
                                      Expanded(
                                        child: TypeAheadField<InqueryGlModel>(
                                          controller: value.nossbcre,
                                          suggestionsCallback: (search) =>
                                              value.getInquery(search),
                                          builder:
                                              (context, controller, focusNode) {
                                            return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                autofocus: true,
                                                decoration: InputDecoration(
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
                                            value.pilihAkunCre(city);
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
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbCre,
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
                                            hintText: "Nomor Kredit",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Pilih Modul",
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
                                        value: "BACKOFFICE",
                                        groupValue: value.modul,
                                        onChanged: (e) =>
                                            value.gantimodul("BACKOFFICE"),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Backoffice"),
                                      SizedBox(
                                        width: 32,
                                      ),
                                      Radio(
                                        activeColor: colorPrimary,
                                        value: "KASIR",
                                        groupValue: value.modul,
                                        onChanged: (e) =>
                                            value.gantimodul("KASIR"),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Kasir"),
                                      SizedBox(
                                        width: 32,
                                      ),
                                      Radio(
                                        activeColor: colorPrimary,
                                        value: "KAS KECIL",
                                        groupValue: value.modul,
                                        onChanged: (e) =>
                                            value.gantimodul("KAS KECIL"),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Kas Kecil"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text("Hutang dan Piutang "),
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.gantiHutangPiutang("HUTANG");
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 16,
                                          height: 16,
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.grey)),
                                          child: value.hutangPiutang == "HUTANG"
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: colorPrimary),
                                                )
                                              : SizedBox(),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text("Hutang"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      value.gantiHutangPiutang("PIUTANG");
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 16,
                                          height: 16,
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.grey)),
                                          child: value.hutangPiutang ==
                                                  "PIUTANG"
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: colorPrimary),
                                                )
                                              : SizedBox(),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text("Piutang"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            const SizedBox(
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
                                      : SizedBox(),
                                ],
                              ))
                            ],
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
  DetailDataSource(SetupTransaksiNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listData);
  }

  SetupTransaksiNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<SetupTransModel> list) {
    int index = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (index++).toString()),
                DataGridCell(columnName: 'kode', value: data.kdTrans),
                DataGridCell(columnName: 'nama', value: "${data.namaTrans}"),
                DataGridCell(
                    columnName: 'gl_deb',
                    value: "${data.glDeb} - ${data.namaDeb}"),
                DataGridCell(
                    columnName: 'gl_kre',
                    value: "${data.glKre} - ${data.namaKre}"),
                DataGridCell(columnName: 'modul', value: data.modul),
                DataGridCell(
                    columnName: 'hutangpiutang',
                    value: data.hutangPiutang == null ||
                            data.hutangPiutang == "null"
                        ? ""
                        : data.hutangPiutang),
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
              style: TextStyle(fontSize: 12),
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
