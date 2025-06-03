import 'package:accounting/models/hutang_piutang_item_model.dart';
import 'package:accounting/models/index.dart';
import 'package:accounting/module/pembayaran_hutang/pembayaran_hutang_notifier.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart' as a;
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
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Expanded(
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
                                child: const Text(
                                  "Tutup Hitung Rincian Bayar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(
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
                          padding: const EdgeInsets.all(20),
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
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Jenis Transaksi",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Customer / Supplier",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child:
                                          TypeAheadField<CustomerSupplierModel>(
                                        controller: value.customersupplier,
                                        suggestionsCallback: (search) => value
                                            .getCustomerSupplierQuery(search),
                                        builder:
                                            (context, controller, focusNode) {
                                          return TextField(
                                              controller: controller,
                                              focusNode: focusNode,
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                border:
                                                    const OutlineInputBorder(),
                                                labelText:
                                                    'Cari ${value.jenis == 1 ? "Customer" : "Supplier"}',
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
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            controller: value.alamat,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Cari Pembayaran",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
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
                                              decoration: const InputDecoration(
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
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            controller: value.noSbb,
                                            readOnly: true,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: InkWell(
                                            onTap: () => value.cariTrans(),
                                            child: TextFormField(
                                              enabled: false,
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: value.caritransaksis,
                                              decoration: InputDecoration(
                                                hintText: "Cari Transaksi",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Nilai Pembayaran",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
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
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: value.nilaipembayaran,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Tgl Valuta",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: value.tglValuta,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                              hintText: "Tanggal Valuta",
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
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "No Dok",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: value.nodokumen,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Keterangan",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
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
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                      child: const Row(
                                        children: [
                                          Text(
                                            "No Kontrak / Invoice",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
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
                                        SizedBox(
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
                                          height: 16,
                                        ),
                                      ],
                                    )),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Nilai",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            controller: value.nilaitagihan,
                                            readOnly: true,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Tgl Kontrak",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: value.tglKontrak,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "No. Ref",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: value.noref,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Keterangan",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
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
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller: value.keterangan,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 1,
                                            readOnly: true,
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                      child: const Row(
                                        children: [
                                          Text(
                                            "No. Dokumen",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "*",
                                            style: TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 250,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        maxLines: 1,
                                        controller: value.nodokumen,
                                        style: const TextStyle(fontSize: 12),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                            color: colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: const Text(
                                          "Hitung Rincian Bayar",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 250,
                                  child: SfDataGrid(
                                    headerRowHeight: 40,
                                    defaultColumnWidth: 180,
                                    frozenColumnsCount: 2,
                                    gridLinesVisibility:
                                        GridLinesVisibility.both,
                                    headerGridLinesVisibility:
                                        GridLinesVisibility.both,
                                    selectionMode: SelectionMode.single,
                                    source: DetailDataPembayaranSource(value),
                                    columns: <GridColumn>[
                                      GridColumn(
                                          width: 50,
                                          columnName: 'no',
                                          label: Container(
                                              padding: const EdgeInsets.all(6),
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              child: const Text('Ke',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 200,
                                          columnName: 'invoice',
                                          label: Container(
                                              padding: const EdgeInsets.all(6),
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              child: const Text('No. Invoice',
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
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('Nilai Tagihan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 200,
                                          columnName: 'bayartagihan',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('Bayar Tagihan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 200,
                                          columnName: 'tagppn',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('Tag PPN',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 200,
                                          columnName: 'bayarppn',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('Bayar PPN',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 200,
                                          columnName: 'tagpph',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('Tag PPH',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 200,
                                          columnName: 'bayarpph',
                                          label: Container(
                                              color: colorPrimary,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(6),
                                              child: const Text('Bayar PPH',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                      GridColumn(
                                          width: 300,
                                          columnName: 'keterangan',
                                          label: Container(
                                              color: colorPrimary,
                                              padding: const EdgeInsets.all(6),
                                              alignment: Alignment.center,
                                              child: const Text('Keterangan',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  )))),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 200,
                                        child: const Text(
                                          "Selisih",
                                          textAlign: TextAlign.center,
                                        )),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    SizedBox(
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
                                    SizedBox(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          CupertinoSwitch(
                                              activeTrackColor: colorPrimary,
                                              value: value.kelebihan,
                                              onChanged: (e) {
                                                value.gantikelebihan();
                                              }),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Kekurangan / Kelebihan Bayar",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    SizedBox(
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
                : const SizedBox(),
          ),
          Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: value.dialog
                  ? Container(
                      width: 700,
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: const EdgeInsets.all(20),
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
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.close),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Expanded(
                            child: value.editData == "caritransaksi"
                                ? Container(
                                    padding: const EdgeInsets.all(5),
                                    height: MediaQuery.of(context).size.height,
                                    child: SfDataGrid(
                                      headerRowHeight: 40,
                                      defaultColumnWidth: 180,
                                      frozenColumnsCount: 2,
                                      gridLinesVisibility:
                                          GridLinesVisibility.both,
                                      headerGridLinesVisibility:
                                          GridLinesVisibility.both,
                                      selectionMode: SelectionMode.single,
                                      source: DetailDataTransaksi(value),
                                      columns: <GridColumn>[
                                        GridColumn(
                                            width: 80,
                                            columnName: 'action',
                                            label: Container(
                                                color: colorPrimary,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: const Text('Aksi',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    )))),
                                        GridColumn(
                                            width: 150,
                                            columnName: 'tgltranstrans',
                                            label: Container(
                                                color: colorPrimary,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child:
                                                    const Text('Tanggal Valuta',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white,
                                                        )))),
                                        GridColumn(
                                            width: 150,
                                            columnName: 'nilaitrans',
                                            label: Container(
                                                color: colorPrimary,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: const Text('Nilai',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    )))),
                                        GridColumn(
                                            width: 150,
                                            columnName: 'nodoktrans',
                                            label: Container(
                                                color: colorPrimary,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: const Text('No. Dokumen',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    )))),
                                        GridColumn(
                                            width: 80,
                                            columnName: 'keterangan',
                                            label: Container(
                                                color: colorPrimary,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                alignment: Alignment.center,
                                                child: const Text('Keterangan',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    )))),
                                      ],
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(5),
                                    height: MediaQuery.of(context).size.height,
                                    child: SfDataGrid(
                                      headerRowHeight: 40,
                                      defaultColumnWidth: 180,
                                      frozenColumnsCount: 1,
                                      gridLinesVisibility:
                                          GridLinesVisibility.both,
                                      headerGridLinesVisibility:
                                          GridLinesVisibility.both,
                                      selectionMode: SelectionMode.single,
                                      source: DetailDataTagihanSource(value),
                                      columns: <GridColumn>[
                                        GridColumn(
                                            columnName: 'action',
                                            width: 80,
                                            label: Container(
                                                color: colorPrimary,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                alignment: Alignment.center,
                                                child: const Text('Aksi',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    )))),
                                        GridColumn(
                                            width: 150,
                                            columnName: 'nokontraktagihan',
                                            label: Container(
                                                color: colorPrimary,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: const Text('No. Kontrak',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    )))),
                                        GridColumn(
                                            width: 150,
                                            columnName: 'nilaitagihan',
                                            label: Container(
                                                color: colorPrimary,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: const Text('Nilai',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    )))),
                                        GridColumn(
                                            width: 150,
                                            columnName: 'jangkawaktu',
                                            label: Container(
                                                color: colorPrimary,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child:
                                                    const Text('Jangka Waktu',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white,
                                                        )))),
                                        GridColumn(
                                            width: 150,
                                            columnName: 'tgltransaksi',
                                            label: Container(
                                                color: colorPrimary,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: const Text(
                                                    'Tanggal Kontrak',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    )))),
                                        GridColumn(
                                            width: 200,
                                            columnName: 'keterangantagihan',
                                            label: Container(
                                                color: colorPrimary,
                                                padding:
                                                    const EdgeInsets.all(6),
                                                alignment: Alignment.center,
                                                child: const Text('Keterangan',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white,
                                                    )))),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox()),
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

class DetailDataPembayaranSource extends DataGridSource {
  DetailDataPembayaranSource(PembayaranHutangNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listPembayaran);
  }

  PembayaranHutangNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<HutangPiutangItemModel> list) {
    var no = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'no', value: (no++).toString()),
                DataGridCell(
                    columnName: 'invoice',
                    value: data.noinv == null ? "" : data.noinv),
                DataGridCell(
                    columnName: 'tagihan',
                    value: FormatCurrency.oCcyDecimal
                        .format(double.parse(data.tagPokok))),
                DataGridCell(
                    columnName: 'bayartagihan', value: (no - 1).toString()),
                DataGridCell(columnName: 'tagppn', value: (no - 1).toString()),
                DataGridCell(
                    columnName: 'bayarppn', value: (no - 1).toString()),
                DataGridCell(columnName: 'tagpph', value: (no - 1).toString()),
                DataGridCell(
                    columnName: 'bayarpph', value: (no - 1).toString()),
                DataGridCell(
                    columnName: 'keterangantagihan', value: data.keterangan),
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
                tindakanNotifier!.pilihTagihan(e.value);
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
                  "Pilih",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        } else if (e.columnName == 'bayartagihan' ||
            e.columnName == 'tagppn' ||
            e.columnName == 'bayarppn' ||
            e.columnName == 'tagpph' ||
            e.columnName == 'bayarpph') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(6.0),
            child: Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: TextFormField(
                  onChanged: (e) {},
                  controller: e.columnName == 'bayartagihan'
                      ? tindakanNotifier!
                          .listBayarTagihan[int.parse(e.value) - 1]
                      : e.columnName == 'tagppn'
                          ? tindakanNotifier!.listPPN[int.parse(e.value) - 1]
                          : e.columnName == 'tagpph'
                              ? tindakanNotifier!
                                  .listPPH[int.parse(e.value) - 1]
                              : e.columnName == 'bayarppn'
                                  ? tindakanNotifier!
                                      .listBayarPPN[int.parse(e.value) - 1]
                                  : tindakanNotifier!
                                      .listBayarPPH[int.parse(e.value) - 1],
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    a.CurrencyInputFormatter(
                      leadingSymbol: 'Rp ',
                      useSymbolPadding: true,
                      thousandSeparator: a.ThousandSeparator.Period,
                      mantissaLength: 2, // jumlah angka desimal
                      // decimalSeparator: DecimalSeparator.Comma,
                    ),
                  ],
                )),
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

class DetailDataTransaksi extends DataGridSource {
  DetailDataTransaksi(PembayaranHutangNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listTransaksiPendingAdd);
  }

  PembayaranHutangNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<TransaksiPendModel> list) {
    var no = 1;
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'action', value: data.rrn),
                DataGridCell(
                    columnName: 'tgltranstrans', value: data.tglValuta),
                DataGridCell(
                    columnName: 'nilaitrans',
                    value: FormatCurrency.oCcy.format(int.parse(data.nominal))),
                DataGridCell(columnName: 'nodoktrans', value: data.noDokumen),
                DataGridCell(columnName: 'keterangan', value: data.keterangan),
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
                tindakanNotifier!.pilihTransaksi(e.value);
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
                  "Pilih",
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

class DetailDataTagihanSource extends DataGridSource {
  DetailDataTagihanSource(PembayaranHutangNotifier value) {
    tindakanNotifier = value;
    buildRowData(value.listTransaksiAdd);
  }

  PembayaranHutangNotifier? tindakanNotifier;

  List<DataGridRow> _laporanData = [];
  @override
  List<DataGridRow> get rows => _laporanData;
  void buildRowData(List<HutangPiutangTransaksiModel> list) {
    _laporanData = list
        .map<DataGridRow>((data) => DataGridRow(
              cells: [
                DataGridCell(
                    columnName: 'action', value: data.nokontrak.toString()),
                DataGridCell(columnName: 'kontrak', value: data.nokontrak),
                DataGridCell(
                    columnName: 'nilaitagihan',
                    value: FormatCurrency.oCcyDecimal
                        .format(double.parse(data.totalTagPokok))),
                DataGridCell(
                    columnName: 'jangkawaktu', value: data.jangkawaktu),
                DataGridCell(
                    columnName: 'tgltransaksi', value: data.tglKontrak),
                DataGridCell(
                    columnName: 'keterangantagihan', value: data.keterangan),
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
                tindakanNotifier!.pilihTagihan(e.value);
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
                  "Pilih",
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
