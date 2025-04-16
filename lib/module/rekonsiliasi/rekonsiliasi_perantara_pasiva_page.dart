import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/format_currency.dart';
import '../../utils/images_path.dart';

import 'rekonsiliasi_perantara_notifier.dart';
import 'rekonsiliasi_perantara_pasiva_notifier.dart';

class RekonsiliasiPerantaraPasivaPage extends StatelessWidget {
  const RekonsiliasiPerantaraPasivaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RekonsiliasiPerantaraPasivaNotifier(context: context),
        child: Consumer<RekonsiliasiPerantaraPasivaNotifier>(
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
                              "Rekonsiliasi Perantara Pasiva",
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
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "ACC. KREDIT",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 16),
                          child: Text(
                            "KETERANGAN",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "DEBET",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "KREDIT",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        width: 120,
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                          "SALDO",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 12),
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
                                                    Container(
                                                      width: 360,
                                                      margin: EdgeInsets.only(
                                                          right: 16),
                                                      child: Text(
                                                        "(${a.nosbb}) - ${a.namaSbb}",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 16),
                                                        child: Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 180,
                                                      margin: EdgeInsets.only(
                                                          right: 16),
                                                      child: Text(
                                                        "",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.end,
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
                                                        style: TextStyle(
                                                            fontSize: 12),
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
                                                        style: TextStyle(
                                                            fontSize: 12),
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
                                                                              .start,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              16),
                                                                      child:
                                                                          Text(
                                                                        "",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
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
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 180,
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            16),
                                                                    child: Text(
                                                                      "",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
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
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
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
