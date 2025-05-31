import 'package:accounting/module/setup_closing_eom/setup_closing_eom_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class SetupClosingEomPage extends StatelessWidget {
  const SetupClosingEomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetupClosingEomNotifier(context: context),
      child: Consumer<SetupClosingEomNotifier>(
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
                        "Setup Back Date",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: FocusTraversalGroup(
                      child: Form(
                        key: value.keyForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 350,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                              value: true,
                                              activeColor: colorPrimary,
                                              groupValue: value.jenisTrans,
                                              onChanged: (e) {
                                                value.pilihJenisTransaksi(e!);
                                              }),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text(
                                            "Back Date s/d Bulan (Tahun Lalu)",
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
                                              enabled: value.jenisTrans,
                                              textInputAction: TextInputAction.done,
                                              controller: value.closingDate,
                                              maxLines: 1,
                                              onTap: () => value.showDate(),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
                                              style: TextStyle(
                                                // Make text bigger and black
                                                color: value.jenisTrans ? Colors.black : Colors.grey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                filled: !value.jenisTrans,
                                                fillColor: Colors.grey[200],
                                                hintText: "Pilih Bulan",
                                                hintStyle: const TextStyle(color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey.shade600),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                              value: false,
                                              activeColor: colorPrimary,
                                              groupValue: value.jenisTrans,
                                              onChanged: (e) {
                                                value.pilihJenisTransaksi(e!);
                                              }),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text(
                                            "Back Date mundur (bulan)",
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
                                              enabled: !value.jenisTrans,
                                              textInputAction: TextInputAction.done,
                                              controller: value.backdatemundur,
                                              maxLines: 1,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                                FilteringTextInputFormatter.allow(RegExp(r'^(0?[1-9]|[1-9][0-9])$')),
                                              ],
                                              style: TextStyle(
                                                // Make text bigger and black
                                                color: !value.jenisTrans ? Colors.black : Colors.grey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              validator: (e) {
                                                if (e!.isEmpty) {
                                                  return "Wajib diisi";
                                                } else if (int.tryParse(e)! < 1 || int.tryParse(e)! > 99) {
                                                  return "Hanya angka 1 sampai 99";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                filled: value.jenisTrans,
                                                fillColor: Colors.grey[200],
                                                hintText: "Bulan",
                                                hintStyle: const TextStyle(color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey.shade600),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
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
                    ),
                  )
                ],
              ))
            ],
          ),
        )),
      ),
    );
  }
}
