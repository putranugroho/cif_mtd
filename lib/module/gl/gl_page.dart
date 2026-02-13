import 'package:cif/module/gl/gl_notifier.dart';

import 'package:cif/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/images_path.dart';

class GlPage extends StatelessWidget {
  const GlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GlNotifier(context: context),
      child: Consumer<GlNotifier>(
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
                            "GL ",
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
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        // value.changeStartDate();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              DateFormat('MMMM y').format(DateTime.now()),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: value.list.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, i) {
                      final ac = value.list[i];
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Text(
                                    ac.group,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                    itemCount: ac.item.length,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, i) {
                                      final data = ac.item[i];
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
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: 120, child: Text(a.nosbb)),
                                                          Expanded(child: Text(a.namaSbb)),
                                                          Text(
                                                            FormatCurrency.oCcyDecimal.format(a.saldo),
                                                            textAlign: TextAlign.end,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  data.namaBb,
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                                const SizedBox(
                                                  width: 100,
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    FormatCurrency.oCcyDecimal.format(data.sbbItem.map((e) => e.saldo).reduce((a, b) => a + b)),
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      );
                                    })
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        )),
      ),
    );
  }
}
