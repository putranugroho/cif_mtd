import 'package:cif/module/rekonsiliasi/rekonsiliasi_bank_notifier.dart';
import 'package:cif/utils/button_custom.dart';
import 'package:cif/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

import '../../utils/images_path.dart';

class RekonsiliasiBankPage extends StatelessWidget {
  const RekonsiliasiBankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RekonsiliasiBankNotifier(context: context),
      child: Consumer<RekonsiliasiBankNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Rekonsiliasi Bank",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImageAssets.excel,
                                  height: 15,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Download to Excel",
                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 16),
                            width: 80,
                            child: const Text("NO SBB"),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text("KETERANGAN"),
                            ),
                          ),
                          Container(
                            width: 180,
                            margin: const EdgeInsets.only(right: 16),
                            child: const Text(
                              "SALDO GL",
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 16),
                            child: const Text(
                              "SELISIH",
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Container(
                            width: 180,
                            margin: const EdgeInsets.only(right: 16),
                            child: const Text(
                              "SALDO BANK",
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Container(
                            width: 180,
                            margin: const EdgeInsets.only(right: 16),
                            child: const Text(
                              "TANGGAL BANK",
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 1,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: ListView.builder(
                                    itemCount: value.list.where((e) => e.typePosting == "AKTIVA").length,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, i) {
                                      final data = value.list.where((e) => e.typePosting == "AKTIVA").toList()[i];
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          ListView.builder(
                                              itemCount: data.sbbItem.length,
                                              shrinkWrap: true,
                                              physics: const ClampingScrollPhysics(),
                                              itemBuilder: (context, b) {
                                                final a = data.sbbItem[b];
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        value.edit(a);
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(vertical: 2),
                                                        decoration: BoxDecoration(
                                                          color: a.saldo - a.saldoSistem != 0.00 ? Colors.red[800] : Colors.white,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(right: 16),
                                                              width: 80,
                                                              child: Text(
                                                                a.nosbb,
                                                                style: TextStyle(
                                                                    color: a.saldo - a.saldoSistem != 0.00 ? Colors.white : Colors.black,
                                                                    fontSize: 12),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                margin: const EdgeInsets.only(right: 16),
                                                                child: Text(
                                                                  a.namaSbb,
                                                                  style: TextStyle(
                                                                      color: a.saldo - a.saldoSistem != 0.00 ? Colors.white : Colors.black,
                                                                      fontSize: 12),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 180,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: Text(
                                                                FormatCurrency.oCcyDecimal.format(a.saldo),
                                                                textAlign: TextAlign.end,
                                                                style: TextStyle(
                                                                    color: a.saldo - a.saldoSistem != 0.00 ? Colors.white : Colors.black,
                                                                    fontSize: 12),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: Text(
                                                                FormatCurrency.oCcyDecimal.format(a.saldo - a.saldoSistem),
                                                                textAlign: TextAlign.end,
                                                                style: TextStyle(
                                                                    color: a.saldo - a.saldoSistem != 0.00 ? Colors.white : Colors.black,
                                                                    fontSize: 12),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 180,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: Text(
                                                                FormatCurrency.oCcyDecimal.format(a.saldoSistem),
                                                                textAlign: TextAlign.end,
                                                                style: TextStyle(
                                                                    color: a.saldo - a.saldoSistem != 0.00 ? Colors.white : Colors.black,
                                                                    fontSize: 12),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 180,
                                                              margin: const EdgeInsets.only(right: 16),
                                                              child: Text(
                                                                DateFormat('dd MMM y HH:mm').format(DateTime.parse(a.tglTransaksi)),
                                                                textAlign: TextAlign.start,
                                                                style: TextStyle(
                                                                    color: a.saldo - a.saldoSistem != 0.00 ? Colors.white : Colors.black,
                                                                    fontSize: 12),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    )
                                                  ],
                                                );
                                              }),
                                          Row(
                                            children: [
                                              Container(
                                                width: 80,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(right: 16),
                                                  child: Text(
                                                    data.namaBb,
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 180,
                                                margin: const EdgeInsets.only(right: 16),
                                                child: Text(
                                                  FormatCurrency.oCcyDecimal.format(data.sbbItem.map((e) => e.saldo).reduce((a, b) => a + b)),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                margin: const EdgeInsets.only(right: 16),
                                                child: Text(
                                                  FormatCurrency.oCcyDecimal
                                                      .format(data.sbbItem.map((e) => e.saldo - e.saldoSistem).reduce((a, b) => a + b)),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                ),
                                              ),
                                              Container(
                                                width: 180,
                                                margin: const EdgeInsets.only(right: 16),
                                                child: Text(
                                                  FormatCurrency.oCcyDecimal.format(data.sbbItem.map((e) => e.saldoSistem).reduce((a, b) => a + b)),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                ),
                                              ),
                                              Container(
                                                width: 180,
                                                margin: const EdgeInsets.only(right: 16),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          )
                                        ],
                                      );
                                    })),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 1,
                      color: Colors.grey,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 16),
                            width: 80,
                            child: const Text(""),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "TOTAL",
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            width: 180,
                            margin: const EdgeInsets.only(right: 16),
                            child: Text(
                              formatRounded(value.totalAktiva),
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 16),
                            child: Text(
                              formatRounded(value.totalAktiva - value.totalSistem),
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width: 180,
                            margin: const EdgeInsets.only(right: 16),
                            child: Text(
                              formatRounded(value.totalSistem),
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            width: 180,
                            margin: const EdgeInsets.only(right: 16),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 80,
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
                  right: 0,
                  bottom: 0,
                  child: value.dialog
                      ? Container(
                          width: 600,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Bank Rekonsiliasi",
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
                              const Text(
                                "No. SBB",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                readOnly: true,
                                controller: value.nosbb,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintText: "Akun SBB",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Nama Akun",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                readOnly: true,
                                controller: value.akun,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintText: "Akun SBB",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Saldo GL",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                readOnly: true,
                                controller: value.saldo,
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintText: "Saldo GL",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Saldo Bank",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                controller: value.nominal,
                                keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true,
                                  signed: false,
                                ),
                                textAlign: TextAlign.end,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                                onChanged: (e) => value.onChangeTotal(),
                                decoration: InputDecoration(
                                  hintText: "Nominal",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Selisih",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextField(
                                readOnly: true,
                                textAlign: TextAlign.end,
                                controller: value.selisih,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintText: "Selisih",
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
                                      const Text(
                                        "Tanggal Valuta",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          value.pilihTanggalBuka();
                                        },
                                        child: TextField(
                                          enabled: false,
                                          controller: value.tglTransaksiText,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Tanggal Valuta",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
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
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        "Jam Transaksi",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          value.pilihJam();
                                        },
                                        child: TextField(
                                          enabled: false,
                                          controller: value.jamMulai,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Pilih Jam",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
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
                                  ButtonPrimary(
                                    onTap: () {},
                                    name: "Simpan",
                                  )
                                ],
                              )
                            ],
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
