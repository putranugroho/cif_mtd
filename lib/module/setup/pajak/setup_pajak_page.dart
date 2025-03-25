import 'package:accounting/module/setup/pajak/setup_pajak_notifier.dart';
import 'package:accounting/utils/currency_formatted.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utils/button_custom.dart';
import '../../../utils/decimal_format_input.dart';

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
                    Row(
                      children: [
                        Text(
                          "PPN%",
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
                      controller: value.ppn,
                      maxLines: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false,
                      ),
                      validator: (e) {
                        if (e!.isEmpty) {
                          return "Wajib diisi";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "PPN",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          "Nilai Maksimal Kena PPN",
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
                      controller: value.maksPpn,
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
                        hintText: "Nilai Maks",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          "PPH 23%",
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
                      controller: value.pph23,
                      maxLines: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false,
                      ),
                      validator: (e) {
                        if (e!.isEmpty) {
                          return "Wajib diisi";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "PPH",
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
