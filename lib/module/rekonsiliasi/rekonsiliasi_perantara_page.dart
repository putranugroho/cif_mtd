import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/rekon_perantara_item_model.dart';
import '../../utils/colors.dart';
import '../../utils/format_currency.dart';
import '../../utils/images_path.dart';

import 'rekonsiliasi_perantara_notifier.dart';

class RekonsiliasiPerantaraPage extends StatelessWidget {
  const RekonsiliasiPerantaraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RekonsiliasiPerantaraNotifier(context: context),
        child: Consumer<RekonsiliasiPerantaraNotifier>(
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
                              "Rekonsiliasi Perantara Aktiva",
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
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                      ),
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
                        width: 180,
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "ACC. DEBET",
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "ACC. KREDIT",
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 16),
                          child: Text("KETERANGAN"),
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "DEBET",
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "KREDIT",
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Container(
                        width: 120,
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "SALDO",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
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
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, i) {
                            final data = value.list[i];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                data.sbbItem.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: data.sbbItem.length,
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: (context, b) {
                                          final a = data.sbbItem[b];
                                          double saldoAwal = a.saldo;

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "(${a.nosbb}) - ${a.namaSbb}",
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 180,
                                                      margin: EdgeInsets.only(
                                                          right: 16),
                                                      child: Text(
                                                        "${FormatCurrency.oCcyDecimal.format(a.saldo)}",
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 180,
                                                      margin: EdgeInsets.only(
                                                          right: 16),
                                                      child: Text(
                                                        "",
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 120,
                                                      margin: EdgeInsets.only(
                                                          right: 16),
                                                      child: Text(
                                                        "${FormatCurrency.oCcyDecimal.format(a.saldo)}",
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              a.itemTransaksi.isNotEmpty
                                                  ? ListView.builder(
                                                      itemCount: a
                                                          .itemTransaksi.length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          ClampingScrollPhysics(),
                                                      itemBuilder:
                                                          (context, c) {
                                                        final d =
                                                            a.itemTransaksi[c];

                                                        double
                                                            totalPengurangan =
                                                            d.nominal;

                                                        var sisaSaldo =
                                                            saldoAwal -
                                                                totalPengurangan;
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    width: 360,
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            16),
                                                                    child: Text(
                                                                      "(${d.creditAcc}) - ${d.namaCredit}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              16),
                                                                      child: Text(
                                                                          ""),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 180,
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            16),
                                                                    child: Text(
                                                                      "${FormatCurrency.oCcyDecimal.format(d.nominal)}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 120,
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            16),
                                                                    child: Text(
                                                                      "${FormatCurrency.oCcyDecimal.format(d.sisaSaldo)}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      })
                                                  : SizedBox(),
                                              Container(),
                                              SizedBox(
                                                height: 16,
                                              )
                                            ],
                                          );
                                        })
                                    : SizedBox(),
                                SizedBox(
                                  height: 16,
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          )),
        ));
  }
}
