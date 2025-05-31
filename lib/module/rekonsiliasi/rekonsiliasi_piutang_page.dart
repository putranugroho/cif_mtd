import 'package:accounting/module/rekonsiliasi/rekonsiliasi_piutang_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/format_currency.dart';
import '../../utils/images_path.dart';

class RekonsiliasiPiutangPage extends StatelessWidget {
  const RekonsiliasiPiutangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RekonsiliasiPiutangNotifier(context: context),
        child: Consumer<RekonsiliasiPiutangNotifier>(
          builder: (context, value, child) => SafeArea(
              child: Scaffold(
            body: Column(
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
                              "Rekonsiliasi Piutang",
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
                        width: 100,
                        child: const Text("STATUS"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        width: 120,
                        child: const Text("NO INVOICE"),
                      ),
                      Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 16),
                        child: const Text(
                          "TGL INVOICE",
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 16),
                        child: const Text(
                          "TGL JATUH TEMPO",
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: const Text("CUSTOMER"),
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 16),
                        child: const Text(
                          "SALDO PIUTANG",
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 16),
                        child: const Text(
                          "TGL UPDATE",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: value.list.where((e) => e.statusInvoice == "A").length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, b) {
                            final a = value.list.where((e) => e.statusInvoice == "A").toList()[b];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // value.edit(a);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          width: 100,
                                          child: Text(
                                            a.statusInvoice == "A"
                                                ? "Aktif"
                                                : a.statusInvoice == "L"
                                                    ? "Lunas"
                                                    : a.statusInvoice == "M"
                                                        ? "Macet"
                                                        : "Hapus",
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          width: 120,
                                          child: Text(
                                            a.noInvoice,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          width: 120,
                                          child: Text(
                                            a.tglInvoice,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          width: 150,
                                          child: Text(
                                            a.tglJtTempo,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 16),
                                            child: Text(
                                              a.nmSif,
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 180,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            FormatCurrency.oCcyDecimal.format(int.parse(a.nilaiInvoice)),
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 120,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            DateFormat('dd MMM y HH:mm').format(DateTime.parse(a.tglInvoice)),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(fontSize: 12),
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
                              width: 100,
                              child: const Text(""),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: const Text(
                                  "TOTAL PIUTANG AKTIF",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 16),
                              child: Text(
                                FormatCurrency.oCcyDecimal.format((value.list.where((e) => e.statusInvoice == "A").map((f) => double.parse(f.nilaiInvoice)).reduce((a, b) => a + b))),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              width: 100,
                              child: const Text(""),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: const Text(
                                  "(0290101) - PIUTANG AKTIF",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 16),
                              child: Text(
                                FormatCurrency.oCcyDecimal.format((value.list.where((e) => e.statusInvoice == "A").map((f) => double.parse(f.nilaiInvoice)).reduce((a, b) => a + b))),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              width: 100,
                              child: const Text(""),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: const Text(
                                  "SELISIH",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 16),
                              child: Text(
                                FormatCurrency.oCcyDecimal.format(0),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: value.list.where((e) => e.statusInvoice == "M").length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, b) {
                            final a = value.list.where((e) => e.statusInvoice == "M").toList()[b];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // value.edit(a);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    decoration: const BoxDecoration(),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          width: 100,
                                          child: Text(
                                            a.statusInvoice == "A"
                                                ? "Aktif"
                                                : a.statusInvoice == "L"
                                                    ? "Lunas"
                                                    : a.statusInvoice == "M"
                                                        ? "Macet"
                                                        : "Hapus",
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          width: 120,
                                          child: Text(
                                            a.noInvoice,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          width: 120,
                                          child: Text(
                                            a.tglInvoice,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          width: 150,
                                          child: Text(
                                            a.tglJtTempo,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 16),
                                            child: Text(
                                              a.nmSif,
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 180,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            FormatCurrency.oCcyDecimal.format(int.parse(a.nilaiInvoice)),
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 120,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            DateFormat('dd MMM y HH:mm').format(DateTime.parse(a.tglInvoice)),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(fontSize: 12),
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
                              width: 100,
                              child: const Text(""),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: const Text(
                                  "TOTAL PIUTANG MACET",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 16),
                              child: Text(
                                FormatCurrency.oCcyDecimal.format((value.list.where((e) => e.statusInvoice == "M").map((f) => double.parse(f.nilaiInvoice)).reduce((a, b) => a + b))),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              width: 100,
                              child: const Text(""),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: const Text(
                                  "(0290102) - PIUTANG MACET",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 16),
                              child: Text(
                                FormatCurrency.oCcyDecimal.format((value.list.where((e) => e.statusInvoice == "M").map((f) => double.parse(f.nilaiInvoice)).reduce((a, b) => a + b)) - 185000),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              width: 100,
                              child: const Text(""),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: const Text(
                                  "SELISIH",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 16),
                              child: Text(
                                FormatCurrency.oCcyDecimal.format((value.list.where((e) => e.statusInvoice == "M").map((f) => double.parse(f.nilaiInvoice)).reduce((a, b) => a + b)) - ((value.list.where((e) => e.statusInvoice == "M").map((f) => double.parse(f.nilaiInvoice)).reduce((a, b) => a + b)) - 185000)),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          )),
        ));
  }
}
