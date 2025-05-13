import 'package:accounting/module/setup/pajak/setup_pajak_notifier.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/decimal_format_input.dart';
import '../../../utils/pro_shimmer.dart';

class SetupPajakPage extends StatelessWidget {
  const SetupPajakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetupPajakNotifier(context: context),
      child: Consumer<SetupPajakNotifier>(
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
                      child: Text(
                        "Setup Pajak",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
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
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: value.keyForm,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "PPN (%)",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
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
                                    Container(
                                      width: 180,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        controller: value.ppn,
                                        maxLines: 1,
                                        readOnly: !value.editData,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(
                                                r'^(100(\.00?)?|([1-9]\d?|0)(\.\d{0,2})?)$'),
                                          ),
                                        ],
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                          decimal: true,
                                          signed: false,
                                        ),
                                        validator: (e) {
                                          if (e == null || e.isEmpty) {
                                            return "Wajib diisi";
                                          }

                                          final valueAsDouble = double.tryParse(
                                              e.replaceAll(",", "."));
                                          if (valueAsDouble == null) {
                                            return "Format tidak valid";
                                          }

                                          if (valueAsDouble < 0 ||
                                              valueAsDouble > 100) {
                                            return "Nilai harus antara 0 dan 100";
                                          }

                                          // Ensure only 2 decimal places max
                                          if (e.contains(".")) {
                                            final decimalPart = e.split(".")[1];
                                            if (decimalPart.length > 2) {
                                              return "Maksimal 2 angka di belakang koma";
                                            }
                                          }

                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          filled: !value.editData,
                                          fillColor: Colors.grey[200],
                                          hintText: "PPN",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                      "Nilai maksimal tidak kena PPN",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
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
                                    Container(
                                      width: 180,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        controller: value.maksPpn,
                                        maxLines: 1,
                                        readOnly: !value.editData,
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
                                          filled: !value.editData,
                                          fillColor: Colors.grey[200],
                                          hintText: "Nilai Maks",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text(
                                      "PPH 23 (%)",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
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
                                    Container(
                                      width: 180,
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        controller: value.pph23,
                                        maxLines: 1,
                                        readOnly: !value.editData,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(
                                                r'^(100(\.00?)?|([1-9]\d?|0)(\.\d{0,2})?)$'),
                                          ),
                                        ],
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                          decimal: true,
                                          signed: false,
                                        ),
                                        validator: (e) {
                                          if (e == null || e.isEmpty) {
                                            return "Wajib diisi";
                                          }

                                          final valueAsDouble = double.tryParse(
                                              e.replaceAll(",", "."));
                                          if (valueAsDouble == null) {
                                            return "Format tidak valid";
                                          }

                                          if (valueAsDouble < 0 ||
                                              valueAsDouble > 100) {
                                            return "Nilai harus antara 0 dan 100";
                                          }

                                          // Ensure only 2 decimal places max
                                          if (e.contains(".")) {
                                            final decimalPart = e.split(".")[1];
                                            if (decimalPart.length > 2) {
                                              return "Maksimal 2 angka di belakang koma";
                                            }
                                          }

                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          filled: !value.editData,
                                          fillColor: Colors.grey[200],
                                          hintText: "PPH",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                value.editData
                                    ? Row(
                                        children: [
                                          ButtonPrimary(
                                            onTap: () {
                                              value.cek();
                                            },
                                            name: "Simpan",
                                          ),
                                          const SizedBox(width: 16),
                                          ButtonDanger(
                                            onTap: () {
                                              value.edit();
                                            },
                                            name: "Cancel",
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          ButtonPrimary(
                                            onTap: () {
                                              value.edit();
                                            },
                                            name: "Edit",
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
