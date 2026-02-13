import 'package:cif/models/index.dart';
import 'package:cif/module/perantara/perantara_aktiva_notifier.dart';
import 'package:cif/utils/button_custom.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/currency_formatted.dart';
import '../../utils/format_currency.dart';

class RekonsiliasiPerantaraPage extends StatelessWidget {
  const RekonsiliasiPerantaraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PerantaraAktivaNotifier(context: context),
        child: Consumer<PerantaraAktivaNotifier>(
          builder: (context, value, child) => SafeArea(
              child: Scaffold(
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
                                    "Perantara",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: "AKTIVA",
                                    activeColor: colorPrimary,
                                    groupValue: value.jenis,
                                    onChanged: (e) {
                                      value.gantijenis("AKTIVA");
                                    }),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text("Aktiva"),
                                const SizedBox(
                                  width: 32,
                                ),
                                Radio(
                                    value: "PASIVA",
                                    activeColor: colorPrimary,
                                    groupValue: value.jenis,
                                    onChanged: (e) {
                                      value.gantijenis("PASIVA");
                                    }),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text("Pasiva"),
                              ],
                            )
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
                              width: 180,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "ACC. DEBET",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "ACC. KREDIT",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: const Text(
                                  "KETERANGAN",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "DEBET",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "KREDIT",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 16),
                              child: const Text(
                                "SALDO",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
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
                      value.jenis == "AKTIVA"
                          ? Expanded(
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
                                            data.sbbItem.isNotEmpty
                                                ? ListView.builder(
                                                    itemCount: data.sbbItem.length,
                                                    shrinkWrap: true,
                                                    physics: const ClampingScrollPhysics(),
                                                    itemBuilder: (context, b) {
                                                      final a = data.sbbItem[b];
                                                      double saldoAwal = a.saldo;

                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 360,
                                                                  margin: const EdgeInsets.only(right: 16),
                                                                  child: Text(
                                                                    "(${a.nosbb}) - ${a.namaSbb}",
                                                                    textAlign: TextAlign.start,
                                                                    style: const TextStyle(
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Container(
                                                                    margin: const EdgeInsets.only(right: 16),
                                                                    child: Text(
                                                                      a.typePosting,
                                                                      textAlign: TextAlign.start,
                                                                      style: const TextStyle(
                                                                        fontSize: 12,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  margin: const EdgeInsets.only(right: 16),
                                                                  child: Text(
                                                                    FormatCurrency.oCcyDecimal.format(a.saldo),
                                                                    textAlign: TextAlign.end,
                                                                    style: const TextStyle(
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  margin: const EdgeInsets.only(right: 16),
                                                                  child: const Text(
                                                                    "",
                                                                    textAlign: TextAlign.end,
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 120,
                                                                  margin: const EdgeInsets.only(right: 16),
                                                                  child: Text(
                                                                    FormatCurrency.oCcyDecimal.format(a.saldo),
                                                                    textAlign: TextAlign.end,
                                                                    style: const TextStyle(
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          a.itemTransaksi.isNotEmpty
                                                              ? ListView.builder(
                                                                  itemCount: a.itemTransaksi.length,
                                                                  shrinkWrap: true,
                                                                  physics: const ClampingScrollPhysics(),
                                                                  itemBuilder: (context, c) {
                                                                    final d = a.itemTransaksi[c];

                                                                    double totalPengurangan = d.nominal;

                                                                    var sisaSaldo = saldoAwal - totalPengurangan;
                                                                    return Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                      children: [
                                                                        Container(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                          child: Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 360,
                                                                                margin: const EdgeInsets.only(right: 16),
                                                                                child: Text(
                                                                                  "(${d.creditAcc}) - ${d.namaCredit}",
                                                                                  textAlign: TextAlign.end,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Container(
                                                                                  margin: const EdgeInsets.only(right: 16),
                                                                                  child: const Text(
                                                                                    "",
                                                                                    style: TextStyle(
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 150,
                                                                                margin: const EdgeInsets.only(right: 16),
                                                                                child: Text(
                                                                                  FormatCurrency.oCcyDecimal.format(d.nominal),
                                                                                  textAlign: TextAlign.end,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 120,
                                                                                margin: const EdgeInsets.only(right: 16),
                                                                                child: Text(
                                                                                  FormatCurrency.oCcyDecimal.format(d.sisaSaldo),
                                                                                  textAlign: TextAlign.end,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  })
                                                              : const SizedBox(),
                                                          Container(),
                                                          const SizedBox(
                                                            height: 16,
                                                          )
                                                        ],
                                                      );
                                                    })
                                                : const SizedBox(),
                                            const SizedBox(
                                              height: 16,
                                            )
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            )
                          : Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListView.builder(
                                      itemCount: value.listPasive.length,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        final data = value.listPasive[i];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            data.sbbItem.isNotEmpty
                                                ? ListView.builder(
                                                    itemCount: data.sbbItem.length,
                                                    shrinkWrap: true,
                                                    physics: const ClampingScrollPhysics(),
                                                    itemBuilder: (context, b) {
                                                      final a = data.sbbItem[b];
                                                      double saldoAwal = a.saldo;

                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 360,
                                                                  margin: const EdgeInsets.only(right: 16),
                                                                  child: Text(
                                                                    "(${a.nosbb}) - ${a.namaSbb}",
                                                                    textAlign: TextAlign.end,
                                                                    style: const TextStyle(
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Container(
                                                                    margin: const EdgeInsets.only(right: 16),
                                                                    child: Text(
                                                                      a.typePosting,
                                                                      textAlign: TextAlign.start,
                                                                      style: const TextStyle(
                                                                        fontSize: 12,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  margin: const EdgeInsets.only(right: 16),
                                                                  child: const Text(
                                                                    "",
                                                                    textAlign: TextAlign.end,
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  margin: const EdgeInsets.only(right: 16),
                                                                  child: Text(
                                                                    FormatCurrency.oCcyDecimal.format(a.saldo),
                                                                    textAlign: TextAlign.end,
                                                                    style: const TextStyle(
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 120,
                                                                  margin: const EdgeInsets.only(right: 16),
                                                                  child: Text(
                                                                    FormatCurrency.oCcyDecimal.format(a.saldo),
                                                                    textAlign: TextAlign.end,
                                                                    style: const TextStyle(
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          a.itemTransaksi.isNotEmpty
                                                              ? ListView.builder(
                                                                  itemCount: a.itemTransaksi.length,
                                                                  shrinkWrap: true,
                                                                  physics: const ClampingScrollPhysics(),
                                                                  itemBuilder: (context, c) {
                                                                    final d = a.itemTransaksi[c];

                                                                    double totalPengurangan = d.nominal;

                                                                    var sisaSaldo = saldoAwal - totalPengurangan;
                                                                    return Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                      children: [
                                                                        Container(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                          child: Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 360,
                                                                                margin: const EdgeInsets.only(right: 16),
                                                                                child: Text(
                                                                                  "(${d.creditAcc}) - ${d.namaCredit}",
                                                                                  textAlign: TextAlign.start,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Container(
                                                                                  margin: const EdgeInsets.only(right: 16),
                                                                                  child: const Text(
                                                                                    "",
                                                                                    style: TextStyle(
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 150,
                                                                                margin: const EdgeInsets.only(right: 16),
                                                                                child: Text(
                                                                                  FormatCurrency.oCcyDecimal.format(d.nominal),
                                                                                  textAlign: TextAlign.end,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 150,
                                                                                margin: const EdgeInsets.only(right: 16),
                                                                                child: const Text(
                                                                                  "",
                                                                                  textAlign: TextAlign.end,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 120,
                                                                                margin: const EdgeInsets.only(right: 16),
                                                                                child: Text(
                                                                                  FormatCurrency.oCcyDecimal.format(d.sisaSaldo),
                                                                                  textAlign: TextAlign.end,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  })
                                                              : const SizedBox(),
                                                          Container(),
                                                          const SizedBox(
                                                            height: 16,
                                                          )
                                                        ],
                                                      );
                                                    })
                                                : const SizedBox(),
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
                      ? value.jenis == "AKTIVA"
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
                                          "Tambah Transaksi",
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
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          const Row(
                                            children: [
                                              Text(
                                                "Nomor Dokumen",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            textInputAction: TextInputAction.done,
                                            controller: value.nomorDok,
                                            maxLines: 1,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            validator: (e) {
                                              if (e!.isEmpty) {
                                                return "Wajib diisi";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Nomor Dok",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          const Row(
                                            children: [
                                              Text(
                                                "Nomor Reference",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            textInputAction: TextInputAction.done,
                                            controller: value.nomorRef,
                                            readOnly: true,
                                            maxLines: 1,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            validator: (e) {
                                              if (e!.isEmpty) {
                                                return "Wajib diisi";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Nomor Referensi",
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Row(
                                    children: [
                                      Text(
                                        "Pilih Debet Akun",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "*",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownSearch<CoaModel>(
                                          popupProps: const PopupPropsMultiSelection.menu(
                                            showSearchBox: true, // Aktifkan fitur pencarian
                                          ),
                                          selectedItem: value.sbbAset,
                                          items: value.listCoaDebet.where((e) => e.jnsAcc == "C").toList(),
                                          itemAsString: (e) => e.namaSbb,
                                          onChanged: (e) {
                                            value.pilihSbbAset(e!);
                                          },
                                          dropdownDecoratorProps: DropDownDecoratorProps(
                                            baseStyle: const TextStyle(fontSize: 16),
                                            textAlignVertical: TextAlignVertical.center,
                                            dropdownSearchDecoration: InputDecoration(
                                              hintText: "Pilih Debet Akun",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbAset,
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
                                            hintText: "Nomor SBB",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Row(
                                    children: [
                                      Text(
                                        "Pilih Kredit Akun",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "*",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbKredit,
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
                                            hintText: "Nama SBB",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbpenyusutan,
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
                                            hintText: "Nomor SBB",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    readOnly: true,
                                    controller: value.keterangan,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      hintText: "Sumber Keterangan",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        "Nominal",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "*",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    controller: value.nominal,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CurrencyInputFormatter(),
                                    ],
                                    validator: (e) {
                                      if (e!.isEmpty) {
                                        return "Wajib diisi";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Nilai Transaksi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        "Keterangan",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintText: "Keterangan Transaksi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  ButtonPrimary(
                                    onTap: () {},
                                    name: "Simpan",
                                  )
                                ],
                              ),
                            )
                          : Container(
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
                                          "Tambah Transaksi",
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
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          const Row(
                                            children: [
                                              Text(
                                                "Nomor Dokumen",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            textInputAction: TextInputAction.done,
                                            controller: value.nomorDok,
                                            maxLines: 1,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            validator: (e) {
                                              if (e!.isEmpty) {
                                                return "Wajib diisi";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Nomor Dok",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          const Row(
                                            children: [
                                              Text(
                                                "Nomor Reference",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            textInputAction: TextInputAction.done,
                                            controller: value.nomorRef,
                                            readOnly: true,
                                            maxLines: 1,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                            validator: (e) {
                                              if (e!.isEmpty) {
                                                return "Wajib diisi";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Nomor Referensi",
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Row(
                                    children: [
                                      Text(
                                        "Pilih Debet Akun",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "*",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbDebit,
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
                                            hintText: "Nama SBB",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbAset,
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
                                            hintText: "Nomor SBB",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    readOnly: true,
                                    controller: value.keterangan,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      hintText: "Sumber Keterangan",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        "Pilih Kredit Akun",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "*",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownSearch<CoaModel>(
                                          popupProps: const PopupPropsMultiSelection.menu(
                                            showSearchBox: true, // Aktifkan fitur pencarian
                                          ),
                                          selectedItem: value.sbbAset,
                                          items: value.listCoaDebet.where((e) => e.jnsAcc == "C").toList(),
                                          itemAsString: (e) => e.namaSbb,
                                          onChanged: (e) {
                                            value.pilihSbbAset(e!);
                                          },
                                          dropdownDecoratorProps: DropDownDecoratorProps(
                                            baseStyle: const TextStyle(fontSize: 16),
                                            textAlignVertical: TextAlignVertical.center,
                                            dropdownSearchDecoration: InputDecoration(
                                              hintText: "Pilih Debet Akun",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                          // enabled: false,
                                          readOnly: true,
                                          textInputAction: TextInputAction.done,
                                          controller: value.namaSbbpenyusutan,
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
                                            hintText: "Nomor SBB",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Row(
                                    children: [
                                      Text(
                                        "Nominal",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "*",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    controller: value.nominal,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CurrencyInputFormatter(),
                                    ],
                                    validator: (e) {
                                      if (e!.isEmpty) {
                                        return "Wajib diisi";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Nilai Transaksi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        "Keterangan",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintText: "Keterangan Transaksi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  ButtonPrimary(
                                    onTap: () {},
                                    name: "Simpan",
                                  )
                                ],
                              ),
                            )
                      : const SizedBox(),
                )
              ],
            ),
          )),
        ));
  }
}
