import 'package:accounting/module/setup/penyusutan/penyusutan_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utils/currency_formatted.dart';

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
                padding: EdgeInsets.all(20),
                child: Row(
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
              SizedBox(
                height: 16,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      height: 1,
                      color: Colors.grey,
                    ),
                    Text(
                      "Ganti Metode Penyusutan",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Radio(
                            value: 0,
                            activeColor: colorPrimary,
                            groupValue: value.metode,
                            onChanged: (e) {
                              value.gantimetode(0);
                            }),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Straight Line"),
                        SizedBox(
                          width: 24,
                        ),
                        Radio(
                            value: 1,
                            activeColor: colorPrimary,
                            groupValue: value.metode,
                            onChanged: (e) {
                              value.gantimetode(1);
                            }),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Double Declining"),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          "Nilai Akhir",
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
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: value.nilai,
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
                        hintText: "Nilai Akhir",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ButtonPrimary(
                          onTap: () {},
                          name: "Simpan",
                        ),
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        )),
      ),
    );
  }
}
