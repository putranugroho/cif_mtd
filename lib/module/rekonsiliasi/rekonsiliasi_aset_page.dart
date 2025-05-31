import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/format_currency.dart';
import '../../utils/images_path.dart';
import 'rekonsiliasi_aset_notifier.dart';

class RekonsiliasiAsetPage extends StatelessWidget {
  const RekonsiliasiAsetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RekonsiliasiAsetNotifier(context: context),
        child: Consumer<RekonsiliasiAsetNotifier>(
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
                              "Rekonsiliasi Aset",
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
                        width: 120,
                        child: const Text("NO. ASET"),
                      ),
                      Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 16),
                        child: const Text(
                          "TGL BELI",
                        ),
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
                          "SALDO ASET",
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
                          itemCount: value.list.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, i) {
                            final data = value.list[i];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListView.builder(
                                    itemCount: data.item.length,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, b) {
                                      final a = data.item[b];
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(right: 16),
                                                  width: 120,
                                                  child: Text(
                                                    a.kdaset,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 16),
                                                  width: 120,
                                                  child: Text(
                                                    a.tglBeli,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: const EdgeInsets.only(right: 16),
                                                    child: Text(
                                                      a.ket,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 180,
                                                  margin: const EdgeInsets.only(right: 16),
                                                  child: Text(
                                                    FormatCurrency.oCcy.format(int.parse(a.haper)),
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      fontSize: 12,
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
                                            height: 4,
                                          )
                                        ],
                                      );
                                    }),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            data.namaKelompok,
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 180,
                                        margin: const EdgeInsets.only(right: 16),
                                        child: Text(
                                          FormatCurrency.oCcy.format(data.item.map((e) => int.parse(e.haper)).reduce((a, b) => a + b)),
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
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
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            "(${0160201 + i}) - INVENTARIS ${data.namaKelompok}",
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 180,
                                        margin: const EdgeInsets.only(right: 16),
                                        child: Text(
                                          FormatCurrency.oCcy.format(data.item.map((e) => int.parse(e.haper)).reduce((a, b) => a + b)),
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
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
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "SELISIH",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 180,
                                        margin: const EdgeInsets.only(right: 16),
                                        child: Text(
                                          FormatCurrency.oCcy.format(data.item.map((e) => int.parse(e.haper)).reduce((a, b) => a + b) - data.item.map((e) => int.parse(e.haper)).reduce((a, b) => a + b)),
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
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
                                )
                              ],
                            );
                          }),
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
