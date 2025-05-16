import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/sbb_kas/setup_sbb_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../../utils/currency_formatted.dart';
import '../../../utils/pro_shimmer.dart';

class SetupSbbPage extends StatelessWidget {
  const SetupSbbPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetupSbbNotifier(context: context),
      child: Consumer<SetupSbbNotifier>(
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
                        "Setup Kas Kecil",
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
                                Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      child: Text(
                                        "Akun Kas Kecil",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      width: 375,
                                      child: TypeAheadField<InqueryGlModel>(
                                        controller: value.nosbbdeb,
                                        suggestionsCallback: (search) =>
                                            value.getInquery(search),
                                        builder:
                                            (context, controller, focusNode) {
                                          return TextField(
                                              controller: controller,
                                              focusNode: focusNode,
                                              enabled:
                                                  value.setupTransModel == null,
                                              autofocus: true,
                                              decoration: InputDecoration(
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
                                          value.pilihAkunDeb(city);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      width: 150,
                                      child: TextFormField(
                                        // enabled: false,
                                        readOnly: true,
                                        textInputAction: TextInputAction.done,
                                        controller: value.namaSbbDeb,
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
                                          hintText: "Nomor Akun",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      child: Text(
                                        "Akun Kas Bon",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      width: 375,
                                      child: TypeAheadField<InqueryGlModel>(
                                        controller: value.nossbcre,
                                        suggestionsCallback: (search) =>
                                            value.getInquery(search),
                                        builder:
                                            (context, controller, focusNode) {
                                          return TextField(
                                              controller: controller,
                                              focusNode: focusNode,
                                              enabled:
                                                  value.setupTransModel == null,
                                              autofocus: true,
                                              decoration: InputDecoration(
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
                                          value.pilihAkunCre(city);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      width: 150,
                                      child: TextFormField(
                                        // enabled: false,
                                        readOnly: true,
                                        textInputAction: TextInputAction.done,
                                        controller: value.namaSbbCre,
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
                                          hintText: "Nomor Akun",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
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
