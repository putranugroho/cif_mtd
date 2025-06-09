import 'package:accounting/models/inquery_gl_model.dart';
import 'package:accounting/module/setup/penyusutan/penyusutan_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../../utils/currency_formatted.dart';
import '../../../utils/pro_shimmer.dart';

class PenyusutanPage extends StatelessWidget {
  const PenyusutanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PenyusutanNotifier(context: context),
      child: Consumer<PenyusutanNotifier>(
        builder: (context, value, child) => SafeArea(
            child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Metode Penyusutan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: value.isLoading
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProShimmer(height: 10, width: 200),
                              SizedBox(
                                height: 4,
                              ),
                              ProShimmer(height: 10, width: 120),
                              SizedBox(
                                height: 4,
                              ),
                              ProShimmer(height: 10, width: 100),
                              SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: value.keyForm,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                const Text(
                                  "Ganti Metode Penyusutan",
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: 1,
                                        activeColor: colorPrimary,
                                        groupValue: value.metode,
                                        onChanged: (e) {
                                          value.gantimetode(1);
                                        }),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text("Garis Lurus"),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    Radio(
                                        value: 2,
                                        activeColor: colorPrimary,
                                        groupValue: value.metode,
                                        onChanged: (e) {
                                          value.gantimetode(2);
                                        }),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text("Menurun"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      "Nilai Akhir",
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
                                    SizedBox(
                                      width: 180,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        controller: value.nilai,
                                        maxLines: 1,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
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
                                          hintText: "Nilai Akhir",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16),
                                value.metode == 2
                                    ? Column(
                                        children: [
                                          const Row(
                                            children: [
                                              Text(
                                                "Presentase Penurunan (%)",
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
                                              SizedBox(
                                                width: 180,
                                                child: TextFormField(
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  controller: value.declining,
                                                  maxLines: 1,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                      RegExp(
                                                          r'^(100(\.00?)?|([1-9]\d?|0)(\.\d{0,2})?)$'),
                                                    ),
                                                  ],
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                    decimal: true,
                                                    signed: false,
                                                  ),
                                                  validator: (e) {
                                                    if (e == null ||
                                                        e.isEmpty) {
                                                      return "Wajib diisi";
                                                    }

                                                    final valueAsDouble =
                                                        double.tryParse(
                                                            e.replaceAll(
                                                                ",", "."));
                                                    if (valueAsDouble == null) {
                                                      return "Format tidak valid";
                                                    }

                                                    if (valueAsDouble < 0 ||
                                                        valueAsDouble > 100) {
                                                      return "Nilai harus antara 0 dan 100";
                                                    }

                                                    // Ensure only 2 decimal places max
                                                    if (e.contains(".")) {
                                                      final decimalPart =
                                                          e.split(".")[1];
                                                      if (decimalPart.length >
                                                          2) {
                                                        return "Maksimal 2 angka di belakang koma";
                                                      }
                                                    }

                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Penurunan",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          const Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Berdampak apabila metode penyusutan Menurun",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      )
                                    : const SizedBox(),
                                const Row(
                                  children: [
                                    Text(
                                      "Akun Pendapatan",
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
                                      child: TypeAheadField<InqueryGlModel>(
                                        controller: value.namasbbaset,
                                        suggestionsCallback: (search) =>
                                            value.getInquerySbbAset(search),
                                        builder:
                                            (context, controller, focusNode) {
                                          return TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Wajib diisi'; // Must not be empty
                                                }
                                                return null;
                                              },
                                              controller: controller,
                                              focusNode: focusNode,
                                              autofocus: true,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Cari Akun',
                                              ));
                                        },
                                        itemBuilder: (context, city) {
                                          return ListTile(
                                            title: Text(city.nosbb),
                                            subtitle: Text(city.namaSbb),
                                          );
                                        },
                                        onSelected: (city) {
                                          // value.selectInvoice(city);
                                          value.pilihSbbAset(city);
                                        },
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
                                        controller: value.nosbbaset,
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
                                          hintText: "Nomor Debet",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    ButtonPrimary(
                                      onTap: () {
                                        value.cek();
                                      },
                                      name: "Simpan",
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ))
            ],
          ),
        )),
      ),
    );
  }
}
