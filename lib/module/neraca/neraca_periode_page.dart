import 'package:accounting/module/neraca/neraca_berjalan_notiifer.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/images_path.dart';
import 'neraca_periode_notifier.dart';

class NeracaPeriodePage extends StatelessWidget {
  const NeracaPeriodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NeracaPeriodeNotifier(context: context),
      child: Consumer<NeracaPeriodeNotifier>(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Neraca Periode",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageAssets.excel,
                            height: 15,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Download to Excel",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        value.changeStartDate();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 14,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${DateFormat('MMMM y').format(value.now)}",
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      width: 150,
                      child: Text("NO SBB"),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Text("KETERANGAN"),
                      ),
                    ),
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 16),
                      child: Text("SALDO"),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      width: 150,
                      child: Text("NO SBB"),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Text("KETERANGAN"),
                      ),
                    ),
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 16),
                      child: Text("SALDO"),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                height: 1,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: value.list
                                .where((e) => e.typePosting == "AKTIVA")
                                .length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, i) {
                              final data = value.list
                                  .where((e) => e.typePosting == "AKTIVA")
                                  .toList()[i];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListView.builder(
                                      itemCount: data.sbbItem.length,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, b) {
                                        final a = data.sbbItem[b];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  width: 150,
                                                  child: Text("${a.nosbb}"),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 16),
                                                    child: Text("${a.namaSbb}"),
                                                  ),
                                                ),
                                                Container(
                                                  width: 150,
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  child: Text(
                                                      "${FormatCurrency.oCcy.format(int.parse(a.saldo))}",
                                                      textAlign: TextAlign.end),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            )
                                          ],
                                        );
                                      }),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 16),
                                        width: 150,
                                        child: Text(""),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "${data.namaBb}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        margin: EdgeInsets.only(right: 16),
                                        child: Text(
                                          "${FormatCurrency.oCcy.format(data.sbbItem.map((e) => int.parse(e.saldo)).reduce((a, b) => a + b))}",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  )
                                ],
                              );
                            })),
                    SizedBox(
                      width: 24,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: value.list
                                .where((e) => e.typePosting == "PASIVA")
                                .length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, i) {
                              final data = value.list
                                  .where((e) => e.typePosting == "PASIVA")
                                  .toList()[i];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListView.builder(
                                      itemCount: data.sbbItem
                                          .where((e) =>
                                              e.nosbb != "600100000001" &&
                                              e.nosbb != "600200000001")
                                          .length,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, b) {
                                        final a = data.sbbItem
                                            .where((e) =>
                                                e.nosbb != "600100000001" &&
                                                e.nosbb != "600200000001")
                                            .toList()[b];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  width: 150,
                                                  child: Text("${a.nosbb}"),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 16),
                                                    child: Text("${a.namaSbb}"),
                                                  ),
                                                ),
                                                Container(
                                                  width: 150,
                                                  margin: EdgeInsets.only(
                                                      right: 16),
                                                  child: Text(
                                                      "${FormatCurrency.oCcy.format(int.parse(a.saldo))}",
                                                      textAlign: TextAlign.end),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            )
                                          ],
                                        );
                                      }),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 16),
                                        width: 150,
                                        child: Text(""),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "${data.namaBb}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        margin: EdgeInsets.only(right: 16),
                                        child: Text(
                                          "${FormatCurrency.oCcy.format(data.sbbItem.map((e) => int.parse(e.saldo)).reduce((a, b) => a + b))}",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  )
                                ],
                              );
                            })),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                height: 1,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      width: 150,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "TOTAL AKTIVA",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 16),
                      child: Text("${FormatCurrency.oCcy.format(124000000000)}",
                          textAlign: TextAlign.end),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      width: 150,
                      child: Text(""),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "TOTAL PASIVA",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 16),
                      child: Text("${FormatCurrency.oCcy.format(124000000000)}",
                          textAlign: TextAlign.end),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        )),
      ),
    );
  }
}
