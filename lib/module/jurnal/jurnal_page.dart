import 'package:cif/module/jurnal/jurnal_notifier.dart';
import 'package:cif/utils/colors.dart';
import 'package:cif/utils/format_currency.dart';
import 'package:cif/utils/images_path.dart';
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
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Jurnal",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                DateFormat('dd MMM y').format(value.now),
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                            ],
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
                        value.changeStartDate();
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
                              DateFormat('dd MMM y').format(value.now),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: value.listData.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, i) {
                        final data = value.listData[i];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "Kode",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 16),
                                      child: const Text(
                                        "Keterangan",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "No. Dok",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "No. Ref",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "No-Acc Debet",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "No-Acc Kredit",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "Nilai Debet",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "Nilai Kredit",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              height: 1,
                              color: Colors.grey,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      data.kodeTrans,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 16),
                                      child: Text(
                                        data.keterangan,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      data.nomorDok,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      data.nomorRef,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      "(${data.debetAcc}) - ${data.namaDebet}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      FormatCurrency.oCcy.format(int.parse(data.nominal)),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            i == 0
                                ? const SizedBox()
                                : Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 16),
                                            child: const Text(
                                              "",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            "(${data.creditAcc}) - ${data.namaCredit}",
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            FormatCurrency.oCcy.format(50000),
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            i == 0
                                ? Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 16),
                                            child: const Text(
                                              "",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            "(${data.creditAcc}) - ${data.namaCredit}",
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            FormatCurrency.oCcy.format(int.parse(data.nominal)),
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            i == 0
                                ? const SizedBox()
                                : Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 16),
                                            child: const Text(
                                              "",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            "(${data.creditAcc}) - ${data.namaCredit}",
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            FormatCurrency.oCcy.format(700000),
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            i == 0
                                ? const SizedBox()
                                : Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 16),
                                            child: const Text(
                                              "",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            "(${data.creditAcc}) - ${data.namaCredit}",
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: const Text(
                                            "",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          margin: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            FormatCurrency.oCcy.format(750000),
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              height: 1,
                              color: Colors.grey,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 16),
                                      child: const Text(
                                        "",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: const Text(
                                      "",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      FormatCurrency.oCcy.format(int.parse(data.nominal)),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      FormatCurrency.oCcy.format(int.parse(data.nominal)),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
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
