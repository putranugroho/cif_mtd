import 'package:accounting/module/pembayaran_hutang/pembayaran_hutang_notifier.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
          body: Column(
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
                            child: Expanded(
                              child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "",
                                        style: const TextStyle(fontSize: 12),
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
                                    children: [
                                      Row(
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
                                    children: [
                                      Row(
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
                                              style: TextStyle(fontSize: 12),
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    "No Kontrak / Invoice",
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
                                      Text(
                                        "Nilai",
                                        style: const TextStyle(fontSize: 16),
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
                                              style: TextStyle(fontSize: 12),
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
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
                                      Text(
                                        "Tgl Kontrak",
                                        style: const TextStyle(fontSize: 16),
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
                                              style: TextStyle(fontSize: 12),
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
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
                                  const SizedBox(height: 16),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 16),
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Cara Bayar",
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
                                      Text("Transfer"),
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
                                      Text("Tunai"),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sub Buku Besar",
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
                                              style: TextStyle(fontSize: 12),
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: "SBB",
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
                                              style: TextStyle(fontSize: 12),
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
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
                                      Text(
                                        "Tgl Bayar",
                                        style: const TextStyle(fontSize: 16),
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
                                              style: TextStyle(fontSize: 12),
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Tanggal Bayar",
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
                                      Text(
                                        "No Dok",
                                        style: const TextStyle(fontSize: 16),
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
                                              style: TextStyle(fontSize: 12),
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            child: Text(
                                              "Ke",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            width: 150,
                                            child: Text(
                                              "No. Invoice",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            width: 100,
                                            child: Text(
                                              "Nilai Tagihan",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            width: 100,
                                            child: Text(
                                              "Bayar Tagihan",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            width: 100,
                                            child: Text(
                                              "Tag PPN",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            width: 100,
                                            child: Text(
                                              "Bayar PPN",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            width: 100,
                                            child: Text(
                                              "Tag PPH",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            width: 100,
                                            child: Text(
                                              "Bayar PPH",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            width: 150,
                                            child: Text(
                                              "Keterangan",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                  ListView.builder(
                                      itemCount: value.transaksi,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  child: TextFormField(
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
                                                      hintText: "Ke",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: TextFormField(
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
                                                      hintText: "No. Invoice",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: TextFormField(
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
                                                      hintText: "Nilai Tagihan",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: TextFormField(
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
                                                      hintText: "Bayar Tagihan",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: TextFormField(
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
                                                      hintText: "Tag PPN",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: TextFormField(
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
                                                      hintText: "Bayar PPN",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: TextFormField(
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
                                                      hintText: "Tag PPH",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: TextFormField(
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
                                                      hintText: "Bayar PPH",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: TextFormField(
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
                                                      hintText: "Keterangan",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        );
                                      }),
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
                          )))
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
