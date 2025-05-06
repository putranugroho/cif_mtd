import 'package:accounting/models/index.dart';
import 'package:accounting/module/setup/sbb_hutang_piutang/sbb_hutang_piutang_notifier.dart';
import 'package:accounting/utils/button_custom.dart';
import 'package:accounting/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../utils/currency_formatted.dart';
import '../../../utils/pro_shimmer.dart';

class SbbHutangPiutangPage extends StatelessWidget {
  const SbbHutangPiutangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SbbHutangPiutangNotifier(context: context),
      child: Consumer<SbbHutangPiutangNotifier>(
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
                          "Setup Hutang / Piutang",
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
                          padding: EdgeInsets.all(20),
                          width: 600,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Hutang",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                      controller: value.nmSbbTransHutang,
                                      suggestionsCallback: (search) =>
                                          value.getInquery(search),
                                      builder:
                                          (context, controller, focusNode) {
                                        return TextField(
                                            controller: controller,
                                            focusNode: focusNode,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Cari SBB Transaksi',
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
                                        value.pilihTransHutang(city);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: TypeAheadField<InqueryGlModel>(
                                      controller: value.nmSbbPpnHutang,
                                      suggestionsCallback: (search) =>
                                          value.getInquery(search),
                                      builder:
                                          (context, controller, focusNode) {
                                        return TextField(
                                            controller: controller,
                                            focusNode: focusNode,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Cari SBB PPN',
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
                                        value.pilihPpnHutang(city);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: TypeAheadField<InqueryGlModel>(
                                      controller: value.nmSbbPphHutang,
                                      suggestionsCallback: (search) =>
                                          value.getInquery(search),
                                      builder:
                                          (context, controller, focusNode) {
                                        return TextField(
                                            controller: controller,
                                            focusNode: focusNode,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Cari SBB PPH',
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
                                        value.pilihPphHutang(city);
                                      },
                                    ),
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
                                      controller: value.noSbbTransHutang,
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
                                        hintText: "No SBB",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      // enabled: false,
                                      readOnly: true,
                                      textInputAction: TextInputAction.done,
                                      controller: value.noSbbPpnHutang,
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
                                        hintText: "No SBB",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      // enabled: false,
                                      readOnly: true,
                                      textInputAction: TextInputAction.done,
                                      controller: value.noSbbPphHutang,
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
                                        hintText: "No SBB",
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
                                height: 24,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Piutang",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                      controller: value.nmSbbTransPiutang,
                                      suggestionsCallback: (search) =>
                                          value.getInquery(search),
                                      builder:
                                          (context, controller, focusNode) {
                                        return TextField(
                                            controller: controller,
                                            focusNode: focusNode,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Cari SBB Transaksi',
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
                                        value.pilihTransPiutang(city);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: TypeAheadField<InqueryGlModel>(
                                      controller: value.nmSbbPpnPiutang,
                                      suggestionsCallback: (search) =>
                                          value.getInquery(search),
                                      builder:
                                          (context, controller, focusNode) {
                                        return TextField(
                                            controller: controller,
                                            focusNode: focusNode,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Cari SBB PPN',
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
                                        value.pilihPpnPiutang(city);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: TypeAheadField<InqueryGlModel>(
                                      controller: value.nmSbbPphPiutang,
                                      suggestionsCallback: (search) =>
                                          value.getInquery(search),
                                      builder:
                                          (context, controller, focusNode) {
                                        return TextField(
                                            controller: controller,
                                            focusNode: focusNode,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Cari SBB PPH',
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
                                        value.pilihPphPiutang(city);
                                      },
                                    ),
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
                                      controller: value.noSbbTransPiutang,
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
                                        hintText: "No SBB",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      // enabled: false,
                                      readOnly: true,
                                      textInputAction: TextInputAction.done,
                                      controller: value.noSbbPpnPiutang,
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
                                        hintText: "No SBB",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      // enabled: false,
                                      readOnly: true,
                                      textInputAction: TextInputAction.done,
                                      controller: value.noSbbPphPiutang,
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
                                        hintText: "No SBB",
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
                                height: 12,
                              ),
                              Row(
                                children: [
                                  ButtonPrimary(
                                    onTap: () {
                                      // value.cek();
                                    },
                                    name: "Simpan",
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
