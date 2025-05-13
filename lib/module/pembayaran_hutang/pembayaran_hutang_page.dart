import 'package:accounting/models/index.dart';
import 'package:accounting/module/pembayaran_hutang/pembayaran_hutang_notifier.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/decimal_format_input.dart';
import '../../../utils/pro_shimmer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../utils/colors.dart';

class PembayaranHutangPage extends StatelessWidget {
  const PembayaranHutangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PembayaranHutangNotifier(context: context),
      child: Consumer<PembayaranHutangNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
                body: Stack(children: [
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
                          "Pembayaran Hutang / Piutang",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      value.rincianData
                          ? InkWell(
                              onTap: () => value.rincian(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 255, 0, 0),
                                  border: Border.all(
                                    width: 2,
                                    color: const Color.fromARGB(255, 255, 0, 0),
                                  ),
                                ),
                                child: Text(
                                  "Tutup Hitung Rincian Bayar",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  // child: SingleChildScrollView(
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
                            child: ListView(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 180,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Jenis Transaksi",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Radio(
                                        value: false,
                                        groupValue: value.akun,
                                        onChanged: (e) =>
                                            value.gantiakun(false)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("Hutang"),
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
                                    Text("Piutang"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 180,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Customer / Supplier",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 12),
                                            validator: (e) {
                                              if (e!.isEmpty) {
                                                return "Wajib diisi";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              // contentPadding:
                                              //     EdgeInsets.all(0),
                                              hintText:
                                                  "Nama Customer / Supplier",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
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
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 12),
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
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 180,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Cari Pembayaran",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: TypeAheadField<InqueryGlModel>(
                                        controller: value.nmSbb,
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
                                                labelText: 'Cari SBB Transaksi',
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
                                          value.pilihTransHutang(city);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            controller: value.noSbb,
                                            readOnly: true,
                                            style: TextStyle(fontSize: 12),
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
                                              hintText: "No SBB",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
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
                                        Container(
                                          height: 40,
                                          child: InkWell(
                                            onTap: () => value.cariTrans(),
                                            child: TextFormField(
                                              enabled: false,
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.caritransaksi,
                                              decoration: InputDecoration(
                                                hintText: "Cari Transaksi",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 180,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Nilai Pembayaran",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            controller: value.nilaipembayaran,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style: TextStyle(fontSize: 12),
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
                                              hintText: "Nilai Pembayaran",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    )),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Tgl Transaksi",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style: TextStyle(fontSize: 12),
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
                                              hintText: "Tanggal Transaksi",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    )),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "No Dok",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style: TextStyle(fontSize: 12),
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
                                              hintText: "No Dok",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 180,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Keterangan",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style: TextStyle(fontSize: 12),
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
                                              hintText: "Keterangan",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    )),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 180,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            "No Kontrak / Invoice",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: InkWell(
                                            onTap: () => value.cariTagihan(),
                                            child: TextFormField(
                                              enabled: false,
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.caritransaksi,
                                              decoration: InputDecoration(
                                                hintText: "Cari Tagihan",
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
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    )),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Nilai",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            controller: value.nilaitagihan,
                                            readOnly: true,
                                            style: TextStyle(fontSize: 12),
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
                                              hintText: "Nilai",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    )),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Tgl Kontrak",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style: TextStyle(fontSize: 12),
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
                                              hintText: "Tanggal Kontrak",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    )),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "No. Ref",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style: TextStyle(fontSize: 12),
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
                                              hintText: "No. Ref",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 180,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Keterangan",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style: TextStyle(fontSize: 12),
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
                                              hintText: "Keterangan",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 180,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Text(
                                            "No. Dokumen",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 250,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        maxLines: 1,
                                        controller: value.nodokumen,
                                        style: TextStyle(fontSize: 12),
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
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => value.tambahTransaksi(),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                            color: colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Text(
                                          "Hitung Rincian Bayar",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  height: 250,
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
                                    // controller: value.dataGridController,
                                    gridLinesVisibility:
                                        GridLinesVisibility.both,
                                    headerGridLinesVisibility:
                                        GridLinesVisibility.both,
                                    selectionMode: SelectionMode.single,

                                    source: EmptyDataGridSource(value),
                                    columns: <GridColumn>[
                                      GridColumn(
                                          width: 50,
                                          columnName: 'no',
                                          label: Container(
                                              padding: EdgeInsets.all(6),
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              child: Text('Ke',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 200,
                                          columnName: 'invoice',
                                          label: Container(
                                              padding: EdgeInsets.all(6),
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              child: Text('No. Invoice',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'tagihan',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Nilai Tagihan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 100,
                                          columnName: 'bayartagihan',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Bayar Tagihan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'tagppn',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Tag PPN',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'bayarppn',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Bayar PPN',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      // Cust/Supp	No Kontrak	No Invoice	Nilai Transaksi	Sisa Kewajiban	cara bayar	Jk Waktu
                                      GridColumn(
                                          width: 150,
                                          columnName: 'tagpph',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Tag PPH',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'bayarpph',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Bayar PPH',
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
                                              padding: EdgeInsets.all(6),
                                              alignment: Alignment.center,
                                              child: Text('Keterangan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: 200,
                                        child: Text(
                                          "Selisih",
                                          textAlign: TextAlign.center,
                                        )),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      width: 200,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        // controller: value.namaSbbAset,
                                        maxLines: 1,
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
                                          hintText: "Selisih",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          CupertinoSwitch(
                                              activeColor: colorPrimary,
                                              value: value.kelebihan,
                                              onChanged: (e) {
                                                value.gantikelebihan();
                                              }),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Kekurangan / Kelebihan Bayar",
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Container(
                                      width: 200,
                                      child: TextFormField(
                                        // enabled: false,
                                        readOnly: true,
                                        textInputAction: TextInputAction.done,
                                        // controller: value.namaSbbAset,
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
                                          hintText: "SBB",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                                    source: EmptyDataGridSource(value),
                                    columns: <GridColumn>[
                                      GridColumn(
                                          width: 50,
                                          columnName: 'no',
                                          label: Container(
                                              padding: EdgeInsets.all(6),
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              child: Text('Ke',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 200,
                                          columnName: 'invoice',
                                          label: Container(
                                              padding: EdgeInsets.all(6),
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              child: Text('No. Invoice',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'tagihan',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Nilai Tagihan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 100,
                                          columnName: 'bayartagihan',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Bayar Tagihan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'tagppn',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Tag PPN',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'bayarppn',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Bayar PPN',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      // Cust/Supp	No Kontrak	No Invoice	Nilai Transaksi	Sisa Kewajiban	cara bayar	Jk Waktu
                                      GridColumn(
                                          width: 150,
                                          columnName: 'tagpph',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Tag PPH',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'bayarpph',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Bayar PPH',
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
                                              padding: EdgeInsets.all(6),
                                              alignment: Alignment.center,
                                              child: Text('Keterangan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: 200,
                                        child: Text(
                                          "Selisih",
                                          textAlign: TextAlign.center,
                                        )),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      width: 200,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        // controller: value.namaSbbAset,
                                        maxLines: 1,
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
                                          hintText: "Selisih",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          CupertinoSwitch(
                                              activeColor: colorPrimary,
                                              value: value.kelebihan,
                                              onChanged: (e) {
                                                value.gantikelebihan();
                                              }),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Kekurangan / Kelebihan Bayar",
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Container(
                                      width: 200,
                                      child: TextFormField(
                                        // enabled: false,
                                        readOnly: true,
                                        textInputAction: TextInputAction.done,
                                        // controller: value.namaSbbAset,
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
                                          hintText: "SBB",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                )
                // )
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
                      width: 700,
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  value.editData == "caritransaksi"
                                      ? "Pilih Transaksi"
                                      : "Pilih Tagihan",
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
                          value.editData == "caritransaksi"
                              ? Container(
                                  padding: EdgeInsets.all(5),
                                  height: 250,
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

                                    source: EmptyDataGridSource(value),
                                    columns: <GridColumn>[
                                      GridColumn(
                                          width: 150,
                                          columnName: 'tgltranstrans',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Tanggal Transaksi',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'nilaitrans',
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
                                          width: 150,
                                          columnName: 'nodoktrans',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('No. Dokumen',
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
                                              padding: EdgeInsets.all(6),
                                              alignment: Alignment.center,
                                              child: Text('Keterangan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  height: 250,
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

                                    source: EmptyDataGridSource(value),
                                    columns: <GridColumn>[
                                      GridColumn(
                                          width: 150,
                                          columnName: 'nokontraktagihan',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('No. Kontrak',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'invoicetagihan',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(6),
                                              child: Text('Invoice',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 150,
                                          columnName: 'nilaitagihan',
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
                                          width: 200,
                                          columnName: 'keterangantagihan',
                                          label: Container(
                                              color: colorPrimary,
                                              padding: EdgeInsets.all(6),
                                              alignment: Alignment.center,
                                              child: Text('Keterangan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    )
                  : SizedBox()),
        ]))),
      ),
    );
  }
}

class EmptyDataGridSource extends DataGridSource {
  EmptyDataGridSource(PembayaranHutangNotifier value);

  @override
  List<DataGridRow> get rows => [];

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return null;
  }
}
