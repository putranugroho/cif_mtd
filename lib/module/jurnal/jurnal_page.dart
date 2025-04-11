import 'package:accounting/module/jurnal/jurnal_notifier.dart';
import 'package:accounting/utils/colors.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:accounting/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JurnalPage extends StatelessWidget {
  const JurnalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JurnalNotifier(context: context),
      child: Consumer<JurnalNotifier>(
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
                            "Jurnal",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 12,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "${DateFormat('dd MMM y').format(value.now)}",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                            ],
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
                              "${DateFormat('dd MMM y').format(value.now)}",
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
              Expanded(
                  child: ListView.builder(
                      itemCount: value.listData.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, i) {
                        final data = value.listData[i];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "Kode",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: Text(
                                        "Keterangan",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "No. Dok",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "No. Ref",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "No-Acc Debet",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "No-Acc Kredit",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "Nilai Debet",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "Nilai Kredit",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              height: 1,
                              color: Colors.grey,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "${data.kodeTrans}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: Text(
                                        "${data.keterangan}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "${data.nomorDok}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "${data.nomorRef}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "(${data.debetAcc}) - ${data.namaDebet}",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "${FormatCurrency.oCcy.format(int.parse(data.nominal))}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            i == 0
                                ? SizedBox()
                                : Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 16),
                                            child: Text(
                                              "",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "(${data.creditAcc}) - ${data.namaCredit}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "${FormatCurrency.oCcy.format(50000)}",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            i == 0
                                ? Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 16),
                                            child: Text(
                                              "",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "(${data.creditAcc}) - ${data.namaCredit}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "${FormatCurrency.oCcy.format(int.parse(data.nominal))}",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            i == 0
                                ? SizedBox()
                                : Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 16),
                                            child: Text(
                                              "",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "(${data.creditAcc}) - ${data.namaCredit}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "${FormatCurrency.oCcy.format(700000)}",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            i == 0
                                ? SizedBox()
                                : Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 16),
                                            child: Text(
                                              "",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "(${data.creditAcc}) - ${data.namaCredit}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Text(
                                            "${FormatCurrency.oCcy.format(750000)}",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              height: 1,
                              color: Colors.grey,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: Text(
                                        "",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "${FormatCurrency.oCcy.format(int.parse(data.nominal))}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      "${FormatCurrency.oCcy.format(int.parse(data.nominal))}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 16),
                              height: 8,
                              color: Colors.grey[300],
                            ),
                          ],
                        );
                      }))
            ],
          ),
        )),
      ),
    );
  }
}
